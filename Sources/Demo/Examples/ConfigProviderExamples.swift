import SwiftUI
import MoinUI

/// ConfigProvider usage examples
struct ConfigProviderExamples: View {
    @EnvironmentObject var localization: MoinUILocalization
    @EnvironmentObject var configProvider: MoinUIConfigProvider

    var body: some View {
        GeometryReader { geo in
            let isWide = geo.size.width > ResponsiveBreakpoint.small

            ScrollView {
                VStack(alignment: .leading, spacing: Constants.Spacing.xl) {
                    introduction

                    Divider()

                    // 响应式示例区域
                    if isWide {
                        LazyVGrid(
                            columns: [
                                GridItem(.flexible(), spacing: Constants.Spacing.xl),
                                GridItem(.flexible(), spacing: Constants.Spacing.xl)
                            ],
                            alignment: .leading,
                            spacing: Constants.Spacing.xl
                        ) {
                            basicUsage
                            localeConfig
                            themeConfig
                            tokenConfig
                        }
                    } else {
                        VStack(alignment: .leading, spacing: Constants.Spacing.xl) {
                            basicUsage
                            localeConfig
                            themeConfig
                            tokenConfig
                        }
                    }

                    Divider()

                    apiReference
                }
                .padding(Constants.Spacing.xl)
            }
        }
    }

    // MARK: - Introduction

    private var introduction: some View {
        VStack(alignment: .leading, spacing: Constants.Spacing.md) {
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
            description: localization.tr("config.basic_desc"),
            showCodeText: localization.tr("code.show"),
            hideCodeText: localization.tr("code.hide")
        ) {
            Text(localization.tr("config.basic_demo"))
                .foregroundStyle(.secondary)
        } code: {
            """
            @main
            struct MyApp: App {
                @StateObject private var configProvider = MoinUIConfigProvider.shared

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
            description: localization.tr("config.locale_desc"),
            showCodeText: localization.tr("code.show"),
            hideCodeText: localization.tr("code.hide")
        ) {
            HStack(spacing: Constants.Spacing.md) {
                MoinUIButton(localization.tr("config.switch_zh"), type: .primary) {
                    localization.locale = .zhCN
                }
                MoinUIButton(localization.tr("config.switch_en")) {
                    localization.locale = .enUS
                }
            }
        } code: {
            """
            // Switch locale
            localization.locale = .zhCN  // Chinese
            localization.locale = .enUS  // English

            // Use in SwiftUI
            Picker("", selection: $localization.locale) {
                Text("中文").tag(MoinUILocale.zhCN)
                Text("EN").tag(MoinUILocale.enUS)
            }
            """
        }
    }

    private var themeConfig: some View {
        ExampleSection(
            title: localization.tr("config.theme"),
            description: localization.tr("config.theme_desc"),
            showCodeText: localization.tr("code.show"),
            hideCodeText: localization.tr("code.hide")
        ) {
            VStack(alignment: .leading, spacing: Constants.Spacing.md) {
                // Color picker buttons
                HStack(spacing: Constants.Spacing.sm) {
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
                HStack(spacing: Constants.Spacing.md) {
                    MoinUIButton(localization.tr("button.label.primary"), type: .primary) {}
                    MoinUIButton(localization.tr("button.label.default")) {}
                    MoinUIButton(localization.tr("button.label.primary"), type: .primary, variant: .outline) {}
                }
            }
        } code: {
            """
            let config = MoinUIConfigProvider.shared

            // Configure theme colors
            config.primaryColor = .blue
            config.primaryColor = .purple
            config.primaryColor = .orange

            // Or configure via token
            config.token.colorPrimary = .indigo
            config.token.colorSuccess = .green
            config.token.colorDanger = .red
            """
        }
    }

    private var tokenConfig: some View {
        ExampleSection(
            title: localization.tr("config.token"),
            description: localization.tr("config.token_desc"),
            showCodeText: localization.tr("code.show"),
            hideCodeText: localization.tr("code.hide")
        ) {
            VStack(alignment: .leading, spacing: Constants.Spacing.md) {
                // Border radius slider
                HStack(spacing: Constants.Spacing.sm) {
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
                HStack(spacing: Constants.Spacing.sm) {
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
                HStack(spacing: Constants.Spacing.md) {
                    MoinUIButton(localization.tr("button.label.primary"), type: .primary) {}
                    MoinUIButton(localization.tr("button.label.success"), type: .success) {}
                    MoinUIButton(localization.tr("button.label.danger"), type: .danger) {}
                }

                // Reset button
                MoinUIButton(localization.tr("config.reset"), variant: .outline) {
                    configProvider.token = .default
                }
            }
        } code: {
            """
            let config = MoinUIConfigProvider.shared

            // Configure token
            config.token.borderRadius = 8
            config.token.controlHeight = 36
            config.token.fontSize = 14

            // Reset to default
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
        VStack(alignment: .leading, spacing: Constants.Spacing.lg) {
            Text("API")
                .font(.title2)
                .fontWeight(.semibold)

            Text("MoinUIToken")
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

            Text("MoinUILocale")
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
                    ("zhCN", "-", "-", localization.tr("api.locale.zhCN")),
                    ("enUS", "-", "-", localization.tr("api.locale.enUS")),
                ]
            )
        }
    }
}
