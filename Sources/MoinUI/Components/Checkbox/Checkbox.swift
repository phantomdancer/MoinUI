import SwiftUI


// MARK: - _Checkbox (internal name, use Moin.Checkbox.View)

public struct _Checkbox<Label: View>: View {
    @Binding var checked: Bool
    var indeterminate: Bool
    var disabled: Bool

    let label: Label

    @Environment(\.moinCheckboxToken) private var checkboxToken
    @Environment(\.moinToken) private var token
    @Environment(\.isEnabled) private var isEnabled

    public init(
        checked: Binding<Bool>,
        indeterminate: Bool = false,
        disabled: Bool = false,
        @ViewBuilder label: () -> Label
    ) {
        self._checked = checked
        self.indeterminate = indeterminate
        self.disabled = disabled
        self.label = label()
    }

    @State private var isHovering: Bool = false

    private var isEffectiveDisabled: Bool {
        !isEnabled || disabled
    }

    public var body: some View {
        HStack(spacing: checkboxToken.paddingXS) {
            box

            if !(Label.self == EmptyView.self) {
                label
                    .font(.system(size: token.fontSize))
                    .foregroundStyle(isEffectiveDisabled ? checkboxToken.colorTextDisabled : token.colorText)
                    .lineLimit(1)
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            if !isEffectiveDisabled {
                toggle()
            }
        }
        .onContinuousHover { phase in
            switch phase {
            case .active(_):
                if !isEffectiveDisabled {
                    NSCursor.pointingHand.set()
                    if !isHovering {
                        withAnimation(.easeInOut(duration: checkboxToken.motionDurationMid)) { isHovering = true }
                    }
                } else {
                    NSCursor.operationNotAllowed.set()
                }
            case .ended:
                NSCursor.arrow.set()
                if isHovering {
                    withAnimation(.easeInOut(duration: checkboxToken.motionDurationMid)) { isHovering = false }
                }
            }
        }
    }

    private var box: some View {
        ZStack {
            // Background
            RoundedRectangle(cornerRadius: checkboxToken.borderRadius)
                .fill(boxBackgroundColor)

            // Border
            RoundedRectangle(cornerRadius: checkboxToken.borderRadius)
                .strokeBorder(boxBorderColor, lineWidth: checkboxToken.lineWidth)

            // Indeterminate Block
            if indeterminate {
                Rectangle()
                    .fill(isEffectiveDisabled ? checkboxToken.colorTextDisabled : checkboxToken.colorPrimary)
                    .frame(width: checkboxToken.checkboxSize / 2, height: checkboxToken.checkboxSize / 2)
            }
            // Checkmark
            else if checked {
                CheckmarkShape()
                    .stroke(isEffectiveDisabled ? checkboxToken.colorTextDisabled : checkboxToken.colorWhite, style: StrokeStyle(lineWidth: checkboxToken.lineWidthBold, lineCap: .round, lineJoin: .round))
                    .frame(width: checkboxToken.checkboxSize * 0.7, height: checkboxToken.checkboxSize * 0.7)
            }
        }
        .frame(width: checkboxToken.checkboxSize, height: checkboxToken.checkboxSize)
        .animation(.easeInOut(duration: checkboxToken.motionDurationSlow), value: checked)
        .animation(.easeInOut(duration: checkboxToken.motionDurationSlow), value: indeterminate)
        .animation(.easeInOut(duration: checkboxToken.motionDurationMid), value: isHovering)
    }

    private var boxBackgroundColor: Color {
        if isEffectiveDisabled {
            return checkboxToken.colorBgContainerDisabled
        }
        if checked && !indeterminate {
            return checkboxToken.colorPrimary
        }
        return checkboxToken.colorBgContainer
    }

    private var boxBorderColor: Color {
        if isEffectiveDisabled {
            return checkboxToken.colorBorderDisabled
        }
        if checked && !indeterminate {
            return checkboxToken.colorPrimary
        }

        if isHovering {
            return checkboxToken.colorPrimary
        }

        return checkboxToken.colorBorder
    }

    private func toggle() {
        checked.toggle()
    }
}

// MARK: - Convenience Initializers

public extension _Checkbox where Label == Text {
    init(_ titleKey: LocalizedStringKey, checked: Binding<Bool>, indeterminate: Bool = false, disabled: Bool = false) {
        self.init(checked: checked, indeterminate: indeterminate, disabled: disabled) {
            Text(titleKey)
        }
    }

    init<S>(_ title: S, checked: Binding<Bool>, indeterminate: Bool = false, disabled: Bool = false) where S : StringProtocol {
        self.init(checked: checked, indeterminate: indeterminate, disabled: disabled) {
            Text(title)
        }
    }
}

public extension _Checkbox where Label == EmptyView {
    init(checked: Binding<Bool>, indeterminate: Bool = false, disabled: Bool = false) {
        self.init(checked: checked, indeterminate: indeterminate, disabled: disabled) {
            EmptyView()
        }
    }
}



// MARK: - Shapes

private struct CheckmarkShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        let start = CGPoint(x: rect.minX + rect.width * 0.2, y: rect.minY + rect.height * 0.5)
        let mid = CGPoint(x: rect.minX + rect.width * 0.45, y: rect.maxY - rect.height * 0.2)
        let end = CGPoint(x: rect.maxX - rect.width * 0.1, y: rect.minY + rect.height * 0.2)

        path.move(to: start)
        path.addLine(to: mid)
        path.addLine(to: end)

        return path
    }
}

// MARK: - Moin.Checkbox Extensions

