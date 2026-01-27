import SwiftUI


// MARK: - _Space (internal name, use Moin.Space.View)

/// Space component for setting spacing between child elements
public struct _Space<Content: View, Separator: View>: View {
    @Environment(\.moinToken) private var token

    // Ant Design Space has no component token, uses global padding directly
    // @Environment(\.moinSpaceToken) private var spaceToken

    private let size: _SpaceSize
    private let direction: _SpaceDirection
    private let alignment: _SpaceAlignment
    private let wrap: Bool
    private let separator: Separator?
    private let content: Content

    /// Initialize Space component with separator
    /// - Parameters:
    ///   - size: Spacing size (.small, .medium, .large, .custom)
    ///   - direction: Layout direction (.horizontal, .vertical)
    ///   - alignment: Cross-axis alignment (.start, .end, .center)
    ///   - wrap: Enable auto wrap (horizontal only)
    ///   - separator: Separator view between items
    ///   - content: Child views
    public init(
        size: _SpaceSize = .medium,
        direction: _SpaceDirection = .horizontal,
        alignment: _SpaceAlignment = .center,
        wrap: Bool = false,
        @ViewBuilder separator: () -> Separator,
        @ViewBuilder content: () -> Content
    ) {
        self.size = size
        self.direction = direction
        self.alignment = alignment
        self.wrap = wrap
        self.separator = separator()
        self.content = content()
    }

    public var body: some View {
        let layout = _SpaceLayout(
            direction: direction,
            spacing: spacing,
            verticalAlignment: verticalAlignment,
            horizontalAlignment: horizontalAlignment,
            wrap: wrap,
            separator: separator
        )
        layout.body(content: content)
    }

    // MARK: - Private

    private var spacing: CGFloat {
        switch size {
        case .small:
            return token.paddingXS
        case .medium:
            return token.padding
        case .large:
            return token.paddingLG
        case ._custom(let value):
            return value
        }
    }

    private var verticalAlignment: VerticalAlignment {
        switch alignment {
        case .start: return .top
        case .end: return .bottom
        case .center: return .center
        }
    }

    private var horizontalAlignment: HorizontalAlignment {
        switch alignment {
        case .start: return .leading
        case .end: return .trailing
        case .center: return .center
        }
    }
}

// MARK: - Space without separator

public extension _Space where Separator == EmptyView {
    /// Initialize Space component without separator
    init(
        size: _SpaceSize = .medium,
        direction: _SpaceDirection = .horizontal,
        alignment: _SpaceAlignment = .center,
        wrap: Bool = false,
        @ViewBuilder content: () -> Content
    ) {
        self.size = size
        self.direction = direction
        self.alignment = alignment
        self.wrap = wrap
        self.separator = nil
        self.content = content()
    }
}

// MARK: - _SpaceLayout

private struct _SpaceLayout<Separator: View> {
    let direction: _SpaceDirection
    let spacing: CGFloat
    let verticalAlignment: VerticalAlignment
    let horizontalAlignment: HorizontalAlignment
    let wrap: Bool
    let separator: Separator?

    @ViewBuilder
    func body<Content: View>(content: Content) -> some View {
        if separator != nil {
            _VariadicView.Tree(_SpaceLayoutRoot(layout: self)) {
                content
            }
        } else {
            // No separator, use simple layout
            switch direction {
            case .horizontal:
                if wrap {
                    _FlowLayout(spacing: spacing, alignment: verticalAlignment) {
                        content
                    }
                } else {
                    HStack(alignment: verticalAlignment, spacing: spacing) {
                        content
                    }
                }
            case .vertical:
                VStack(alignment: horizontalAlignment, spacing: spacing) {
                    content
                }
            }
        }
    }
}

// MARK: - _SpaceLayoutRoot

private struct _SpaceLayoutRoot<Separator: View>: _VariadicView.MultiViewRoot {
    let layout: _SpaceLayout<Separator>

    @ViewBuilder
    func body(children: _VariadicView.Children) -> some View {
        let childArray = Array(children)
        switch layout.direction {
        case .horizontal:
            if layout.wrap {
                _FlowLayout(spacing: layout.spacing, alignment: layout.verticalAlignment) {
                    ForEach(childArray.indices, id: \.self) { index in
                        childArray[index]
                        if index < childArray.count - 1, let sep = layout.separator {
                            sep
                        }
                    }
                }
            } else {
                HStack(alignment: layout.verticalAlignment, spacing: layout.spacing) {
                    ForEach(childArray.indices, id: \.self) { index in
                        childArray[index]
                        if index < childArray.count - 1, let sep = layout.separator {
                            sep
                        }
                    }
                }
            }
        case .vertical:
            VStack(alignment: layout.horizontalAlignment, spacing: layout.spacing) {
                ForEach(childArray.indices, id: \.self) { index in
                    childArray[index]
                    if index < childArray.count - 1, let sep = layout.separator {
                        sep
                    }
                }
            }
        }
    }
}

// MARK: - _FlowLayout

/// A flow layout that wraps children to next line when exceeding width
private struct _FlowLayout: Layout {
    var spacing: CGFloat
    var alignment: VerticalAlignment

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let result = arrangeSubviews(proposal: proposal, subviews: subviews)
        return result.size
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let result = arrangeSubviews(proposal: proposal, subviews: subviews)

        for (index, subview) in subviews.enumerated() {
            let position = result.positions[index]
            subview.place(
                at: CGPoint(x: bounds.minX + position.x, y: bounds.minY + position.y),
                proposal: ProposedViewSize(subview.sizeThatFits(.unspecified))
            )
        }
    }

    private func arrangeSubviews(proposal: ProposedViewSize, subviews: Subviews) -> (size: CGSize, positions: [CGPoint]) {
        let maxWidth = proposal.width ?? .infinity
        var positions: [CGPoint] = []
        var currentX: CGFloat = 0
        var currentY: CGFloat = 0
        var lineHeight: CGFloat = 0
        var totalHeight: CGFloat = 0
        var totalWidth: CGFloat = 0

        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)

            if currentX + size.width > maxWidth, currentX > 0 {
                // Move to next line
                currentX = 0
                currentY += lineHeight + spacing
                lineHeight = 0
            }

            positions.append(CGPoint(x: currentX, y: currentY))

            currentX += size.width + spacing
            lineHeight = max(lineHeight, size.height)
            totalWidth = max(totalWidth, currentX - spacing)
        }

        totalHeight = currentY + lineHeight

        return (CGSize(width: totalWidth, height: totalHeight), positions)
    }
}



// MARK: - Moin.Space Extensions

