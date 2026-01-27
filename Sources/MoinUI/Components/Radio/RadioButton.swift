import SwiftUI

// MARK: - _RadioButton (internal name, use Moin.Radio.Button)

public struct _RadioButton<Label: View>: View {
    @Binding var checked: Bool
    var disabled: Bool
    let buttonStyle: _RadioButtonStyle
    let position: _RadioButtonPosition
    let direction: Axis
    let onHover: ((Bool) -> Void)?
    let label: Label
    let block: Bool
    let size: _RadioSize

    @Environment(\.moinRadioToken) private var radioToken
    @Environment(\.moinToken) private var token
    @Environment(\.isEnabled) private var isEnabled

    @State private var isHovering: Bool = false
    @State private var isPressed: Bool = false

    public init(
        checked: Binding<Bool>,
        disabled: Bool = false,
        buttonStyle: _RadioButtonStyle = .outline,
        position: _RadioButtonPosition = .single,
        direction: Axis = .horizontal,
        onHover: ((Bool) -> Void)? = nil,
        block: Bool = false,
        size: _RadioSize = .middle,
        @ViewBuilder label: () -> Label
    ) {
        self._checked = checked
        self.disabled = disabled
        self.buttonStyle = buttonStyle
        self.position = position
        self.direction = direction
        self.onHover = onHover
        self.block = block
        self.size = size
        self.label = label()
    }

    // Custom Shape for handling round corners
    struct SegmentedShape: Shape, InsettableShape {
        var position: _RadioButtonPosition
        var direction: Axis
        var radius: CGFloat
        var insetAmount: CGFloat = 0

        func path(in rect: CGRect) -> Path {
            let r = rect.insetBy(dx: insetAmount, dy: insetAmount)
            var path = Path()

            // Logic:
            // Single: All rounded
            // First: (Horz) Left rounded, (Vert) Top rounded
            // Last: (Horz) Right rounded, (Vert) Bottom rounded
            // Middle: None rounded

            var roundTL = false, roundTR = false, roundBR = false, roundBL = false

            switch position {
            case .single:
                roundTL = true; roundTR = true; roundBR = true; roundBL = true
            case .middle:
                break
            case .first:
                if direction == .horizontal {
                    roundTL = true; roundBL = true
                } else {
                    roundTL = true; roundTR = true
                }
            case .last:
                if direction == .horizontal {
                    roundTR = true; roundBR = true
                } else {
                    roundBL = true; roundBR = true
                }
            }

            // Draw path
            path.move(to: CGPoint(x: r.minX + (roundTL ? radius : 0), y: r.minY))

            // Top line & Top-Right corner
            path.addLine(to: CGPoint(x: r.maxX - (roundTR ? radius : 0), y: r.minY))
            if roundTR {
                path.addArc(center: CGPoint(x: r.maxX - radius, y: r.minY + radius), radius: radius, startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)
            } else {
                path.addLine(to: CGPoint(x: r.maxX, y: r.minY))
            }

            // Right line & Bottom-Right corner
            path.addLine(to: CGPoint(x: r.maxX, y: r.maxY - (roundBR ? radius : 0)))
            if roundBR {
                path.addArc(center: CGPoint(x: r.maxX - radius, y: r.maxY - radius), radius: radius, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)
            } else {
                path.addLine(to: CGPoint(x: r.maxX, y: r.maxY))
            }

            // Bottom line & Bottom-Left corner
            path.addLine(to: CGPoint(x: r.minX + (roundBL ? radius : 0), y: r.maxY))
            if roundBL {
                path.addArc(center: CGPoint(x: r.minX + radius, y: r.maxY - radius), radius: radius, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)
            } else {
                path.addLine(to: CGPoint(x: r.minX, y: r.maxY))
            }

            // Left line & Top-Left corner
            path.addLine(to: CGPoint(x: r.minX, y: r.minY + (roundTL ? radius : 0)))
            if roundTL {
                path.addArc(center: CGPoint(x: r.minX + radius, y: r.minY + radius), radius: radius, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)
            } else {
                path.addLine(to: CGPoint(x: r.minX, y: r.minY))
            }

            path.closeSubpath()
            return path
        }

