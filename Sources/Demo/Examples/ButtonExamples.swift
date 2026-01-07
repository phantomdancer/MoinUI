import SwiftUI
import MoinUI

/// 按钮组件文档页面 Tab
enum ButtonExamplesTab: String, CaseIterable {
    case examples
    case playground
}

/// Button component examples
struct ButtonExamples: View {
    @EnvironmentObject var localization: MoinUILocalization
    @Binding var selectedTab: ButtonExamplesTab
    @State private var isLoading = false

    /// 锚点列表
    private let anchors: [AnchorItem] = [
        AnchorItem(id: "type", titleKey: "button.type"),
        AnchorItem(id: "color", titleKey: "button.color"),
        AnchorItem(id: "variant", titleKey: "button.variant"),
        AnchorItem(id: "size", titleKey: "button.size"),
        AnchorItem(id: "shape", titleKey: "button.shape"),
        AnchorItem(id: "state", titleKey: "button.state"),
        AnchorItem(id: "icon", titleKey: "button.icon"),
        AnchorItem(id: "icon_text", titleKey: "button.icon_text"),
        AnchorItem(id: "link", titleKey: "button.link"),
        AnchorItem(id: "group", titleKey: "button.group"),
        AnchorItem(id: "block", titleKey: "button.block"),
        AnchorItem(id: "api", titleKey: "API"),
    ]

    var body: some View {
        Group {
            switch selectedTab {
            case .examples:
                examplesContent
            case .playground:
                playgroundContent
            }
        }
    }

    // MARK: - Examples Content

    private var examplesContent: some View {
        ExamplePageWithAnchor(anchors: anchors) { _ in
            VStack(alignment: .leading, spacing: Constants.Spacing.xl) {
                typeExample.id("type")
                colorExample.id("color")
                variantExample.id("variant")
                sizeExample.id("size")
                shapeExample.id("shape")
                stateExample.id("state")
                iconExample.id("icon")
                iconTextExample.id("icon_text")
                linkExample.id("link")
                groupExample.id("group")
                blockExample.id("block")

                Divider()

                apiReference.id("api")
            }
        }
    }

    // MARK: - Playground Content

    private var playgroundContent: some View {
        ButtonPlayground()
            .padding(Constants.Spacing.xl)
    }

    // MARK: - Examples

    private var typeExample: some View {
        ExampleSection(
            title: localization.tr("button.type"),
            description: localization.tr("button.type_desc")
        ) {
            HStack(spacing: Constants.Spacing.md) {
                MoinUIButton(localization.tr("button.label.default")) {}
                MoinUIButton(localization.tr("button.label.primary"), type: .primary) {}
                MoinUIButton(localization.tr("button.label.success"), type: .success) {}
                MoinUIButton(localization.tr("button.label.warning"), type: .warning) {}
                MoinUIButton(localization.tr("button.label.danger"), type: .danger) {}
                MoinUIButton(localization.tr("button.label.info"), type: .info) {}
            }
        } code: {
            """
            MoinUIButton("\(localization.tr("button.label.default"))") {}
            MoinUIButton("\(localization.tr("button.label.primary"))", type: .primary) {}
            MoinUIButton("\(localization.tr("button.label.success"))", type: .success) {}
            MoinUIButton("\(localization.tr("button.label.warning"))", type: .warning) {}
            MoinUIButton("\(localization.tr("button.label.danger"))", type: .danger) {}
            MoinUIButton("\(localization.tr("button.label.info"))", type: .info) {}
            """
        }
    }

