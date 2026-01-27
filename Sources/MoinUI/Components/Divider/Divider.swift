import SwiftUI


// MARK: - _Divider (internal name, use Moin.Divider.View)

/// Divider component for separating content
public struct _Divider<Content: View>: View {
    @Environment(\.moinToken) private var token
    @Environment(\.moinDividerToken) private var dividerToken

    private let orientation: _DividerOrientation
    private let variant: _DividerVariant
    private let titlePlacement: _DividerTitlePlacement
    private let plain: Bool
    private let content: Content?

    // MARK: - Initializers

    /// Basic divider without text
    public init(
        orientation: _DividerOrientation = .horizontal,
        variant: _DividerVariant = .solid
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
        orientation: _DividerOrientation = .horizontal,
        variant: _DividerVariant = .solid,
        titlePlacement: _DividerTitlePlacement = .center,
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
        orientation: _DividerOrientation = .horizontal,
        variant: _DividerVariant = .solid,
        titlePlacement: _DividerTitlePlacement = .center,
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
            .frame(height: token.lineWidth)          // 全局Token
            .padding(.vertical, token.marginLG)      // 全局Token
    }

    // MARK: - Horizontal Divider with Content

    @ViewBuilder
    private func horizontalDividerWithContent(_ content: Content) -> some View {
        GeometryReader { geo in
            let totalWidth = geo.size.width
            let shortWidth = totalWidth * dividerToken.orientationMargin  // 组件Token

            HStack(spacing: dividerToken.textPadding) {  // 组件Token
                // Left line
                switch titlePlacement {
                case .left:
                    lineView(isHorizontal: true)
                        .frame(width: shortWidth, height: token.lineWidth)
                case .center, .right:
                    lineView(isHorizontal: true)
                        .frame(height: token.lineWidth)
                }

                // Content
                content
                    .font(.system(size: token.fontSizeLG, weight: plain ? .regular : .medium))  // 全局Token
                    .foregroundStyle(token.colorText)  // 全局Token
                    .lineLimit(1)
                    .fixedSize()

                // Right line
                switch titlePlacement {
                case .right:
                    lineView(isHorizontal: true)
                        .frame(width: shortWidth, height: token.lineWidth)
                case .center, .left:
                    lineView(isHorizontal: true)
                        .frame(height: token.lineWidth)
                }
            }
            .frame(maxWidth: .infinity)
        }
        .frame(height: token.fontSizeLG + token.marginLG * 2)  // 全局Token
        .padding(.vertical, token.marginLG)                    // 全局Token
    }

    // MARK: - Vertical Divider

    private var verticalDivider: some View {
        lineView(isHorizontal: false)
            .frame(width: token.lineWidth)           // 全局Token
            .padding(.horizontal, token.marginXS)    // 全局Token
    }

    // MARK: - Line View

    @ViewBuilder
    private func lineView(isHorizontal: Bool) -> some View {
        switch variant {
        case .solid:
            Rectangle()
                .fill(token.colorBorder)  // 全局Token
        case .dashed:
            _DashedLineShape(
                isHorizontal: isHorizontal,
                dashLength: dividerToken.dashLength,  // 组件Token
                dashGap: dividerToken.dashGap         // 组件Token
            )
            .stroke(token.colorBorder, lineWidth: token.lineWidth)
        case .dotted:
            _DashedLineShape(
                isHorizontal: isHorizontal,
                dashLength: 2,
                dashGap: 2
            )
            .stroke(token.colorBorder, lineWidth: token.lineWidth)
        }
    }
}

// MARK: - _DashedLineShape

private struct _DashedLineShape: Shape {
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



// MARK: - Moin.Divider Extensions

