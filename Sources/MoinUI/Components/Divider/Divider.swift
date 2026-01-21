import SwiftUI

// MARK: - Moin.Divider

public extension Moin {
    /// Divider component for separating content
    struct Divider<Content: View>: View {
        @Environment(\.moinToken) private var token
        @Environment(\.moinDividerToken) private var dividerToken

        private let orientation: DividerOrientation
        private let variant: DividerVariant
        private let titlePlacement: DividerTitlePlacement
        private let plain: Bool
        private let content: Content?

        // MARK: - Initializers

        /// Basic divider without text
        public init(
            orientation: DividerOrientation = .horizontal,
            variant: DividerVariant = .solid
        ) where Content == EmptyView {
            self.orientation = orientation
            self.variant = variant
            self.titlePlacement = .center
            self.plain = true
            self.content = nil
        }

        /// Divider with text title
        public init(
            _ title: String,
            orientation: DividerOrientation = .horizontal,
            variant: DividerVariant = .solid,
            titlePlacement: DividerTitlePlacement = .center,
            plain: Bool = false
        ) where Content == Text {
            self.orientation = orientation
            self.variant = variant
            self.titlePlacement = titlePlacement
            self.plain = plain
            self.content = Text(title)
        }

        /// Divider with custom content
        public init(
            orientation: DividerOrientation = .horizontal,
            variant: DividerVariant = .solid,
            titlePlacement: DividerTitlePlacement = .center,
            plain: Bool = false,
            @ViewBuilder content: () -> Content
        ) {
            self.orientation = orientation
            self.variant = variant
            self.titlePlacement = titlePlacement
            self.plain = plain
            self.content = content()
        }

        // MARK: - Body

        public var body: some View {
            if orientation == .vertical {
                verticalDivider
            } else if let content = content {
                horizontalDividerWithContent(content)
            } else {
                horizontalLine
            }
        }

        // MARK: - Horizontal Divider

        private var horizontalLine: some View {
            lineView(isHorizontal: true)
                .frame(height: dividerToken.lineWidth)
                .padding(.vertical, dividerToken.verticalMargin)
        }

        // MARK: - Horizontal Divider with Content

        @ViewBuilder
        private func horizontalDividerWithContent(_ content: Content) -> some View {
            GeometryReader { geo in
                let totalWidth = geo.size.width
                let shortWidth = totalWidth * dividerToken.orientationMargin
                
                HStack(spacing: dividerToken.textPadding) {
                    // Left line
                    switch titlePlacement {
                    case .left:
                        lineView(isHorizontal: true)
                            .frame(width: shortWidth, height: dividerToken.lineWidth)
                    case .center, .right:
                        lineView(isHorizontal: true)
                            .frame(height: dividerToken.lineWidth)
                    }

                    // Content
                    content
                        .font(.system(size: dividerToken.fontSize, weight: plain ? .regular : .medium))
                        .foregroundStyle(dividerToken.textColor)
                        .lineLimit(1)
                        .fixedSize()

                    // Right line
                    switch titlePlacement {
                    case .right:
                        lineView(isHorizontal: true)
                            .frame(width: shortWidth, height: dividerToken.lineWidth)
                    case .center, .left:
                        lineView(isHorizontal: true)
                            .frame(height: dividerToken.lineWidth)
                    }
                }
                .frame(maxWidth: .infinity)
            }
            .frame(height: dividerToken.fontSize + dividerToken.verticalMargin * 2)
            .padding(.vertical, dividerToken.verticalMargin)
        }

        // MARK: - Vertical Divider

        private var verticalDivider: some View {
            lineView(isHorizontal: false)
                .frame(width: dividerToken.lineWidth)
                .padding(.horizontal, dividerToken.horizontalMargin)
        }

        // MARK: - Line View

        @ViewBuilder
        private func lineView(isHorizontal: Bool) -> some View {
            switch variant {
            case .solid:
                Rectangle()
                    .fill(dividerToken.lineColor)
            case .dashed:
                DashedLineShape(
                    isHorizontal: isHorizontal,
                    dashLength: dividerToken.dashLength,
                    dashGap: dividerToken.dashGap
                )
                .stroke(dividerToken.lineColor, lineWidth: dividerToken.lineWidth)
            case .dotted:
                DashedLineShape(
                    isHorizontal: isHorizontal,
                    dashLength: 2,
                    dashGap: 2
                )
                .stroke(dividerToken.lineColor, lineWidth: dividerToken.lineWidth)
            }
        }
    }
}

// MARK: - DashedLineShape

private struct DashedLineShape: Shape {
    let isHorizontal: Bool
    let dashLength: CGFloat
    let dashGap: CGFloat

    func path(in rect: CGRect) -> Path {
        var path = Path()
        if isHorizontal {
            path.move(to: CGPoint(x: 0, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        } else {
            path.move(to: CGPoint(x: rect.midX, y: 0))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        }
        return path
    }

    var strokeStyle: StrokeStyle {
        StrokeStyle(lineWidth: 1, dash: [dashLength, dashGap])
    }

    func stroke(_ content: some ShapeStyle, lineWidth: CGFloat) -> some View {
        self.stroke(content, style: StrokeStyle(lineWidth: lineWidth, dash: [dashLength, dashGap]))
    }
}
