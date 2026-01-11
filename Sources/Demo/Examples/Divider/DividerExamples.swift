import SwiftUI
import MoinUI

/// Divider 组件文档页面 Tab
enum DividerExamplesTab: String, CaseIterable {
    case examples
    case playground
    case api
}

/// Divider component examples
struct DividerExamples: View {
    @Localized var tr
    @Binding var selectedTab: DividerExamplesTab

    /// 锚点列表
    private let anchors: [AnchorItem] = [
        AnchorItem(id: "horizontal", titleKey: "divider.horizontal"),
        AnchorItem(id: "with_text", titleKey: "divider.with_text"),
        AnchorItem(id: "variant", titleKey: "divider.variant"),
        AnchorItem(id: "vertical", titleKey: "divider.vertical"),
        AnchorItem(id: "plain", titleKey: "divider.plain"),
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
        ExamplePageWithAnchor(pageName: "Divider", anchors: anchors) { _ in
            horizontalExample.id("horizontal")
            withTextExample.id("with_text")
            variantExample.id("variant")
            verticalExample.id("vertical")
            plainExample.id("plain")
        }
    }

    // MARK: - Playground Content

    private var playgroundContent: some View {
        DividerPlayground()
            .padding(Moin.Constants.Spacing.xl)
    }

    // MARK: - API Content

    private var apiContent: some View {
        DividerAPIContent()
    }

    // MARK: - Examples

    private var horizontalExample: some View {
        ExampleSection(
            title: tr("divider.horizontal"),
            description: tr("divider.horizontal_desc")
        ) {
            VStack(alignment: .leading, spacing: 0) {
                Text(tr("divider.lorem1"))
                Moin.Divider()
                Text(tr("divider.lorem2"))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        } code: {
            """
            VStack(alignment: .leading, spacing: 0) {
                Text("Content here...")
                Moin.Divider()
                Text("More content here...")
            }
            """
        }
    }

    private var withTextExample: some View {
        ExampleSection(
            title: tr("divider.with_text"),
            description: tr("divider.with_text_desc")
        ) {
            VStack(alignment: .leading, spacing: 0) {
                Text(tr("divider.lorem_short"))

                Moin.Divider(tr("divider.label.left"), titlePlacement: .left)
                Text(tr("divider.left_aligned"))

                Moin.Divider(tr("divider.label.center"), titlePlacement: .center)
                Text(tr("divider.center_aligned"))

                Moin.Divider(tr("divider.label.right"), titlePlacement: .right)
                Text(tr("divider.right_aligned"))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        } code: {
            """
            Moin.Divider("Left", titlePlacement: .left)
            Moin.Divider("Center", titlePlacement: .center)
            Moin.Divider("Right", titlePlacement: .right)
            """
        }
    }

    private var variantExample: some View {
        ExampleSection(
            title: tr("divider.variant"),
            description: tr("divider.variant_desc")
        ) {
            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.lg) {
                VStack(alignment: .leading, spacing: Moin.Constants.Spacing.xs) {
                    Text(tr("divider.solid")).font(.caption).foregroundStyle(.secondary)
                    Moin.Divider(variant: .solid)
                }
                VStack(alignment: .leading, spacing: Moin.Constants.Spacing.xs) {
                    Text(tr("divider.dashed")).font(.caption).foregroundStyle(.secondary)
                    Moin.Divider(variant: .dashed)
                }
                VStack(alignment: .leading, spacing: Moin.Constants.Spacing.xs) {
                    Text(tr("divider.dotted")).font(.caption).foregroundStyle(.secondary)
                    Moin.Divider(variant: .dotted)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        } code: {
            """
            Moin.Divider(variant: .solid)
            Moin.Divider(variant: .dashed)
            Moin.Divider(variant: .dotted)
            """
        }
    }

    private var verticalExample: some View {
        ExampleSection(
            title: tr("divider.vertical"),
            description: tr("divider.vertical_desc")
        ) {
            HStack {
                Text(tr("divider.text"))
                Moin.Divider(orientation: .vertical)
                    .frame(height: 14)
                Text(tr("divider.link"))
                    .foregroundStyle(Color.accentColor)
                Moin.Divider(orientation: .vertical)
                    .frame(height: 14)
                Text(tr("divider.link"))
                    .foregroundStyle(Color.accentColor)
            }
        } code: {
            """
            HStack {
                Text("Text")
                Moin.Divider(orientation: .vertical)
                    .frame(height: 14)
                Text("Link")
                Moin.Divider(orientation: .vertical)
                    .frame(height: 14)
                Text("Link")
            }
            """
        }
    }

    private var plainExample: some View {
        ExampleSection(
            title: tr("divider.plain"),
            description: tr("divider.plain_desc")
        ) {
            VStack(alignment: .leading, spacing: 0) {
                Text(tr("divider.lorem_short"))

                Moin.Divider(tr("divider.label.text"))
                Text(tr("divider.normal_style"))

                Moin.Divider(tr("divider.label.text"), plain: true)
                Text(tr("divider.plain_style"))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        } code: {
            """
            Moin.Divider("\\(tr("divider.label.text"))")           // bold
            Moin.Divider("\\(tr("divider.label.text"))", plain: true)  // regular
            """
        }
    }
}

#Preview {
    DividerExamples(selectedTab: .constant(.examples))
        .moinThemeRoot()
        .frame(width: 800, height: 600)
}
