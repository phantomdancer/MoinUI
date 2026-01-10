import SwiftUI
import MoinUI

// MARK: - Render Time Modifier

struct RenderTimeModifier: ViewModifier {
    let pageName: String
    @State private var startTime: CFAbsoluteTime?

    init(pageName: String) {
        self.pageName = pageName
    }

    func body(content: Content) -> some View {
        let now = CFAbsoluteTimeGetCurrent()

        return content
            .onAppear {
                let elapsed = CFAbsoluteTimeGetCurrent() - now
                print("📊 [\(pageName)] render: \(String(format: "%.1f", elapsed * 1000))ms")
            }
    }
}

extension View {
    func measureRenderTime(_ pageName: String) -> some View {
        modifier(RenderTimeModifier(pageName: pageName))
    }
}

// MARK: - AnchorItem
struct AnchorItem: Identifiable, Hashable {
    let id: String
    let titleKey: String
}

/// 锚点导航组件
struct AnchorNav: View {
    let anchors: [AnchorItem]
    let scrollProxy: ScrollViewProxy
    @Binding var activeAnchor: String?
    @Localized var tr

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
                    HStack(spacing: Moin.Constants.Spacing.sm) {
                        // 左侧指示条
                        RoundedRectangle(cornerRadius: 1)
                            .fill(activeAnchor == anchor.id ? Color.accentColor : Color.clear)
                            .frame(width: 2, height: 16)

                        Text(tr(anchor.titleKey))
                            .font(.system(size: 12))
                            .foregroundStyle(activeAnchor == anchor.id ? Color.accentColor : .secondary)
                            .lineLimit(1)

                        Spacer()
                    }
                    .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
                .padding(.vertical, Moin.Constants.Spacing.xs)
            }
        }
        .padding(.horizontal, Moin.Constants.Spacing.sm)
        .frame(width: 180)
    }
}

/// 带锚点导航的示例页面容器
struct ExamplePageWithAnchor<Content: View>: View {
    let pageName: String
    let anchors: [AnchorItem]
    @ViewBuilder let content: (ScrollViewProxy) -> Content
    @State private var activeAnchor: String?
    private let renderStartTime: CFAbsoluteTime

    init(pageName: String = "Unknown", anchors: [AnchorItem], @ViewBuilder content: @escaping (ScrollViewProxy) -> Content) {
        self.pageName = pageName
        self.anchors = anchors
        self.content = content
        self.renderStartTime = CFAbsoluteTimeGetCurrent()
    }

    var body: some View {
        ScrollViewReader { proxy in
            HStack(alignment: .top, spacing: 0) {
                // 左侧内容区
                ScrollView {
                    VStack(alignment: .leading, spacing: Moin.Constants.Spacing.xl) {
                        content(proxy)
                    }
                    .padding(Moin.Constants.Spacing.xl)
                    .onAppear {
                        let elapsed = CFAbsoluteTimeGetCurrent() - renderStartTime
                        print("📊 [\(pageName)] render: \(String(format: "%.1f", elapsed * 1000))ms")
                    }
                }

                Divider()

                // 右侧锚点导航
                VStack(alignment: .leading) {
                    AnchorNav(
                        anchors: anchors,
                        scrollProxy: proxy,
                        activeAnchor: $activeAnchor
                    )
                    .padding(.top, Moin.Constants.Spacing.xl)

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
