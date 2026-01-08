import SwiftUI
import AppKit

/// Unified button shape that can represent different shapes
struct MoinUIButtonShapeStyle: Shape {
    let shapeType: MoinUIButtonShape
    let cornerRadius: CGFloat

    func path(in rect: CGRect) -> Path {
        switch shapeType {
        case .default:
            return RoundedRectangle(cornerRadius: cornerRadius).path(in: rect)
        case .round:
            return Capsule().path(in: rect)
        case .circle:
            return Circle().path(in: rect)
        }
    }
}

/// 图标位置 - 与 antd iconPlacement 一致
public enum MoinUIButtonIconPlacement {
    case start
    case end
}

/// Loading 配置 - 支持 delay 和自定义 icon
public struct MoinUIButtonLoading: ExpressibleByBooleanLiteral, Equatable {
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

/// MoinUI Button Component
public struct MoinUIButton<Label: View>: View {
    private let action: (() -> Void)?
    private let label: Label
    private let color: MoinUIButtonColor
    private let size: MoinUIButtonSize
    private let variant: MoinUIButtonVariant
    private let shape: MoinUIButtonShape
    private let loadingConfig: MoinUIButtonLoading
    private let isDisabled: Bool
    private let isBlock: Bool
    private let isGhost: Bool
    private let icon: String?
    private let iconPlacement: MoinUIButtonIconPlacement
    private let href: URL?
    private let target: String?
    private let gradient: LinearGradient?
    private let fontColor: Color?

    @State private var isHovered = false
    @State private var isPressed = false
    @State private var showLoading = false
    @State private var rotationAngle: Double = 0

    // 使用 Environment 获取配置，避免每个按钮都订阅 ObservedObject
    @Environment(\.moinUIToken) private var token
    @Environment(\.moinUIButtonToken) private var buttonToken