        func inset(by amount: CGFloat) -> SegmentedShape {
            var copy = self
            copy.insetAmount += amount
            return copy
        }
    }

    private var isEffectiveDisabled: Bool {
        !isEnabled || disabled
    }

    // MARK: - Size Configuration

    private var paddings: (horizontal: CGFloat, vertical: CGFloat) {
        switch size {
        case .small:
            return (radioToken.buttonPaddingInline - 4, radioToken.buttonPaddingXSVertical)
        case .middle:
            return (radioToken.buttonPaddingInline, radioToken.buttonPaddingDefaultVertical)
        case .large:
            return (radioToken.buttonPaddingInline + 8, radioToken.buttonPaddingLargeVertical)
        }
    }

    // MARK: - Colors

    private var backgroundColor: Color {
        if isEffectiveDisabled {
            if checked {
                return radioToken.buttonCheckedBgDisabled
            }
            return radioToken.buttonBg
        }
        if checked {
            if buttonStyle == .solid {
                if isPressed {
                    return radioToken.buttonSolidCheckedActiveBg
                }
                return isHovering ? radioToken.buttonSolidCheckedHoverBg : radioToken.buttonSolidCheckedBg
            }
            return radioToken.buttonCheckedBg
        }
        return radioToken.buttonBg
    }

    private var foregroundColor: Color {
        if isEffectiveDisabled {
            // 禁用时：选中用 buttonCheckedColorDisabled，未选中用 colorTextDisabled
            return checked ? radioToken.buttonCheckedColorDisabled : radioToken.colorTextDisabled
        }
        if checked {
            return buttonStyle == .solid ? radioToken.buttonSolidCheckedColor : radioToken.colorPrimary
        }
        return isHovering ? radioToken.colorPrimary : radioToken.buttonColor
    }

    private var borderColor: Color {
        if isEffectiveDisabled {
            return radioToken.colorBorder
        }
        if checked {
            return buttonStyle == .solid ? radioToken.buttonSolidCheckedBg : radioToken.colorPrimary
        }
        return isHovering ? radioToken.colorPrimary : radioToken.colorBorder
    }

    public var body: some View {
        label
            .font(.system(size: token.fontSize))
            .foregroundStyle(foregroundColor)
            .frame(maxWidth: block ? .infinity : nil)
            .padding(.vertical, paddings.vertical)
            .padding(.horizontal, paddings.horizontal)
            .background(
                SegmentedShape(position: position, direction: direction, radius: 6)
                    .fill(backgroundColor)
            )
            .overlay(
                SegmentedShape(position: position, direction: direction, radius: 6)
                    .strokeBorder(borderColor, lineWidth: radioToken.lineWidth)
            )
            .contentShape(SegmentedShape(position: position, direction: direction, radius: 6))
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { _ in
                        if !isEffectiveDisabled && !isPressed {
                            withAnimation(.easeInOut(duration: 0.05)) {
                                isPressed = true
                            }
                        }
                    }
                    .onEnded { _ in
                        if !isEffectiveDisabled {
                            withAnimation(.easeInOut(duration: radioToken.motionDurationMid)) {
                                isPressed = false
                                checked = true
                            }
                        }
                    }
            )
            .onHover { hover in
                if !isEffectiveDisabled {
                    withAnimation(.easeInOut(duration: radioToken.motionDurationMid)) {
                        isHovering = hover
                    }
                    onHover?(hover)
                    if hover { NSCursor.pointingHand.set() } else { NSCursor.arrow.set() }
                } else {
                    if hover { NSCursor.operationNotAllowed.set() } else { NSCursor.arrow.set() }
                }
            }
    }
}


