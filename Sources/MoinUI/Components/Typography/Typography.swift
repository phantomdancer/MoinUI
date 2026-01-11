import SwiftUI
import AppKit

/// Mark 背景色 - 使用 Ant Design 的 yellow-3 色值
private let colorMarkBg = Color(hex: 0xFFE58F)

public extension Moin {
    /// Title component for headings (h1-h5)
    struct Title: View {
        @Environment(\.moinToken) private var token

        private let content: String
        private let level: TitleLevel
        private let type: TypographyType
        private let disabled: Bool
        private let mark: Bool
        private let underline: Bool
        private let delete: Bool
        private let code: Bool

        public init(
            _ content: String,
            level: TitleLevel = .h1,
            type: TypographyType = .default,
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
            var text = Text(content)

            if code {
                text = Text(content).font(.system(size: fontSize * 0.9, design: .monospaced))
            }
            if underline { text = text.underline() }
            if delete { text = text.strikethrough() }

            return text
                .background(mark ? colorMarkBg : Color.clear)
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

public extension Moin {
    /// Text component for inline text
    struct Typography: View {
        @Environment(\.moinToken) private var token

        private let content: String
        private let type: TypographyType
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
            type: TypographyType = .default,
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
            var text = Text(content)
            if underline { text = text.underline() }
            if delete { text = text.strikethrough() }
            if italic { text = text.italic() }
            return text
                .background(mark ? colorMarkBg : Color.clear)
                .transformEffect(italic ? CGAffineTransform(a: 1, b: 0, c: -0.2, d: 1, tx: 0, ty: 0) : .identity)
        }

        private var codeStyle: some View {
            Text(content)
                .font(.system(size: token.fontSize * 0.9, design: .monospaced))
                .padding(.horizontal, token.paddingXXS)
                .background(token.colorFillTertiary)
                .clipShape(RoundedRectangle(cornerRadius: token.borderRadiusXS))
        }

        private var keyboardStyle: some View {
            Text(content)
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

public extension Moin {
    /// Paragraph component for block-level text
    struct Paragraph: View {
        @Environment(\.moinToken) private var token

        private let content: String
        private let type: TypographyType
        private let disabled: Bool
        private let mark: Bool
        private let underline: Bool
        private let delete: Bool
        private let strong: Bool
        private let italic: Bool

        public init(
            _ content: String,
            type: TypographyType = .default,
            disabled: Bool = false,
            mark: Bool = false,
            underline: Bool = false,
            delete: Bool = false,
            strong: Bool = false,
            italic: Bool = false
        ) {
            self.content = content
            self.type = type
            self.disabled = disabled
            self.mark = mark
            self.underline = underline
            self.delete = delete
            self.strong = strong
            self.italic = italic
        }

        public var body: some View {
            styledText
                .font(textFont)
                .foregroundStyle(textColor)
                .lineSpacing((token.lineHeight - token.fontSize) / 2)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, token.marginXS)
        }

        private var styledText: some View {
            var text = Text(content)
            if underline { text = text.underline() }
            if delete { text = text.strikethrough() }
            if italic { text = text.italic() }
            return text
                .background(mark ? colorMarkBg : Color.clear)
                .transformEffect(italic ? CGAffineTransform(a: 1, b: 0, c: -0.2, d: 1, tx: 0, ty: 0) : .identity)
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

public extension Moin {
    /// Link component for clickable text
    struct Link: View {
        @Environment(\.moinToken) private var token

        private let content: String
        private let disabled: Bool
        private let action: () -> Void

        @State private var isHovered = false

        public init(
            _ content: String,
            disabled: Bool = false,
            action: @escaping () -> Void
        ) {
            self.content = content
            self.disabled = disabled
            self.action = action
        }

        public var body: some View {
            Text(content)
                .font(.system(size: token.fontSize))
                .foregroundStyle(linkColor)
                .underline(isHovered && !disabled)
                .textSelection(.disabled)
                .onHover { hovering in
                    isHovered = hovering
                    if !disabled {
                        if hovering {
                            NSCursor.pointingHand.push()
                        } else {
                            NSCursor.pop()
                        }
                    }
                }
                .onTapGesture {
                    if !disabled { action() }
                }
        }

        private var linkColor: Color {
            if disabled { return token.colorTextDisabled }
            if isHovered { return token.colorLinkHover }
            return token.colorLink
        }
    }
}
