import SwiftUI
import MoinUI

/// Divider 组件文档页面 Tab
enum DividerExamplesTab: String, CaseIterable {
    case examples
    case api
    case token
}

/// Divider component examples
struct DividerExamples: View {
    @Localized var tr
    @Binding var selectedTab: DividerExamplesTab

    // 懒加载状态
    @State private var apiReady = false
    @State private var tokenReady = false

    /// 锚点列表
    private let anchors: [AnchorItem] = [
        AnchorItem(id: "horizontal", titleKey: "divider.horizontal"),
        AnchorItem(id: "with_text", titleKey: "divider.with_text"),
        AnchorItem(id: "custom_content", titleKey: "divider.custom_content"),
        AnchorItem(id: "variant", titleKey: "divider.variant"),
        AnchorItem(id: "vertical", titleKey: "divider.vertical"),
        AnchorItem(id: "plain", titleKey: "divider.plain"),
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

    private func triggerLazyLoad(for tab: DividerExamplesTab) {
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
        ExamplePageWithAnchor(pageName: "Divider", anchors: anchors) { _ in
            horizontalExample.id("horizontal")
            withTextExample.id("with_text")
            customContentExample.id("custom_content")
            variantExample.id("variant")
            verticalExample.id("vertical")
            plainExample.id("plain")
        }
    }

    // MARK: - API Content

    private var apiContent: some View {
        DividerAPIView()
    }

    // MARK: - Token Content

    private var tokenContent: some View {
        DividerTokenView()
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
                Text("\(tr("divider.lorem1"))")
                Moin.Divider()
                Text("\(tr("divider.lorem2"))")
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
            Moin.Divider("\(tr("divider.label.left"))", titlePlacement: .left)
            Moin.Divider("\(tr("divider.label.center"))", titlePlacement: .center)
            Moin.Divider("\(tr("divider.label.right"))", titlePlacement: .right)
            """
        }
    }

    private var customContentExample: some View {
        ExampleSection(
            title: tr("divider.custom_content"),
            description: tr("divider.custom_content_desc")
        ) {
            VStack(alignment: .leading, spacing: 0) {
                Text(tr("divider.lorem_short"))

                Moin.Divider {
                    HStack(spacing: 4) {
                        Image(systemName: "star.fill")
                            .foregroundStyle(.yellow)
                        Text(tr("divider.label.featured"))
                            .fontWeight(.medium)
                    }
                }

                Text(tr("divider.lorem_short"))

                Moin.Divider(titlePlacement: .left) {
                    HStack(spacing: 4) {
                        Image(systemName: "link")
                            .foregroundStyle(Color.accentColor)
                        Moin.Typography.Link(tr("divider.label.more")) {}
                    }
                }

                Text(tr("divider.lorem_short"))

                Moin.Divider(variant: .dashed) {
                    Moin.Button(tr("divider.label.expand"), color: .primary, size: .small, variant: .text) {}
                }

                Text(tr("divider.lorem_short"))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        } code: {
            """
            // \(tr("divider.custom_icon_text"))
            Moin.Divider {
                HStack(spacing: 4) {
                    Image(systemName: "star.fill")
                        .foregroundStyle(.yellow)
                    Text("\(tr("divider.label.featured"))")
                }
            }

            // \(tr("divider.custom_link"))
            Moin.Divider(titlePlacement: .left) {
                HStack(spacing: 4) {
                    Image(systemName: "link")
                        .foregroundStyle(Color.accentColor)
                    Moin.Typography.Link("\(tr("divider.label.more"))") {}
                }
            }

            // \(tr("divider.custom_button"))
            Moin.Divider(variant: .dashed) {
                Moin.Button("\(tr("divider.label.expand"))", color: .primary, size: .small, variant: .text) {}
            }
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
                Text("\(tr("divider.text"))")
                Moin.Divider(orientation: .vertical)
                    .frame(height: 14)
                Text("\(tr("divider.link"))")
                Moin.Divider(orientation: .vertical)
                    .frame(height: 14)
                Text("\(tr("divider.link"))")
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
            Moin.Divider("\(tr("divider.label.text"))")           // bold
            Moin.Divider("\(tr("divider.label.text"))", plain: true)  // regular
            """
        }
    }
}
