import SwiftUI
import AppKit

/// Unified button shape that can represent different shapes
private struct ButtonShapeStyle: Shape {
    let shapeType: Moin.ButtonShape
    let cornerRadius: CGFloat
    let compactContext: Moin.SpaceCompactContext

    init(shapeType: Moin.ButtonShape, cornerRadius: CGFloat, compactContext: Moin.SpaceCompactContext = .none) {
        self.shapeType = shapeType
        self.cornerRadius = cornerRadius
        self.compactContext = compactContext
    }

    func path(in rect: CGRect) -> Path {
        switch shapeType {
        case .default:
            if compactContext.isCompact {
                return compactPath(in: rect)
            }
            return RoundedRectangle(cornerRadius: cornerRadius).path(in: rect)
        case .round:
            if compactContext.isCompact {
                return compactPath(in: rect, isRound: true)
            }
            return Capsule().path(in: rect)
        case .circle:
            return Circle().path(in: rect)
        }
    }

    private func compactPath(in rect: CGRect, isRound: Bool = false) -> Path {
        let radius = isRound ? min(rect.width, rect.height) / 2 : cornerRadius
        let corners: UIRectCorner

        switch (compactContext.direction, compactContext.position) {
        case (_, .only), (_, .none):
            corners = .allCorners
        case (.horizontal, .first):
            corners = [.topLeft, .bottomLeft]
        case (.horizontal, .last):
            corners = [.topRight, .bottomRight]
        case (.horizontal, .middle):
            corners = []
        case (.vertical, .first):
            corners = [.topLeft, .topRight]
        case (.vertical, .last):
            corners = [.bottomLeft, .bottomRight]
        case (.vertical, .middle):
            corners = []
        }

        return Path(roundedRect: rect, cornerRadius: radius, corners: corners)
    }