    public init(
        color: MoinUIButtonColor = .default,
        size: MoinUIButtonSize = .medium,
        variant: MoinUIButtonVariant = .solid,
        shape: MoinUIButtonShape = .default,
        icon: String? = nil,
        iconPlacement: MoinUIButtonIconPlacement = .start,
        loading: MoinUIButtonLoading = false,
        isDisabled: Bool = false,
        isBlock: Bool = false,
        isGhost: Bool = false,
        href: URL? = nil,
        target: String? = nil,
        gradient: LinearGradient? = nil,
        fontColor: Color? = nil,
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
        self.target = target
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

    private var baseColor: Color {
        switch color {
        case .default: return Color.gray
        case .primary: return token.colorPrimary
        case .success: return token.colorSuccess
        case .warning: return token.colorWarning
        case .danger: return token.colorDanger
        case .info: return token.colorInfo
        case .custom(let c): return c
        }
    }

    // MARK: - Body

    public var body: some View {
        Group {
            if let href = href {
                Link(destination: href) { buttonContent }
            } else {
                Button(action: handleAction) { buttonContent }
            }
        }
        .buttonStyle(.plain)
        .disabled(effectiveDisabled && !shouldApplyDisabledOpacity)
        .allowsHitTesting(!effectiveDisabled)
        .opacity(shouldApplyDisabledOpacity ? 0.65 : 1)
        .onHover { hovering in
            guard isHovered != hovering else { return }
            withAnimation(.easeInOut(duration: token.motionDuration / 2)) {
                isHovered = hovering
                if !hovering { isPressed = false }
            }
            if hovering {
                let cursor: NSCursor = effectiveDisabled ? .operationNotAllowed : .pointingHand
                cursor.set()
            } else {
                NSCursor.arrow.set()
            }
        }
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in
                    if !isPressed {
                        withAnimation(.easeInOut(duration: token.motionDuration / 2)) {
                            isPressed = true
                        }
                    }
                }
                .onEnded { _ in
                    withAnimation(.easeInOut(duration: token.motionDuration / 2)) {
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
        .frame(maxWidth: isBlock ? .infinity : nil)
        .frame(minWidth: shape == .circle ? controlHeight : nil)
        .padding(.vertical, verticalPadding > 0 ? verticalPadding : 0)
        .padding(.horizontal, shape == .circle ? 0 : horizontalPadding)
        .background(backgroundView)
        .clipShape(buttonShape)
        .overlay(borderOverlay)
        .contentShape(Rectangle())
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
        Image(systemName: loadingIcon)
            .font(.system(size: iconSize))
            .rotationEffect(.degrees(rotationAngle))
            .onAppear {
                withAnimation(.linear(duration: 1).repeatForever(autoreverses: false)) {
                    rotationAngle = 360
                }
            }
    }

    private var buttonShape: MoinUIButtonShapeStyle {
        MoinUIButtonShapeStyle(shapeType: shape, cornerRadius: cornerRadius)
    }

    @ViewBuilder
    private var borderOverlay: some View {
        if variant == .dashed {
            buttonShape
                .stroke(borderColor, style: StrokeStyle(lineWidth: MoinUIConstants.Button.borderWidth, dash: [4, 3]))
        } else {
            buttonShape
                .stroke(borderColor, lineWidth: MoinUIConstants.Button.borderWidth)
        }
    }

    // MARK: - Sizing

    private var iconSize: CGFloat {
        switch size {
        case .small: return buttonToken.onlyIconSizeSM
        case .medium: return buttonToken.onlyIconSize
        case .large: return buttonToken.onlyIconSizeLG
        }
    }

    private var fontSize: CGFloat {
        switch size {
        case .small: return buttonToken.contentFontSizeSM
        case .medium: return buttonToken.contentFontSize
        case .large: return buttonToken.contentFontSizeLG
        }
    }

    private var controlHeight: CGFloat {
        switch size {
        case .small: return token.controlHeightSM
        case .medium: return token.controlHeight
        case .large: return token.controlHeightLG
        }
    }

    private var horizontalPadding: CGFloat {
        switch size {
        case .small: return buttonToken.paddingInlineSM
        case .medium: return buttonToken.paddingInline
        case .large: return buttonToken.paddingInlineLG
        }
    }

    private var verticalPadding: CGFloat {
        switch size {
        case .small: return buttonToken.paddingBlockSM
        case .medium: return buttonToken.paddingBlock
        case .large: return buttonToken.paddingBlockLG
        }
    }

    private var cornerRadius: CGFloat {
        switch size {
        case .small: return token.borderRadiusSM
        case .medium: return token.borderRadius
        case .large: return token.borderRadiusLG
        }
    }

    // MARK: - Colors

    private var hoverColor: Color {
        baseColor.lightened(by: 0.08)
    }

    private var activeColor: Color {
        baseColor.darkened(by: 0.08)
    }

    private var backgroundColor: Color {
        // Ghost 模式背景透明，hover 时白色半透明
        if isGhost {
            if isPressed { return Color.white.opacity(0.25) }
            else if isHovered { return Color.white.opacity(0.15) }
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

    private var foregroundColor: Color {
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
            if color.isDefault { return buttonToken.defaultColor }
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

    private var borderColor: Color {
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
            rotationAngle = 0
        }
    }
}

// MARK: - Convenience Initializers

public extension MoinUIButton where Label == Text {
    init(
        _ title: String,
        color: MoinUIButtonColor = .default,
        size: MoinUIButtonSize = .medium,
        variant: MoinUIButtonVariant = .solid,
        shape: MoinUIButtonShape = .default,
        icon: String? = nil,
        iconPlacement: MoinUIButtonIconPlacement = .start,
        loading: MoinUIButtonLoading = false,
        isDisabled: Bool = false,
        isBlock: Bool = false,
        isGhost: Bool = false,
        href: URL? = nil,
        gradient: LinearGradient? = nil,
        fontColor: Color? = nil,
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

public extension MoinUIButton where Label == EmptyView {
    init(
        icon iconName: String,
        color: MoinUIButtonColor = .default,
        size: MoinUIButtonSize = .medium,
        variant: MoinUIButtonVariant = .solid,
        shape: MoinUIButtonShape = .circle,
        loading: MoinUIButtonLoading = false,
        isDisabled: Bool = false,
        isGhost: Bool = false,
        href: URL? = nil,
        gradient: LinearGradient? = nil,
        fontColor: Color? = nil,
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
