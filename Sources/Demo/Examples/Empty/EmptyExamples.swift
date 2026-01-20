import SwiftUI
import MoinUI

/// Empty 组件文档页面 Tab
enum EmptyExamplesTab: String, CaseIterable {
    case examples
    case api
    case token
}

struct EmptyExamples: View {
    @Localized var tr
    @Binding var selectedTab: EmptyExamplesTab

    // 懒加载状态
    @State private var apiReady = false
    @State private var tokenReady = false

    /// 锚点列表
    private let anchors: [AnchorItem] = [
        AnchorItem(id: "basic", titleKey: "empty.basic"),
        AnchorItem(id: "custom_image", titleKey: "empty.custom_image"),
        AnchorItem(id: "custom_view", titleKey: "empty.custom_view"),
        AnchorItem(id: "image_url", titleKey: "empty.image_url"),
        AnchorItem(id: "with_action", titleKey: "empty.with_action"),
        AnchorItem(id: "simple", titleKey: "empty.simple"),
        AnchorItem(id: "no_image", titleKey: "empty.no_image"),
        AnchorItem(id: "no_description", titleKey: "empty.no_description"),
    ]

    var body: some View {
        Group {
            switch selectedTab {
            case .examples:
                examplesContent
            case .api:
                if apiReady {
                    apiContent
                } else {
                    loadingView
                }
            case .token:
                if tokenReady {
                    tokenContent
                } else {
                    loadingView
                }
            }
        }
        .onAppear { triggerLazyLoad(for: selectedTab) }
        .onChange(of: selectedTab) { triggerLazyLoad(for: $0) }
    }

    private var loadingView: some View {
        Moin.Spin()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private func triggerLazyLoad(for tab: EmptyExamplesTab) {
        switch tab {
        case .examples:
            break
        case .api:
            if !apiReady {
                DispatchQueue.main.async { apiReady = true }
            }
        case .token:
            if !tokenReady {
                DispatchQueue.main.async { tokenReady = true }
            }
        }
    }

    // MARK: - Examples Content
    private var examplesContent: some View {
        ExamplePageWithAnchor(pageName: "Empty", anchors: anchors) { _ in
            basicExample.id("basic")
            customImageExample.id("custom_image")
            customViewExample.id("custom_view")
            imageUrlExample.id("image_url")
            withActionExample.id("with_action")
            simpleExample.id("simple")
            noImageExample.id("no_image")
            noDescriptionExample.id("no_description")
        }
    }

    // MARK: - API Content
    private var apiContent: some View {
        EmptyAPIView()
    }

    // MARK: - Token Content
    private var tokenContent: some View {
        EmptyTokenView()
    }

    // MARK: - Examples

    private var basicExample: some View {
        ExampleSection(
            title: tr("empty.basic"),
            description: tr("empty.basic_desc"),
            content: {
                Moin.Empty()
            },
            code: {
                """
                Moin.Empty()
                """
            }
        )
    }

    private var customImageExample: some View {
        ExampleSection(
            title: tr("empty.custom_image"),
            description: tr("empty.custom_image_desc"),
            content: {
                HStack(spacing: 48) {
                    Moin.Empty(
                        image: .systemIcon("folder"),
                        description: tr("empty.no_files")
                    )
                    Moin.Empty(
                        image: .systemIcon("magnifyingglass"),
                        description: tr("empty.no_results")
                    )
                }
            },
            code: {
                """
                Moin.Empty(
                    image: .systemIcon("folder"),
                    description: "\(tr("empty.no_files"))"
                )
                Moin.Empty(
                    image: .systemIcon("magnifyingglass"),
                    description: "\(tr("empty.no_results"))"
                )
                """
            }
        )
    }

    private var imageUrlExample: some View {
        ExampleSection(
            title: tr("empty.image_url"),
            description: tr("empty.image_url_desc"),
            content: {
                Moin.Empty(
                    image: .url("https://api.dicebear.com/7.x/shapes/png?seed=empty"),
                    description: tr("empty.default_description")
                )
            },
            code: {
                """
                Moin.Empty(
                    image: .url("https://api.dicebear.com/7.x/shapes/png?seed=empty"),
                    description: "\(tr("empty.default_description"))"
                )
                """
            }
        )
    }

    private var withActionExample: some View {
        ExampleSection(
            title: tr("empty.with_action"),
            description: tr("empty.with_action_desc"),
            content: {
                Moin.Empty(description: tr("empty.default_description")) {
                    Moin.Button(tr("empty.create_now"), color: .primary) {}
                }
            },
            code: {
                """
                Moin.Empty(description: "\(tr("empty.default_description"))") {
                    Moin.Button("\(tr("empty.create_now"))", color: .primary) {}
                }
                """
            }
        )
    }

    private var simpleExample: some View {
        ExampleSection(
            title: tr("empty.simple"),
            description: tr("empty.simple_desc"),
            content: {
                Moin.Empty(
                    image: .simple,
                    description: tr("empty.default_description")
                )
            },
            code: {
                """
                Moin.Empty(
                    image: .simple,
                    description: "\(tr("empty.default_description"))"
                )
                """
            }
        )
    }

    private var noDescriptionExample: some View {
        ExampleSection(
            title: tr("empty.no_description"),
            description: tr("empty.no_description_desc"),
            content: {
                Moin.Empty(image: .default, description: "")
            },
            code: {
                """
                Moin.Empty(image: .default, description: "")
                """
            }
        )
    }

    private var customViewExample: some View {
        ExampleSection(
            title: tr("empty.custom_view"),
            description: tr("empty.custom_view_desc"),
            content: {
                Moin.Empty(
                    image: .custom(Image(systemName: "star.circle.fill")),
                    description: tr("empty.default_description")
                )
            },
            code: {
                """
                Moin.Empty(
                    image: .custom(Image(systemName: "star.circle.fill")),
                    description: "\(tr("empty.default_description"))"
                )
                """
            }
        )
    }

    private var noImageExample: some View {
        ExampleSection(
            title: tr("empty.no_image"),
            description: tr("empty.no_image_desc"),
            content: {
                Moin.Empty(
                    image: .none,
                    description: tr("empty.default_description")
                )
            },
            code: {
                """
                Moin.Empty(
                    image: .none,
                    description: "\(tr("empty.default_description"))"
                )
                """
            }
        )
    }
}
