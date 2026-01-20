import SwiftUI
import MoinUI

/// Avatar 组件文档页面 Tab
enum AvatarExamplesTab: String, CaseIterable {
    case examples
    case api
    case token
}

struct AvatarExamples: View {
    @Localized var tr
    @Binding var selectedTab: AvatarExamplesTab

    // 懒加载状态
    @State private var apiReady = false
    @State private var tokenReady = false

    /// 锚点列表
    private let anchors: [AnchorItem] = [
        AnchorItem(id: "basic", titleKey: "avatar.basic"),
        AnchorItem(id: "size", titleKey: "avatar.size"),
        AnchorItem(id: "shape", titleKey: "avatar.shape"),
        AnchorItem(id: "type", titleKey: "avatar.type"),
        AnchorItem(id: "src", titleKey: "avatar.src"),
        AnchorItem(id: "icon_view", titleKey: "avatar.icon_view"),
        AnchorItem(id: "gap", titleKey: "avatar.gap"),
        AnchorItem(id: "color", titleKey: "avatar.color"),
        AnchorItem(id: "group", titleKey: "avatar.group"),
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

    private func triggerLazyLoad(for tab: AvatarExamplesTab) {
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
        ExamplePageWithAnchor(pageName: "Avatar", anchors: anchors) { _ in
            basicExample.id("basic")
            sizeExample.id("size")
            shapeExample.id("shape")
            typeExample.id("type")
            srcExample.id("src")
            iconViewExample.id("icon_view")
            gapExample.id("gap")
            colorExample.id("color")
            groupExample.id("group")
        }
    }

    // MARK: - API Content
    private var apiContent: some View {
        AvatarAPIView()
    }

    // MARK: - Token Content
    private var tokenContent: some View {
        AvatarTokenView()
    }
    
    // MARK: - Examples
    
    private var basicExample: some View {
        ExampleSection(
            title: tr("avatar.basic"),
            description: tr("avatar.basic_desc"),
            content: {
                HStack(spacing: 24) {
                    Moin.Avatar(icon: "person.fill")
                    Moin.Avatar("U")
                    Moin.Avatar("User", shape: .square)
                    Moin.Avatar(icon: "person")
                }
            },
            code: {
                """
                Moin.Avatar(icon: "person.fill")
                Moin.Avatar("U")
                Moin.Avatar("User", shape: .square)
                Moin.Avatar(icon: "person")
                """
            }
        )
    }

    private var sizeExample: some View {
        ExampleSection(
            title: tr("avatar.size"),
            description: tr("avatar.size_desc"),
            content: {
                HStack(alignment: .bottom, spacing: 24) {
                    Moin.Avatar(icon: "person", size: .large)
                    Moin.Avatar(icon: "person", size: .default)
                    Moin.Avatar(icon: "person", size: .small)
                    Moin.Avatar(icon: "person", size: 64)
                }
            },
            code: {
                """
                Moin.Avatar(icon: "person", size: .large)
                Moin.Avatar(icon: "person", size: .default)
                Moin.Avatar(icon: "person", size: .small)
                Moin.Avatar(icon: "person", size: 64)
                """
            }
        )
    }

    private var shapeExample: some View {
        ExampleSection(
            title: tr("avatar.shape"),
            description: tr("avatar.shape_desc"),
            content: {
                HStack(spacing: 24) {
                    Moin.Avatar(icon: "person", shape: .circle)
                    Moin.Avatar(icon: "person", shape: .square)
                }
            },
            code: {
                """
                Moin.Avatar(icon: "person", shape: .circle)
                Moin.Avatar(icon: "person", shape: .square)
                """
            }
        )
    }

    private var typeExample: some View {
        ExampleSection(
            title: tr("avatar.type"),
            description: tr("avatar.type_desc"),
            content: {
                HStack(spacing: 24) {
                    Moin.Avatar(icon: "person")
                    Moin.Avatar("Text")
                    Moin.Avatar(image: Image(systemName: "photo"))
                }
            },
            code: {
                """
                Moin.Avatar(icon: "person")
                Moin.Avatar("Text")
                Moin.Avatar(image: Image(systemName: "photo"))
                """
            }
        )
    }

    private var srcExample: some View {
        ExampleSection(
            title: tr("avatar.src"),
            description: tr("avatar.src_desc"),
            content: {
                HStack(spacing: 24) {
                    Moin.Avatar(
                        src: "https://api.dicebear.com/7.x/avataaars/png?seed=Felix",
                        fallbackIcon: "person.fill"
                    )
                    Moin.Avatar(
                        src: "https://example.com/404.png",
                        fallbackIcon: "exclamationmark.triangle"
                    )
                    Moin.Avatar(
                        src: URL(string: "https://api.dicebear.com/7.x/avataaars/png?seed=Felix"),
                        size: .large
                    )
                }
            },
            code: {
                """
                // \(tr("avatar.src_url"))
                Moin.Avatar(
                    src: "https://api.dicebear.com/7.x/avataaars/png?seed=Felix",
                    fallbackIcon: "person.fill"
                )

                // \(tr("avatar.src_fallback"))
                Moin.Avatar(
                    src: "https://example.com/404.png",
                    fallbackIcon: "exclamationmark.triangle"
                )

                // URL \(tr("avatar.src_type"))
                Moin.Avatar(
                    src: URL(string: "https://api.dicebear.com/7.x/avataaars/png?seed=Felix"),
                    size: .large
                )
                """
            }
        )
    }

    private var iconViewExample: some View {
        ExampleSection(
            title: tr("avatar.icon_view"),
            description: tr("avatar.icon_view_desc"),
            content: {
                HStack(spacing: 24) {
                    Moin.Avatar(backgroundColor: .blue, content: {
                        Image(systemName: "star.fill")
                            .foregroundStyle(.yellow)
                    })
                    Moin.Avatar(size: .large, backgroundColor: .purple, content: {
                        Image(systemName: "heart.fill")
                            .font(.system(size: 20))
                            .foregroundStyle(.pink)
                    })
                    Moin.Avatar(shape: .square, backgroundColor: .green, content: {
                        Text("🐱")
                            .font(.system(size: 18))
                    })
                }
            },
            code: {
                """
                // \(tr("avatar.icon_view_custom"))
                Moin.Avatar(backgroundColor: .blue) {
                    Image(systemName: "star.fill")
                        .foregroundStyle(.yellow)
                }

                Moin.Avatar(size: .large, backgroundColor: .purple) {
                    Image(systemName: "heart.fill")
                        .font(.system(size: 20))
                        .foregroundStyle(.pink)
                }

                // \(tr("avatar.icon_view_emoji"))
                Moin.Avatar(shape: .square, backgroundColor: .green) {
                    Text("🐱")
                        .font(.system(size: 18))
                }
                """
            }
        )
    }

    private var gapExample: some View {
        ExampleSection(
            title: tr("avatar.gap"),
            description: tr("avatar.gap_desc"),
            content: {
                VStack(alignment: .leading, spacing: 16) {
                    HStack(spacing: 24) {
                        VStack {
                            Moin.Avatar("ABC", gap: 2)
                            Text("gap: 2").font(.caption).foregroundStyle(.secondary)
                        }
                        VStack {
                            Moin.Avatar("ABC", gap: 4)
                            Text("gap: 4").font(.caption).foregroundStyle(.secondary)
                        }
                        VStack {
                            Moin.Avatar("ABC", gap: 8)
                            Text("gap: 8").font(.caption).foregroundStyle(.secondary)
                        }
                    }
                    HStack(spacing: 24) {
                        VStack {
                            Moin.Avatar("LongText", size: .large, gap: 4)
                            Text(tr("avatar.gap_auto_scale")).font(.caption).foregroundStyle(.secondary)
                        }
                    }
                }
            },
            code: {
                """
                // \(tr("avatar.gap_control"))
                Moin.Avatar("ABC", gap: 2)
                Moin.Avatar("ABC", gap: 4)  // \(tr("avatar.gap_default"))
                Moin.Avatar("ABC", gap: 8)

                // \(tr("avatar.gap_long_text"))
                Moin.Avatar("LongText", size: .large, gap: 4)
                """
            }
        )
    }

    private var colorExample: some View {
        ExampleSection(
            title: tr("avatar.color"),
            description: tr("avatar.color_desc"),
            content: {
                HStack(spacing: 24) {
                    Moin.Avatar("User", backgroundColor: .orange)
                    Moin.Avatar("Admin", backgroundColor: .green)
                    Moin.Avatar(icon: "star.fill", backgroundColor: .yellow)
                }
            },
            code: {
                """
                Moin.Avatar("User", backgroundColor: .orange)
                Moin.Avatar("Admin", backgroundColor: .green)
                Moin.Avatar(icon: "star.fill", backgroundColor: .yellow)
                """
            }
        )
    }

    private var groupExample: some View {
        ExampleSection(
            title: tr("avatar.group"),
            description: tr("avatar.group_desc"),
            content: {
                VStack(alignment: .leading, spacing: 16) {
                    Moin.AvatarGroup {
                        Moin.Avatar(icon: "person")
                        Moin.Avatar("A")
                        Moin.Avatar("B", backgroundColor: .blue)
                        Moin.Avatar(icon: "person.fill")
                    }
                    
                    Text("Max Count = 3")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    
                    Moin.AvatarGroup(maxCount: 3) {
                        Moin.Avatar(icon: "person")
                        Moin.Avatar("A")
                        Moin.Avatar("B", backgroundColor: .blue)
                        Moin.Avatar(icon: "person.fill")
                        Moin.Avatar("C")
                    }
                }
            },
            code: {
                """
                Moin.AvatarGroup {
                    Moin.Avatar(icon: "person")
                    Moin.Avatar("A")
                    Moin.Avatar("B", backgroundColor: .blue)
                    Moin.Avatar(icon: "person.fill")
                }
                
                Moin.AvatarGroup(maxCount: 3) {
                    Moin.Avatar(icon: "person")
                    Moin.Avatar("A")
                    Moin.Avatar("B", backgroundColor: .blue)
                    Moin.Avatar(icon: "person.fill")
                    Moin.Avatar("C")
                }
                """
            }
        )
    }
}
