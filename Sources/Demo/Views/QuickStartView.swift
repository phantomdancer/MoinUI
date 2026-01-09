import SwiftUI
import MoinUI

/// Quick Start Page
struct QuickStartView: View {
    @Localized var tr
    @ObservedObject private var config = Moin.ConfigProvider.shared

    private var token: Moin.Token { config.token }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.xl) {
                // Title
                Text(tr("nav.quick_start"))
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(token.colorText)

                Text(tr("quick_start.desc"))
                    .font(.body)
                    .foregroundStyle(token.colorTextSecondary)

                // Installation
                VStack(alignment: .leading, spacing: Moin.Constants.Spacing.md) {
                    Text(tr("quick_start.installation"))
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundStyle(token.colorText)

                    CodeBlock(
                        title: "Package.swift",
                        code: """
                        dependencies: [
                            .package(url: "https://github.com/phantomdancer/MoinUI.git", from: "\(Moin.version)")
                        ]
                        """
                    )
                }

                // Basic Usage
                VStack(alignment: .leading, spacing: Moin.Constants.Spacing.md) {
                    Text(tr("quick_start.basic_usage"))
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
                                Moin.Button("\(tr("quick_start.click_me"))", color: .primary) {
                                    print("\(tr("quick_start.hello_moinui"))")
                                }
                            }
                        }
                        """
                    )
                }

                // Theme Config
                VStack(alignment: .leading, spacing: Moin.Constants.Spacing.md) {
                    Text(tr("quick_start.theme_config"))
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
                                        .moinTheme(.dark)  // \(tr("code_comment.or_light_system"))
                                }
                            }
                        }
                        """
                    )
                }

                Spacer(minLength: 40)
            }
            .padding(Moin.Constants.Spacing.xl)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(maxWidth: .infinity)
        .background(token.colorBgContainer)
        .measureRenderTime("QuickStart")
    }
}

private struct CodeBlock: View {
    let title: String
    let code: String
    @Localized var tr
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
                        Text(isCopied ? tr("code.copied") : tr("code.copy"))
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