    private var colorExample: some View {
        ExampleSection(
            title: localization.tr("button.color"),
            description: localization.tr("button.color_desc")
        ) {
            VStack(alignment: .leading, spacing: Constants.Spacing.md) {
                // Pink
                HStack(spacing: Constants.Spacing.sm) {
                    MoinUIButton(localization.tr("button.label.solid"), variant: .solid, color: Color.pink) {}
                    MoinUIButton(localization.tr("button.label.outline"), variant: .outline, color: Color.pink) {}
                    MoinUIButton(localization.tr("button.label.text"), variant: .text, color: Color.pink) {}
                    MoinUIButton(localization.tr("button.label.link"), variant: .link, color: Color.pink) {}
                }
                // Purple
                HStack(spacing: Constants.Spacing.sm) {
                    MoinUIButton(localization.tr("button.label.solid"), variant: .solid, color: Color.purple) {}
                    MoinUIButton(localization.tr("button.label.outline"), variant: .outline, color: Color.purple) {}
                    MoinUIButton(localization.tr("button.label.text"), variant: .text, color: Color.purple) {}
                    MoinUIButton(localization.tr("button.label.link"), variant: .link, color: Color.purple) {}
                }
                // Cyan
                HStack(spacing: Constants.Spacing.sm) {
                    MoinUIButton(localization.tr("button.label.solid"), variant: .solid, color: Color.cyan) {}
                    MoinUIButton(localization.tr("button.label.outline"), variant: .outline, color: Color.cyan) {}
                    MoinUIButton(localization.tr("button.label.text"), variant: .text, color: Color.cyan) {}
                    MoinUIButton(localization.tr("button.label.link"), variant: .link, color: Color.cyan) {}
                }
                // Orange
                HStack(spacing: Constants.Spacing.sm) {
                    MoinUIButton(localization.tr("button.label.solid"), variant: .solid, color: Color.orange) {}
                    MoinUIButton(localization.tr("button.label.outline"), variant: .outline, color: Color.orange) {}
                    MoinUIButton(localization.tr("button.label.text"), variant: .text, color: Color.orange) {}
                    MoinUIButton(localization.tr("button.label.link"), variant: .link, color: Color.orange) {}
                }
            }
        } code: {
            """
            // Pink
            MoinUIButton("\(localization.tr("button.label.solid"))", variant: .solid, color: Color.pink) {}
            MoinUIButton("\(localization.tr("button.label.outline"))", variant: .outline, color: Color.pink) {}

            // Purple
            MoinUIButton("\(localization.tr("button.label.solid"))", variant: .solid, color: Color.purple) {}

            // Cyan
            MoinUIButton("\(localization.tr("button.label.solid"))", variant: .solid, color: Color.cyan) {}
            """
        }
    }

    private var variantExample: some View {
        ExampleSection(
            title: localization.tr("button.variant"),
            description: localization.tr("button.variant_desc")
        ) {
            HStack(spacing: Constants.Spacing.md) {
                MoinUIButton(localization.tr("button.label.solid"), type: .primary, variant: .solid) {}
                MoinUIButton(localization.tr("button.label.outline"), type: .primary, variant: .outline) {}
                MoinUIButton(localization.tr("button.label.text"), type: .primary, variant: .text) {}
                MoinUIButton(localization.tr("button.label.link"), type: .primary, variant: .link) {}
                MoinUIButton(localization.tr("button.label.ghost"), type: .primary, variant: .ghost) {}
            }
        } code: {
            """
            MoinUIButton("\(localization.tr("button.label.solid"))", type: .primary, variant: .solid) {}
            MoinUIButton("\(localization.tr("button.label.outline"))", type: .primary, variant: .outline) {}
            MoinUIButton("\(localization.tr("button.label.text"))", type: .primary, variant: .text) {}
            MoinUIButton("\(localization.tr("button.label.link"))", type: .primary, variant: .link) {}
            MoinUIButton("\(localization.tr("button.label.ghost"))", type: .primary, variant: .ghost) {}
            """
        }
    }

