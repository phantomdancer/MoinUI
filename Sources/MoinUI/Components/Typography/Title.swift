import SwiftUI

public extension Moin.Typography {
    /// Title component for headings (h1-h5)
    struct Title: View {
        @Environment(\.moinToken) private var token

        private let content: String
        private let level: TitleLevel
        private let type: TextType
        private let disabled: Bool
        private let mark: Bool
        private let underline: Bool
        private let delete: Bool
        private let code: Bool

        public init(
            _ content: String,
            level: TitleLevel = .h1,
            type: TextType = .default,
            disabled: Bool = false,
            mark: Bool = false,
            underline: Bool = false,
            delete: Bool = false,
            code: Bool = false
        ) {
            self.content = content
            self.level = level
            self.type = type
            self.disabled = disabled
            self.mark = mark
            self.underline = underline
            self.delete = delete
            self.code = code
        }

        public var body: some View {
            styledText
                .font(.system(size: fontSize, weight: .semibold))
                .foregroundStyle(textColor)
                .lineSpacing((lineHeight - fontSize) / 2)
        }

        private var styledText: some View {
            var text = SwiftUI.Text(content)

            if code {
                text = SwiftUI.Text(content).font(.system(size: fontSize * 0.9, design: .monospaced))
            }
            if underline { text = text.underline() }
            if delete { text = text.strikethrough() }

            return text
                .background(mark ? Moin.Typography.colorMarkBg : Color.clear)
        }

        private var fontSize: CGFloat {
            switch level {
            case .h1: return token.fontSizeHeading1
            case .h2: return token.fontSizeHeading2
            case .h3: return token.fontSizeHeading3
            case .h4: return token.fontSizeHeading4
            case .h5: return token.fontSizeHeading5
            }
        }

        private var lineHeight: CGFloat {
            switch level {
            case .h1: return token.lineHeightHeading1
            case .h2: return token.lineHeightHeading2
            case .h3: return token.lineHeightHeading3
            case .h4: return token.lineHeightHeading4
            case .h5: return token.lineHeightHeading5
            }
        }

        private var textColor: Color {
            if disabled { return token.colorTextDisabled }
            switch type {
            case .default: return token.colorText
            case .secondary: return token.colorTextSecondary
            case .success: return token.colorSuccess
            case .warning: return token.colorWarning
            case .danger: return token.colorDanger
            }
        }
    }
}
