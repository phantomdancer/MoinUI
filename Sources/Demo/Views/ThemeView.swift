import SwiftUI
import MoinUI

/// Theme Configuration Page
struct ThemeView: View {
    @EnvironmentObject var localization: Moin.Localization
    @ObservedObject private var config = Moin.ConfigProvider.shared

    private var token: Moin.Token { config.token }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.xl) {
                // Title
                VStack(alignment: .leading, spacing: Moin.Constants.Spacing.sm) {
                    Text(localization.tr("theme.title"))
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundStyle(token.colorText)

                    Text(localization.tr("theme.description"))
                        .font(.body)
                        .foregroundStyle(token.colorTextSecondary)
                }

                Divider()

                // Quick Start
                themeRootSection

                Divider()

                // Theme Switch
                themeSwitchSection

                Divider()

                // Token Config
                tokenSection

                Divider()

                // API Reference
                apiSection

                Spacer(minLength: 40)
            }
            .padding(Moin.Constants.Spacing.xl)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(maxWidth: .infinity)
        .background(token.colorBgContainer)
        .measureRenderTime("Theme")
    }

    // MARK: - Theme Root Section

    private var themeRootSection: some View {
        VStack(alignment: .leading, spacing: Moin.Constants.Spacing.lg) {
            Text(localization.tr("theme.root.title"))
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundStyle(token.colorText)

            Text(localization.tr("theme.root.desc"))
                .font(.body)
                .foregroundStyle(token.colorTextSecondary)

            CodeBlock(
                title: "App.swift",
                code: """
                import SwiftUI
                import MoinUI

                @main
                struct MyApp: App {
                    var body: some Scene {
                        WindowGroup {
                            ContentView()
                                .moinThemeRoot()  // \(localization.tr("code_comment.enable_global_theme"))
                        }
                    }
                }
                """
            )

            // Info card
            HStack(alignment: .top, spacing: Moin.Constants.Spacing.md) {
                Image(systemName: "info.circle.fill")
                    .foregroundStyle(token.colorPrimary)

                Text(localization.tr("theme.root.note"))
                    .font(.callout)
                    .foregroundStyle(token.colorTextSecondary)
            }
            .padding(Moin.Constants.Spacing.md)
            .background(token.colorPrimary.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 8))
        }
    }

    // MARK: - Theme Switch Section

    private var themeSwitchSection: some View {
        VStack(alignment: .leading, spacing: Moin.Constants.Spacing.lg) {
            Text(localization.tr("theme.switch.title"))
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundStyle(token.colorText)

            Text(localization.tr("theme.switch.desc"))
                .font(.body)
                .foregroundStyle(token.colorTextSecondary)

            // Demo
            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.md) {
                Text(localization.tr("theme.switch.current"))
                    .font(.subheadline)
                    .foregroundStyle(token.colorTextSecondary)

                HStack(spacing: Moin.Constants.Spacing.md) {
                    ForEach(Moin.Theme.allCases, id: \.self) { theme in
                        Moin.Button(
                            theme.displayName,
                            color: config.theme == theme ? .primary : .default,
                            variant: config.theme == theme ? .solid : .outlined
                        ) {
                            config.applyTheme(theme)
                        }
                    }
                }
            }
            .padding(Moin.Constants.Spacing.lg)
            .background(token.colorBgElevated)
            .clipShape(RoundedRectangle(cornerRadius: 12))

            CodeBlock(
                title: localization.tr("theme.switch.code_title"),
                code: """
                // \(localization.tr("code_comment.method1_set_theme"))
                Moin.ConfigProvider.shared.applyTheme(.dark)
                Moin.ConfigProvider.shared.applyTheme(.light)
                Moin.ConfigProvider.shared.applyTheme(.system)

                // \(localization.tr("code_comment.method2_toggle"))
                Moin.ConfigProvider.shared.toggleTheme()

                // \(localization.tr("code_comment.method3_check"))
                if Moin.ConfigProvider.shared.isDarkMode {
                    // \(localization.tr("code_comment.is_dark_mode"))
                }
                """
            )
        }
    }

    // MARK: - Token Section

    private var tokenSection: some View {
        VStack(alignment: .leading, spacing: Moin.Constants.Spacing.lg) {
            Text(localization.tr("theme.token.title"))
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundStyle(token.colorText)

            Text(localization.tr("theme.token.desc"))
                .font(.body)
                .foregroundStyle(token.colorTextSecondary)

            // Token color preview
            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.md) {
                Text(localization.tr("theme.token.colors"))
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundStyle(token.colorText)

                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], spacing: Moin.Constants.Spacing.md) {
                    TokenColorPreview(name: "colorPrimary", color: token.colorPrimary)
                    TokenColorPreview(name: "colorSuccess", color: token.colorSuccess)
                    TokenColorPreview(name: "colorWarning", color: token.colorWarning)
                    TokenColorPreview(name: "colorDanger", color: token.colorDanger)
                    TokenColorPreview(name: "colorBgContainer", color: token.colorBgContainer)
                    TokenColorPreview(name: "colorText", color: token.colorText)
                }
            }
            .padding(Moin.Constants.Spacing.lg)
            .background(token.colorBgElevated)
            .clipShape(RoundedRectangle(cornerRadius: 12))

            CodeBlock(
                title: localization.tr("theme.token.code_title"),
                code: """
                // \(localization.tr("code_comment.access_token"))
                let token = Moin.ConfigProvider.shared.token

                // \(localization.tr("code_comment.use_token_color"))
                Text("Hello")
                    .foregroundStyle(token.colorText)
                    .background(token.colorBgContainer)

                // \(localization.tr("code_comment.custom_token"))
                var customToken = Moin.Token.light
                customToken.colorPrimary = .purple
                Moin.ConfigProvider.shared.token = customToken
                """
            )
        }
    }

    // MARK: - API Section

    private var apiSection: some View {
        VStack(alignment: .leading, spacing: Moin.Constants.Spacing.lg) {
            Text("API")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundStyle(token.colorText)

            // Moin.Theme
            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.md) {
                Text("Moin.Theme")
                    .font(.headline)
                    .foregroundStyle(token.colorText)

                APITable(
                    headers: (
                        localization.tr("api.value"),
                        localization.tr("api.type"),
                        localization.tr("api.default"),
                        localization.tr("api.description")
                    ),
                    rows: [
                        (".light", "-", "-", localization.tr("theme.api.light")),
                        (".dark", "-", "-", localization.tr("theme.api.dark")),
                        (".system", "-", "-", localization.tr("theme.api.system"))
                    ],
                    columnWidths: (180, 80, 80, 300)
                )
            }

            // ConfigProvider Theme Methods
            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.md) {
                Text("Moin.ConfigProvider")
                    .font(.headline)
                    .foregroundStyle(token.colorText)

                APITable(
                    headers: (
                        localization.tr("api.property"),
                        localization.tr("api.type"),
                        localization.tr("api.default"),
                        localization.tr("api.description")
                    ),
                    rows: [
                        ("applyTheme(_:)", "Method", "-", localization.tr("theme.api.apply")),
                        ("isDarkMode", "Bool", "-", localization.tr("theme.api.is_dark")),
                        ("theme", "Moin.Theme", ".system", localization.tr("theme.api.theme_prop")),
                        ("toggleTheme()", "Method", "-", localization.tr("theme.api.toggle"))
                    ],
                    columnWidths: (180, 120, 80, 260)
                )
            }

            // View Modifier
            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.md) {
                Text("View Modifier")
                    .font(.headline)
                    .foregroundStyle(token.colorText)

                APITable(
                    headers: (
                        localization.tr("api.property"),
                        localization.tr("api.type"),
                        localization.tr("api.default"),
                        localization.tr("api.description")
                    ),
                    rows: [
                        (".moinTheme(_:)", "Modifier", "-", localization.tr("theme.api.theme_modifier")),
                        (".moinThemeRoot()", "Modifier", "-", localization.tr("theme.api.theme_root"))
                    ],
                    columnWidths: (180, 100, 80, 280)
                )
            }
        }
    }
}

