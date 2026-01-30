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
    @State private var tooltipSize: CGSize = .zero
    @State private var targetSize: CGSize = .zero
    
    @Environment(\.moinTooltipToken) private var tooltipToken
    @Environment(\.moinToken) private var token
    
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
            .overlay(alignment: overlayAlignment) {
                if effectiveIsOpen {
                    tooltipView
                        .fixedSize()
                        // 垂直对齐修正
                        .alignmentGuide(verticalGuide) { d in
                            computeVerticalGuide(d)
                        }
                        // 水平对齐修正
                        .alignmentGuide(horizontalGuide) { d in
                            computeHorizontalGuide(d)
                        }
                        .animation(.easeInOut(duration: tooltipToken.motionDurationMid), value: effectiveIsOpen)
                }
            }
            .onContinuousHover { phase in
                guard trigger == .hover else { return }
                switch phase {
                case .active:
                    if !isHovering {
                        isHovering = true
                        scheduleShow()
                    }
                case .ended:
                    isHovering = false
                    scheduleHide()
                }
            }
            .onTapGesture {
                guard trigger == .click else { return }
                withAnimation(.easeInOut(duration: tooltipToken.motionDurationMid)) {
                    internalIsOpen.toggle()
                }
            }
    }
    
    // MARK: - Alignment Logic
    
    /// 根据 placement 决定 overlay 对齐到目标的哪个点
    private var overlayAlignment: Alignment {
        switch placement {
        case .top: return .top
        case .topLeft: return .topLeading
        case .topRight: return .topTrailing
            
        case .bottom: return .bottom
        case .bottomLeft: return .bottomLeading
        case .bottomRight: return .bottomTrailing
            
        case .left: return .leading
        case .leftTop: return .topLeading
        case .leftBottom: return .bottomLeading
            
        case .right: return .trailing
        case .rightTop: return .topTrailing
        case .rightBottom: return .bottomTrailing
        }
    }
    
    /// 垂直方向我们要修改哪个 Guide?
    private var verticalGuide: VerticalAlignment {
        switch placement {
        // 对于 Top 系列，我们要修改 .top guide (使其指向 Tooltip 底部)
        case .top, .topLeft, .topRight: return .top
            
        // 对于 Bottom 系列，我们要修改 .bottom guide (使其指向 Tooltip 顶部)
        case .bottom, .bottomLeft, .bottomRight: return .bottom
            
        // 对于侧边系列，维持默认 (Center/Top/Bottom 对齐)
        case .left, .right: return .center
        case .leftTop, .rightTop: return .top
        case .leftBottom, .rightBottom: return .bottom
        }
    }
    
    /// 水平方向我们要修改哪个 Guide?
    private var horizontalGuide: HorizontalAlignment {
        switch placement {
        case .left, .leftTop, .leftBottom: return .leading
        case .right, .rightTop, .rightBottom: return .trailing
        
        case .top, .bottom: return .center
        case .topLeft, .bottomLeft: return .leading
        case .topRight, .bottomRight: return .trailing
        }
    }
    
    /// 计算垂直偏移
    private func computeVerticalGuide(_ d: ViewDimensions) -> CGFloat {
        let gap: CGFloat = tooltipToken.arrowSize + 4
        // 18 = 12(bubble padding) + arrowOffset. 确保箭头对齐目标边缘
        let alignOffset: CGFloat = 18 + tooltipToken.arrowSize
        
        switch placement {
        case .top, .topLeft, .topRight:
            // 此 View 的 Top 对齐到 Container Top.
            // 我们希望此 View Bottom 位于 Container Top 并上移 gap
            // 返回 d[.bottom] + gap 让 .top alignment line = bottom edge + gap
            return d[.bottom] + gap
            
        case .bottom, .bottomLeft, .bottomRight:
            // 此 View Bottom 对齐 Container Bottom.
            // 我们希望此 View Top 位于 Container Bottom 并下移 gap (gap > 0)
            // 返回 d[.top] - gap
            return d[.top] - gap
            
        case .left, .right:
            return d[VerticalAlignment.center]
            
        case .leftTop, .rightTop:
            // Top 对齐 Top.
            // 箭头在 Tooltip Top + alignOffset.
            // 目标中心 (?) No, 目标 Top.
            // 我们希望箭头对齐 Target Top.
            // 所以 View 应该上移 alignOffset.
            // 返回 d[.top] + alignOffset.
            return d[.top] + alignOffset
            
        case .leftBottom, .rightBottom:
            // Bottom 对齐 Bottom.
            // 箭头在 Tooltip Bottom - alignOffset.
            // 我们希望箭头对齐 Target Bottom.
            // View 下移 alignOffset.
            // 返回 d[.bottom] - alignOffset.
            return d[.bottom] - alignOffset
        }
    }
    
    /// 计算水平偏移
    private func computeHorizontalGuide(_ d: ViewDimensions) -> CGFloat {
        let gap: CGFloat = tooltipToken.arrowSize + 4
        let alignOffset: CGFloat = 18 + tooltipToken.arrowSize
        
        switch placement {
        case .left, .leftTop, .leftBottom:
            // Leading 对齐 Leading (Target).
            // 希望 View Trailing 位于 Target Leading 并左移 gap.
            // 返回 d[.trailing] + gap.
            return d[.trailing] + gap
            
        case .right, .rightTop, .rightBottom:
            // Trailing 对齐 Trailing (Target).
            // 希望 View Leading 位于 Target Trailing 并右移 gap.
            // 返回 d[.leading] - gap.
            return d[.leading] - gap
            
        case .top, .bottom:
            return d[HorizontalAlignment.center]
            
        case .topLeft, .bottomLeft:
            // Leading 对齐 Leading.
            // 箭头在 Leading + alignOffset.
            // 希望箭头对齐 Target Leading.
            // View 左移 alignOffset.
            // 返回 d[.leading] + alignOffset.
            return d[.leading] + alignOffset
            
        case .topRight, .bottomRight:
            // Trailing 对齐 Trailing.
            // 箭头在 Trailing - alignOffset.
            // 希望箭头对齐 Target Trailing.
            // View 右移 alignOffset.
            // 返回 d[.trailing] - alignOffset.
            return d[.trailing] - alignOffset
        }
    }
    
    
    // MARK: - Tooltip View
    
    private var tooltipView: some View {
        TooltipBubble(
            placement: placement,
            arrowConfig: arrowConfig,
            bgColor: effectiveBgColor,
            arrowSize: tooltipToken.arrowSize,
            borderRadius: tooltipToken.borderRadius,
            arrowOffset: 12
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
    @ViewBuilder let content: () -> Content
    
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
            switch placement.arrowAlignment {
            case .center:
                Spacer(minLength: 0)
                horizontalArrow(pointingDown: pointingDown)
                Spacer(minLength: 0)
            case .leading:
                Spacer().frame(width: arrowOffset)
                horizontalArrow(pointingDown: pointingDown)
                Spacer(minLength: 0)
            case .trailing:
                Spacer(minLength: 0)
                horizontalArrow(pointingDown: pointingDown)
                Spacer().frame(width: arrowOffset)
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
            switch placement.arrowAlignment {
            case .center:
                Spacer(minLength: 0)
                verticalArrow(pointingRight: pointingRight)
                Spacer(minLength: 0)
            case .top:
                Spacer().frame(height: arrowOffset)
                verticalArrow(pointingRight: pointingRight)
                Spacer(minLength: 0)
            case .bottom:
                Spacer(minLength: 0)
                verticalArrow(pointingRight: pointingRight)
                Spacer().frame(height: arrowOffset)
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
    /// 添加 Tooltip
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
