import SwiftUI

/// 一个兼容 macOS 13 的精确锚点滚动组件。
///
/// 特性：
/// 1. 使用 `ScrollViewReader` 实现精确跳转。
/// 2. 内置“双重校准”机制，解决 `LazyVStack` 高度估算不准导致的定位偏差。
/// 3. 移除了 macOS 14 的 `scrollPosition` API，因此去掉了版本限制。
///
/// 注意：此版本仅支持“点击跳转”。滚动时不会自动更新 `scrollPosition`（单向绑定）。
struct AnchorScrollView<ID: Hashable, Content: View>: View {
    /// 目标滚动 ID，当此值改变时触发跳转
    @Binding var targetScrollId: ID?
    
    /// 滚动视图的内容
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                content()
            }
            .onChange(of: targetScrollId) { newValue in
                if let newValue {
                    // 第一次跳转
                    withAnimation {
                        proxy.scrollTo(newValue, anchor: .top)
                    }
                    
                    // 二次校准：延迟 0.1s 再次跳转
                    // 彻底修复 LazyVStack 内容异步加载导致的偏移
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
