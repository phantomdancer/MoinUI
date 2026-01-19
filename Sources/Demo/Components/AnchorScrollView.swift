import SwiftUI

/// 一个封装了精确锚点滚动逻辑的 ScrollView。
///
/// 它结合了 macOS 14 的 `scrollPosition` 用于监听滚动位置，
/// 以及 `ScrollViewReader` 用于执行精确跳转（包含二次校准以应对 LazyVStack 的高度偏差）。
@available(macOS 14.0, *)
struct AnchorScrollView<ID: Hashable, Content: View>: View {
    /// 当前滚动位置（只读/双向），用于高亮导航栏
    @Binding var scrollPosition: ID?
    
    /// 目标滚动 ID，当此值改变时触发跳转
    @Binding var targetScrollId: ID?
    
    /// 滚动视图的内容，通常是一个 LazyVStack
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                content()
                    .scrollTargetLayout() // 关键：标记内容布局为滚动目标
            }
            .scrollTargetBehavior(.viewAligned)
            .scrollPosition(id: $scrollPosition, anchor: .top)
            .onChange(of: targetScrollId) { _, newValue in
                if let newValue {
                    // 第一次跳转
                    withAnimation {
                        proxy.scrollTo(newValue, anchor: .top)
                    }
                    
                    // 二次校准：延迟 0.1s 再次跳转
                    // 这解决了 LazyVStack 因内容异步加载或估算高度不准导致的定位偏差
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        withAnimation {
                            proxy.scrollTo(newValue, anchor: .top)
                        }
                    }
                }
            }
        }
        .background(Color(nsColor: .controlBackgroundColor))
    }
}
