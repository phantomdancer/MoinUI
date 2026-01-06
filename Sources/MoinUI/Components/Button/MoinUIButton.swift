import SwiftUI

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

/// MoinUI Button Component
public struct MoinUIButton<Label: View>: View {
    private let action: () -> Void
    private let label: Label
    private let type: MoinUIButtonType
    private let size: MoinUIButtonSize
    private let variant: MoinUIButtonVariant
    private let shape: MoinUIButtonShape
    private let isLoading: Bool
    private let isDisabled: Bool
    private let isBlock: Bool

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
        isLoading: Bool = false,
        isDisabled: Bool = false,
        isBlock: Bool = false,
        action: @escaping () -> Void,
        @ViewBuilder label: () -> Label
    ) {
        self.type = type
        self.size = size
        self.variant = variant
        self.shape = shape
        self.isLoading = isLoading
        self.isDisabled = isDisabled
        self.isBlock = isBlock
        self.action = action
        self.label = label()
    }

    public var body: some View {
        Button(action: handleAction) {
            HStack(spacing: Constants.Button.iconSpacing) {
                if isLoading {
                    loadingIndicator
                }
                label
                    .opacity(isLoading ? 0.7 : 1)
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
        .buttonStyle(.plain)
        .disabled(effectiveDisabled)
        .opacity(effectiveDisabled ? 0.6 : 1)
        .animation(.easeInOut(duration: token.motionDuration / 2), value: isHovered)
        .animation(.easeInOut(duration: token.motionDuration / 2), value: isPressed)
        .onHover { hovering in
            isHovered = hovering
        }
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in isPressed = true }
                .onEnded { _ in isPressed = false }
        )
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
        action()
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
        let baseColor = colorForType(type)

        switch variant {
        case .solid:
            if type == .default {
                if isPressed {
                    return token.colorBgContainer.opacity(0.8)
                } else if isHovered {
                    return token.colorBgHover
                }
                return token.colorBgContainer
            }
            if isPressed {
                return baseColor.opacity(0.8)
            } else if isHovered {
                return baseColor.opacity(0.9)
            }
            return baseColor
        case .outline, .text, .link, .ghost:
            if isPressed {
                return baseColor.opacity(0.1)
            } else if isHovered {
                return baseColor.opacity(0.05)
            }
            return .clear
        }
    }

    private var foregroundColor: Color {
        guard !effectiveDisabled else {
            return token.colorTextDisabled
        }

        let baseColor = colorForType(type)

        switch variant {
        case .solid:
            return type == .default ? token.colorText : .white
        case .outline, .text, .ghost:
            if type == .default {
                return isHovered ? token.colorPrimary : token.colorText
            }
            return baseColor
        case .link:
            if type == .default {
                return isHovered ? token.colorPrimary.opacity(0.8) : token.colorPrimary
            }
            return isHovered ? baseColor.opacity(0.8) : baseColor
        }
    }

    private var borderColor: Color {
        let baseColor = colorForType(type)

        switch variant {
        case .solid:
            return type == .default ? token.colorBorder : baseColor
        case .outline:
            if type == .default {
                return isHovered ? token.colorBorderHover : token.colorBorder
            }
            return baseColor
        case .text, .link:
            return .clear
        case .ghost:
            if type == .default {
                return token.colorBorder
            }
            return baseColor.opacity(0.5)
        }
    }
}

// MARK: - Convenience Initializers

public extension MoinUIButton where Label == Text {
    /// Create a button with text label
    init(
        _ title: String,
        type: MoinUIButtonType = .default,
        size: MoinUIButtonSize = .medium,
        variant: MoinUIButtonVariant = .solid,
        shape: MoinUIButtonShape = .default,
        isLoading: Bool = false,
        isDisabled: Bool = false,
        isBlock: Bool = false,
        action: @escaping () -> Void
    ) {
        self.init(
            type: type,
            size: size,
            variant: variant,
            shape: shape,
            isLoading: isLoading,
            isDisabled: isDisabled,
            isBlock: isBlock,
            action: action
        ) {
            Text(title)
        }
    }
}

public extension MoinUIButton where Label == AnyView {
    /// Create an icon-only button
    init(
        icon: String,
        type: MoinUIButtonType = .default,
        size: MoinUIButtonSize = .medium,
        variant: MoinUIButtonVariant = .solid,
        shape: MoinUIButtonShape = .circle,
        isLoading: Bool = false,
        isDisabled: Bool = false,
        action: @escaping () -> Void
    ) {
        let token = MoinUIConfigProvider.shared.token
        let iconSize: CGFloat = {
            switch size {
            case .small: return token.fontSizeSM
            case .medium: return token.fontSize
            case .large: return token.fontSizeLG
            }
        }()
        self.init(
            type: type,
            size: size,
            variant: variant,
            shape: shape,
            isLoading: isLoading,
            isDisabled: isDisabled,
            isBlock: false,
            action: action
        ) {
            AnyView(
                Image(systemName: icon)
                    .font(.system(size: iconSize))
            )
        }
    }
}
