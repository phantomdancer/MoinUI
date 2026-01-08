import SwiftUI
import MoinUI

/// 锚点项
struct AnchorItem: Identifiable, Hashable {
    let id: String
    let titleKey: String
}

/// 锚点导航组件
struct AnchorNav: View {
    let anchors: [AnchorItem]
    let scrollProxy: ScrollViewProxy
    @Binding var activeAnchor: String?
    @EnvironmentObject var localization: MoinUILocalization

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach(anchors) { anchor in
                Button {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        // 稍微偏下一点，留出顶部空间
                        scrollProxy.scrollTo(anchor.id, anchor: UnitPoint(x: 0, y: 0.03))
                    }
                    activeAnchor = anchor.id
                } label: {
                    HStack(spacing: MoinUIConstants.Spacing.sm) {
                        // 左侧指示条
                        RoundedRectangle(cornerRadius: 1)
                            .fill(activeAnchor == anchor.id ? Color.accentColor : Color.clear)
                            .frame(width: 2, height: 16)

                        Text(localization.tr(anchor.titleKey))
                            .font(.system(size: 12))
                            .foregroundStyle(activeAnchor == anchor.id ? Color.accentColor : .secondary)
                            .lineLimit(1)

                        Spacer()
                    }
                    .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
                .padding(.vertical, MoinUIConstants.Spacing.xs)
            }
        }
        .padding(.horizontal, MoinUIConstants.Spacing.sm)
        .frame(width: 140)
    }
}

/// 带锚点导航的示例页面容器
struct ExamplePageWithAnchor<Content: View>: View {
    let anchors: [AnchorItem]
    @ViewBuilder let content: (ScrollViewProxy) -> Content
    @State private var activeAnchor: String?

    var body: some View {
        ScrollViewReader { proxy in
            HStack(alignment: .top, spacing: 0) {
                // 左侧内容区
                ScrollView {
                    content(proxy)
                        .padding(MoinUIConstants.Spacing.xl)
                }

                Divider()

                // 右侧锚点导航
                VStack(alignment: .leading) {
                    AnchorNav(
                        anchors: anchors,
                        scrollProxy: proxy,
                        activeAnchor: $activeAnchor
                    )
                    .padding(.top, MoinUIConstants.Spacing.xl)

                    Spacer()
                }
            }
        }
        .onAppear {
            // 默认选中第一个
            if activeAnchor == nil, let first = anchors.first {
                activeAnchor = first.id
            }
        }
    }
}
