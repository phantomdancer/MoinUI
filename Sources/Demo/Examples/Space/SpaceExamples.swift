import SwiftUI
import MoinUI

/// Space 组件文档页面 Tab
enum SpaceExamplesTab: String, CaseIterable {
    case examples
    case playground
    case api
    case token
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
            } else if selectedTab == .api {
                apiContent
            } else {
                tokenContent
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

    // MARK: - Token Content

    private var tokenContent: some View {
        SpaceTokenContent()
    }

    // MARK: - Examples

    private var basicExample: some View {
        ExampleSection(
            title: tr("space.basic"),
            description: tr("space.basic_desc")
        ) {
            Moin.Space {
                Moin.Button("\(tr("button.label.button")) 1", color: .primary) {}
                Moin.Button("\(tr("button.label.button")) 2", color: .primary) {}
                Moin.Button("\(tr("button.label.button")) 3", color: .primary) {}
            }
        } code: {
            """
            Moin.Space {
                Moin.Button("\(tr("space.button_n").replacingOccurrences(of: "%d", with: "1"))", color: .primary) {}
                Moin.Button("\(tr("space.button_n").replacingOccurrences(of: "%d", with: "2"))", color: .primary) {}
                Moin.Button("\(tr("space.button_n").replacingOccurrences(of: "%d", with: "3"))", color: .primary) {}
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
                        Moin.Button(tr("button.label.button"), color: .primary) {}
                        Moin.Button(tr("button.label.button"), color: .primary) {}
                        Moin.Button(tr("button.label.button"), color: .primary) {}
                    }
                }
                HStack {
                    Text("medium:").frame(width: 60, alignment: .leading)
                    Moin.Space(size: .medium) {
                        Moin.Button(tr("button.label.button"), color: .primary) {}
                        Moin.Button(tr("button.label.button"), color: .primary) {}
                        Moin.Button(tr("button.label.button"), color: .primary) {}
                    }
                }
                HStack {
                    Text("large:").frame(width: 60, alignment: .leading)
                    Moin.Space(size: .large) {
                        Moin.Button(tr("button.label.button"), color: .primary) {}
                        Moin.Button(tr("button.label.button"), color: .primary) {}
                        Moin.Button(tr("button.label.button"), color: .primary) {}
                    }
                }
                HStack {
                    Text("\(tr("space.custom")):").frame(width: 60, alignment: .leading)
                    Moin.Space(size: 24) {
                        Moin.Button(tr("button.label.button"), color: .primary) {}
                        Moin.Button(tr("button.label.button"), color: .primary) {}
                        Moin.Button(tr("button.label.button"), color: .primary) {}
                    }
                }
            }
        } code: {
            """
            Moin.Space(size: .small) { ... }
            Moin.Space(size: .medium) { ... }
            Moin.Space(size: .large) { ... }
            Moin.Space(size: 24) { ... }  // \(tr("space.pass_number"))
            """
        }
    }

    private var directionExample: some View {
        ExampleSection(
            title: tr("space.direction"),
            description: tr("space.direction_desc")
        ) {
            Moin.Space(direction: .vertical) {
                Moin.Button("\(tr("button.label.button")) 1", color: .primary) {}
                Moin.Button("\(tr("button.label.button")) 2", color: .primary) {}
                Moin.Button("\(tr("button.label.button")) 3", color: .primary) {}
            }
        } code: {
            """
            Moin.Space(direction: .vertical) {
                Moin.Button("\(tr("space.button_n").replacingOccurrences(of: "%d", with: "1"))", color: .primary) {}
                Moin.Button("\(tr("space.button_n").replacingOccurrences(of: "%d", with: "2"))", color: .primary) {}
                Moin.Button("\(tr("space.button_n").replacingOccurrences(of: "%d", with: "3"))", color: .primary) {}
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
                        Moin.Button(tr("button.label.small"), color: .primary, size: .small) {}
                        Moin.Button(tr("button.label.medium"), color: .primary, size: .medium) {}
                        Moin.Button(tr("button.label.large"), color: .primary, size: .large) {}
                    }
                }
                HStack {
                    Moin.Space(alignment: .center) {
                      Text("center:").frame(width: 50, alignment: .leading)
                        Moin.Button(tr("button.label.small"), color: .primary, size: .small) {}
                        Moin.Button(tr("button.label.medium"), color: .primary, size: .medium) {}
                        Moin.Button(tr("button.label.large"), color: .primary, size: .large) {}
                    }
                }
                HStack {
                    Moin.Space(alignment: .end) {
                        Text("end:").frame(width: 50, alignment: .leading)
                        Moin.Button(tr("button.label.small"), color: .primary, size: .small) {}
                        Moin.Button(tr("button.label.medium"), color: .primary, size: .medium) {}
                        Moin.Button(tr("button.label.large"), color: .primary, size: .large) {}
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
                        Moin.Button("\(tr("button.label.button")) \(i)", color: .primary) {}
                    }
                }
            }
        } code: {
            """
            Moin.Space(wrap: true) {
                ForEach(1...6, id: \\.self) { i in
                    Moin.Button("\(tr("space.button_n").replacingOccurrences(of: "%d", with: "\\(i)"))", color: .primary) {}
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
            Moin.Space {
                Moin.SpaceCompact(direction: .vertical) {
                    Moin.Button("\(tr("button.label.button")) 1", variant: .outlined) {}
                    Moin.Button("\(tr("button.label.button")) 2", variant: .outlined) {}
                    Moin.Button("\(tr("button.label.button")) 3", variant: .outlined) {}
                }
                Moin.SpaceCompact(direction: .vertical) {
                    Moin.Button("\(tr("button.label.button")) 1", variant: .dashed) {}
                    Moin.Button("\(tr("button.label.button")) 2", variant: .dashed) {}
                    Moin.Button("\(tr("button.label.button")) 3", variant: .dashed) {}
                }
                Moin.SpaceCompact(direction: .vertical) {
                    Moin.Button("\(tr("button.label.button")) 1", color: .primary) {}
                    Moin.Button("\(tr("button.label.button")) 2", color: .primary) {}
                    Moin.Button("\(tr("button.label.button")) 3", color: .primary) {}
                }
            }
        } code: {
            """
            Moin.Space {
                Moin.SpaceCompact(direction: .vertical) {
                    Moin.Button("\(tr("space.button_n").replacingOccurrences(of: "%d", with: "1"))", variant: .outlined) {}
                    Moin.Button("\(tr("space.button_n").replacingOccurrences(of: "%d", with: "2"))", variant: .outlined) {}
                    Moin.Button("\(tr("space.button_n").replacingOccurrences(of: "%d", with: "3"))", variant: .outlined) {}
                }
                Moin.SpaceCompact(direction: .vertical) {
                    Moin.Button("\(tr("space.button_n").replacingOccurrences(of: "%d", with: "1"))", variant: .dashed) {}
                    Moin.Button("\(tr("space.button_n").replacingOccurrences(of: "%d", with: "2"))", variant: .dashed) {}
                    Moin.Button("\(tr("space.button_n").replacingOccurrences(of: "%d", with: "3"))", variant: .dashed) {}
                }
                Moin.SpaceCompact(direction: .vertical) {
                    Moin.Button("\(tr("space.button_n").replacingOccurrences(of: "%d", with: "1"))", color: .primary) {}
                    Moin.Button("\(tr("space.button_n").replacingOccurrences(of: "%d", with: "2"))", color: .primary) {}
                    Moin.Button("\(tr("space.button_n").replacingOccurrences(of: "%d", with: "3"))", color: .primary) {}
                }
            }
            """
        }
    }

    private var separatorExample: some View {
        ExampleSection(
            title: tr("space.separator"),
            description: tr("space.separator_desc")
        ) {
            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.lg) {
                // Horizontal with divider
                Text("\(tr("space.horizontal")):").font(.caption).foregroundStyle(.secondary)
                Moin.Space(size: .small, separator: { Moin.Divider(orientation: .vertical) }) {
                    Moin.Link(tr("space.link_n").replacingOccurrences(of: "%d", with: "1")) {}
                    Moin.Link(tr("space.link_n").replacingOccurrences(of: "%d", with: "2")) {}
                    Moin.Link(tr("space.link_n").replacingOccurrences(of: "%d", with: "3")) {}
                }

                // Vertical with custom separator
                Text("\(tr("space.vertical")):").font(.caption).foregroundStyle(.secondary)
                Moin.Space(direction: .vertical, separator: { Moin.Divider() }) {
                    Moin.Link(tr("space.link_n").replacingOccurrences(of: "%d", with: "1")) {}
                    Moin.Link(tr("space.link_n").replacingOccurrences(of: "%d", with: "2")) {}
                    Moin.Link(tr("space.link_n").replacingOccurrences(of: "%d", with: "3")) {}
                }

                // Custom text separator
                Text("\(tr("space.custom_separator")):").font(.caption).foregroundStyle(.secondary)
                Moin.Space(separator: { Text("|").foregroundStyle(.secondary) }) {
                    Text(tr("space.nav_home"))
                    Text(tr("space.nav_products"))
                    Text(tr("space.nav_about"))
                }

                // Icon separator
                Text("\(tr("space.icon_separator")):").font(.caption).foregroundStyle(.secondary)
                Moin.Space(separator: {
                    Image(systemName: "star.fill")
                        .font(.system(size: 8))
                        .foregroundStyle(.orange)
                }) {
                    Text("Swift")
                    Text("SwiftUI")
                    Text("MoinUI")
                }
            }
        } code: {
            """
            // \(tr("space.horizontal"))
            Moin.Space(size: .small, separator: { Moin.Divider(orientation: .vertical) }) {
                Moin.Link("\(tr("space.link_n").replacingOccurrences(of: "%d", with: "1"))") {}
                Moin.Link("\(tr("space.link_n").replacingOccurrences(of: "%d", with: "2"))") {}
                Moin.Link("\(tr("space.link_n").replacingOccurrences(of: "%d", with: "3"))") {}
            }

            // \(tr("space.vertical"))
            Moin.Space(direction: .vertical, separator: { Moin.Divider() }) {
                Moin.Link("\(tr("space.link_n").replacingOccurrences(of: "%d", with: "1"))") {}
                Moin.Link("\(tr("space.link_n").replacingOccurrences(of: "%d", with: "2"))") {}
                Moin.Link("\(tr("space.link_n").replacingOccurrences(of: "%d", with: "3"))") {}
            }

            // \(tr("space.custom_separator"))
            Moin.Space(separator: { Text("|").foregroundStyle(.secondary) }) {
                Text("\(tr("space.nav_home"))")
                Text("\(tr("space.nav_products"))")
                Text("\(tr("space.nav_about"))")
            }

            // \(tr("space.icon_separator"))
            Moin.Space(separator: {
                Image(systemName: "star.fill")
                    .font(.system(size: 8))
                    .foregroundStyle(.orange)
            }) {
                Text("Swift")
                Text("SwiftUI")
                Text("MoinUI")
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
