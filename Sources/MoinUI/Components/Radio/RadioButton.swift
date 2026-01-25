import SwiftUI

public extension Moin {
    enum RadioOptionType {
        case `default`
        case button
    }

    enum RadioButtonStyle {
        case outline
        case solid
    }
    
    public enum RadioButtonPosition: Sendable {
        case first, middle, last, single
    }
    
    struct RadioButton<Label: View>: View {
        @Binding var checked: Bool
        var disabled: Bool
        let buttonStyle: RadioButtonStyle
        let position: RadioButtonPosition
        let direction: Axis
        let onHover: ((Bool) -> Void)?
        let label: Label
        let block: Bool
        let size: RadioSize

        @Environment(\.moinRadioToken) private var radioToken
        @Environment(\.moinToken) private var token
        @Environment(\.isEnabled) private var isEnabled

        @State private var isHovering: Bool = false

        public init(
            checked: Binding<Bool>,
            disabled: Bool = false,
            buttonStyle: RadioButtonStyle = .outline,
            position: RadioButtonPosition = .single,
            direction: Axis = .horizontal,
            onHover: ((Bool) -> Void)? = nil,
            block: Bool = false,
            size: RadioSize = .middle,
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
            var position: RadioButtonPosition
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
                return (radioToken.buttonPaddingXSHorizontal, radioToken.buttonPaddingXSVertical)
            case .middle:
                return (radioToken.buttonPaddingDefaultHorizontal, radioToken.buttonPaddingDefaultVertical)
            case .large:
                return (radioToken.buttonPaddingLargeHorizontal, radioToken.buttonPaddingLargeVertical)
            }
        }

        // MARK: - Colors
        
        private var backgroundColor: Color {
            if isEffectiveDisabled {
                return token.colorBgDisabled
            }
            if checked {
                return buttonStyle == .solid ? token.colorPrimary : token.colorBgContainer
            }
            return token.colorBgContainer
        }
        
        private var foregroundColor: Color {
            if isEffectiveDisabled {
                return token.colorTextDisabled
            }
            if checked {
                return buttonStyle == .solid ? Color.white : token.colorPrimary
            }
            return isHovering ? token.colorPrimary : token.colorText
        }
        
        private var borderColor: Color {
            if isEffectiveDisabled {
                return token.colorBorder
            }
            if checked {
                return token.colorPrimary
            }
            return isHovering ? token.colorPrimary : token.colorBorder
        }
        
        public var body: some View {
            label
                .font(.system(size: token.fontSize))
                .foregroundStyle(foregroundColor)
                .frame(maxWidth: block ? .infinity : nil) // Expand only if block is true
                .padding(.vertical, paddings.vertical)
                .padding(.horizontal, paddings.horizontal)
                .background(
                    SegmentedShape(position: position, direction: direction, radius: 6)
                        .fill(backgroundColor)
                )
                .overlay(
                    // Border handling needs to be careful about overlaps in groups.
                    // For simplicity in this standalone component, we just draw border.
                    // Real segmented controls usually let parent handle borders or use negative padding.
                    // We will assume the parent RadioGroup handles the layout to stick them together.
                    // However, to mimic AntD simply:
                    SegmentedShape(position: position, direction: direction, radius: 6)
                        .strokeBorder(borderColor, lineWidth: radioToken.lineWidth)
                )
                .contentShape(SegmentedShape(position: position, direction: direction, radius: 6)) // Hit testing
                .onTapGesture {
                    if !isEffectiveDisabled {
                        withAnimation(.easeInOut(duration: radioToken.motionDurationMid)) {
                            checked = true
                        }
                    }
                }
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
                // Transition support?
        }
    }
}
