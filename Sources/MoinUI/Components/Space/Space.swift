import SwiftUI

// MARK: - Moin.Space

public extension Moin {
    /// Space component for setting spacing between child elements
    struct Space<Content: View>: View {
        @Environment(\.moinToken) private var token
        @Environment(\.moinSpaceToken) private var spaceToken

        private let size: Moin.SpaceSize
        private let direction: Moin.SpaceDirection
        private let alignment: Moin.SpaceAlignment
        private let wrap: Bool
        private let content: Content

        /// Initialize Space component
        /// - Parameters:
        ///   - size: Spacing size (.small, .medium, .large, .custom)
        ///   - direction: Layout direction (.horizontal, .vertical)
        ///   - alignment: Cross-axis alignment (.start, .end, .center)
        ///   - wrap: Enable auto wrap (horizontal only)
        ///   - content: Child views
        public init(
            size: Moin.SpaceSize = .medium,
            direction: Moin.SpaceDirection = .horizontal,
            alignment: Moin.SpaceAlignment = .center,
            wrap: Bool = false,
            @ViewBuilder content: () -> Content
        ) {
            self.size = size
            self.direction = direction
            self.alignment = alignment
            self.wrap = wrap
            self.content = content()
        }

        public var body: some View {
            switch direction {
            case .horizontal:
                if wrap {
                    FlowLayout(spacing: spacing, alignment: verticalAlignment) {
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

        // MARK: - Private

        private var spacing: CGFloat {
            switch size {
            case .small:
                return spaceToken.sizeSmall
            case .medium:
                return spaceToken.sizeMedium
            case .large:
                return spaceToken.sizeLarge
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
}

// MARK: - FlowLayout

/// A flow layout that wraps children to next line when exceeding width
private struct FlowLayout: Layout {
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
