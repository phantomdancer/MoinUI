import SwiftUI
import MoinUI

/// ConfigProvider usage examples
struct ConfigProviderExamples: View {
    @EnvironmentObject var localization: Moin.Localization
    @EnvironmentObject var configProvider: Moin.ConfigProvider

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.xl) {
                introduction

                Divider()

                // 示例区域（单列显示）
                basicUsage
                localeConfig
                themeConfig
                tokenConfig

                Divider()

                apiReference
            }
            .padding(Moin.Constants.Spacing.xl)
        }
        .measureRenderTime("ConfigProvider")
    }

    // MARK: - Introduction

    private var introduction: some View {
        VStack(alignment: .leading, spacing: Moin.Constants.Spacing.md) {
            Text(localization.tr("config.title"))
                .font(.largeTitle)
                .fontWeight(.bold)

            Text(localization.tr("config.description"))
                .font(.body)
                .foregroundStyle(.secondary)
        }
    }

    // MARK: - Examples

    private var basicUsage: some View {
        ExampleSection(
            title: localization.tr("config.basic"),
            description: localization.tr("config.basic_desc")
        ) {
            Text(localization.tr("config.basic_demo"))
                .foregroundStyle(.secondary)
        } code: {
            """
            @main
            struct MyApp: App {
                @StateObject private var configProvider = Moin.ConfigProvider.shared

                var body: some Scene {
                    WindowGroup {
                        ContentView()
                            .environmentObject(configProvider)
                            .environmentObject(configProvider.localization)
                    }
                }
            }
            """
        }
    }

    private var localeConfig: some View {
        ExampleSection(
            title: localization.tr("config.locale"),
            description: localization.tr("config.locale_desc")
        ) {
            HStack(spacing: Moin.Constants.Spacing.md) {
                Moin.Button(localization.tr("config.switch_zh"), color: .primary) {
                    localization.locale = .zhCN
                }
                Moin.Button(localization.tr("config.switch_en")) {
                    localization.locale = .enUS
                }
            }
        } code: {
            """
            // \(localization.tr("code_comment.switch_locale"))
            localization.locale = .zhCN  // \(localization.tr("code_comment.chinese"))
            localization.locale = .enUS  // \(localization.tr("code_comment.english"))

            // \(localization.tr("code_comment.use_in_swiftui"))
            Picker("", selection: $localization.locale) {
                Text("\(localization.tr("locale.zh"))").tag(Moin.Locale.zhCN)
                Text("\(localization.tr("locale.en"))").tag(Moin.Locale.enUS)
            }
            """
        }
    }

    private var themeConfig: some View {
        ExampleSection(
            title: localization.tr("config.theme"),
            description: localization.tr("config.theme_desc")
        ) {
            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.md) {
                // Color picker buttons
                HStack(spacing: Moin.Constants.Spacing.sm) {
                    Text(localization.tr("config.primary_color"))
                        .font(.caption)
                        .foregroundStyle(.secondary)

                    ForEach(themeColors, id: \.name) { item in
                        Button {
                            configProvider.primaryColor = item.color
                        } label: {
                            Circle()
                                .fill(item.color)
                                .frame(width: 24, height: 24)
                                .overlay(
                                    Circle()
                                        .stroke(configProvider.token.colorPrimary == item.color ? Color.primary : Color.clear, lineWidth: 2)
                                )
                        }
                        .buttonStyle(.plain)
                    }
                }

                // Preview buttons
                HStack(spacing: Moin.Constants.Spacing.md) {
                    Moin.Button(localization.tr("button.label.primary"), color: .primary) {}
                    Moin.Button(localization.tr("button.label.default")) {}
                    Moin.Button(localization.tr("button.label.primary"), color: .primary, variant: .outlined) {}
                }
            }
        } code: {
            """
            let config = Moin.ConfigProvider.shared

            // \(localization.tr("code_comment.configure_theme_colors"))
            config.primaryColor = .blue
            config.primaryColor = .purple
            config.primaryColor = .orange

            // \(localization.tr("code_comment.or_configure_via_token"))
            config.token.colorPrimary = .indigo
            config.token.colorSuccess = .green
            config.token.colorDanger = .red
            """
        }
    }

    private var tokenConfig: some View {
        ExampleSection(
            title: localization.tr("config.token"),
            description: localization.tr("config.token_desc")
        ) {
            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.md) {
                // Border radius slider
                HStack(spacing: Moin.Constants.Spacing.sm) {
                    Text(localization.tr("config.border_radius"))
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .frame(width: 80, alignment: .leading)

                    Slider(value: Binding(
                        get: { configProvider.token.borderRadius },
                        set: { configProvider.token.borderRadius = $0 }
                    ), in: 0...20, step: 2)
                    .frame(width: 150)

                    Text("\(Int(configProvider.token.borderRadius))px")
                        .font(.caption)
                        .monospacedDigit()
                        .frame(width: 40)
                }

                // Control height slider
                HStack(spacing: Moin.Constants.Spacing.sm) {
                    Text(localization.tr("config.control_height"))
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .frame(width: 80, alignment: .leading)

                    Slider(value: Binding(
                        get: { configProvider.token.controlHeight },
                        set: { configProvider.token.controlHeight = $0 }
                    ), in: 24...48, step: 4)
                    .frame(width: 150)

                    Text("\(Int(configProvider.token.controlHeight))px")
                        .font(.caption)
                        .monospacedDigit()
                        .frame(width: 40)
                }

                // Preview buttons
                HStack(spacing: Moin.Constants.Spacing.md) {
                    Moin.Button(localization.tr("button.label.primary"), color: .primary) {}
                    Moin.Button(localization.tr("button.label.success"), color: .success) {}
                    Moin.Button(localization.tr("button.label.danger"), color: .danger) {}
                }

                // Reset button
                Moin.Button(localization.tr("config.reset"), variant: .outlined) {
                    configProvider.token = .default
                }
            }
        } code: {
            """
            let config = Moin.ConfigProvider.shared

            // \(localization.tr("code_comment.configure_token"))
            config.token.borderRadius = 8
            config.token.controlHeight = 36
            config.token.fontSize = 14

            // \(localization.tr("code_comment.reset_to_default"))
            config.token = .default
            """
        }
    }

    // MARK: - Theme Colors

    private var themeColors: [(name: String, color: Color)] {
        [
            ("blue", .blue),
            ("purple", .purple),
            ("pink", .pink),
            ("orange", .orange),
            ("green", .green),
            ("indigo", .indigo),
        ]
    }

    // MARK: - API Reference

    private var apiReference: some View {
        VStack(alignment: .leading, spacing: Moin.Constants.Spacing.lg) {
            Text("API")
                .font(.title2)
                .fontWeight(.semibold)

            Text("Moin.Token")
                .font(.headline)

            APITable(
                headers: (
                    localization.tr("api.property"),
                    localization.tr("api.type"),
                    localization.tr("api.default"),
                    localization.tr("api.description")
                ),
                rows: [
                    ("colorPrimary", "Color", ".blue", localization.tr("api.token.colorPrimary")),
                    ("colorSuccess", "Color", ".green", localization.tr("api.token.colorSuccess")),
                    ("colorWarning", "Color", ".orange", localization.tr("api.token.colorWarning")),
                    ("colorDanger", "Color", ".red", localization.tr("api.token.colorDanger")),
                    ("borderRadius", "CGFloat", "6", localization.tr("api.token.borderRadius")),
                    ("controlHeight", "CGFloat", "32", localization.tr("api.token.controlHeight")),
                    ("fontSize", "CGFloat", "14", localization.tr("api.token.fontSize")),
                    ("motionDuration", "Double", "0.2", localization.tr("api.token.motionDuration")),
                ]
            )

            Text("Moin.Locale")
                .font(.headline)
                .padding(.top, Moin.Constants.Spacing.md)

            APITable(
                headers: (
                    localization.tr("api.value"),
                    localization.tr("api.type"),
                    localization.tr("api.default"),
                    localization.tr("api.description")
                ),
                rows: [
                    ("zhCN", "-", "-", localization.tr("api.locale.zhCN")),
                    ("enUS", "-", "-", localization.tr("api.locale.enUS")),
                ]
            )
        }
    }
}
