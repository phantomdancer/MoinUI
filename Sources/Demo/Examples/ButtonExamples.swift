import SwiftUI
import MoinUI

/// Button component examples
struct ButtonExamples: View {
    @EnvironmentObject var localization: MoinUILocalization
    @State private var isLoading = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Constants.Spacing.xl) {
                introduction

                Divider()

                // 示例区域（单列显示）
                basicExample
                typeExample
                variantExample
                sizeExample
                shapeExample
                stateExample
                iconExample
                blockExample

                Divider()

                apiReference
            }
            .padding(Constants.Spacing.xl)
        }
    }

    // MARK: - Introduction

    private var introduction: some View {
        VStack(alignment: .leading, spacing: Constants.Spacing.md) {
            Text(localization.tr("button.title"))
                .font(.largeTitle)
                .fontWeight(.bold)

            Text(localization.tr("button.description"))
                .font(.body)
                .foregroundStyle(.secondary)
        }
    }

    // MARK: - Examples

    private var basicExample: some View {
        ExampleSection(
            title: localization.tr("button.basic"),
            description: localization.tr("button.basic_desc")
        ) {
            HStack(spacing: Constants.Spacing.md) {
                MoinUIButton(localization.tr("button.label.button")) {}
                MoinUIButton(localization.tr("button.label.primary"), type: .primary) {}
            }
        } code: {
            """
            MoinUIButton("\(localization.tr("button.label.button"))") {}
            MoinUIButton("\(localization.tr("button.label.primary"))", type: .primary) {}
            """
        }
    }

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
            MoinUIButton("\(localization.tr("button.label.loading"))", type: .primary, isLoading: isLoading) {
                isLoading = true
            }
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
                    ("isLoading", "Bool", "false", localization.tr("api.button.isLoading")),
                    ("isDisabled", "Bool", "false", localization.tr("api.button.isDisabled")),
                    ("isBlock", "Bool", "false", localization.tr("api.button.isBlock")),
                    ("action", "() -> Void", "-", localization.tr("api.button.action")),
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

struct ExampleSection<Content: View>: View {
    let title: String
    let description: String
    @ViewBuilder let content: () -> Content
    let code: () -> String

    @EnvironmentObject private var localization: MoinUILocalization
    @State private var showCode = false
    @ObservedObject private var config = MoinUIConfigProvider.shared

    var body: some View {
        VStack(alignment: .leading, spacing: Constants.Spacing.md) {
            Text(title)
                .font(.title3)
                .fontWeight(.semibold)

            Text(description)
                .font(.body)
                .foregroundStyle(.secondary)

            GroupBox {
                VStack(alignment: .leading, spacing: Constants.Spacing.md) {
                    content()
                        .padding(Constants.Spacing.sm)

                    Divider()

                    // 左对齐显示代码按钮，整行可点击
                    Button(action: { showCode.toggle() }) {
                        HStack(spacing: Constants.Spacing.xs) {
                            Image(systemName: showCode ? "chevron.up" : "chevron.down")
                            Text(showCode ? localization.tr("code.hide") : localization.tr("code.show"))
                            Spacer()
                        }
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .padding(.vertical, Constants.Spacing.xs)
                        .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)

                    if showCode {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HighlightedCodeView(code: code())
                                .padding(Constants.Spacing.sm)
                        }
                        .background(config.isDarkMode ? Color(white: 0.08) : Color(white: 0.96))
                        .cornerRadius(Constants.Radius.sm)
                    }
                }
            }
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
