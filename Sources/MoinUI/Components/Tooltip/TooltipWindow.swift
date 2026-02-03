
import AppKit
import SwiftUI

// MARK: - Tooltip Window


// MARK: - Tooltip Window

class TooltipWindow: NSWindow {
    
    // 我们不需要每次新建 window，可以复用
    static let shared = TooltipWindow()
    
    private init() {
        super.init(
            contentRect: .zero,
            styleMask: [.borderless], // 无边框
            backing: .buffered,
            defer: false
        )
        self.isReleasedWhenClosed = false
        self.backgroundColor = .clear // 透明背景
        self.hasShadow = true // 系统阴影会自动扩展边界
        self.isOpaque = false
        
        // 允许鼠标交互，支持 Hover Tooltip 本身
        self.level = .init(rawValue: 1070)
        self.ignoresMouseEvents = false
    }
    
    private var generation: Int = 0
    // 记录当前的父窗口，用于解绑
    private weak var currentParentWindow: NSWindow?
    
    /// 显示 Tooltip
    func show<Content: View>(
        content: Content,
        parentWindow: NSWindow, // 新增参数：宿主窗口
        targetRect: CGRect, // 屏幕坐标系下的目标 Frame
        placement: _TooltipPlacement,
        arrowConfig: _TooltipArrowConfig,
        arrowSize: CGFloat,

        maxWidth: CGFloat? = nil,
        offset: CGFloat = 4,
        zIndex: Int = 1070,
        layoutState: TooltipLayoutState? = nil,
        onHover: ((Bool) -> Void)? = nil // Add onHover callback
    ) -> Int {
        // Increment generation to invalidate any pending hide completions
        generation += 1
        
        // Update Level
        self.level = NSWindow.Level(rawValue: Int(zIndex))
        
        NotificationCenter.default.post(
            name: .moinTooltipDidShow,
            object: nil,
            userInfo: ["generation": generation]
        )
        
        if currentParentWindow != parentWindow {
            currentParentWindow?.removeChildWindow(self)
        }
        
        if self.parent != parentWindow {
            parentWindow.addChildWindow(self, ordered: .above)
            currentParentWindow = parentWindow
        }
        
        // 1. 设置内容
        let hostingView = NSHostingView(rootView: content.edgesIgnoringSafeArea(.all))
        
        // Wrap in Container handling Hover
        let containerView = TooltipContainerView(contentView: hostingView)
        containerView.onHover = onHover
        
        self.contentView = containerView
        
        // 2. 计算大小
        // 关键修复：如果有 maxWidth，先设置宽度约束让 SwiftUI 计算换行后的高度
        var size: CGSize
        if let maxWidth = maxWidth {
            // 先获取理想尺寸
            let idealSize = hostingView.fittingSize
            
            // 如果理想宽度超过 maxWidth，需要在限定宽度下重新计算
            if idealSize.width > maxWidth {
                // 设置临时 frame 宽度，强制 SwiftUI 重新布局
                hostingView.frame = CGRect(x: 0, y: 0, width: maxWidth, height: 10000)
                hostingView.layoutSubtreeIfNeeded()
                
                // 重新获取 fittingSize（此时会考虑宽度限制）
                size = hostingView.fittingSize
                size.width = min(size.width, maxWidth)
            } else {
                size = idealSize
            }
        } else {
            size = hostingView.fittingSize
        }
        
        // 3. 计算位置
        let frame = calculateFrame(
            contentSize: size,
            targetRect: targetRect,
            placement: placement,
            offset: offset,
            arrowSize: arrowSize
        )
        
        // 3.1 动态计算箭头偏移 (PointAtCenter 逻辑)
        if arrowConfig.pointAtCenter, let state = layoutState {
            let targetMidX = targetRect.midX
            let targetMidY = targetRect.midY
            let tooltipMinX = frame.minX
            
            switch placement.primaryDirection {
            case .top, .bottom:
                let relativeX = targetMidX - tooltipMinX
                let spacerWidth = relativeX - (arrowSize)
                DispatchQueue.main.async {
                    state.arrowAlignmentOverride = .leading
                    state.arrowOffsetOverride = max(0, spacerWidth)
                }
            case .leading, .trailing:
                let distanceFromTop = frame.maxY - targetMidY
                let spacerHeight = distanceFromTop - arrowSize
                 DispatchQueue.main.async {
                    state.arrowAlignmentOverride = .top
                    state.arrowOffsetOverride = max(0, spacerHeight)
                }
            }
        } else {
             // Reset overrides if not pointAtCenter
             if let state = layoutState {
                 DispatchQueue.main.async {
                     state.arrowAlignmentOverride = nil
                     state.arrowOffsetOverride = nil
                 }
             }
        }
        
        // 4. 设置 Frame 并显示
        self.setFrame(frame, display: true)
        self.orderFront(nil)
        
        // 5. 动画
        if self.alphaValue > 0.1 && self.isVisible {
            // Instant transition
             self.animator().alphaValue = 1
        } else {
            // Normal fade in
            self.alphaValue = 0
            NSAnimationContext.runAnimationGroup { context in
                context.duration = 0.15
                self.animator().alphaValue = 1
            }
        }
        
        return generation
    }
    
