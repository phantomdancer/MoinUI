
import SwiftUI
import AppKit

struct TooltipAnchor<TooltipContent: View>: NSViewRepresentable {
    
    @Binding var isOpen: Bool
    let tooltipContent: TooltipContent
    let placement: _TooltipPlacement
    let arrowConfig: _TooltipArrowConfig
    let trigger: _TooltipTrigger
    let arrowSize: CGFloat
    let offset: CGFloat
    
    // 我们需要一个回调来更新 isOpen (当 trigger == .hover 时)
    // 或者我们自己在内部管理 hover 状态，并通过 Binding 更新外部
    
    var onHover: ((Bool) -> Void)?
    
    func makeNSView(context: Context) -> TooltipAnchorNSView {
        let view = TooltipAnchorNSView()
        view.onHoverChange = { hovering in
            // 简单的传递事件，让外部处理 Delay 和 State
             if trigger == .hover {
                self.onHover?(hovering)
             }
        }
        return view
    }
    
    func updateNSView(_ nsView: TooltipAnchorNSView, context: Context) {
        // 更新内容和配置
        nsView.tooltipContent = AnyView(tooltipContent)
        nsView.placement = placement
        nsView.arrowConfig = arrowConfig
        nsView.arrowSize = arrowSize
        nsView.offset = offset
        nsView.trigger = trigger
        
        // 外部强制控制显示/隐藏 (例如 Click 模式)
        // 如果 isOpen 为 true，且当前没有显示，则强制显示
        if isOpen && !nsView.isTooltipVisible {
            nsView.showTooltip()
        } else if !isOpen && nsView.isTooltipVisible {
            nsView.hideTooltip()
        }
    }
}

class TooltipAnchorNSView: NSView {
    
    var tooltipContent: AnyView?
    var placement: _TooltipPlacement = .top
    var arrowConfig: _TooltipArrowConfig = .true
    var arrowSize: CGFloat = 8
    var offset: CGFloat = 4
    var trigger: _TooltipTrigger = .hover
    
    var onHoverChange: ((Bool) -> Void)?
    
    private var trackingArea: NSTrackingArea?
    var isTooltipVisible: Bool = false
    
    override func updateTrackingAreas() {
        super.updateTrackingAreas()
        
        if let ta = trackingArea {
            removeTrackingArea(ta)
        }
        
        // 建立一个新的 TrackingArea
        let options: NSTrackingArea.Options = [
            .mouseEnteredAndExited,
            .activeAlways, // 即使 App 不在前台也响应? 或者是 activeInActiveApp
            .activeInKeyWindow
        ]
        
        let newTa = NSTrackingArea(
            rect: self.bounds,
            options: options,
            owner: self,
            userInfo: nil
        )
        addTrackingArea(newTa)
        trackingArea = newTa
    }
    
    override func mouseEntered(with event: NSEvent) {
        // 通知 Hover 开始
        onHoverChange?(true)
    }
    
    override func mouseExited(with event: NSEvent) {
        // 通知 Hover 结束
        onHoverChange?(false)
    }
    
    // 使得 View 透明不阻挡点击
    override func hitTest(_ point: NSPoint) -> NSView? {
        // 返回 nil 表示不接收点击事件，事件会传递给下面的 View
        // 但是 TrackingArea 仍然有效，因为它是 frame-based
        return nil
    }
    
    // MARK: - Show/Hide Logic
    
    var currentGeneration: Int?
    
    // MARK: - Show/Hide Logic
    
    func showTooltip() {
        guard let window = self.window else { return }
        
        // 计算屏幕坐标
        // 1. Convert self.bounds to window coordinates
        let rectInWindow = self.convert(self.bounds, to: nil)
        // 2. Convert window rect to screen coordinates
        let rectInScreen = window.convertToScreen(rectInWindow)
        
        guard let content = tooltipContent else { return }
        
        // 保存 generation token
        self.currentGeneration = TooltipWindow.shared.show(
            content: content,
            targetRect: rectInScreen,
            placement: placement,
            arrowConfig: arrowConfig,
            arrowSize: arrowSize,
            offset: offset
        )
        isTooltipVisible = true
    }
    
    func hideTooltip() {
        if let gen = currentGeneration {
            TooltipWindow.shared.hide(forGeneration: gen)
            currentGeneration = nil
        }
        isTooltipVisible = false
    }
    private var observers: [NSObjectProtocol] = []
    
    override func viewDidMoveToWindow() {
        super.viewDidMoveToWindow()
        setupObservers()
    }
    
    private func setupObservers() {
        // 清理旧的观察者
        observers.forEach { NotificationCenter.default.removeObserver($0) }
        observers.removeAll()
        
        guard let window = self.window else { return }
        
        // 1. 监听窗口移动/调整大小
        // 当窗口位置改变时，Tooltip 的绝对坐标就不准了，应该隐藏
        let windowMove = NotificationCenter.default.addObserver(
            forName: NSWindow.didMoveNotification,
            object: window,
            queue: nil
        ) { [weak self] _ in
            self?.forceHide()
        }
        observers.append(windowMove)
        
        let windowResize = NotificationCenter.default.addObserver(
            forName: NSWindow.didResizeNotification,
            object: window,
            queue: nil
        ) { [weak self] _ in
            self?.forceHide()
        }
        observers.append(windowResize)
        
        // 2. 监听滚动
        // 如果我们在 ScrollView 内，监听其 bounds 变化 (即 scrolling)
        if let scrollView = self.enclosingScrollView {
            // 监听 ClipView 的 bounds 变化，这是最高效/准确捕获滚动的方式
            scrollView.contentView.postsBoundsChangedNotifications = true
            let scrollObserver = NotificationCenter.default.addObserver(
                forName: NSView.boundsDidChangeNotification,
                object: scrollView.contentView,
                queue: nil
            ) { [weak self] _ in
                self?.forceHide()
            }
            observers.append(scrollObserver)
        }
    }
    
    /// 当发生外部干扰（滚动、移动）时，强制隐藏并通知外部状态更新
    private func forceHide() {
        if isTooltipVisible {
            hideTooltip()
            // 通知外部 Hover 结束，防止鼠标不动时 Tooltip 又被 schedule 出来
            onHoverChange?(false)
        }
    }
    
    deinit {
        observers.forEach { NotificationCenter.default.removeObserver($0) }
    }
}
