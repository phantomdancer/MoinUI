import SwiftUI
import MoinUI

/// Localization usage examples
struct LocalizationExamples: View {
    @Localized var tr

    /// 锚点列表
    private let anchors: [AnchorItem] = [
        AnchorItem(id: "basic", titleKey: "i18n.basic"),
        AnchorItem(id: "custom", titleKey: "i18n.custom"),
        AnchorItem(id: "json", titleKey: "i18n.json"),
        AnchorItem(id: "api", titleKey: "i18n.anchor.api"),
    ]

    var body: some View {
        ExamplePageWithAnchor(pageName: "Localization", anchors: anchors) { _ in
            introduction

            Divider()

            basicUsage.id("basic")
            customTranslations.id("custom")
            jsonTranslations.id("json")

            Divider()

            apiReference.id("api")
        }
    }

    // MARK: - Introduction

    private var introduction: some View {
        VStack(alignment: .leading, spacing: Moin.Constants.Spacing.md) {
            Text(tr("i18n.title"))
                .font(.largeTitle)
                .fontWeight(.bold)

            Text(tr("i18n.description"))
                .font(.body)
                .foregroundStyle(.secondary)
        }
    }

    // MARK: - Examples

    private var basicUsage: some View {
        ExampleSection(
            title: tr("i18n.basic"),
            description: tr("i18n.basic_desc")
        ) {
            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.sm) {
                Text("tr(\"button.title\") = \"\(tr("button.title"))\"")
                    .font(.system(.body, design: .monospaced))
            }
        } code: {
            """
            struct MyView: View {
                @EnvironmentObject var localization: Moin.Localization

                var body: some View {
                    Text(tr("button.title"))
                }
            }
            """
        }
    }

    private var customTranslations: some View {
        ExampleSection(
            title: tr("i18n.custom"),
            description: tr("i18n.custom_desc")
        ) {
            Text(tr("i18n.custom_demo"))
                .foregroundStyle(.secondary)
        } code: {
            """
            // \(tr("code_comment.register_custom_translations"))
            Moin.Localization.shared.register([
                "my.key": "My Value",
                "my.other_key": "Other Value"
            ], locale: .zhCN)

            // \(tr("code_comment.register_english"))
            Moin.Localization.shared.register([
                "my.key": "My Value",
                "my.other_key": "Other Value"
            ], locale: .enUS)
            """
        }
    }

    private var jsonTranslations: some View {
        ExampleSection(
            title: tr("i18n.json"),
            description: tr("i18n.json_desc")
        ) {
            Text(tr("i18n.json_demo"))
                .foregroundStyle(.secondary)
        } code: {
            """
            // zh-CN.json
            {
                "button": {
                    "title": "\(tr("button.title"))",
                    "label": {
                        "primary": "\(tr("button.label.primary"))"
                    }
                }
            }

            // \(tr("code_comment.flattened_keys")): "button.title", "button.label.primary"

            // \(tr("code_comment.load_json_file"))
            if let url = Bundle.module.url(
                forResource: "zh-CN",
                withExtension: "json",
                subdirectory: "Locales"
            ),
            let data = try? Data(contentsOf: url) {
                try? Moin.Localization.shared.registerFromJSON(
                    data,
                    locale: .zhCN
                )
            }
            """
        }
    }

    // MARK: - API Reference

    private var apiReference: some View {
        VStack(alignment: .leading, spacing: Moin.Constants.Spacing.lg) {
            Text("API")
                .font(.title2)
                .fontWeight(.semibold)

            Text("Moin.Localization")
                .font(.headline)

            APITable(
                headers: (
                    tr("api.method"),
                    tr("api.type"),
                    tr("api.default"),
                    tr("api.description")
                ),
                rows: [
                    ("tr(_:)", "String -> String", "-", tr("api.i18n.tr")),
                    ("register(_:locale:)", "([String:String], Moin.Locale)", "-", tr("api.i18n.register")),
                    ("registerFromJSON(_:locale:)", "(Data, Moin.Locale) throws", "-", tr("api.i18n.registerFromJSON")),
                    ("locale", "Moin.Locale", ".zhCN", tr("api.i18n.locale")),
                ]
            )
        }
    }
}