    /// 隐藏 Tooltip
    func hide(forGeneration gen: Int) {
        // 如果传入的 generation 不等于当前的，说明 Window 已经被新的 Tooltip 接管，
        // 我们不能执行隐藏操作。
        guard gen == self.generation else { return }
        
        // 立即解除父子关系，避免影响焦点切换
        if let parent = self.currentParentWindow {
            parent.removeChildWindow(self)
            self.currentParentWindow = nil
        }
        
        NSAnimationContext.runAnimationGroup { context in
            context.duration = 0.1
            self.animator().alphaValue = 0
        } completionHandler: {
           // Double check generation in completion
           if self.generation == gen {
               self.orderOut(nil)
               self.contentView = nil
           }
        }
    }
    
    // MARK: - Positioning Logic
    
    private func calculateFrame(
        contentSize: CGSize,
        targetRect: CGRect,
        placement: _TooltipPlacement,
        offset: CGFloat,
        arrowSize: CGFloat
    ) -> CGRect {
        var x: CGFloat = 0
        var y: CGFloat = 0
        
        let w = contentSize.width
        let h = contentSize.height
        
        let spacing = offset
        
        switch placement {
        case .top, .topLeft, .topRight:
            y = targetRect.maxY + spacing
            if placement == .top {
                x = targetRect.midX - w / 2
            } else if placement == .topLeft {
                x = targetRect.minX
            } else {
                x = targetRect.maxX - w
            }
            
        case .bottom, .bottomLeft, .bottomRight:
            y = targetRect.minY - spacing - h
            if placement == .bottom {
                x = targetRect.midX - w / 2
            } else if placement == .bottomLeft {
                x = targetRect.minX
            } else {
                x = targetRect.maxX - w
            }
            
        case .left, .leftTop, .leftBottom:
            x = targetRect.minX - spacing - w
            if placement == .left {
                y = targetRect.midY - h / 2
            } else if placement == .leftTop {
                y = targetRect.maxY - h
            } else {
                y = targetRect.minY
            }
            
        case .right, .rightTop, .rightBottom:
            x = targetRect.maxX + spacing
            if placement == .right {
                y = targetRect.midY - h / 2
            } else if placement == .rightTop {
                y = targetRect.maxY - h
            } else {
                y = targetRect.minY
            }
        }
        
        return CGRect(x: x, y: y, width: w, height: h)
    }
}

// MARK: - Tooltip Container View (Handles Hover)

private class TooltipContainerView: NSView {
    let contentView: NSView
    var onHover: ((Bool) -> Void)?
    
    init(contentView: NSView) {
        self.contentView = contentView
        super.init(frame: .zero)
        
        self.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: self.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateTrackingAreas() {
        super.updateTrackingAreas()
        
        for area in trackingAreas {
            removeTrackingArea(area)
        }
        
        let options: NSTrackingArea.Options = [
            .mouseEnteredAndExited,
            .activeAlways,
            .inVisibleRect
        ]
        
        let trackingArea = NSTrackingArea(
            rect: self.bounds,
            options: options,
            owner: self,
            userInfo: nil
        )
        addTrackingArea(trackingArea)
    }
    
    override func mouseEntered(with event: NSEvent) {
        onHover?(true)
    }
    
    override func mouseExited(with event: NSEvent) {
        onHover?(false)
    }
    
    // Transparent for clicks?
    // If we want to allow selecting text, we shouldn't hitTest -> nil.
    // If we want to block clicks, normal NSView does that.
}



extension NSNotification.Name {
    static let moinTooltipDidShow = NSNotification.Name("MoinTooltipDidShow")
}
