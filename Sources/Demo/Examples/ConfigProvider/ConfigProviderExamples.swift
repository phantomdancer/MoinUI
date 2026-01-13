import SwiftUI
import MoinUI

/// ConfigProvider usage examples
struct ConfigProviderExamples: View {
    @Localized var tr
    @EnvironmentObject var configProvider: Moin.ConfigProvider

    /// 锚点列表
    private let anchors: [AnchorItem] = [
        AnchorItem(id: "basic", titleKey: "config.basic"),
        AnchorItem(id: "locale", titleKey: "config.locale"),
        AnchorItem(id: "theme", titleKey: "config.theme"),
        AnchorItem(id: "token", titleKey: "config.token"),
        AnchorItem(id: "api", titleKey: "config.anchor.api"),
    ]

    var body: some View {
        ExamplePageWithAnchor(pageName: "ConfigProvider", anchors: anchors) { _ in
            introduction

            Divider()

            basicUsage.id("basic")
            localeConfig.id("locale")
            themeConfig.id("theme")
            tokenConfig.id("token")

            Divider()

            apiReference.id("api")
        }
    }

    // MARK: - Introduction

    private var introduction: some View {
        VStack(alignment: .leading, spacing: Moin.Constants.Spacing.md) {
            Text(tr("config.title"))
                .font(.largeTitle)
                .fontWeight(.bold)

            Text(tr("config.description"))
                .font(.body)
                .foregroundStyle(.secondary)
        }
    }

    // MARK: - Examples

    private var basicUsage: some View {
        ExampleSection(
            title: tr("config.basic"),
            description: tr("config.basic_desc")
        ) {
            Text(tr("config.basic_demo"))
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
            title: tr("config.locale"),
            description: tr("config.locale_desc")
        ) {
            HStack(spacing: Moin.Constants.Spacing.md) {
                Moin.Button(tr("config.switch_zh"), color: .primary) {
                    configProvider.locale = .zhCN
                }
                Moin.Button(tr("config.switch_en")) {
                    configProvider.locale = .enUS
                }
            }
        } code: {
            """
            // \(tr("code_comment.switch_locale"))
            configProvider.locale = .zhCN  // \(tr("code_comment.chinese"))
            configProvider.locale = .enUS  // \(tr("code_comment.english"))

            // \(tr("code_comment.use_in_swiftui"))
            Picker("", selection: $configProvider.locale) {
                Text("\(tr("locale.zh"))").tag(Moin.Locale.zhCN)
                Text("\(tr("locale.en"))").tag(Moin.Locale.enUS)
            }
            """
        }
    }

    private var themeConfig: some View {
        ExampleSection(
            title: tr("config.theme"),
            description: tr("config.theme_desc")
        ) {
            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.md) {
                // Color picker buttons
                HStack(spacing: Moin.Constants.Spacing.sm) {
                    Text(tr("config.primary_color"))
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
                    Moin.Button(tr("button.label.primary"), color: .primary) {}
                    Moin.Button(tr("button.label.default")) {}
                    Moin.Button(tr("button.label.primary"), color: .primary, variant: .outlined) {}
                }
            }
        } code: {
            """
            let config = Moin.ConfigProvider.shared

            // \(tr("code_comment.configure_theme_colors"))
            config.primaryColor = .blue
            config.primaryColor = .purple
            config.primaryColor = .orange

            // \(tr("code_comment.or_configure_via_token"))
            config.token.colorPrimary = .indigo
            config.token.colorSuccess = .green
            config.token.colorDanger = .red
            """
        }
    }

    private var tokenConfig: some View {
        ExampleSection(
            title: tr("config.token"),
            description: tr("config.token_desc")
        ) {
            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.md) {
                // Border radius slider
                HStack(spacing: Moin.Constants.Spacing.sm) {
                    Text(tr("config.border_radius"))
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .frame(width: 80, alignment: .leading)

                    Slider(value: Binding(
                        get: { configProvider.seed.borderRadius },
                        set: { configProvider.setBorderRadius($0) }
                    ), in: 0...20, step: 2)
                    .frame(width: 150)

                    Text("\(Int(configProvider.token.borderRadius))px")
                        .font(.caption)
                        .monospacedDigit()
                        .frame(width: 40)
                }

                // Control height slider
                HStack(spacing: Moin.Constants.Spacing.sm) {
                    Text(tr("config.control_height"))
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
                    Moin.Button(tr("button.label.primary"), color: .primary) {}
                    Moin.Button(tr("button.label.success"), color: .success) {}
                    Moin.Button(tr("button.label.danger"), color: .danger) {}
                }

                // Reset button
                Moin.Button(tr("config.reset"), variant: .outlined) {
                    configProvider.token = .default
                }
            }
        } code: {
            """
            let config = Moin.ConfigProvider.shared

            // \(tr("code_comment.configure_token"))
            config.token.borderRadius = 8
            config.token.controlHeight = 36
            config.token.fontSize = 14

            // \(tr("code_comment.reset_to_default"))
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
                    tr("api.property"),
                    tr("api.type"),
                    tr("api.default"),
                    tr("api.description")
                ),
                rows: [
                    ("colorPrimary", "Color", ".blue", tr("api.token.colorPrimary")),
                    ("colorSuccess", "Color", ".green", tr("api.token.colorSuccess")),
                    ("colorWarning", "Color", ".orange", tr("api.token.colorWarning")),
                    ("colorDanger", "Color", ".red", tr("api.token.colorDanger")),
                    ("borderRadius", "CGFloat", "6", tr("api.token.borderRadius")),
                    ("controlHeight", "CGFloat", "32", tr("api.token.controlHeight")),
                    ("fontSize", "CGFloat", "14", tr("api.token.fontSize")),
                    ("motionDuration", "Double", "0.2", tr("api.token.motionDuration")),
                ]
            )

            Text("Moin.Locale")
                .font(.headline)
                .padding(.top, Moin.Constants.Spacing.md)

            APITable(
                headers: (
                    tr("api.value"),
                    tr("api.type"),
                    tr("api.default"),
                    tr("api.description")
                ),
                rows: [
                    ("zhCN", "-", "-", tr("api.locale.zhCN")),
                    ("enUS", "-", "-", tr("api.locale.enUS")),
                ]
            )
        }
    }
}
