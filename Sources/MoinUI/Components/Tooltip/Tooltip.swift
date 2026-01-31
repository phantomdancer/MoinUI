import SwiftUI

// MARK: - Tooltip Placement

public enum _TooltipPlacement: String, CaseIterable, Sendable {
    case top
    case topLeft
    case topRight
    case bottom
    case bottomLeft
    case bottomRight
    case left
    case leftTop
    case leftBottom
    case right
    case rightTop
    case rightBottom
    
    /// Tooltip 位于目标的哪个方向
    var primaryDirection: Edge {
        switch self {
        case .top, .topLeft, .topRight:
            return .top
        case .bottom, .bottomLeft, .bottomRight:
            return .bottom
        case .left, .leftTop, .leftBottom:
            return .leading
        case .right, .rightTop, .rightBottom:
            return .trailing
        }
    }
    
    /// 箭头在 tooltip 内的对齐方式
    var arrowAlignment: ArrowAlignment {
        switch self {
        case .top, .bottom: return .center
        case .topLeft, .bottomLeft: return .leading
        case .topRight, .bottomRight: return .trailing
        case .left, .right: return .center
        case .leftTop, .rightTop: return .top
        case .leftBottom, .rightBottom: return .bottom
        }
    }
    
    enum ArrowAlignment {
        case center, leading, trailing, top, bottom
    }
}

// MARK: - Tooltip Trigger

public enum _TooltipTrigger: String, CaseIterable, Sendable {
    case hover
    case click
}

// MARK: - Arrow Configuration

public struct _TooltipArrowConfig: Sendable {
    public var show: Bool
    public var pointAtCenter: Bool
    
    public init(show: Bool = true, pointAtCenter: Bool = false) {
        self.show = show
        self.pointAtCenter = pointAtCenter
    }
    
    public static let `true` = _TooltipArrowConfig(show: true, pointAtCenter: false)
    public static let `false` = _TooltipArrowConfig(show: false, pointAtCenter: false)
    public static let center = _TooltipArrowConfig(show: true, pointAtCenter: true)
}

// MARK: - TargetSizeKey

private struct TargetSizeKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

private struct TooltipSizeKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

// MARK: - Layout State

class TooltipLayoutState: ObservableObject {
    @Published var arrowOffsetOverride: CGFloat? = nil
    @Published var arrowAlignmentOverride: _TooltipPlacement.ArrowAlignment? = nil
}

// MARK: - _Tooltip

public struct _Tooltip<Content: View, TooltipContent: View>: View {
    private let content: Content
    private let tooltipContent: TooltipContent
    private let placement: _TooltipPlacement
    private let arrowConfig: _TooltipArrowConfig
    private let color: Color?
    private let trigger: _TooltipTrigger
    
    @Binding private var isOpen: Bool
    @State private var internalIsOpen: Bool = false
    @State private var isHovering: Bool = false
    @State private var hoverTask: Task<Void, Never>?
    
    @Environment(\.moinTooltipToken) private var tooltipToken
    @Environment(\.moinToken) private var token
    
    // 注入当前的环境变量到 Tooltip Window 中
    // 因为 TooltipWindow 是一个新的 View Hierarchy Root
    @Environment(\.colorScheme) private var colorScheme
    
    @StateObject private var layoutState = TooltipLayoutState()
    
    private var effectiveIsOpen: Bool {
        get { isOpen || internalIsOpen }
    }
    
    public init(
        @ViewBuilder content: () -> Content,
        @ViewBuilder tooltip: () -> TooltipContent,
        placement: _TooltipPlacement = .top,
        arrow: _TooltipArrowConfig = .true,
        color: Color? = nil,
        trigger: _TooltipTrigger = .hover,
        isOpen: Binding<Bool>? = nil
    ) {
        self.content = content()
        self.tooltipContent = tooltip()
        self.placement = placement
        self.arrowConfig = arrow
        self.color = color
        self.trigger = trigger
        self._isOpen = isOpen ?? .constant(false)
    }
    
    // Bool 便捷初始化
    public init(
        @ViewBuilder content: () -> Content,
        @ViewBuilder tooltip: () -> TooltipContent,
        placement: _TooltipPlacement = .top,
        arrow: Bool,
        color: Color? = nil,
        trigger: _TooltipTrigger = .hover,
        isOpen: Binding<Bool>? = nil
    ) {
        self.init(
            content: content,
            tooltip: tooltip,
            placement: placement,
            arrow: arrow ? .true : .false,
            color: color,
            trigger: trigger,
            isOpen: isOpen
        )
    }
    
