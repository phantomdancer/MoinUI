import SwiftUI
import MoinUI

/// 响应式布局断点
enum ResponsiveBreakpoint {
    static let small: CGFloat = 1000
    static let medium: CGFloat = 1400
}

/// 响应式网格布局 - 根据容器宽度动态计算列数
struct ResponsiveLayout<Content: View>: View {
    let minItemWidth: CGFloat
    let maxColumns: Int
    let spacing: CGFloat
    @ViewBuilder let content: () -> Content

    @State private var containerWidth: CGFloat = 0

    init(
        minItemWidth: CGFloat = 280,
        maxColumns: Int = 3,
        spacing: CGFloat = Moin.Constants.Spacing.xl,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.minItemWidth = minItemWidth
        self.maxColumns = maxColumns
        self.spacing = spacing
        self.content = content
    }

    private var columnCount: Int {
        guard containerWidth > 0 else { return 1 }
        let count = Int((containerWidth + spacing) / (minItemWidth + spacing))
        return max(1, min(count, maxColumns))
    }

    var body: some View {
        LazyVGrid(
            columns: Array(repeating: GridItem(.flexible(), spacing: spacing), count: columnCount),
            alignment: .leading,
            spacing: spacing
        ) {
            content()
        }
        .background(
            GeometryReader { geo in
                Color.clear
                    .preference(key: ContainerWidthKey.self, value: geo.size.width)
            }
        )
        .onPreferenceChange(ContainerWidthKey.self) { containerWidth = $0 }
    }
}

private struct ContainerWidthKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
