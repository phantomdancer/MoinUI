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

/// 图标位置
public enum MoinUIButtonIconPosition {
    case leading
    case trailing
}

/// MoinUI Button Component
public struct MoinUIButton<Label: View>: View {
    private let action: (() -> Void)?
    private let label: Label
    private let type: MoinUIButtonType
    private let size: MoinUIButtonSize
    private let variant: MoinUIButtonVariant
    private let shape: MoinUIButtonShape
    private let isLoading: Bool
    private let isDisabled: Bool
    private let isBlock: Bool
    private let icon: String?
    private let iconPosition: MoinUIButtonIconPosition
    private let href: URL?
    private let target: String?
    private let color: Color?

    @State private var isHovered = false
    @State private var isPressed = false

    /// Observe config changes for real-time updates
    @ObservedObject private var configProvider = MoinUIConfigProvider.shared

    /// Access global token
    private var token: MoinUIToken { configProvider.token }

    public init(
        type: MoinUIButtonType = .default,
        size: MoinUIButtonSize = .medium,
        variant: MoinUIButtonVariant = .solid,
        shape: MoinUIButtonShape = .default,
        icon: String? = nil,
        iconPosition: MoinUIButtonIconPosition = .leading,
        isLoading: Bool = false,
        isDisabled: Bool = false,
        isBlock: Bool = false,
        href: URL? = nil,
        target: String? = nil,
        color: Color? = nil,
        action: (() -> Void)? = nil,
        @ViewBuilder label: () -> Label
    ) {
        self.type = type
        self.size = size
        self.variant = variant
        self.shape = shape
        self.icon = icon
        self.iconPosition = iconPosition
        self.isLoading = isLoading
        self.isDisabled = isDisabled
        self.isBlock = isBlock
        self.href = href
        self.target = target
        self.color = color
        self.action = action
        self.label = label()
    }

