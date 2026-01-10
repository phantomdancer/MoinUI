// Moin.Compact - Compact layout with auto position detection
import SwiftUI

// MARK: - Size Preference Key

private struct CompactItemSizePreference: PreferenceKey {
    static var defaultValue: [Int: CGSize] = [:]
    static func reduce(value: inout [Int: CGSize], nextValue: () -> [Int: CGSize]) {
        value.merge(nextValue()) { $1 }
    }
}

private struct CompactItemSizeReader: ViewModifier {
    let index: Int

    func body(content: Content) -> some View {
        content.background(
            GeometryReader { geo in
                Color.clear.preference(key: CompactItemSizePreference.self, value: [index: geo.size])
            }
        )
    }
}

public extension Moin {
    /// Compact layout with zero spacing and merged borders
    struct Compact: View {
        let direction: SpaceDirection
        let items: [AnyView]

        @State private var maxWidth: CGFloat = 0

        public var body: some View {
            if direction == .horizontal {
                HStack(spacing: 0) {
                    ForEach(Array(items.enumerated()), id: \.offset) { index, item in
                        item
                            .environment(\.moinSpaceCompactContext, context(for: index))
                    }
                }
            } else {
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(Array(items.enumerated()), id: \.offset) { index, item in
                        item
                            .modifier(CompactItemSizeReader(index: index))
                            .frame(width: maxWidth > 0 ? maxWidth : nil, alignment: .leading)
                            .environment(\.moinSpaceCompactContext, context(for: index))
                    }
                }
                .onPreferenceChange(CompactItemSizePreference.self) { sizes in
                    maxWidth = sizes.values.map(\.width).max() ?? 0
                }
            }
        }

        private func context(for index: Int) -> SpaceCompactContext {
            let position: SpaceCompactPosition
            if items.count == 1 {
                position = .only
            } else if index == 0 {
                position = .first
            } else if index == items.count - 1 {
                position = .last
            } else {
                position = .middle
            }
            return SpaceCompactContext(
                isCompact: true,
                direction: direction,
                position: position,
                fillWidth: direction == .vertical && maxWidth > 0
            )
        }
    }
}

// MARK: - Convenience initializers

public extension Moin.Compact {
    /// Two items
    init<V0: View, V1: View>(
        direction: Moin.SpaceDirection = .horizontal,
        @ViewBuilder content: () -> TupleView<(V0, V1)>
    ) {
        self.direction = direction
        let tuple = content().value
        self.items = [AnyView(tuple.0), AnyView(tuple.1)]
    }

    /// Three items
    init<V0: View, V1: View, V2: View>(
        direction: Moin.SpaceDirection = .horizontal,
        @ViewBuilder content: () -> TupleView<(V0, V1, V2)>
    ) {
        self.direction = direction
        let tuple = content().value
        self.items = [AnyView(tuple.0), AnyView(tuple.1), AnyView(tuple.2)]
    }

    /// Four items
    init<V0: View, V1: View, V2: View, V3: View>(
        direction: Moin.SpaceDirection = .horizontal,
        @ViewBuilder content: () -> TupleView<(V0, V1, V2, V3)>
    ) {
        self.direction = direction
        let tuple = content().value
        self.items = [AnyView(tuple.0), AnyView(tuple.1), AnyView(tuple.2), AnyView(tuple.3)]
    }

    /// Five items
    init<V0: View, V1: View, V2: View, V3: View, V4: View>(
        direction: Moin.SpaceDirection = .horizontal,
        @ViewBuilder content: () -> TupleView<(V0, V1, V2, V3, V4)>
    ) {
        self.direction = direction
        let tuple = content().value
        self.items = [AnyView(tuple.0), AnyView(tuple.1), AnyView(tuple.2), AnyView(tuple.3), AnyView(tuple.4)]
    }

    /// Six items
    init<V0: View, V1: View, V2: View, V3: View, V4: View, V5: View>(
        direction: Moin.SpaceDirection = .horizontal,
        @ViewBuilder content: () -> TupleView<(V0, V1, V2, V3, V4, V5)>
    ) {
        self.direction = direction
        let tuple = content().value
        self.items = [AnyView(tuple.0), AnyView(tuple.1), AnyView(tuple.2), AnyView(tuple.3), AnyView(tuple.4), AnyView(tuple.5)]
    }

    /// Single item
    init<V0: View>(
        direction: Moin.SpaceDirection = .horizontal,
        @ViewBuilder content: () -> V0
    ) {
        self.direction = direction
        self.items = [AnyView(content())]
    }
}
