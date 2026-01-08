import SwiftUI
import MoinUI

/// Quick Start Page
struct QuickStartView: View {
    @EnvironmentObject var localization: MoinUILocalization
    @ObservedObject private var config = MoinUIConfigProvider.shared

    private var token: MoinUIToken { config.token }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Constants.Spacing.xl) {
                // Title
                Text(localization.tr("nav.quick_start"))
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(token.colorText)

                Text(localization.tr("quick_start.desc"))
                    .font(.body)
                    .foregroundStyle(token.colorTextSecondary)

                // Installation
                VStack(alignment: .leading, spacing: Constants.Spacing.md) {
                    Text(localization.tr("quick_start.installation"))
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundStyle(token.colorText)

                    CodeBlock(
                        title: "Package.swift",
                        code: """
                        dependencies: [
                            .package(url: "https://github.com/phantomdancer/moin-ui.git", from: "\(MoinUI.version)")
                        ]
                        """
                    )
                }

                // Basic Usage
                VStack(alignment: .leading, spacing: Constants.Spacing.md) {
                    Text(localization.tr("quick_start.basic_usage"))
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundStyle(token.colorText)

                    CodeBlock(
                        title: "ContentView.swift",
                        code: """
                        import SwiftUI
                        import MoinUI

                        struct ContentView: View {
                            var body: some View {
                                MoinUIButton("\(localization.tr("quick_start.click_me"))", color: .primary) {
                                    print("\(localization.tr("quick_start.hello_moinui"))")
                                }
                            }
                        }
                        """
                    )
                }

                // Theme Config
                VStack(alignment: .leading, spacing: Constants.Spacing.md) {
                    Text(localization.tr("quick_start.theme_config"))
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundStyle(token.colorText)

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
                                        .moinUITheme(.dark)  // \(localization.tr("code_comment.or_light_system"))
                                }
                            }
                        }
                        """
                    )
                }

                Spacer(minLength: 40)
            }
            .padding(Constants.Spacing.xl)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(maxWidth: .infinity)
        .background(token.colorBgContainer)
    }
}

private struct CodeBlock: View {
    let title: String
    let code: String
    @EnvironmentObject private var localization: MoinUILocalization
    @State private var isCopied = false
    @ObservedObject private var config = MoinUIConfigProvider.shared

    private var token: MoinUIToken { config.token }

    var body: some View {
        VStack(alignment: .leading, spacing: Constants.Spacing.sm) {
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
                        Text(isCopied ? localization.tr("code.copied") : localization.tr("code.copy"))
                    }
                    .font(.caption)
                    .foregroundStyle(isCopied ? .green : token.colorTextSecondary)
                }
                .buttonStyle(.plain)
            }

            HighlightedCodeView(code: code)
                .padding(Constants.Spacing.lg)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(config.isDarkMode ? Color(white: 0.08) : Color(white: 0.96))
                .clipShape(RoundedRectangle(cornerRadius: 8))
        }
    }
}