    public var body: some View {
        Group {
            if let href = href {
                Link(destination: href) {
                    buttonContent
                }
            } else {
                Button(action: handleAction) {
                    buttonContent
                }
            }
        }
        .buttonStyle(.plain)
        .disabled(effectiveDisabled)
        .animation(.easeInOut(duration: token.motionDuration / 2), value: isHovered)
        .animation(.easeInOut(duration: token.motionDuration / 2), value: isPressed)
        .onHover { hovering in
            isHovered = hovering
            // 设置鼠标指针样式
            if effectiveDisabled {
                if hovering {
                    NSCursor.operationNotAllowed.push()
                } else {
                    NSCursor.pop()
                }
            } else {
                if hovering {
                    NSCursor.pointingHand.push()
                } else {
                    NSCursor.pop()
                }
            }
        }
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in isPressed = true }
                .onEnded { _ in isPressed = false }
        )
    }

    @ViewBuilder
    private var buttonContent: some View {
        HStack(spacing: Constants.Button.iconSpacing) {
            if isLoading {
                loadingIndicator
            } else if let icon = icon, iconPosition == .leading {
                iconView(icon)
            }
            label
                .opacity(isLoading ? 0.7 : 1)
            if !isLoading, let icon = icon, iconPosition == .trailing {
                iconView(icon)
            }
        }
        .font(.system(size: fontSize, weight: .medium))
        .foregroundColor(foregroundColor)
        .frame(height: controlHeight)
        .frame(maxWidth: isBlock ? .infinity : nil)
        .frame(minWidth: shape == .circle ? controlHeight : nil)
        .padding(.horizontal, shape == .circle ? 0 : horizontalPadding)
        .background(backgroundColor)
        .clipShape(buttonShape)
        .overlay(borderOverlay)
    }

    @ViewBuilder
    private func iconView(_ iconName: String) -> some View {
        Image(systemName: iconName)
            .font(.system(size: iconSize))
    }

    private var iconSize: CGFloat {
        switch size {
        case .small: return token.fontSizeSM
        case .medium: return token.fontSize
        case .large: return token.fontSizeLG
        }
    }

    // MARK: - Token-based sizing

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

    // MARK: - Token-based colors

    /// 获取按钮基础颜色（自定义颜色优先）
    private var baseColor: Color {
        if let color = color {
            return color
        }
        return colorForType(type)
    }

    /// 是否使用自定义颜色
    private var hasCustomColor: Bool {
        color != nil
    }

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

    private var effectiveDisabled: Bool {
        isDisabled || isLoading
    }

    private func handleAction() {
        guard !effectiveDisabled else { return }
        action?()
    }

    @ViewBuilder
    private var loadingIndicator: some View {
        ProgressView()
            .controlSize(.small)
            .progressViewStyle(.circular)
    }

    private var buttonShape: MoinUIButtonShapeStyle {
        MoinUIButtonShapeStyle(shapeType: shape, cornerRadius: cornerRadius)
    }

    @ViewBuilder
    private var borderOverlay: some View {
        buttonShape
            .stroke(borderColor, lineWidth: Constants.Button.borderWidth)
    }

    private var backgroundColor: Color {
        // 禁用状态：使用专门的禁用背景色
        if effectiveDisabled {
            switch variant {
            case .solid:
                return token.colorBgDisabled
            case .outline, .text, .link, .ghost:
                return .clear
            }
        }

        switch variant {
        case .solid:
            // 无自定义颜色且 type 为 default
            if !hasCustomColor && type == .default {
                if isPressed {
                    return token.colorBgContainer.opacity(0.85)
                } else if isHovered {
                    return token.colorBgHover
                }
                return token.colorBgContainer
            }
            // 有色按钮（自定义颜色或语义色）
            if isPressed {
                return activeColorForType(type)
            } else if isHovered {
                return hoverColorForType(type)
            }
            return baseColor
        case .outline, .text, .ghost:
            if isPressed {
                return baseColor.opacity(0.15)
            } else if isHovered {
                return baseColor.opacity(0.1)
            }
            return .clear
        case .link:
            return .clear
        }
    }

    /// 获取 hover 状态的颜色
    private func hoverColorForType(_ buttonType: MoinUIButtonType) -> Color {
        // 自定义颜色使用 lighten
        if hasCustomColor {
            return baseColor.lightened(by: 0.08)
        }
        switch buttonType {
        case .default: return token.colorBgHover
        case .primary: return token.colorPrimaryHover
        case .success: return Color(red: 0.45, green: 0.80, blue: 0.40)
        case .warning: return Color(red: 1.0, green: 0.78, blue: 0.40)
        case .danger: return Color(red: 1.0, green: 0.47, blue: 0.47)
        case .info: return Color(red: 0.65, green: 0.65, blue: 0.65)
        }
    }

    /// 获取 active 状态的颜色
    private func activeColorForType(_ buttonType: MoinUIButtonType) -> Color {
        if hasCustomColor {
            return baseColor.darkened(by: 0.08)
        }
        return hoverColorForType(buttonType).darkened(by: 0.1)
    }

    private var foregroundColor: Color {
        guard !effectiveDisabled else {
            return token.colorTextDisabled
        }

        switch variant {
        case .solid:
            // solid 统一白色文字（与 antd 一致），default 类型除外
            if hasCustomColor {
                return .white
            }
            return type == .default ? token.colorText : .white
        case .outline, .text, .ghost:
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
        // 禁用状态：使用专门的禁用边框色
        if effectiveDisabled {
            switch variant {
            case .solid, .outline:
                return token.colorBorder.opacity(0.5)
            case .text, .link:
                return .clear
            case .ghost:
                return token.colorBorder.opacity(0.3)
            }
        }

        switch variant {
        case .solid:
            if hasCustomColor {
                return baseColor
            }
            return type == .default ? token.colorBorder : baseColor
        case .outline:
            if !hasCustomColor && type == .default {
                return isHovered ? token.colorBorderHover : token.colorBorder
            }
            return baseColor
        case .text, .link:
            return .clear
        case .ghost:
            if !hasCustomColor && type == .default {
                return token.colorBorder
            }
            return baseColor.opacity(0.5)
        }
    }
}

// MARK: - Convenience Initializers

public extension MoinUIButton where Label == Text {
    /// 创建文本按钮
    init(
        _ title: String,
        type: MoinUIButtonType = .default,
        size: MoinUIButtonSize = .medium,
        variant: MoinUIButtonVariant = .solid,
        shape: MoinUIButtonShape = .default,
        icon: String? = nil,
        iconPosition: MoinUIButtonIconPosition = .leading,
        isLoading: Bool = false,
        isDisabled: Bool = false,
        isBlock: Bool = false,
        href: URL? = nil,
        color: Color? = nil,
        action: (() -> Void)? = nil
    ) {
        self.init(
            type: type,
            size: size,
            variant: variant,
            shape: shape,
            icon: icon,
            iconPosition: iconPosition,
            isLoading: isLoading,
            isDisabled: isDisabled,
            isBlock: isBlock,
            href: href,
            color: color,
            action: action
        ) {
            Text(title)
        }
    }
}

public extension MoinUIButton where Label == EmptyView {
    /// 创建纯图标按钮
    init(
        icon iconName: String,
        type: MoinUIButtonType = .default,
        size: MoinUIButtonSize = .medium,
        variant: MoinUIButtonVariant = .solid,
        shape: MoinUIButtonShape = .circle,
        isLoading: Bool = false,
        isDisabled: Bool = false,
        href: URL? = nil,
        color: Color? = nil,
        action: (() -> Void)? = nil
    ) {
        self.init(
            type: type,
            size: size,
            variant: variant,
            shape: shape,
            icon: iconName,
            iconPosition: .leading,
            isLoading: isLoading,
            isDisabled: isDisabled,
            isBlock: false,
            href: href,
            color: color,
            action: action
        ) {
            EmptyView()
        }
    }
}