    private var sizeExample: some View {
        ExampleSection(
            title: localization.tr("button.size"),
            description: localization.tr("button.size_desc")
        ) {
            HStack(alignment: .center, spacing: Constants.Spacing.md) {
                MoinUIButton(localization.tr("button.label.small"), type: .primary, size: .small) {}
                MoinUIButton(localization.tr("button.label.medium"), type: .primary, size: .medium) {}
                MoinUIButton(localization.tr("button.label.large"), type: .primary, size: .large) {}
            }
        } code: {
            """
            MoinUIButton("\(localization.tr("button.label.small"))", type: .primary, size: .small) {}
            MoinUIButton("\(localization.tr("button.label.medium"))", type: .primary, size: .medium) {}
            MoinUIButton("\(localization.tr("button.label.large"))", type: .primary, size: .large) {}
            """
        }
    }

    private var shapeExample: some View {
        ExampleSection(
            title: localization.tr("button.shape"),
            description: localization.tr("button.shape_desc")
        ) {
            HStack(spacing: Constants.Spacing.md) {
                MoinUIButton(localization.tr("button.label.default"), type: .primary, shape: .default) {}
                MoinUIButton(localization.tr("button.label.round"), type: .primary, shape: .round) {}
                MoinUIButton(icon: "plus", type: .primary, shape: .circle) {}
            }
        } code: {
            """
            MoinUIButton("\(localization.tr("button.label.default"))", type: .primary, shape: .default) {}
            MoinUIButton("\(localization.tr("button.label.round"))", type: .primary, shape: .round) {}
            MoinUIButton(icon: "plus", type: .primary, shape: .circle) {}
            """
        }
    }