    public var body: some View {
        content
            .overlay(
                TooltipAnchor(
                    isOpen: Binding(get: { effectiveIsOpen }, set: { _ in }),
                    tooltipContent: tooltipView,
                    placement: placement,
                    arrowConfig: arrowConfig,
                    trigger: trigger,
                    arrowSize: tooltipToken.arrowSize,
                    offset: 4,
                    layoutState: layoutState, // Pass state
                    onHover: { hovering in
                        handleHover(hovering)
                    },
                    onClick: {
                         handleAnchorClick()
                    },
                    onClose: {
                        handleForceClose()
                    }
                )
                // 确保 Anchor 不拦截点击，虽然内部 hitTest 已经处理，
                // 但在这里声明更清晰 (SwiftUI 层面)
                .allowsHitTesting(false)
            )
            .simultaneousGesture(
                TapGesture().onEnded {
                    guard trigger == .click else { return }
                    toggleWithAnimation()
                }
            )
            .onReceive(NotificationCenter.default.publisher(for: .moinTooltipDidShow)) { _ in
                 guard internalIsOpen else { return }
                 // 当任何一个 Tooltip (可能是自己，也可能是别人) show 之后
                 // 所有的 _Tooltip 都会收到通知。
                 // 如果我们是 Click 模式，我们应该在别人打开时自动关闭吗？
                 // 通常是的。同一时间只能有一个 Tooltip。
                 
                 // 简单粗暴：收到通知就把自己关了？
                 // 不行，那样把自己刚打开的也关了。
                 
                 // 我们需要知道是不是自己触发的 notification
                 // user info 只有 generation。
                 
                 // 暂时先只打印日志，看看时序
                 // print("[Tooltip(\(id))] Notification Received: moinTooltipDidShow")
            }
    }
    
    // MARK: - Logic
    
    private func handleHover(_ hovering: Bool) {
        guard trigger == .hover else { return }
        if hovering {
            if !isHovering {
                isHovering = true
                scheduleShow()
            }
        } else {
            isHovering = false
            scheduleHide()
        }
    }
    
    private func handleAnchorClick() {
        guard trigger == .click else { return }
    }

    private func handleForceClose() {
        DispatchQueue.main.async {
            self.internalIsOpen = false
            self.isHovering = false
        }
    }

    private func toggleWithAnimation() {
        withAnimation(.easeInOut(duration: tooltipToken.motionDurationMid)) {
            internalIsOpen.toggle()
        }
    }
    
    // MARK: - Tooltip View Construction
    
    private var tooltipView: some View {
        TooltipBubble(
            placement: placement,
            arrowConfig: arrowConfig,
            bgColor: effectiveBgColor,
            arrowSize: tooltipToken.arrowSize,
            borderRadius: tooltipToken.borderRadius,
            arrowOffset: 8,
            layoutState: layoutState // Pass state
        ) {
            tooltipContent
                .font(.system(size: tooltipToken.fontSize))
                .foregroundStyle(tooltipToken.colorText)
                .padding(.vertical, tooltipToken.paddingVertical)
                .padding(.horizontal, tooltipToken.paddingHorizontal)
        }
        .shadow(
            color: tooltipToken.boxShadow.color,
            radius: tooltipToken.boxShadow.radius,
            x: tooltipToken.boxShadow.x,
            y: tooltipToken.boxShadow.y
        )
        .fixedSize()
        // 关键：注入 Environment
        .environment(\.moinToken, token)
        .environment(\.moinTooltipToken, tooltipToken)
        .environment(\.colorScheme, colorScheme) // 确保暗黑模式跟随
    }
    
    private var effectiveBgColor: Color {
        color ?? tooltipToken.colorBg
    }
    
    // MARK: - Hover Delay
    
    private func scheduleShow() {
        hoverTask?.cancel()
        hoverTask = Task {
            try? await Task.sleep(nanoseconds: UInt64(tooltipToken.mouseEnterDelay * 1_000_000_000))
            guard !Task.isCancelled, isHovering else { return }
            await MainActor.run {
                withAnimation(.easeInOut(duration: tooltipToken.motionDurationMid)) {
                    internalIsOpen = true
                }
            }
        }
    }
    
    private func scheduleHide() {
        hoverTask?.cancel()
        hoverTask = Task {
            try? await Task.sleep(nanoseconds: UInt64(tooltipToken.mouseLeaveDelay * 1_000_000_000))
            guard !Task.isCancelled, !isHovering else { return }
            await MainActor.run {
                withAnimation(.easeInOut(duration: tooltipToken.motionDurationMid)) {
                    internalIsOpen = false
                }
            }
        }
    }
}

// MARK: - TooltipBubble

private struct TooltipBubble<Content: View>: View {
    let placement: _TooltipPlacement
    let arrowConfig: _TooltipArrowConfig
    let bgColor: Color
    let arrowSize: CGFloat
    let borderRadius: CGFloat
    let arrowOffset: CGFloat
    @ObservedObject var layoutState: TooltipLayoutState // Observe State
    
    @ViewBuilder let content: () -> Content
    
