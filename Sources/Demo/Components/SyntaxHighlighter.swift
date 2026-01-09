import SwiftUI
import Splash
import MoinUI
import AppKit

/// 使用Splash的代码高亮视图
struct HighlightedCodeView: View {
    let code: String
    var fontSize: CGFloat = 14
    @ObservedObject private var config = Moin.ConfigProvider.shared

    var body: some View {
        Text(highlightedCode)
            .font(.system(size: fontSize, design: .monospaced))
            .textSelection(.enabled)
    }

    private var highlightedCode: AttributedString {
        let theme = config.isDarkMode
            ? SplashTheme.dark(fontSize: fontSize)
            : SplashTheme.light(fontSize: fontSize)
        let highlighter = SyntaxHighlighter(format: AttributedStringOutputFormat(theme: theme))
        let highlighted = highlighter.highlight(code)
        return AttributedString(highlighted)
    }
}

/// Splash主题配置
enum SplashTheme {
    static func dark(fontSize: CGFloat = 14) -> Theme {
        Theme(
            font: Font(size: fontSize),
            plainTextColor: NSColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1),
            tokenColors: [
                .keyword: NSColor(red: 0.99, green: 0.37, blue: 0.53, alpha: 1),
                .string: NSColor(red: 0.98, green: 0.75, blue: 0.47, alpha: 1),
                .type: NSColor(red: 0.58, green: 0.80, blue: 0.98, alpha: 1),
                .call: NSColor(red: 0.69, green: 0.89, blue: 0.62, alpha: 1),
                .number: NSColor(red: 0.82, green: 0.68, blue: 0.97, alpha: 1),
                .comment: NSColor(red: 0.48, green: 0.55, blue: 0.60, alpha: 1),
                .property: NSColor(red: 0.69, green: 0.89, blue: 0.62, alpha: 1),
                .dotAccess: NSColor(red: 0.69, green: 0.89, blue: 0.62, alpha: 1),
                .preprocessing: NSColor(red: 0.99, green: 0.37, blue: 0.53, alpha: 1)
            ],
            backgroundColor: NSColor(red: 0.08, green: 0.08, blue: 0.08, alpha: 1)
        )
    }

    static func light(fontSize: CGFloat = 14) -> Theme {
        Theme(
            font: Font(size: fontSize),
            plainTextColor: NSColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1),
            tokenColors: [
                .keyword: NSColor(red: 0.67, green: 0.05, blue: 0.57, alpha: 1),
                .string: NSColor(red: 0.77, green: 0.10, blue: 0.09, alpha: 1),
                .type: NSColor(red: 0.11, green: 0.36, blue: 0.53, alpha: 1),
                .call: NSColor(red: 0.20, green: 0.47, blue: 0.36, alpha: 1),
                .number: NSColor(red: 0.11, green: 0.00, blue: 0.81, alpha: 1),
                .comment: NSColor(red: 0.42, green: 0.47, blue: 0.51, alpha: 1),
                .property: NSColor(red: 0.20, green: 0.47, blue: 0.36, alpha: 1),
                .dotAccess: NSColor(red: 0.20, green: 0.47, blue: 0.36, alpha: 1),
                .preprocessing: NSColor(red: 0.67, green: 0.05, blue: 0.57, alpha: 1)
            ],
            backgroundColor: NSColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
        )
    }
}
