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
            .coordinateSpace(name: "API_SCROLL_VIEW") // 定义坐标空间
            // 监听点击跳转
            .onChange(of: targetScrollId) { newValue in
                if let newValue {
                    // 第一次跳转
                    withAnimation {
                        proxy.scrollTo(newValue, anchor: .top)
                    }
                    
                    // 二次校准：延迟 0.1s 再次跳转
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        withAnimation {
                            proxy.scrollTo(newValue, anchor: .top)
                        }
                    }
                }
            }
            // 监听滚动位置（Scroll Spy）
            .onPreferenceChange(ScrollAnchorPreferenceKey.self) { preferences in
                // 1. 过滤出所有可见或接近顶部的锚点
                // 我们寻找 minY 刚刚小于等于 0（或某个阈值，比如 20）的最后一个锚点，
                // 或者 minY > 0 的第一个锚点的前一个。
                
                // 简单算法：找出所有 minY <= 100 的锚点，取其中 minY 最大的那个（也就是最靠下的那个，即当前 Section 的 Header）。
                // 解释：随着页面上卷，Header 的 Y 坐标会变小（变成负数）。
                // 当前正显示的 Section，其 Header 应该是位于顶部附近或已经在上方（负值）。
                
                let visibleHeaders = preferences.filter { $0.anchorY <= 150 } // 150 是个宽松的阈值，允许头部稍微下来一点也算
                
                // 在这些在“上方”的 Header 中，Y 值最大（最接近 0）的那个，就是当前生效的 Header。
                if let active = visibleHeaders.max(by: { $0.anchorY < $1.anchorY }),
                   let activeId = active.id as? ID {
                    
                    // 只有当 ID 变化且不是用户正在点击跳转时才更新（避免跳动）
                    // 简便起见，直接更新，配合防抖会更好，但这里直出。
                    if currentScrollId != activeId {
                        currentScrollId = activeId
                    }
                }
            }
        }
        .background(Color(nsColor: .controlBackgroundColor))
    }
}