    /// Returns border path for compact mode (open path, not closed)
    func borderPath(in rect: CGRect) -> Path {
        guard compactContext.isCompact else {
            return path(in: rect)
        }

        let radius = shapeType == .round ? min(rect.width, rect.height) / 2 : cornerRadius
        var path = Path()

        switch (compactContext.direction, compactContext.position) {
        case (_, .only), (_, .none):
            return self.path(in: rect)

        case (.horizontal, .first):
            // Draw: bottom-left corner, left, top-left corner, top, right (no right edge)
            path.move(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX + radius, y: rect.maxY))
            path.addArc(center: CGPoint(x: rect.minX + radius, y: rect.maxY - radius),
                       radius: radius, startAngle: .degrees(90), endAngle: .degrees(180), clockwise: false)
            path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + radius))
            path.addArc(center: CGPoint(x: rect.minX + radius, y: rect.minY + radius),
                       radius: radius, startAngle: .degrees(180), endAngle: .degrees(270), clockwise: false)
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))

        case (.horizontal, .middle):
            // Draw: left, top, bottom (no right edge - next button draws its left)
            path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
            path.move(to: CGPoint(x: rect.minX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))

        case (.horizontal, .last):
            // Draw: left, top, right with corners, bottom
            path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
            path.move(to: CGPoint(x: rect.minX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX - radius, y: rect.minY))
            path.addArc(center: CGPoint(x: rect.maxX - radius, y: rect.minY + radius),
                       radius: radius, startAngle: .degrees(-90), endAngle: .degrees(0), clockwise: false)
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - radius))
            path.addArc(center: CGPoint(x: rect.maxX - radius, y: rect.maxY - radius),
                       radius: radius, startAngle: .degrees(0), endAngle: .degrees(90), clockwise: false)
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))

        case (.vertical, .first):
            // Draw: left, top-left corner, top, top-right corner, right (no bottom)
            path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + radius))
            path.addArc(center: CGPoint(x: rect.minX + radius, y: rect.minY + radius),
                       radius: radius, startAngle: .degrees(180), endAngle: .degrees(270), clockwise: false)
            path.addLine(to: CGPoint(x: rect.maxX - radius, y: rect.minY))
            path.addArc(center: CGPoint(x: rect.maxX - radius, y: rect.minY + radius),
                       radius: radius, startAngle: .degrees(-90), endAngle: .degrees(0), clockwise: false)
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))

        case (.vertical, .middle):
            // Draw: top, left, right (no bottom)
            path.move(to: CGPoint(x: rect.minX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            path.move(to: CGPoint(x: rect.minX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.move(to: CGPoint(x: rect.maxX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))

        case (.vertical, .last):
            // Draw: top, left, bottom with corners, right
            path.move(to: CGPoint(x: rect.minX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            path.move(to: CGPoint(x: rect.minX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY - radius))
            path.addArc(center: CGPoint(x: rect.minX + radius, y: rect.maxY - radius),
                       radius: radius, startAngle: .degrees(180), endAngle: .degrees(90), clockwise: true)
            path.addLine(to: CGPoint(x: rect.maxX - radius, y: rect.maxY))
            path.addArc(center: CGPoint(x: rect.maxX - radius, y: rect.maxY - radius),
                       radius: radius, startAngle: .degrees(90), endAngle: .degrees(0), clockwise: true)
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        }

        return path
    }
}

/// Shape that draws partial border for compact mode
private struct CompactBorderShape: Shape {
    let baseShape: ButtonShapeStyle

    func path(in rect: CGRect) -> Path {
        baseShape.borderPath(in: rect)
    }
}

/// UIRectCorner for SwiftUI compatibility
struct UIRectCorner: OptionSet {
    let rawValue: Int

    static let topLeft = UIRectCorner(rawValue: 1 << 0)
    static let topRight = UIRectCorner(rawValue: 1 << 1)
    static let bottomLeft = UIRectCorner(rawValue: 1 << 2)
    static let bottomRight = UIRectCorner(rawValue: 1 << 3)
    static let allCorners: UIRectCorner = [.topLeft, .topRight, .bottomLeft, .bottomRight]
}

extension Path {
    init(roundedRect rect: CGRect, cornerRadius: CGFloat, corners: UIRectCorner) {
        self.init()

        let tl = corners.contains(.topLeft) ? cornerRadius : 0
        let tr = corners.contains(.topRight) ? cornerRadius : 0
        let bl = corners.contains(.bottomLeft) ? cornerRadius : 0
        let br = corners.contains(.bottomRight) ? cornerRadius : 0

        move(to: CGPoint(x: rect.minX + tl, y: rect.minY))
        addLine(to: CGPoint(x: rect.maxX - tr, y: rect.minY))
        if tr > 0 {
            addArc(center: CGPoint(x: rect.maxX - tr, y: rect.minY + tr),
                   radius: tr, startAngle: .degrees(-90), endAngle: .degrees(0), clockwise: false)
        }
        addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - br))
        if br > 0 {
            addArc(center: CGPoint(x: rect.maxX - br, y: rect.maxY - br),
                   radius: br, startAngle: .degrees(0), endAngle: .degrees(90), clockwise: false)
        }
        addLine(to: CGPoint(x: rect.minX + bl, y: rect.maxY))
        if bl > 0 {
            addArc(center: CGPoint(x: rect.minX + bl, y: rect.maxY - bl),
                   radius: bl, startAngle: .degrees(90), endAngle: .degrees(180), clockwise: false)
        }
        addLine(to: CGPoint(x: rect.minX, y: rect.minY + tl))
        if tl > 0 {
            addArc(center: CGPoint(x: rect.minX + tl, y: rect.minY + tl),
                   radius: tl, startAngle: .degrees(180), endAngle: .degrees(270), clockwise: false)
        }
        closeSubpath()
    }
}

/// 图标位置 - 与 antd iconPlacement 一致
public extension Moin {
    enum ButtonIconPlacement {
        case start
        case end
    }
}


/// Loading 配置 - 支持 delay 和自定义 icon
public extension Moin {
    struct ButtonLoading: ExpressibleByBooleanLiteral, Equatable {
        public let isLoading: Bool
        public let delay: TimeInterval?
        public let icon: String?

        public init(_ isLoading: Bool = true, delay: TimeInterval? = nil, icon: String? = nil) {
            self.isLoading = isLoading
            self.delay = delay
            self.icon = icon
        }

        public init(booleanLiteral value: Bool) {
            self.isLoading = value
            self.delay = nil
            self.icon = nil
        }
    }
}


// MARK: - Loading Indicator Component

private struct LoadingIndicator: View {
    let icon: String
    let size: CGFloat

    @State private var isAnimating = false

    var body: some View {
        Image(systemName: icon)
            .font(.system(size: size))
            .rotationEffect(.degrees(isAnimating ? 360 : 0))
            .animation(.linear(duration: 1).repeatForever(autoreverses: false), value: isAnimating)
            .onAppear {
                isAnimating = true
            }
    }
}

// MARK: - Moin.Button

public extension Moin {
    /// MoinUI Button Component
    struct Button<Label: View>: View {
        private let action: (() -> Void)?
        private let label: Label
        private let color: Moin.ButtonColor
        private let size: Moin.ButtonSize
        private let variant: Moin.ButtonVariant
        private let shape: Moin.ButtonShape
        private let loadingConfig: Moin.ButtonLoading
        private let isDisabled: Bool
        private let isBlock: Bool
        private let isGhost: Bool
        private let icon: String?
        private let iconPlacement: Moin.ButtonIconPlacement
        private let href: URL?
        private let gradient: LinearGradient?
        private let fontColor: SwiftUI.Color?

        @State private var isHovered = false
        @State private var isPressed = false
        @State private var showLoading = false
        @FocusState private var isFocused: Bool

        // 使用 Environment 获取配置，避免每个按钮都订阅 ObservedObject
        @Environment(\.moinToken) private var token
        @Environment(\.moinButtonToken) private var buttonToken
        @Environment(\.moinSpaceCompactContext) private var compactContext
        @Environment(\.accessibilityReduceMotion) private var reduceMotion

        public init(
            color: Moin.ButtonColor = .default,
            size: Moin.ButtonSize = .medium,
            variant: Moin.ButtonVariant = .solid,
            shape: Moin.ButtonShape = .default,
            icon: String? = nil,
            iconPlacement: Moin.ButtonIconPlacement = .start,
            loading: Moin.ButtonLoading = false,
            isDisabled: Bool = false,
            isBlock: Bool = false,
            isGhost: Bool = false,
            href: URL? = nil,
            gradient: LinearGradient? = nil,
            fontColor: SwiftUI.Color? = nil,
            action: (() -> Void)? = nil,
            @ViewBuilder label: () -> Label
        ) {
            self.color = color
            self.size = size
            self.variant = variant
            self.shape = shape
            self.icon = icon
            self.iconPlacement = iconPlacement
            self.loadingConfig = loading
            self.isDisabled = isDisabled
            self.isBlock = isBlock
            self.isGhost = isGhost
            self.href = href
            self.gradient = gradient
            self.fontColor = fontColor
            self.action = action
            self.label = label()
        }

        // MARK: - Computed Properties

        private var isLoading: Bool { showLoading }

        private var effectiveDisabled: Bool {
            isDisabled || isLoading
        }

        private var shouldApplyDisabledOpacity: Bool {
            effectiveDisabled && (!color.isDefault || gradient != nil)
        }

        private var baseColor: SwiftUI.Color {
            switch color {
            case .default: return SwiftUI.Color.gray
            case .primary: return token.colorPrimary
            case .success: return token.colorSuccess
            case .warning: return token.colorWarning
            case .danger: return token.colorDanger
            case .info: return token.colorInfo
            case .custom(let c): return c
            }
        }

        // MARK: - Body

        /// 动画：尊重 reducedMotion 设置
        private var stateAnimation: Animation? {
            reduceMotion ? nil : .easeInOut(duration: token.motionDuration / 2)
        }

        public var body: some View {
            Group {
                if let href = href {
                    SwiftUI.Link(destination: href) { buttonContent }
                } else {
                    SwiftUI.Button(action: handleAction) { buttonContent }
                }
            }
            .buttonStyle(.plain)
            .focused($isFocused)
            .disabled(effectiveDisabled && !shouldApplyDisabledOpacity)
            .allowsHitTesting(!effectiveDisabled)
            .opacity(shouldApplyDisabledOpacity ? 0.65 : 1)
            .zIndex(compactContext.isCompact && isHovered ? 10 : 0)
            .onContinuousHover { phase in
                switch phase {
                case .active:
                    if !isHovered {
                        withAnimation(stateAnimation) {
                            isHovered = true
                        }
                    }
                    let cursor: NSCursor = effectiveDisabled ? .operationNotAllowed : .pointingHand
                    cursor.set()
                case .ended:
                    if isHovered {
                        withAnimation(stateAnimation) {
                            isHovered = false
                            isPressed = false
                        }
                    }
                    NSCursor.arrow.set()
                }
            }
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { _ in
                        if !isPressed {
                            withAnimation(stateAnimation) {
                                isPressed = true
                            }
                        }
                    }
                    .onEnded { _ in
                        withAnimation(stateAnimation) {
                            isPressed = false
                        }
                    }
            )
            .task(id: loadingConfig.isLoading) {
                handleLoadingChange(loadingConfig.isLoading)
            }
        }

        // MARK: - Button Content

        @ViewBuilder
        private var buttonContent: some View {
            HStack(spacing: buttonToken.iconGap) {
                if isLoading && iconPlacement == .start {
                    loadingIndicator
                } else if let icon = icon, iconPlacement == .start {
                    iconView(icon)
                }
                label
                if isLoading && iconPlacement == .end {
                    loadingIndicator
                } else if let icon = icon, iconPlacement == .end, !isLoading {
                    iconView(icon)
                }
            }
            .font(.system(size: fontSize, weight: buttonToken.fontWeight))
            .foregroundColor(foregroundColor)
            .frame(height: verticalPadding > 0 ? nil : controlHeight)
            .frame(maxWidth: isBlock || compactContext.fillWidth ? .infinity : nil)
            .frame(minWidth: shape == .circle ? controlHeight : nil)
            .padding(.vertical, verticalPadding > 0 ? verticalPadding : 0)
            .padding(.horizontal, shape == .circle ? 0 : horizontalPadding)
            .background(backgroundView)
            .clipShape(buttonShape)
            .shadow(color: shadowColor, radius: shadowRadius, x: 0, y: shadowY)
            .overlay(borderOverlay)
            .overlay(focusRingOverlay)
            .contentShape(Rectangle())
        }

        /// 焦点环样式
        @ViewBuilder
        private var focusRingOverlay: some View {
            if isFocused && !effectiveDisabled {
                buttonShape
                    .stroke(token.colorPrimary.opacity(0.5), lineWidth: 2)
                    .padding(-2)
            }
        }

        @ViewBuilder
        private var backgroundView: some View {
            if let gradient = gradient, variant == .solid {
                gradient
            } else {
                backgroundColor
            }
        }

        @ViewBuilder
        private func iconView(_ iconName: String) -> some View {
            Image(systemName: iconName)
                .font(.system(size: iconSize))
        }

        @ViewBuilder
        private var loadingIndicator: some View {
            let loadingIcon = loadingConfig.icon ?? "arrow.trianglehead.2.clockwise"
            LoadingIndicator(icon: loadingIcon, size: iconSize)
        }

        private var buttonShape: ButtonShapeStyle {
            ButtonShapeStyle(shapeType: shape, cornerRadius: cornerRadius, compactContext: compactContext)
        }

        @ViewBuilder
        private var borderOverlay: some View {
            if compactContext.isCompact && compactContext.position != .only && !isHovered {
                // Use open border path for compact mode (not hovered)
                if variant == .dashed {
                    CompactBorderShape(baseShape: buttonShape)
                        .stroke(borderColor, style: StrokeStyle(lineWidth: Moin.Constants.Button.borderWidth, dash: [4, 3]))
                } else {
                    CompactBorderShape(baseShape: buttonShape)
                        .stroke(borderColor, lineWidth: Moin.Constants.Button.borderWidth)
                }
            } else if variant == .dashed {
                buttonShape
                    .stroke(borderColor, style: StrokeStyle(lineWidth: Moin.Constants.Button.borderWidth, dash: [4, 3]))
            } else {
                buttonShape
                    .stroke(borderColor, lineWidth: Moin.Constants.Button.borderWidth)
            }
        }

        // MARK: - Sizing

        private func sizedValue<T>(small: T, medium: T, large: T) -> T {
            switch size {
            case .small: return small
            case .medium: return medium
            case .large: return large
            }
        }

        private var iconSize: CGFloat {
            sizedValue(small: buttonToken.onlyIconSizeSM, medium: buttonToken.onlyIconSize, large: buttonToken.onlyIconSizeLG)
        }

        private var fontSize: CGFloat {
            sizedValue(small: buttonToken.contentFontSizeSM, medium: buttonToken.contentFontSize, large: buttonToken.contentFontSizeLG)
        }

        private var controlHeight: CGFloat {
            sizedValue(small: token.controlHeightSM, medium: token.controlHeight, large: token.controlHeightLG)
        }

        private var horizontalPadding: CGFloat {
            sizedValue(small: buttonToken.paddingInlineSM, medium: buttonToken.paddingInline, large: buttonToken.paddingInlineLG)
        }

        private var verticalPadding: CGFloat {
            sizedValue(small: buttonToken.paddingBlockSM, medium: buttonToken.paddingBlock, large: buttonToken.paddingBlockLG)
        }

        private var cornerRadius: CGFloat {
            sizedValue(small: token.borderRadiusSM, medium: token.borderRadius, large: token.borderRadiusLG)
        }

        // MARK: - Shadow

        /// 阴影颜色
        private var shadowColor: SwiftUI.Color {
            // 只有 solid variant 且非 ghost/disabled 时显示阴影
            guard variant == .solid && !isGhost && !effectiveDisabled else {
                return .clear
            }
            // 有色按钮使用主题色阴影，default 使用灰色
            if color.isDefault {
                return SwiftUI.Color.black.opacity(token.shadowOpacity1)
            }
            return baseColor.opacity(0.25)
        }

        /// 阴影半径
        private var shadowRadius: CGFloat {
            guard variant == .solid && !isGhost && !effectiveDisabled else { return 0 }
            return isPressed ? 1 : token.shadowRadius1
        }

        /// 阴影 Y 偏移
        private var shadowY: CGFloat {
            guard variant == .solid && !isGhost && !effectiveDisabled else { return 0 }
            return isPressed ? 0 : 1
        }

        // MARK: - Colors

        /// Hover 颜色 - 使用 token 色阶 (level 5)
        private var hoverColor: SwiftUI.Color {
            switch color {
            case .default: return token.colorPrimary
            case .primary: return token.colorPrimaryHover
            case .success: return token.colorSuccessHover
            case .warning: return token.colorWarningHover
            case .danger: return token.colorDangerHover
            case .info: return token.colorInfoHover
            case .custom(let c):
                // 自定义颜色：动态生成色板取 level 5
                return Moin.ColorPalette.generate(from: c)[5]
            }
        }

        /// Active 颜色 - 使用 token 色阶 (level 7)
        private var activeColor: SwiftUI.Color {
            switch color {
            case .default: return token.colorPrimary
            case .primary: return token.colorPrimaryActive
            case .success: return token.colorSuccessActive
            case .warning: return token.colorWarningActive
            case .danger: return token.colorDangerActive
            case .info: return token.colorInfoActive
            case .custom(let c):
                // 自定义颜色：动态生成色板取 level 7
                return Moin.ColorPalette.generate(from: c)[7]
            }
        }

        private var backgroundColor: SwiftUI.Color {
            // Ghost 模式背景透明，hover 时白色半透明
            if isGhost {
                if isPressed { return SwiftUI.Color.white.opacity(0.25) }
                else if isHovered { return SwiftUI.Color.white.opacity(0.15) }
                return buttonToken.ghostBg
            }

            // 禁用状态
            if effectiveDisabled {
                switch variant {
                case .solid:
                    if !color.isDefault { return baseColor }
                    return buttonToken.defaultBgDisabled
                case .filled:
                    return baseColor.opacity(0.15)
                case .outlined, .dashed, .text, .link:
                    return .clear
                }
            }

            switch variant {
            case .solid:
                if color.isDefault {
                    if isPressed { return buttonToken.defaultActiveBg }
                    else if isHovered { return buttonToken.defaultHoverBg }
                    return buttonToken.defaultBg
                }
                if isPressed { return activeColor }
                else if isHovered { return hoverColor }
                return baseColor

            case .filled:
                if isPressed { return baseColor.opacity(0.25) }
                else if isHovered { return baseColor.opacity(0.2) }
                return baseColor.opacity(0.15)

            case .outlined, .dashed:
                if isPressed { return baseColor.opacity(0.15) }
                else if isHovered { return baseColor.opacity(0.1) }
                return .clear

            case .text:
                if isPressed { return buttonToken.textHoverBg.opacity(1.5) }
                else if isHovered { return buttonToken.textHoverBg }
                return .clear

            case .link:
                return buttonToken.linkHoverBg
            }
        }

        private var foregroundColor: SwiftUI.Color {
            // 优先使用自定义 fontColor
            if let fontColor = fontColor {
                return effectiveDisabled ? fontColor.opacity(0.65) : fontColor
            }

            // Ghost 模式：default 用白色，有色用原色
            if isGhost {
                if effectiveDisabled { return buttonToken.defaultGhostColor.opacity(0.5) }
                return color.isDefault ? buttonToken.defaultGhostColor : baseColor
            }

            // 禁用状态
            if effectiveDisabled {
                if !color.isDefault {
                    return variant == .solid ? buttonToken.solidTextColor : baseColor
                }
                return token.colorTextDisabled
            }

            switch variant {
            case .solid:
                if color.isDefault {
                    if isPressed { return buttonToken.defaultActiveColor }
                    else if isHovered { return buttonToken.defaultHoverColor }
                    return buttonToken.defaultColor
                }
                return color == .danger ? buttonToken.dangerColor : buttonToken.primaryColor

            case .filled, .outlined, .dashed:
                if color.isDefault {
                    if isPressed { return buttonToken.defaultActiveColor }
                    else if isHovered { return buttonToken.defaultHoverColor }
                    return buttonToken.defaultColor
                }
                return baseColor

            case .text:
                if color.isDefault {
                    if isPressed { return buttonToken.textTextActiveColor }
                    else if isHovered { return buttonToken.textTextHoverColor }
                    return buttonToken.textTextColor
                }
                return baseColor

            case .link:
                if color.isDefault {
                    return isHovered ? token.colorPrimary.opacity(0.8) : token.colorPrimary
                }
                return isHovered ? baseColor.opacity(0.8) : baseColor
            }
        }

        private var borderColor: SwiftUI.Color {
            // Ghost 模式：default 用白色边框，有色用原色边框
            if isGhost {
                if effectiveDisabled { return buttonToken.defaultGhostBorderColor.opacity(0.3) }
                return color.isDefault ? buttonToken.defaultGhostBorderColor : baseColor
            }

            // 禁用状态
            if effectiveDisabled {
                if !color.isDefault { return baseColor }
                switch variant {
                case .solid, .outlined, .dashed, .filled:
                    return buttonToken.borderColorDisabled
                case .text, .link:
                    return .clear
                }
            }

            switch variant {
            case .solid:
                if color.isDefault {
                    if isPressed { return buttonToken.defaultActiveBorderColor }
                    else if isHovered { return buttonToken.defaultHoverBorderColor }
                    return buttonToken.defaultBorderColor
                }
                if isPressed { return activeColor }
                else if isHovered { return hoverColor }
                return baseColor

            case .outlined, .dashed:
                if color.isDefault {
                    if isPressed { return buttonToken.defaultActiveBorderColor }
                    else if isHovered { return buttonToken.defaultHoverBorderColor }
                    return buttonToken.defaultBorderColor
                }
                return baseColor

            case .filled:
                return .clear

            case .text, .link:
                return .clear
            }
        }

        // MARK: - Actions

        private func handleAction() {
            guard !effectiveDisabled else { return }
            action?()
        }

        private func handleLoadingChange(_ isLoading: Bool) {
            if isLoading {
                if let delay = loadingConfig.delay, delay > 0 {
                    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                        if self.loadingConfig.isLoading {
                            self.showLoading = true
                        }
                    }
                } else {
                    showLoading = true
                }
            } else {
                showLoading = false
            }
        }
    }
}


