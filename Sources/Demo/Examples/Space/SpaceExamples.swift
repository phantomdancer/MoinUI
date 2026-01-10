import SwiftUI
import MoinUI

/// Space 组件文档页面 Tab
enum SpaceExamplesTab: String, CaseIterable {
    case examples
    case playground
    case api
}

/// Space component examples
struct SpaceExamples: View {
    @Localized var tr
    @Binding var selectedTab: SpaceExamplesTab

    /// 锚点列表
    private let anchors: [AnchorItem] = [
        AnchorItem(id: "basic", titleKey: "space.basic"),
        AnchorItem(id: "size", titleKey: "space.size"),
        AnchorItem(id: "direction", titleKey: "space.direction"),
        AnchorItem(id: "alignment", titleKey: "space.alignment"),
        AnchorItem(id: "wrap", titleKey: "space.wrap"),
        AnchorItem(id: "compact", titleKey: "space.compact"),
        AnchorItem(id: "separator", titleKey: "space.separator"),
    ]

    var body: some View {
        Group {
            if selectedTab == .examples {
                examplesContent
            } else if selectedTab == .playground {
                playgroundContent
            } else {
                apiContent
            }
        }
    }

    // MARK: - Examples Content

    private var examplesContent: some View {
        ExamplePageWithAnchor(pageName: "Space", anchors: anchors) { _ in
            basicExample.id("basic")
            sizeExample.id("size")
            directionExample.id("direction")
            alignmentExample.id("alignment")
            wrapExample.id("wrap")
            compactExample.id("compact")
            separatorExample.id("separator")
        }
    }

    // MARK: - Playground Content

    private var playgroundContent: some View {
        SpacePlayground()
            .padding(Moin.Constants.Spacing.xl)
    }

    // MARK: - API Content

    private var apiContent: some View {
        SpaceAPIContent()
    }

    // MARK: - Examples

    private var basicExample: some View {
        ExampleSection(
            title: tr("space.basic"),
            description: tr("space.basic_desc")
        ) {
            Moin.Space {
                Moin.Button("Button 1", color: .primary) {}
                Moin.Button("Button 2", color: .primary) {}
                Moin.Button("Button 3", color: .primary) {}
            }
        } code: {
            """
            Moin.Space {
                Moin.Button("Button 1", color: .primary) {}
                Moin.Button("Button 2", color: .primary) {}
                Moin.Button("Button 3", color: .primary) {}
            }
            """
        }
    }

