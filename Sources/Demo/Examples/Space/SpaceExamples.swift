import SwiftUI
import MoinUI

/// Space 组件文档页面 Tab
enum SpaceExamplesTab: String, CaseIterable {
    case examples
    case api
    case token
}

/// Space component examples
struct SpaceExamples: View {
    @Localized var tr
    @Binding var selectedTab: SpaceExamplesTab

    // 懒加载状态
    @State private var apiReady = false
    @State private var tokenReady = false

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

    private func triggerLazyLoad(for tab: SpaceExamplesTab) {
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

    // MARK: - API Content

    private var apiContent: some View {
        SpaceAPIView()
    }

    // MARK: - Token Content

    private var tokenContent: some View {
        SpaceTokenView()
    }

    // MARK: - Examples

    private var basicExample: some View {
        ExampleSection(
            title: tr("space.basic"),
            description: tr("space.basic_desc")
        ) {
            _Space {
                Moin.Button("\(tr("button.label.button")) 1", color: .primary) {}
                Moin.Button("\(tr("button.label.button")) 2", color: .primary) {}
                Moin.Button("\(tr("button.label.button")) 3", color: .primary) {}
            }
        } code: {
            """
            _Space {
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
            SpaceSizeDemoView()
        } code: {
            """
            Moin.Space(size: .small) {
                Moin.Button(tr("button.label.button"), color: .primary) {}
                Moin.Button(tr("button.label.button"), color: .primary) {}
                Moin.Button(tr("button.label.button"), color: .primary) {}
            }
            Moin.Space(size: .medium) {
                Moin.Button(tr("button.label.button"), color: .primary) {}
                Moin.Button(tr("button.label.button"), color: .primary) {}
                Moin.Button(tr("button.label.button"), color: .primary) {}
            }
            Moin.Space(size: .large) {
                Moin.Button(tr("button.label.button"), color: .primary) {}
                Moin.Button(tr("button.label.button"), color: .primary) {}
                Moin.Button(tr("button.label.button"), color: .primary) {}
            }
            Moin.Space(size: 24) {
                Moin.Button(tr("button.label.button"), color: .primary) {}
                Moin.Button(tr("button.label.button"), color: .primary) {}
                Moin.Button(tr("button.label.button"), color: .primary) {}
            }  // \(tr("space.pass_number"))
            """
        }
    }

    private var directionExample: some View {
        ExampleSection(
            title: tr("space.direction"),
            description: tr("space.direction_desc")
        ) {
            SpaceDirectionDemoView()
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
            SpaceAlignmentDemoView()
        } code: {
            """
            // \(tr("space.horizontal"))
            Moin.Space(alignment: .start) { ... }
            Moin.Space(alignment: .center) { ... }
            Moin.Space(alignment: .end) { ... }
            
            // \(tr("space.vertical"))
            Moin.Space(direction: .vertical, alignment: .start) { ... }
            Moin.Space(direction: .vertical, alignment: .center) { ... }
            Moin.Space(direction: .vertical, alignment: .end) { ... }
            """
        }
    }

    private var wrapExample: some View {
        ExampleSection(
            title: tr("space.wrap"),
            description: tr("space.wrap_desc")
        ) {
            SpaceWrapDemoView()
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
            _Space {
                Moin.Space.Compact(direction: .vertical) {
                    Moin.Button("\(tr("button.label.button")) 1", variant: .outlined) {}
                    Moin.Button("\(tr("button.label.button")) 2", variant: .outlined) {}
                    Moin.Button("\(tr("button.label.button")) 3", variant: .outlined) {}
                }
                Moin.Space.Compact(direction: .vertical) {
                    Moin.Button("\(tr("button.label.button")) 1", variant: .dashed) {}
                    Moin.Button("\(tr("button.label.button")) 2", variant: .dashed) {}
                    Moin.Button("\(tr("button.label.button")) 3", variant: .dashed) {}
                }
                Moin.Space.Compact(direction: .vertical) {
                    Moin.Button("\(tr("button.label.button")) 1", color: .primary) {}
                    Moin.Button("\(tr("button.label.button")) 2", color: .primary) {}
                    Moin.Button("\(tr("button.label.button")) 3", color: .primary) {}
                }
            }
        } code: {
            """
            _Space {
                Moin.Space.Compact(direction: .vertical) {
                    Moin.Button("\(tr("space.button_n").replacingOccurrences(of: "%d", with: "1"))", variant: .outlined) {}
                    Moin.Button("\(tr("space.button_n").replacingOccurrences(of: "%d", with: "2"))", variant: .outlined) {}
                    Moin.Button("\(tr("space.button_n").replacingOccurrences(of: "%d", with: "3"))", variant: .outlined) {}
                }
                Moin.Space.Compact(direction: .vertical) {
                    Moin.Button("\(tr("space.button_n").replacingOccurrences(of: "%d", with: "1"))", variant: .dashed) {}
                    Moin.Button("\(tr("space.button_n").replacingOccurrences(of: "%d", with: "2"))", variant: .dashed) {}
                    Moin.Button("\(tr("space.button_n").replacingOccurrences(of: "%d", with: "3"))", variant: .dashed) {}
                }
                Moin.Space.Compact(direction: .vertical) {
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
            SpaceSeparatorDemoView()
        } code: {
            """
            // \(tr("space.horizontal"))
            Moin.Space(size: .small, separator: { Moin.Divider(orientation: .vertical) }) {
                Moin.Typography.Link("\(tr("space.link_n").replacingOccurrences(of: "%d", with: "1"))") {}
                Moin.Typography.Link("\(tr("space.link_n").replacingOccurrences(of: "%d", with: "2"))") {}
                Moin.Typography.Link("\(tr("space.link_n").replacingOccurrences(of: "%d", with: "3"))") {}
            }

            // \(tr("space.vertical"))
            Moin.Space(direction: .vertical, separator: { Moin.Divider() }) {
                Moin.Typography.Link("\(tr("space.link_n").replacingOccurrences(of: "%d", with: "1"))") {}
                Moin.Typography.Link("\(tr("space.link_n").replacingOccurrences(of: "%d", with: "2"))") {}
                Moin.Typography.Link("\(tr("space.link_n").replacingOccurrences(of: "%d", with: "3"))") {}
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
