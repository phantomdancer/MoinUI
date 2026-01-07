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
public struct MoinUIButtonLoading: ExpressibleByBooleanLiteral {
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
    private let type: MoinUIButtonType
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
    private let color: Color?
    private let gradient: LinearGradient?

    @State private var isHovered = false
    @State private var isPressed = false
    @State private var showLoading = false
    @State private var loadingRotation: Double = 0

    @ObservedObject private var configProvider = MoinUIConfigProvider.shared
    private var token: MoinUIToken { configProvider.token }

    public init(
        type: MoinUIButtonType = .default,
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
        color: Color? = nil,
        gradient: LinearGradient? = nil,
        action: (() -> Void)? = nil,
        @ViewBuilder label: () -> Label
    ) {
        self.type = type
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
        self.color = color
        self.gradient = gradient
        self.action = action
        self.label = label()
    }

    // MARK: - Computed Properties

    private var isLoading: Bool { showLoading }

    private var effectiveDisabled: Bool {
        isDisabled || isLoading
    }

    private var shouldApplyDisabledOpacity: Bool {
        effectiveDisabled && (hasCustomColor || type != .default || gradient != nil)
    }

    private var hasCustomColor: Bool {
        color != nil
    }

    private var baseColor: Color {
        if let color = color { return color }
        return colorForType(type)
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
        .animation(.easeInOut(duration: token.motionDuration / 2), value: isHovered)
        .animation(.easeInOut(duration: token.motionDuration / 2), value: isPressed)
        .onHover { hovering in
            isHovered = hovering
            if !hovering { isPressed = false }
            updateCursor(hovering: hovering)
        }
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in isPressed = true }
                .onEnded { _ in isPressed = false }
        )
        .onChange(of: loadingConfig.isLoading) { newValue in
            handleLoadingChange(newValue)
        }
        .onAppear {
            if loadingConfig.isLoading {
                handleLoadingChange(true)
            }
        }
    }

    // MARK: - Button Content

    @ViewBuilder
    private var buttonContent: some View {
        HStack(spacing: Constants.Button.iconSpacing) {
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
        .font(.system(size: fontSize, weight: .medium))
        .foregroundColor(foregroundColor)
        .frame(height: controlHeight)
        .frame(maxWidth: isBlock ? .infinity : nil)
        .frame(minWidth: shape == .circle ? controlHeight : nil)
        .padding(.horizontal, shape == .circle ? 0 : horizontalPadding)
        .background(backgroundView)
        .clipShape(buttonShape)
        .overlay(borderOverlay)
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
            .rotationEffect(.degrees(loadingRotation))
            .id(isLoading)
            .onAppear {
                loadingRotation = 0
                withAnimation(.linear(duration: 1).repeatForever(autoreverses: false)) {
                    loadingRotation = 360
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
                .stroke(borderColor, style: StrokeStyle(lineWidth: Constants.Button.borderWidth, dash: [4, 3]))
        } else {
            buttonShape
                .stroke(borderColor, lineWidth: Constants.Button.borderWidth)
        }
    }

    // MARK: - Sizing

    private var iconSize: CGFloat {
        switch size {
        case .small: return token.fontSizeSM
        case .medium: return token.fontSize
        case .large: return token.fontSizeLG
        }
    }

    private var fontSize: CGFloat {
        switch size {
        case .small: return token.fontSizeSM
        case .medium: return token.fontSize
        case .large: return token.fontSizeLG
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
        case .small: return token.paddingSM
        case .medium: return token.padding
        case .large: return token.paddingLG
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

    private func colorForType(_ buttonType: MoinUIButtonType) -> Color {
        switch buttonType {
        case .default: return Color.gray
        case .primary: return token.colorPrimary
        case .success: return token.colorSuccess
        case .warning: return token.colorWarning
        case .danger: return token.colorDanger
        case .info: return token.colorInfo
        }
    }

    private func hoverColorForType(_ buttonType: MoinUIButtonType) -> Color {
        if hasCustomColor { return baseColor.lightened(by: 0.08) }
        switch buttonType {
        case .default: return token.colorBgHover
        case .primary: return token.colorPrimaryHover
        case .success: return Color(red: 0.45, green: 0.80, blue: 0.40)
        case .warning: return Color(red: 1.0, green: 0.78, blue: 0.40)
        case .danger: return Color(red: 1.0, green: 0.47, blue: 0.47)
        case .info: return Color(red: 0.65, green: 0.65, blue: 0.65)
        }
    }

    private func activeColorForType(_ buttonType: MoinUIButtonType) -> Color {
        if hasCustomColor { return baseColor.darkened(by: 0.08) }
        return hoverColorForType(buttonType).darkened(by: 0.1)
    }

    private var backgroundColor: Color {
        // Ghost 模式背景透明，hover 时白色半透明
        if isGhost {
            if isPressed { return Color.white.opacity(0.25) }
            else if isHovered { return Color.white.opacity(0.15) }
            return .clear
        }

        // 禁用状态
        if effectiveDisabled {
            switch variant {
            case .solid:
                if hasCustomColor || type != .default { return baseColor }
                return token.colorBgDisabled
            case .filled:
                return baseColor.opacity(0.15)
            case .outlined, .dashed, .text, .link:
                return .clear
            }
        }

        switch variant {
        case .solid:
            if !hasCustomColor && type == .default {
                if isPressed { return token.colorBgContainer.opacity(0.85) }
                else if isHovered { return token.colorBgHover }
                return token.colorBgContainer
            }
            if isPressed { return activeColorForType(type) }
            else if isHovered { return hoverColorForType(type) }
            return baseColor

        case .filled:
            if isPressed { return baseColor.opacity(0.25) }
            else if isHovered { return baseColor.opacity(0.2) }
            return baseColor.opacity(0.15)

        case .outlined, .dashed, .text:
            if isPressed { return baseColor.opacity(0.15) }
            else if isHovered { return baseColor.opacity(0.1) }
            return .clear

        case .link:
            return .clear
        }
    }

    private var foregroundColor: Color {
        // Ghost 模式：default 用白色，有色用原色
        if isGhost {
            if effectiveDisabled { return Color.white.opacity(0.5) }
            return hasCustomColor || type != .default ? baseColor : Color.white
        }

        // 禁用状态
        if effectiveDisabled {
            if hasCustomColor || type != .default {
                return variant == .solid ? .white : baseColor
            }
            return token.colorTextDisabled
        }

        switch variant {
        case .solid:
            if hasCustomColor { return .white }
            return type == .default ? token.colorText : .white

        case .filled, .outlined, .dashed, .text:
            if !hasCustomColor && type == .default {
                return isHovered ? token.colorPrimary : token.colorText
            }
            return baseColor

        case .link:
            if !hasCustomColor && type == .default {
                return isHovered ? token.colorPrimary.opacity(0.8) : token.colorPrimary
            }
            return isHovered ? baseColor.opacity(0.8) : baseColor
        }
    }

    private var borderColor: Color {
        // Ghost 模式：default 用白色边框，有色用原色边框
        if isGhost {
            if effectiveDisabled { return Color.white.opacity(0.3) }
            return hasCustomColor || type != .default ? baseColor : Color.white
        }

        // 禁用状态
        if effectiveDisabled {
            if hasCustomColor || type != .default { return baseColor }
            switch variant {
            case .solid, .outlined, .dashed, .filled:
                return token.colorBorder.opacity(0.5)
            case .text, .link:
                return .clear
            }
        }

        switch variant {
        case .solid:
            if !hasCustomColor && type == .default { return token.colorBorder }
            if isPressed { return activeColorForType(type) }
            else if isHovered { return hoverColorForType(type) }
            return baseColor

        case .outlined, .dashed:
            if !hasCustomColor && type == .default {
                return isHovered ? token.colorBorderHover : token.colorBorder
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

    private func updateCursor(hovering: Bool) {
        if effectiveDisabled {
            if hovering { NSCursor.operationNotAllowed.push() }
            else { NSCursor.pop() }
        } else {
            if hovering { NSCursor.pointingHand.push() }
            else { NSCursor.pop() }
        }
    }
}

// MARK: - Convenience Initializers

public extension MoinUIButton where Label == Text {
    init(
        _ title: String,
        type: MoinUIButtonType = .default,
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
        color: Color? = nil,
        gradient: LinearGradient? = nil,
        action: (() -> Void)? = nil
    ) {
        self.init(
            type: type,
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
            color: color,
            gradient: gradient,
            action: action
        ) {
            Text(title)
        }
    }
}

public extension MoinUIButton where Label == EmptyView {
    init(
        icon iconName: String,
        type: MoinUIButtonType = .default,
        size: MoinUIButtonSize = .medium,
        variant: MoinUIButtonVariant = .solid,
        shape: MoinUIButtonShape = .circle,
        loading: MoinUIButtonLoading = false,
        isDisabled: Bool = false,
        isGhost: Bool = false,
        href: URL? = nil,
        color: Color? = nil,
        gradient: LinearGradient? = nil,
        action: (() -> Void)? = nil
    ) {
        self.init(
            type: type,
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
            color: color,
            gradient: gradient,
            action: action
        ) {
            EmptyView()
        }
    }
}
