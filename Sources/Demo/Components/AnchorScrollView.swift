import SwiftUI

// MARK: - Preference Key

/// 用于传递锚点位置的 PreferenceKey
struct ScrollAnchorPreferenceData: Equatable {
    let id: String
    let anchorY: CGFloat
}

struct ScrollAnchorPreferenceKey: PreferenceKey {
    static var defaultValue: [ScrollAnchorPreferenceData] = []
    
    static func reduce(value: inout [ScrollAnchorPreferenceData], nextValue: () -> [ScrollAnchorPreferenceData]) {
        value.append(contentsOf: nextValue())
    }
}

// MARK: - View Extension

extension View {
    /// 标记此视图为一个滚动锚点，用于自动高亮
    /// - Parameter id: 锚点 ID
    func scrollAnchor(_ id: String) -> some View {
        self.modifier(ScrollAnchorModifier(id: id))
    }
}

struct ScrollAnchorModifier: ViewModifier {
    let id: String
    
    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { proxy in
                    Color.clear
                        .preference(
                            key: ScrollAnchorPreferenceKey.self,
                            value: [ScrollAnchorPreferenceData(
                                id: id,
                                anchorY: proxy.frame(in: .named("API_SCROLL_VIEW")).minY
                            )]
                        )
                }
            )
            .id(id) // 保留系统的 id 用于 scrollTo 跳转
    }
}

// MARK: - AnchorScrollView

/// 一个兼容 macOS 13 的精确锚点滚动组件，支持双向同步。
struct AnchorScrollView<ID: Hashable, Content: View>: View {
    /// 目标滚动 ID，当此值改变时触发跳转（点击导航触发）
    @Binding var targetScrollId: ID?
    
    /// 当前滚动到的位置 ID（只读，滚动时自动更新，用于高亮导航）
    @Binding var currentScrollId: ID?
    
    /// 滚动视图的内容
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                content()
            }
            .coordinateSpace(name: "API_SCROLL_VIEW")
            .onChange(of: targetScrollId) { newValue in
                if let newValue {
                    withAnimation {
                        proxy.scrollTo(newValue, anchor: .top)
                    }
                }
            }
            .onPreferenceChange(ScrollAnchorPreferenceKey.self) { preferences in
                let visibleHeaders = preferences.filter { $0.anchorY <= 150 }
                if let active = visibleHeaders.max(by: { $0.anchorY < $1.anchorY }),
                   let activeId = active.id as? ID,
                   currentScrollId != activeId {
                    currentScrollId = activeId
                }
            }
        }
        .background(Color(nsColor: .controlBackgroundColor))
    }
}