    private var stateExample: some View {
        ExampleSection(
            title: localization.tr("button.state"),
            description: localization.tr("button.state_desc")
        ) {
            HStack(spacing: Constants.Spacing.md) {
                MoinUIButton(localization.tr("button.label.normal"), type: .primary) {}
                MoinUIButton(localization.tr("button.label.disabled"), type: .primary, isDisabled: true) {}
                MoinUIButton(localization.tr("button.label.loading"), type: .primary, isLoading: isLoading) {
                    isLoading = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        isLoading = false
                    }
                }
            }
        } code: {
            """
            MoinUIButton("\(localization.tr("button.label.normal"))", type: .primary) {}
            MoinUIButton("\(localization.tr("button.label.disabled"))", type: .primary, isDisabled: true) {}
            MoinUIButton("\(localization.tr("button.label.loading"))", type: .primary, isLoading: true) {}
            """
        }
    }

    private var iconExample: some View {
        ExampleSection(
            title: localization.tr("button.icon"),
            description: localization.tr("button.icon_desc")
        ) {
            HStack(spacing: Constants.Spacing.md) {
                MoinUIButton(icon: "plus", type: .primary) {}
                MoinUIButton(icon: "pencil", type: .success) {}
                MoinUIButton(icon: "trash", type: .danger) {}
                MoinUIButton(icon: "magnifyingglass", type: .info) {}
            }
        } code: {
            """
            MoinUIButton(icon: "plus", type: .primary) {}
            MoinUIButton(icon: "pencil", type: .success) {}
            MoinUIButton(icon: "trash", type: .danger) {}
            MoinUIButton(icon: "magnifyingglass", type: .info) {}
            """
        }
    }

    private var iconTextExample: some View {
        ExampleSection(
            title: localization.tr("button.icon_text"),
            description: localization.tr("button.icon_text_desc")
        ) {
            HStack(spacing: Constants.Spacing.md) {
                MoinUIButton(localization.tr("button.label.search"), type: .primary, icon: "magnifyingglass") {}
                MoinUIButton(localization.tr("button.label.download"), type: .success, icon: "arrow.down.circle") {}
                MoinUIButton(localization.tr("button.label.go"), type: .info, icon: "arrow.right", iconPosition: .trailing) {}
            }
        } code: {
            """
            MoinUIButton("\(localization.tr("button.label.search"))", type: .primary, icon: "magnifyingglass") {}
            MoinUIButton("\(localization.tr("button.label.download"))", type: .success, icon: "arrow.down.circle") {}
            MoinUIButton("\(localization.tr("button.label.go"))", type: .info, icon: "arrow.right", iconPosition: .trailing) {}
            """
        }
    }

    private var linkExample: some View {
        ExampleSection(
            title: localization.tr("button.link"),
            description: localization.tr("button.link_desc")
        ) {
            HStack(spacing: Constants.Spacing.md) {
                MoinUIButton(
                    "MoinUI",
                    type: .primary,
                    icon: "link",
                    href: URL(string: "https://github.com/phantomdancer/MoinUI.git")
                )
            }
        } code: {
            """
            MoinUIButton(
                "MoinUI",
                type: .primary,
                icon: "link",
                href: URL(string: "https://github.com/phantomdancer/MoinUI.git")
            )
            """
        }
    }

    private var groupExample: some View {
        ExampleSection(
            title: localization.tr("button.group"),
            description: localization.tr("button.group_desc")
        ) {
            MoinUIButtonGroup {
                MoinUIButton(icon: "chevron.left", type: .primary, shape: .default) {}
                MoinUIButton(icon: "chevron.right", type: .primary, shape: .default) {}
            }
        } code: {
            """
            MoinUIButtonGroup {
                MoinUIButton(icon: "chevron.left", type: .primary) {}
                MoinUIButton(icon: "chevron.right", type: .primary) {}
            }
            """
        }
    }

    private var blockExample: some View {
        ExampleSection(
            title: localization.tr("button.block"),
            description: localization.tr("button.block_desc")
        ) {
            MoinUIButton(localization.tr("button.label.block_button"), type: .primary, isBlock: true) {}
        } code: {
            """
            MoinUIButton("\(localization.tr("button.label.block_button"))", type: .primary, isBlock: true) {}
            """
        }
    }

    // MARK: - API Reference

    private var apiReference: some View {
        VStack(alignment: .leading, spacing: Constants.Spacing.lg) {
            Text("API")
                .font(.title2)
                .fontWeight(.semibold)

            APITable(
                headers: (
                    localization.tr("api.property"),
                    localization.tr("api.type"),
                    localization.tr("api.default"),
                    localization.tr("api.description")
                ),
                rows: [
                    ("type", "MoinUIButtonType", ".default", localization.tr("api.button.type")),
                    ("size", "MoinUIButtonSize", ".medium", localization.tr("api.button.size")),
                    ("variant", "MoinUIButtonVariant", ".solid", localization.tr("api.button.variant")),
                    ("shape", "MoinUIButtonShape", ".default", localization.tr("api.button.shape")),
                    ("color", "Color?", "nil", localization.tr("api.button.color")),
                    ("icon", "String?", "nil", localization.tr("api.button.icon")),
                    ("iconPosition", "MoinUIButtonIconPosition", ".leading", localization.tr("api.button.iconPosition")),
                    ("isLoading", "Bool", "false", localization.tr("api.button.isLoading")),
                    ("isDisabled", "Bool", "false", localization.tr("api.button.isDisabled")),
                    ("isBlock", "Bool", "false", localization.tr("api.button.isBlock")),
                    ("href", "URL?", "nil", localization.tr("api.button.href")),
                    ("action", "(() -> Void)?", "nil", localization.tr("api.button.action")),
                ]
            )

            Text("MoinUIButtonType")
                .font(.headline)
                .padding(.top, Constants.Spacing.md)

            APITable(
                headers: (
                    localization.tr("api.value"),
                    localization.tr("api.type"),
                    localization.tr("api.default"),
                    localization.tr("api.description")
                ),
                rows: [
                    ("default", "-", "-", localization.tr("api.type_values.default")),
                    ("primary", "-", "-", localization.tr("api.type_values.primary")),
                    ("success", "-", "-", localization.tr("api.type_values.success")),
                    ("warning", "-", "-", localization.tr("api.type_values.warning")),
                    ("danger", "-", "-", localization.tr("api.type_values.danger")),
                    ("info", "-", "-", localization.tr("api.type_values.info")),
                ]
            )

            Text("MoinUIButtonVariant")
                .font(.headline)
                .padding(.top, Constants.Spacing.md)

            APITable(
                headers: (
                    localization.tr("api.value"),
                    localization.tr("api.type"),
                    localization.tr("api.default"),
                    localization.tr("api.description")
                ),
                rows: [
                    ("solid", "-", "-", localization.tr("api.variant_values.solid")),
                    ("outline", "-", "-", localization.tr("api.variant_values.outline")),
                    ("text", "-", "-", localization.tr("api.variant_values.text")),
                    ("link", "-", "-", localization.tr("api.variant_values.link")),
                    ("ghost", "-", "-", localization.tr("api.variant_values.ghost")),
                ]
            )
        }
    }
}

