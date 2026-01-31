
import AppKit
import SwiftUI

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
        self.backgroundColor = .clear // 透明背景，内容由 SwiftUI 视图绘制
        self.hasShadow = false // SwiftUI 视图自己带阴影，或者我们可以这里开启
        // self.level = .floating // 不再需要全局置顶
        self.isOpaque = false
        
        // 忽略鼠标事件? 
        // Tooltip 通常不交互，或者如果需要交互(复制文本)，不能忽略。
        // Ant Design 的 Tooltip 默认鼠标移入 Tooltip 也会保持显示。
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
        offset: CGFloat = 4 // 距离目标的间距
    ) -> Int {
        // Increment generation to invalidate any pending hide completions
        generation += 1
        
        // 0. 绑定父子窗口关系
        // 如果之前绑在别的窗口上，先解绑
        if currentParentWindow != parentWindow {
            currentParentWindow?.removeChildWindow(self)
        }
        
        // 绑定到新窗口 (如果还没绑定)
        if self.parent != parentWindow {
            parentWindow.addChildWindow(self, ordered: .above)
            currentParentWindow = parentWindow
        }
        
        // 1. 设置内容
        // 我们用 NSHostingView 包装
        let hostingView = NSHostingView(rootView: content.edgesIgnoringSafeArea(.all))
        self.contentView = hostingView
        
        // 2. 计算大小 (Fitting Size)
        let size = hostingView.fittingSize
        
        // 3. 计算位置
        let frame = calculateFrame(
            contentSize: size,
            targetRect: targetRect,
            placement: placement,
            offset: offset,
            arrowSize: arrowSize
        )
        
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
        
        NSAnimationContext.runAnimationGroup { context in
            context.duration = 0.1
            self.animator().alphaValue = 0
        } completionHandler: {
           // Double check generation in completion
           if self.generation == gen {
               self.orderOut(nil)
               self.contentView = nil
               
               // 解除父子关系，避免持有引用
               if let parent = self.currentParentWindow {
                   parent.removeChildWindow(self)
                   self.currentParentWindow = nil
               }
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
        
        // 箭头高度包含在 contentSize 吗？
        // TooltipBubble 是包含箭头的 View。所以 contentSize 已经包含了箭头尺寸。
        // 但是我们需要知道箭头的方向和偏移来对齐。
        
        // 注意：macOS 屏幕坐标系 (0,0) 可能在左下角 (AppKit默认) 或 左上角 (CoreGraphics/SwiftUI处理后)。
        // NSWindow setFrame 使用的是 **Bottom-Left** origin (AppKit Coordinates).
        // 但是 targetRect 往往来自 window.convertToScreen，它也是 Bottom-Left 吗？
        // 需确认。NSWindow.frame 是 Bottom-Left。
        
        let w = contentSize.width
        let h = contentSize.height
        
        // gap 是 目标 和 Tooltip 实体之间的距离 (不包含箭头嵌入部分?)
        // 因为 TooltipBubble 已经画了箭头，所以这里的 spacing 应该是 目标边缘 到 箭头尖端 的微小距离 (offset)
        // 或者如果 offset 包含了箭头高度...
        // 我们的 TooltipBubble 逻辑：
        // placement.top -> Arrow is at bottom.
        // The view height INCLUDES the arrow height.
        // So we just need to place the View Bottom at Target Top + Spacing.
        
        let spacing = offset
        
        switch placement {
        case .top, .topLeft, .topRight:
            // Tooltip 在 Target 上方。
            // Tooltip Y = Target MaxY + spacing
            y = targetRect.maxY + spacing
            
            if placement == .top {
                // 水平居中: Tooltip MidX = Target MidX
                x = targetRect.midX - w / 2
            } else if placement == .topLeft {
                // 左对齐: Tooltip Left = Target Left
                x = targetRect.minX
            } else {
                // 右对齐: Tooltip Right = Target Right
                x = targetRect.maxX - w
            }
            
        case .bottom, .bottomLeft, .bottomRight:
            // Tooltip 在 Target 下方。
            // Tooltip Top (MaxY) = Target MinY - spacing
            // Tooltip MinY = Target MinY - spacing - h
            y = targetRect.minY - spacing - h
            
            if placement == .bottom {
                x = targetRect.midX - w / 2
            } else if placement == .bottomLeft {
                x = targetRect.minX
            } else {
                x = targetRect.maxX - w
            }
            
        case .left, .leftTop, .leftBottom:
            // Tooltip 在 Target 左侧。
            // Tooltip Right (MaxX) = Target MinX - spacing
            // Tooltip MinX = Target MinX - spacing - w
            x = targetRect.minX - spacing - w
            
            if placement == .left {
                // 垂直居中: Tooltip MidY = Target MidY -> Tooltip MinY = Target MidY - h/2
                y = targetRect.midY - h / 2
            } else if placement == .leftTop {
                // 顶部对齐: Tooltip Top(MaxY) = Target Top(MaxY)
                y = targetRect.maxY - h
            } else {
                //底部对齐: Tooltip Bottom(MinY) = Target Bottom(MinY)
                y = targetRect.minY
            }
            
        case .right, .rightTop, .rightBottom:
            // Tooltip 在 Target 右侧。
            // Tooltip Left (MinX) = Target MaxX + spacing
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
