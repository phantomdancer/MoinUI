
import SwiftUI
import AppKit

struct TooltipAnchor<TooltipContent: View>: NSViewRepresentable {
    
    let open: Bool
    let tooltipContent: TooltipContent
    let placement: _TooltipPlacement
    let arrowConfig: _TooltipArrowConfig
    let trigger: _TooltipTrigger
    let arrowSize: CGFloat
    let offset: CGFloat
    let maxWidth: CGFloat? // <--- Add
    let zIndex: Int
    let layoutState: TooltipLayoutState
    
    // 我们需要一个回调来更新 open (当 trigger == .hover 时)
    // 或者我们自己在内部管理 hover 状态，并通过 Binding 更新外部
    
     var onHover: ((Bool) -> Void)?
     var onTooltipHover: ((Bool) -> Void)? // Callback for tooltip content hover
     var onClick: (() -> Void)?
     var onClose: (() -> Void)? // 新增：强制关闭回调
     
     func makeNSView(context: Context) -> TooltipAnchorNSView {
         let view = TooltipAnchorNSView()
         view.onHoverChange = { hovering in
              if trigger == .hover {
                 self.onHover?(hovering)
              }
         }
          view.onTooltipHover = { hovering in
              self.onTooltipHover?(hovering)
          }
         view.onClick = {
             self.onClick?()
         }
         view.onClose = {
             self.onClose?()
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
        nsView.maxWidth = maxWidth
        nsView.zIndex = zIndex
        nsView.trigger = trigger
        nsView.layoutState = layoutState // Assign state
        
        // 外部强制控制显示/隐藏 (例如 Click 模式)
        // 如果 open 为 true，且当前没有显示，则强制显示
        nsView.shouldShow = open
        
        // 外部强制控制显示/隐藏
        if open && !nsView.isTooltipVisible {
            nsView.showTooltip()
        } else if !open && nsView.isTooltipVisible {
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
    var maxWidth: CGFloat? = nil
    var zIndex: Int = 1070
    var trigger: _TooltipTrigger = .hover
    var layoutState: TooltipLayoutState? // Add this
    
    var onHoverChange: ((Bool) -> Void)?
    var onTooltipHover: ((Bool) -> Void)?
    var onClick: (() -> Void)?
    var onClose: (() -> Void)? // 新增
    
    private var trackingArea: NSTrackingArea?
    var isTooltipVisible: Bool = false
    var shouldShow: Bool = false // 记录外部期望的显示状态
    
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
        // 只有 hover 模式下才响应
        guard trigger == .hover else { return }
        // 通知 Hover 开始
        onHoverChange?(true)
    }
    
    override func mouseExited(with event: NSEvent) {
        guard trigger == .hover else { return }
        // 通知 Hover 结束
        onHoverChange?(false)
    }
    
    override func mouseDown(with event: NSEvent) {
        super.mouseDown(with: event)
        // 只有当 trigger 为 click 时，我们才真的关心这个点击，
        // 但这里我们只负责转发，逻辑在外部判断。
        // 不过要注意，如果这里消费了事件，下面的视图可能收不到。
        // 但我们在 hitTest 返回了 nil，所以正常情况下 mouseDown 不会被调用？
        // 不，hitTest 返回 nil 意味着我们自己不可交互。
        // 那我们怎么捕获点击？
        
        // 方案：hitTest 不返回 nil，而是让 super.hitTest 处理。
        // 然后在 mouseDown 里调用 onClick，并透传事件给下一个响应者？
        // NSView 的事件传递比较复杂。
        
        onClick?()
    }

    // 使得 View 透明不阻挡点击
    override func hitTest(_ point: NSPoint) -> NSView? {
        // 如果我们想要拦截点击来触发 Tooltip，同时又不影响底部按钮点击...
        // 这在 AppKit 里很难做到“既要又要”。
        // 通常如果是 Click Trigger，TooltipAnchor 应该包裹的内容本身就是触发源。
        // 但我们现在的架构是 TooltipAnchor 覆盖在 Content 上 (overlay)。
        
        // 如果 hitTest 返回 nil，mouseDown 永远不会被调用。
        // 如果 hitTest 返回 self，mouseDown 会被调用，但底下的 Content 收不到。
        
        // 所以我们在 SwiftUI 层用 simultaneousGesture 是对的。
        // 但是为什么 simultaneousGesture 还是有时候失效？
        
        // 让我们先恢复 hitTest 为 nil，因为我们依赖 SwiftUI 的 Gesture。
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
            parentWindow: window, // 传入当前窗口作为父窗口
            targetRect: rectInScreen,
            placement: placement,
            arrowConfig: arrowConfig,
            arrowSize: arrowSize,
            maxWidth: maxWidth,
            offset: offset,
            zIndex: zIndex,
            layoutState: layoutState, // Pass state
            onHover: onTooltipHover // Pass tooltip hover callback
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
        
        // 如果 window 为 nil，说明 View 被移出了窗口层级，必须强制清理 Tooltip
        if self.window == nil {
            forceHide()
            // 移除所有观察者
            observers.forEach { NotificationCenter.default.removeObserver($0) }
            observers.removeAll()
            return
        }
        
        setupObservers()
        
        // 如果应该显示但还没显示（之前可能因为没有 window 失败了），现在尝试显示
        if shouldShow && !isTooltipVisible {
             showTooltip()
        }
    }
    
    private func setupObservers() {
        // 清理旧的观察者
        observers.forEach { NotificationCenter.default.removeObserver($0) }
        observers.removeAll()
        
        // 0. 监听应用程序活跃状态
        // 失去焦点时隐藏
        let resignActive = NotificationCenter.default.addObserver(
            forName: NSApplication.willResignActiveNotification,
            object: nil,
            queue: nil
        ) { [weak self] _ in
            self?.forceHide()
        }
        observers.append(resignActive)
        
        // 新增：监听 Tooltip 被抢占通知
        let globalShow = NotificationCenter.default.addObserver(
            forName: .moinTooltipDidShow,
            object: nil,
            queue: nil
        ) { [weak self] note in
            if let gen = note.userInfo?["generation"] as? Int,
               let selfGen = self?.currentGeneration,
               gen != selfGen {
               self?.currentGeneration = nil
               self?.onClose?()
            }
        }
        observers.append(globalShow)

        guard let _ = self.window else { return }
        
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
    
    /// 当发生外部干扰（滚动、移动、失活）时，强制隐藏并通知外部状态更新
    private func forceHide() {
        if isTooltipVisible {
            hideTooltip()
            // 通知外部 Hover 结束
            onHoverChange?(false)
            // 通知外部关闭（用于 click trigger）
            onClose?()
        }
    }
    
    deinit {
        observers.forEach { NotificationCenter.default.removeObserver($0) }
    }
}