// MARK: - Convenience Initializers

public extension Moin.Button where Label == Text {
    init(
        _ title: String,
        color: Moin.ButtonColor = .default,
        size: Moin.ButtonSize = .medium,
        variant: Moin.ButtonVariant = .solid,
        shape: Moin.ButtonShape = .default,
        icon: String? = nil,
        iconPlacement: Moin.ButtonIconPlacement = .start,
        loading: Moin.ButtonLoading = false,
        isDisabled: Bool = false,
        isBlock: Bool = false,
        isGhost: Bool = false,
        href: URL? = nil,
        gradient: LinearGradient? = nil,
        fontColor: SwiftUI.Color? = nil,
        action: (() -> Void)? = nil
    ) {
        self.init(
            color: color,
            size: size,
            variant: variant,
            shape: shape,
            icon: icon,
            iconPlacement: iconPlacement,
            loading: loading,
            isDisabled: isDisabled,
            isBlock: isBlock,
            isGhost: isGhost,
            href: href,
            gradient: gradient,
            fontColor: fontColor,
            action: action
        ) {
            Text(title)
        }
    }
}

public extension Moin.Button where Label == EmptyView {
    init(
        icon iconName: String,
        color: Moin.ButtonColor = .default,
        size: Moin.ButtonSize = .medium,
        variant: Moin.ButtonVariant = .solid,
        shape: Moin.ButtonShape = .circle,
        loading: Moin.ButtonLoading = false,
        isDisabled: Bool = false,
        isGhost: Bool = false,
        href: URL? = nil,
        gradient: LinearGradient? = nil,
        fontColor: SwiftUI.Color? = nil,
        action: (() -> Void)? = nil
    ) {
        self.init(
            color: color,
            size: size,
            variant: variant,
            shape: shape,
            icon: iconName,
            iconPlacement: .start,
            loading: loading,
            isDisabled: isDisabled,
            isBlock: false,
            isGhost: isGhost,
            href: href,
            gradient: gradient,
            fontColor: fontColor,
            action: action
        ) {
            EmptyView()
        }
    }
}
