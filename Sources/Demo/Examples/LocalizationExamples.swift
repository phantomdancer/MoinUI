import SwiftUI
import MoinUI

/// Localization usage examples
struct LocalizationExamples: View {
    @EnvironmentObject var localization: MoinUILocalization

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Constants.Spacing.xl) {
                introduction

                Divider()

                // 示例区域（单列显示）
                basicUsage
                customTranslations
                jsonTranslations

                Divider()

                apiReference
            }
            .padding(Constants.Spacing.xl)
        }
    }

    // MARK: - Introduction

    private var introduction: some View {
        VStack(alignment: .leading, spacing: Constants.Spacing.md) {
            Text(localization.tr("i18n.title"))
                .font(.largeTitle)
                .fontWeight(.bold)

            Text(localization.tr("i18n.description"))
                .font(.body)
                .foregroundStyle(.secondary)
        }
    }

    // MARK: - Examples

    private var basicUsage: some View {
        ExampleSection(
            title: localization.tr("i18n.basic"),
            description: localization.tr("i18n.basic_desc")
        ) {
            VStack(alignment: .leading, spacing: Constants.Spacing.sm) {
                Text("localization.tr(\"button.title\") = \"\(localization.tr("button.title"))\"")
                    .font(.system(.body, design: .monospaced))
            }
        } code: {
            """
            struct MyView: View {
                @EnvironmentObject var localization: MoinUILocalization

                var body: some View {
                    Text(localization.tr("button.title"))
                }
            }
            """
        }
    }

    private var customTranslations: some View {
        ExampleSection(
            title: localization.tr("i18n.custom"),
            description: localization.tr("i18n.custom_desc")
        ) {
            Text(localization.tr("i18n.custom_demo"))
                .foregroundStyle(.secondary)
        } code: {
            """
            // \(localization.tr("code_comment.register_custom_translations"))
            MoinUILocalization.shared.register([
                "my.key": "My Value",
                "my.other_key": "Other Value"
            ], locale: .zhCN)

            // \(localization.tr("code_comment.register_english"))
            MoinUILocalization.shared.register([
                "my.key": "My Value",
                "my.other_key": "Other Value"
            ], locale: .enUS)
            """
        }
    }

    private var jsonTranslations: some View {
        ExampleSection(
            title: localization.tr("i18n.json"),
            description: localization.tr("i18n.json_desc")
        ) {
            Text(localization.tr("i18n.json_demo"))
                .foregroundStyle(.secondary)
        } code: {
            """
            // zh-CN.json
            {
                "button": {
                    "title": "\(localization.tr("button.title"))",
                    "label": {
                        "primary": "\(localization.tr("button.label.primary"))"
                    }
                }
            }

            // \(localization.tr("code_comment.flattened_keys")): "button.title", "button.label.primary"

            // \(localization.tr("code_comment.load_json_file"))
            if let url = Bundle.module.url(
                forResource: "zh-CN",
                withExtension: "json",
                subdirectory: "Locales"
            ),
            let data = try? Data(contentsOf: url) {
                try? MoinUILocalization.shared.registerFromJSON(
                    data,
                    locale: .zhCN
                )
            }
            """
        }
    }

    // MARK: - API Reference

    private var apiReference: some View {
        VStack(alignment: .leading, spacing: Constants.Spacing.lg) {
            Text("API")
                .font(.title2)
                .fontWeight(.semibold)

            Text("MoinUILocalization")
                .font(.headline)

            APITable(
                headers: (
                    localization.tr("api.method"),
                    localization.tr("api.type"),
                    localization.tr("api.default"),
                    localization.tr("api.description")
                ),
                rows: [
                    ("tr(_:)", "String -> String", "-", localization.tr("api.i18n.tr")),
                    ("register(_:locale:)", "([String:String], MoinUILocale)", "-", localization.tr("api.i18n.register")),
                    ("registerFromJSON(_:locale:)", "(Data, MoinUILocale) throws", "-", localization.tr("api.i18n.registerFromJSON")),
                    ("locale", "MoinUILocale", ".zhCN", localization.tr("api.i18n.locale")),
                ]
            )
        }
    }
}