    var effectiveAlignment: _TooltipPlacement.ArrowAlignment {
        layoutState.arrowAlignmentOverride ?? placement.arrowAlignment
    }
    
    var effectiveArrowOffset: CGFloat {
        layoutState.arrowOffsetOverride ?? arrowOffset
    }

    var body: some View {
        // 根据主方向组装
        switch placement.primaryDirection {
        case .top:
            // Tooltip 在目标上方，箭头在 tooltip 底部，尖端朝下
            VStack(spacing: 0) {
                contentBox
                if arrowConfig.show {
                    arrowRowHorizontal(pointingDown: true)
                }
            }
        case .bottom:
            // Tooltip 在目标下方，箭头在 tooltip 顶部，尖端朝上
            VStack(spacing: 0) {
                if arrowConfig.show {
                    arrowRowHorizontal(pointingDown: false)
                }
                contentBox
            }
        case .leading:
            // Tooltip 在目标左侧，箭头在 tooltip 右边，尖端朝右
            HStack(spacing: 0) {
                contentBox
                if arrowConfig.show {
                    arrowColumnVertical(pointingRight: true)
                }
            }
        case .trailing:
            // Tooltip 在目标右侧，箭头在 tooltip 左边，尖端朝左
            HStack(spacing: 0) {
                if arrowConfig.show {
                    arrowColumnVertical(pointingRight: false)
                }
                contentBox
            }
        }
    }
    
    private var contentBox: some View {
        content()
            .background(bgColor)
            .clipShape(RoundedRectangle(cornerRadius: borderRadius))
    }
    
    // 水平方向的箭头行 (用于 top/bottom)
    @ViewBuilder
    private func arrowRowHorizontal(pointingDown: Bool) -> some View {
        HStack(spacing: 0) {
            switch effectiveAlignment { // Use effective alignment
            case .center:
                Spacer(minLength: 0)
                horizontalArrow(pointingDown: pointingDown)
                Spacer(minLength: 0)
            case .leading:
                Spacer().frame(width: effectiveArrowOffset) // Use effective offset
                horizontalArrow(pointingDown: pointingDown)
                Spacer(minLength: 0)
            case .trailing:
                Spacer(minLength: 0)
                horizontalArrow(pointingDown: pointingDown)
                Spacer().frame(width: effectiveArrowOffset) // Use effective offset
            default:
                Spacer(minLength: 0)
                horizontalArrow(pointingDown: pointingDown)
                Spacer(minLength: 0)
            }
        }
    }
    
    // 垂直方向的箭头列 (用于 left/right)
    @ViewBuilder
    private func arrowColumnVertical(pointingRight: Bool) -> some View {
        VStack(spacing: 0) {
            switch effectiveAlignment { // Use effective alignment
            case .center:
                Spacer(minLength: 0)
                verticalArrow(pointingRight: pointingRight)
                Spacer(minLength: 0)
            case .top:
                Spacer().frame(height: effectiveArrowOffset) // Use effective offset
                verticalArrow(pointingRight: pointingRight)
                Spacer(minLength: 0)
            case .bottom:
                Spacer(minLength: 0)
                verticalArrow(pointingRight: pointingRight)
                Spacer().frame(height: effectiveArrowOffset) // Use effective offset
            default:
                Spacer(minLength: 0)
                verticalArrow(pointingRight: pointingRight)
                Spacer(minLength: 0)
            }
        }
    }
    
    // 水平箭头 (尖端朝上或朝下)
    private func horizontalArrow(pointingDown: Bool) -> some View {
        ArrowShape(direction: pointingDown ? .down : .up, cornerRadius: 2)
            .fill(bgColor)
            .frame(width: arrowSize * 2, height: arrowSize)
    }
    
    // 垂直箭头 (尖端朝左或朝右)
    private func verticalArrow(pointingRight: Bool) -> some View {
        ArrowShape(direction: pointingRight ? .right : .left, cornerRadius: 2)
            .fill(bgColor)
            .frame(width: arrowSize, height: arrowSize * 2)
    }
}

// MARK: - Arrow Direction

private enum ArrowDirection {
    case up, down, left, right
}

// MARK: - Arrow Shape

private struct ArrowShape: Shape {
    let direction: ArrowDirection
    let cornerRadius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let r = cornerRadius
        