    private var sizeExample: some View {
        ExampleSection(
            title: tr("space.size"),
            description: tr("space.size_desc")
        ) {
            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.md) {
                HStack {
                    Text("small:").frame(width: 60, alignment: .leading)
                    Moin.Space(size: .small) {
                        Moin.Button("Button", color: .primary) {}
                        Moin.Button("Button", color: .primary) {}
                        Moin.Button("Button", color: .primary) {}
                    }
                }
                HStack {
                    Text("medium:").frame(width: 60, alignment: .leading)
                    Moin.Space(size: .medium) {
                        Moin.Button("Button", color: .primary) {}
                        Moin.Button("Button", color: .primary) {}
                        Moin.Button("Button", color: .primary) {}
                    }
                }
                HStack {
                    Text("large:").frame(width: 60, alignment: .leading)
                    Moin.Space(size: .large) {
                        Moin.Button("Button", color: .primary) {}
                        Moin.Button("Button", color: .primary) {}
                        Moin.Button("Button", color: .primary) {}
                    }
                }
                HStack {
                    Text("custom:").frame(width: 60, alignment: .leading)
                    Moin.Space(size: 24) {
                        Moin.Button("Button", color: .primary) {}
                        Moin.Button("Button", color: .primary) {}
                        Moin.Button("Button", color: .primary) {}
                    }
                }
            }
        } code: {
            """
            Moin.Space(size: .small) { ... }
            Moin.Space(size: .medium) { ... }
            Moin.Space(size: .large) { ... }
            Moin.Space(size: 24) { ... }  // 直接传数字
            """
        }
    }

    private var directionExample: some View {
        ExampleSection(
            title: tr("space.direction"),
            description: tr("space.direction_desc")
        ) {
            Moin.Space(direction: .vertical) {
                Moin.Button("Button 1", color: .primary) {}
                Moin.Button("Button 2", color: .primary) {}
                Moin.Button("Button 3", color: .primary) {}
            }
        } code: {
            """
            Moin.Space(direction: .vertical) {
                Moin.Button("Button 1", color: .primary) {}
                Moin.Button("Button 2", color: .primary) {}
                Moin.Button("Button 3", color: .primary) {}
            }
            """
        }
    }

    private var alignmentExample: some View {
        ExampleSection(
            title: tr("space.alignment"),
            description: tr("space.alignment_desc")
        ) {
            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.md) {
                HStack {
                    Moin.Space(alignment: .start) {
                        Text("start:").frame(width: 50, alignment: .leading)
                        Moin.Button("Small", color: .primary, size: .small) {}
                        Moin.Button("Medium", color: .primary, size: .medium) {}
                        Moin.Button("Large", color: .primary, size: .large) {}
                    }
                }
                HStack {
                    Moin.Space(alignment: .center) {
                      Text("center:").frame(width: 50, alignment: .leading)
                        Moin.Button("Small", color: .primary, size: .small) {}
                        Moin.Button("Medium", color: .primary, size: .medium) {}
                        Moin.Button("Large", color: .primary, size: .large) {}
                    }
                }
                HStack {
                    Moin.Space(alignment: .end) {
                        Text("end:").frame(width: 50, alignment: .leading)
                        Moin.Button("Small", color: .primary, size: .small) {}
                        Moin.Button("Medium", color: .primary, size: .medium) {}
                        Moin.Button("Large", color: .primary, size: .large) {}
                    }
                }
            }
        } code: {
            """
            Moin.Space(alignment: .start) { ... }
            Moin.Space(alignment: .center) { ... }
            Moin.Space(alignment: .end) { ... }
            """
        }
    }

    private var wrapExample: some View {
        ExampleSection(
            title: tr("space.wrap"),
            description: tr("space.wrap_desc")
        ) {
            ResizableContainer(initialWidth: 400, minWidth: 200, maxWidth: 600) {
                Moin.Space(wrap: true) {
                    ForEach(1...6, id: \.self) { i in
                        Moin.Button("Button \(i)", color: .primary) {}
                    }
                }
            }
        } code: {
            """
            Moin.Space(wrap: true) {
                ForEach(1...6, id: \\.self) { i in
                    Moin.Button("Button \\(i)", color: .primary) {}
                }
            }
            """
        }
    }


    private var compactExample: some View {
        ExampleSection(
            title: tr("space.compact"),
            description: tr("space.compact_desc")
        ) {
            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.lg) {
                // Horizontal compact
                Text("Horizontal:")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Moin.Compact {
                    Moin.Button("January", variant: .outlined) {}
                    Moin.Button("February", variant: .outlined) {}
                    Moin.Button("March", variant: .outlined) {}
                }

                // Vertical compact
                Text("Vertical:")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Moin.Compact(direction: .vertical) {
                    Moin.Button("January") {}
                    Moin.Button("February") {}
                    Moin.Button("March") {}
                }
            }
        } code: {
            """
            // Horizontal compact
            Moin.Compact {
                Moin.Button("January", variant: .outlined) {}
                Moin.Button("February", variant: .outlined) {}
                Moin.Button("March", variant: .outlined) {}
            }

            // Vertical compact
            Moin.Compact(direction: .vertical) {
                Moin.Button("January") {}
                Moin.Button("February") {}
                Moin.Button("March") {}
            }
            """
        }
    }

    private var separatorExample: some View {
        ExampleSection(
            title: tr("space.separator"),
            description: tr("space.separator_desc")
        ) {
            let links = ["Link 1", "Link 2", "Link 3"]
            HStack(spacing: Moin.Constants.Spacing.sm) {
                ForEach(Array(links.enumerated()), id: \.offset) { index, link in
                    if index > 0 {
                        Divider()
                            .frame(height: 14)
                    }
                    Text(link)
                        .foregroundStyle(Color.accentColor)
                }
            }
        } code: {
            """
            let links = ["Link 1", "Link 2", "Link 3"]
            HStack(spacing: Moin.Constants.Spacing.sm) {
                ForEach(Array(links.enumerated()), id: \\.offset) { index, link in
                    if index > 0 {
                        Divider()
                            .frame(height: 14)
                    }
                    Text(link)
                        .foregroundStyle(Color.accentColor)
                }
            }
            """
        }
    }
}

#Preview {
    SpaceExamples(selectedTab: .constant(.examples))
        .moinThemeRoot()
        .frame(width: 800, height: 600)
}