// MARK: - Helper Views

/// 示例区块：上下布局，效果在上，代码在下
struct ExampleSection<Content: View>: View {
    let title: String
    let description: String
    @ViewBuilder let content: () -> Content
    let code: () -> String

    @ObservedObject private var config = MoinUIConfigProvider.shared

    var body: some View {
        VStack(alignment: .leading, spacing: Constants.Spacing.md) {
            // 标题和描述
            Text(title)
                .font(.title3)
                .fontWeight(.semibold)

            Text(description)
                .font(.body)
                .foregroundStyle(.secondary)

            // 效果预览
            GroupBox {
                content()
                    .padding(Constants.Spacing.sm)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }

            // 代码展示
            ScrollView(.horizontal, showsIndicators: false) {
                HighlightedCodeView(code: code(), fontSize: 12)
                    .padding(Constants.Spacing.sm)
            }
            .background(config.isDarkMode ? Color(white: 0.08) : Color(white: 0.96))
            .cornerRadius(Constants.Radius.sm)
        }
    }
}

struct APITable: View {
    let headers: (String, String, String, String)
    let rows: [(String, String, String, String)]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            VStack(spacing: 0) {
                // Header
                HStack(spacing: 0) {
                    headerCell(headers.0, width: 140)
                    headerCell(headers.1, width: 180)
                    headerCell(headers.2, width: 100)
                    headerCell(headers.3, width: 220)
                }

                Divider()

                // Rows
                ForEach(rows.indices, id: \.self) { index in
                    HStack(spacing: 0) {
                        bodyCell(rows[index].0, isCode: true, width: 140)
                        bodyCell(rows[index].1, isCode: true, width: 180)
                        bodyCell(rows[index].2, width: 100)
                        bodyCell(rows[index].3, width: 220)
                    }
                    .background(index % 2 == 1 ? Color.primary.opacity(0.03) : Color.clear)

                    if index < rows.count - 1 {
                        Divider()
                    }
                }
            }
            .frame(minWidth: 640)
        }
        .background(Color(nsColor: .controlBackgroundColor))
        .cornerRadius(Constants.Radius.md)
        .overlay(
            RoundedRectangle(cornerRadius: Constants.Radius.md)
                .stroke(Color.primary.opacity(0.1), lineWidth: 1)
        )
    }

    private func headerCell(_ text: String, width: CGFloat) -> some View {
        Text(text)
            .font(.system(.caption, weight: .medium))
            .foregroundStyle(.secondary)
            .frame(width: width, alignment: .leading)
            .padding(.horizontal, Constants.Spacing.sm)
            .padding(.vertical, Constants.Spacing.xs)
    }

    private func bodyCell(_ text: String, isCode: Bool = false, width: CGFloat) -> some View {
        Text(text)
            .font(isCode ? .system(.caption, design: .monospaced) : .caption)
            .foregroundStyle(isCode ? Color.accentColor : .primary)
            .frame(width: width, alignment: .leading)
            .padding(.horizontal, Constants.Spacing.sm)
            .padding(.vertical, Constants.Spacing.xs)
    }
}
