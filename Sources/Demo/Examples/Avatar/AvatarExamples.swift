import SwiftUI
import MoinUI

/// Avatar 组件文档页面 Tab
enum AvatarExamplesTab: String, CaseIterable {
    case examples
    case playground
    case api
    case token
}

struct AvatarExamples: View {
    @Localized var tr
    @Binding var selectedTab: AvatarExamplesTab

    /// 锚点列表
    private let anchors: [AnchorItem] = [
        AnchorItem(id: "basic", titleKey: "avatar.basic"),
        AnchorItem(id: "size", titleKey: "avatar.size"),
        AnchorItem(id: "shape", titleKey: "avatar.shape"),
        AnchorItem(id: "type", titleKey: "avatar.type"),
        AnchorItem(id: "color", titleKey: "avatar.color"),
        AnchorItem(id: "group", titleKey: "avatar.group"),
    ]

    var body: some View {
        Group {
            if selectedTab == .examples {
                examplesContent
            } else if selectedTab == .playground {
                playgroundContent
            } else if selectedTab == .api {
                apiContent
            } else {
                tokenContent
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
            colorExample.id("color")
            groupExample.id("group")
        }
    }

    // MARK: - Playground Content
    private var playgroundContent: some View {
        AvatarPlayground()
            .padding(Moin.Constants.Spacing.xl)
    }

    // MARK: - API Content
    private var apiContent: some View {
        AvatarAPIContent()
    }

    // MARK: - Token Content
    private var tokenContent: some View {
        AvatarTokenSection()
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
                    Moin.Avatar(icon: "person", size: .custom(64))
                }
            },
            code: {
                """
                Moin.Avatar(icon: "person", size: .large)
                Moin.Avatar(icon: "person", size: .default)
                Moin.Avatar(icon: "person", size: .small)
                Moin.Avatar(icon: "person", size: .custom(64))
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