// MARK: - Supporting Views

private struct TokenColorPreview: View {
    let name: String
    let color: Color
    @ObservedObject private var config = Moin.ConfigProvider.shared

    private var token: Moin.Token { config.token }

    var body: some View {
        VStack(spacing: Moin.Constants.Spacing.xs) {
            RoundedRectangle(cornerRadius: 8)
                .fill(color)
                .frame(height: 40)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(token.colorBorder, lineWidth: 1)
                )

            Text(name)
                .font(.caption)
                .foregroundStyle(token.colorTextSecondary)
        }
    }
}

private struct CodeBlock: View {
    let title: String
    let code: String
    @State private var isCopied = false
    @ObservedObject private var config = Moin.ConfigProvider.shared

    private var token: Moin.Token { config.token }

    var body: some View {
        VStack(alignment: .leading, spacing: Moin.Constants.Spacing.sm) {
            HStack {
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundStyle(token.colorText)

                Spacer()

                Button(action: {
                    NSPasteboard.general.clearContents()
                    NSPasteboard.general.setString(code, forType: .string)
                    isCopied = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        isCopied = false
                    }
                }) {
                    HStack(spacing: 4) {
                        Image(systemName: isCopied ? "checkmark" : "doc.on.doc")
                        Text(isCopied ? "Copied" : "Copy")
                    }
                    .font(.caption)
                    .foregroundStyle(isCopied ? .green : token.colorTextSecondary)
                }
                .buttonStyle(.plain)
            }

            HighlightedCodeView(code: code, fontSize: 12)
                .padding(Moin.Constants.Spacing.lg)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(config.isDarkMode ? Color(white: 0.08) : Color(white: 0.96))
                .clipShape(RoundedRectangle(cornerRadius: 8))
        }
    }
}
