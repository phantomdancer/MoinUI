import SwiftUI


// MARK: - _Radio (internal name, use Moin.Radio)

public struct _Radio<Label: View>: View {
    @Binding var checked: Bool
    var disabled: Bool

    let label: Label

    @Environment(\.moinRadioToken) private var radioToken
    @Environment(\.moinToken) private var token
    @Environment(\.isEnabled) private var isEnabled

    public init(
        checked: Binding<Bool>,
        disabled: Bool = false,
        @ViewBuilder label: () -> Label
    ) {
        self._checked = checked
        self.disabled = disabled
        self.label = label()
    }

    @State private var isHovering: Bool = false

    private var isEffectiveDisabled: Bool {
        !isEnabled || disabled
    }

    public var body: some View {
        HStack(spacing: radioToken.paddingXS) {
            radio

            if !(Label.self == EmptyView.self) {
                label
                    .font(.system(size: token.fontSize))
                    .foregroundStyle(isEffectiveDisabled ? radioToken.colorTextDisabled : token.colorText)
                    .lineLimit(1)
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            if !isEffectiveDisabled {
                withAnimation(.easeInOut(duration: radioToken.motionDurationMid)) {
                    checked = true
                }
            }
        }
        .onContinuousHover { phase in
            switch phase {
            case .active(_):
                if !isEffectiveDisabled {
                    NSCursor.pointingHand.set()
                    if !isHovering {
                        withAnimation(.easeInOut(duration: radioToken.motionDurationMid)) { isHovering = true }
                    }
                } else {
                    NSCursor.operationNotAllowed.set()
                }
            case .ended:
                NSCursor.arrow.set()
                if isHovering {
                    withAnimation(.easeInOut(duration: radioToken.motionDurationMid)) { isHovering = false }
                }
            }
        }
    }

    private var radio: some View {
        ZStack {
            // Background & Border
            Circle()
                .strokeBorder(borderColor, lineWidth: radioToken.lineWidth)
                .background(Circle().fill(backgroundColor))

            // Dot
            Circle()
                .fill(isEffectiveDisabled ? radioToken.dotColorDisabled : radioToken.radioColor)
                .frame(width: radioToken.dotSize, height: radioToken.dotSize)
                .scaleEffect(checked ? 1 : 0)
                .opacity(checked ? 1 : 0)
        }
        .frame(width: radioToken.radioSize, height: radioToken.radioSize)
        .animation(.easeInOut(duration: radioToken.motionDurationMid), value: checked)
        .animation(.easeInOut(duration: radioToken.motionDurationMid), value: isHovering)
    }

    private var backgroundColor: Color {
        if isEffectiveDisabled {
            return radioToken.colorBgContainerDisabled
        }
        return radioToken.colorBgContainer
    }

    private var borderColor: Color {
        if isEffectiveDisabled {
            return radioToken.colorBorderDisabled
        }
        if checked {
            return radioToken.colorPrimary
        }
        if isHovering {
            return radioToken.colorPrimaryHover
        }
        return radioToken.colorBorder
    }
}

// MARK: - Convenience Initializers

public extension _Radio where Label == Text {
    init(_ titleKey: LocalizedStringKey, checked: Binding<Bool>, disabled: Bool = false) {
        self.init(checked: checked, disabled: disabled) {
            Text(titleKey)
        }
    }

    init<S>(_ title: S, checked: Binding<Bool>, disabled: Bool = false) where S : StringProtocol {
        self.init(checked: checked, disabled: disabled) {
            Text(title)
        }
    }
}

public extension _Radio where Label == EmptyView {
    init(checked: Binding<Bool>, disabled: Bool = false) {
        self.init(checked: checked, disabled: disabled) {
            EmptyView()
        }
    }
}



// MARK: - Moin.Radio Extensions