        switch direction {
        case .down:
            // 尖端在底部中央
            let midX = rect.midX
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: midX - r, y: rect.height - r))
            path.addQuadCurve(
                to: CGPoint(x: midX + r, y: rect.height - r),
                control: CGPoint(x: midX, y: rect.height)
            )
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            
        case .up:
            // 尖端在顶部中央
            let midX = rect.midX
            path.move(to: CGPoint(x: 0, y: rect.height))
            path.addLine(to: CGPoint(x: midX - r, y: r))
            path.addQuadCurve(
                to: CGPoint(x: midX + r, y: r),
                control: CGPoint(x: midX, y: 0)
            )
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            
        case .right:
            // 尖端在右边中央
            let midY = rect.midY
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: rect.width - r, y: midY - r))
            path.addQuadCurve(
                to: CGPoint(x: rect.width - r, y: midY + r),
                control: CGPoint(x: rect.width, y: midY)
            )
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            
        case .left:
            // 尖端在左边中央
            let midY = rect.midY
            path.move(to: CGPoint(x: rect.width, y: 0))
            path.addLine(to: CGPoint(x: r, y: midY - r))
            path.addQuadCurve(
                to: CGPoint(x: r, y: midY + r),
                control: CGPoint(x: 0, y: midY)
            )
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        }
        
        path.closeSubpath()
        return path
    }
}

// MARK: - Convenience Initializers

public extension _Tooltip where TooltipContent == Text {
    init(
        _ title: String,
        placement: _TooltipPlacement = .top,
        arrow: _TooltipArrowConfig,
        color: Color? = nil,
        trigger: _TooltipTrigger = .hover,
        isOpen: Binding<Bool>? = nil,
        @ViewBuilder content: () -> Content
    ) {
        self.init(
            content: content,
            tooltip: { Text(title) },
            placement: placement,
            arrow: arrow,
            color: color,
            trigger: trigger,
            isOpen: isOpen
        )
    }
    
    init(
        _ title: String,
        placement: _TooltipPlacement = .top,
        arrow: Bool = true,
        color: Color? = nil,
        trigger: _TooltipTrigger = .hover,
        isOpen: Binding<Bool>? = nil,
        @ViewBuilder content: () -> Content
    ) {
        self.init(
            content: content,
            tooltip: { Text(title) },
            placement: placement,
            arrow: arrow ? .true : .false,
            color: color,
            trigger: trigger,
            isOpen: isOpen
        )
    }
    
    init(
        _ title: LocalizedStringKey,
        placement: _TooltipPlacement = .top,
        arrow: Bool = true,
        color: Color? = nil,
        trigger: _TooltipTrigger = .hover,
        isOpen: Binding<Bool>? = nil,
        @ViewBuilder content: () -> Content
    ) {
        self.init(
            content: content,
            tooltip: { Text(title) },
            placement: placement,
            arrow: arrow ? .true : .false,
            color: color,
            trigger: trigger,
            isOpen: isOpen
        )
    }
}

// MARK: - View Modifier

public struct TooltipModifier<TooltipContent: View>: ViewModifier {
    let tooltipContent: TooltipContent
    let placement: _TooltipPlacement
    let arrowConfig: _TooltipArrowConfig
    let color: Color?
    let trigger: _TooltipTrigger
    @Binding var isOpen: Bool
    
    public func body(content: Content) -> some View {
        _Tooltip(
            content: { content },
            tooltip: { tooltipContent },
            placement: placement,
            arrow: arrowConfig,
            color: color,
            trigger: trigger,
            isOpen: $isOpen
        )
    }
}

public extension View {
    /// 添加 Tooltip (支持 Arrow Config)
    func moinTooltip<TooltipContent: View>(
        placement: _TooltipPlacement = .top,
        arrow: _TooltipArrowConfig,
        color: Color? = nil,
        trigger: _TooltipTrigger = .hover,
        isOpen: Binding<Bool>? = nil,
        @ViewBuilder content: () -> TooltipContent
    ) -> some View {
        modifier(TooltipModifier(
            tooltipContent: content(),
            placement: placement,
            arrowConfig: arrow,
            color: color,
            trigger: trigger,
            isOpen: isOpen ?? .constant(false)
        ))
    }
    
    /// 添加 Tooltip (Boolean arrow)
    func moinTooltip<TooltipContent: View>(
        placement: _TooltipPlacement = .top,
        arrow: Bool = true,
        color: Color? = nil,
        trigger: _TooltipTrigger = .hover,
        isOpen: Binding<Bool>? = nil,
        @ViewBuilder content: () -> TooltipContent
    ) -> some View {
        modifier(TooltipModifier(
            tooltipContent: content(),
            placement: placement,
            arrowConfig: arrow ? .true : .false,
            color: color,
            trigger: trigger,
            isOpen: isOpen ?? .constant(false)
        ))
    }
    
    /// 添加文字 Tooltip
    func moinTooltip(
        _ title: String,
        placement: _TooltipPlacement = .top,
        arrow: Bool = true,
        color: Color? = nil,
        trigger: _TooltipTrigger = .hover,
        isOpen: Binding<Bool>? = nil
    ) -> some View {
        moinTooltip(
            placement: placement,
            arrow: arrow,
            color: color,
            trigger: trigger,
            isOpen: isOpen
        ) {
            Text(title)
        }
    }
}
// MARK: - Factory


