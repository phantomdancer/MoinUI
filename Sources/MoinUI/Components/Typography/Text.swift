import SwiftUI

public extension Moin.Typography {
    /// Text component for inline text
    struct Text: View {
        @Environment(\.moinToken) private var token

        private let content: String
        private let type: TextType
        private let disabled: Bool
        private let mark: Bool
        private let underline: Bool
        private let delete: Bool
        private let strong: Bool
        private let italic: Bool
        private let code: Bool
        private let keyboard: Bool

        public init(
            _ content: String,
            type: TextType = .default,
            disabled: Bool = false,
            mark: Bool = false,
            underline: Bool = false,
            delete: Bool = false,
            strong: Bool = false,
            italic: Bool = false,
            code: Bool = false,
            keyboard: Bool = false
        ) {
            self.content = content
            self.type = type
            self.disabled = disabled
            self.mark = mark
            self.underline = underline
            self.delete = delete
            self.strong = strong
            self.italic = italic
            self.code = code
            self.keyboard = keyboard
        }

        public var body: some View {
            styledText
                .font(textFont)
                .foregroundStyle(textColor)
        }

        @ViewBuilder
        private var styledText: some View {
            if keyboard {
                keyboardStyle
            } else if code {
                codeStyle
            } else {
                normalStyle
            }
        }

        private var normalStyle: some View {
            var text = SwiftUI.Text(content)
            if underline { text = text.underline() }
            if delete { text = text.strikethrough() }
            if italic { text = text.italic() }
            return text
                .background(mark ? Moin.Typography.colorMarkBg : Color.clear)
                .transformEffect(italic ? CGAffineTransform(a: 1, b: 0, c: -0.2, d: 1, tx: 0, ty: 0) : .identity)
        }

        private var codeStyle: some View {
            SwiftUI.Text(content)
                .font(.system(size: token.fontSize * 0.9, design: .monospaced))
                .padding(.horizontal, token.paddingXXS)
                .background(token.colorFillTertiary)
                .clipShape(RoundedRectangle(cornerRadius: token.borderRadiusXS))
        }

        private var keyboardStyle: some View {
            SwiftUI.Text(content)
                .font(.system(size: token.fontSizeSM, design: .monospaced))
                .padding(.horizontal, token.paddingXS)
                .padding(.vertical, token.paddingXXS)
                .background(token.colorFillSecondary)
                .clipShape(RoundedRectangle(cornerRadius: token.borderRadiusSM))
                .overlay(
                    RoundedRectangle(cornerRadius: token.borderRadiusSM)
                        .stroke(token.colorBorder, lineWidth: token.lineWidth)
                )
        }

        private var textFont: Font {
            .system(
                size: token.fontSize,
                weight: strong ? .semibold : .regular
            )
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
