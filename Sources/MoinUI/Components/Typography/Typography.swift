import SwiftUI

/// Mark 背景色 - 使用 Ant Design 的 yellow-3 色值
private let colorMarkBg = Color(hex: 0xFFE58F)

// MARK: - Ellipsis Configuration

public extension Moin.Typography {
    /// 省略号配置
    struct EllipsisConfig {
        /// 最大行数
        public let rows: Int
        /// 是否可展开/收起
        public let expandable: Bool
        /// 是否显示展开/收起切换
        public let collapsible: Bool
        /// 展开按钮文案
        public let expandSymbol: String
        /// 收起按钮文案
        public let collapseSymbol: String
        /// 悬停时显示完整内容的 tooltip
        public let tooltip: Bool
        /// 默认是否展开
        public let defaultExpanded: Bool
        /// 展开/收起回调
        public let onExpand: ((Bool) -> Void)?

        public init(
            rows: Int = 1,
            expandable: Bool = false,
            collapsible: Bool = false,
            expandSymbol: String = "展开",
            collapseSymbol: String = "收起",
            tooltip: Bool = false,
            defaultExpanded: Bool = false,
            onExpand: ((Bool) -> Void)? = nil
        ) {
            self.rows = rows
            self.expandable = expandable
            self.collapsible = collapsible
            self.expandSymbol = expandSymbol
            self.collapseSymbol = collapseSymbol
            self.tooltip = tooltip
            self.defaultExpanded = defaultExpanded
            self.onExpand = onExpand
        }

        /// 简单行数限制
        public static func rows(_ count: Int) -> EllipsisConfig {
            EllipsisConfig(rows: count)
        }

        /// 可展开配置
        public static func expandable(
            rows: Int = 3,
            collapsible: Bool = true,
            expandSymbol: String = "展开",
            collapseSymbol: String = "收起"
        ) -> EllipsisConfig {
            EllipsisConfig(
                rows: rows,
                expandable: true,
                collapsible: collapsible,
                expandSymbol: expandSymbol,
                collapseSymbol: collapseSymbol
            )
        }
    }
}

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
                .background(mark ? colorMarkBg : Color.clear)
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

public extension Moin.Typography {
    /// Paragraph component for block-level text with ellipsis support
    struct Paragraph: View {
        @Environment(\.moinToken) private var token

        private let content: String
        private let type: TextType
        private let disabled: Bool
        private let mark: Bool
        private let underline: Bool
        private let delete: Bool
        private let strong: Bool
        private let italic: Bool
        private let ellipsis: EllipsisConfig?

        @State private var isExpanded: Bool
        // 双重测量比对法所需状态
        @State private var intrinsicSize: CGSize = .zero
        @State private var truncatedSize: CGSize = .zero
        @State private var moreTextSize: CGSize = .zero

        public init(
            _ content: String,
            type: TextType = .default,
            disabled: Bool = false,
            mark: Bool = false,
            underline: Bool = false,
            delete: Bool = false,
            strong: Bool = false,
            italic: Bool = false,
            ellipsis: EllipsisConfig? = nil
        ) {
            self.content = content
            self.type = type
            self.disabled = disabled
            self.mark = mark
            self.underline = underline
            self.delete = delete
            self.strong = strong
            self.italic = italic
            self.ellipsis = ellipsis
            self._isExpanded = State(initialValue: ellipsis?.defaultExpanded ?? false)
        }

        public var body: some View {
            textContent
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, token.marginXS)
        }

        /// 是否被截断（双重测量比对）
        private var isTruncated: Bool {
            truncatedSize != intrinsicSize
        }

        @ViewBuilder
        private var textContent: some View {
            if let ellipsis {
                if ellipsis.expandable {
                    expandableText(ellipsis)
                } else {
                    simpleEllipsisText(ellipsis)
                }
            } else {
                plainText
            }
        }

        // 简单省略（无展开按钮）
        @ViewBuilder
        private func simpleEllipsisText(_ config: EllipsisConfig) -> some View {
            let text = plainText
                .lineLimit(config.rows)
                .truncationMode(.tail)

            if config.tooltip {
                text.help(content)
            } else {
                text
            }
        }

        // 可展开文本（双重测量比对法）
        @ViewBuilder
        private func expandableText(_ config: EllipsisConfig) -> some View {
            if isExpanded {
                // 展开状态：文本 + 收起链接（拼接在末尾）
                expandedTextView(config)
            } else {
                // 收起状态：截断文本 + 展开链接（overlay 在末尾）
                collapsedTextView(config)
            }
        }

        /// 展开状态视图
        private func expandedTextView(_ config: EllipsisConfig) -> some View {
            (
                SwiftUI.Text(content)
                    .font(textFont)
                    .foregroundColor(textColor)
                + (config.collapsible
                    ? SwiftUI.Text(" \(config.collapseSymbol)")
                        .font(textFont)
                        .foregroundColor(token.colorLink)
                    : SwiftUI.Text(""))
            )
            .lineSpacing((token.lineHeight - token.fontSize) / 2)
            .frame(maxWidth: .infinity, alignment: .leading)
            .contentShape(Rectangle())
            .onTapGesture {
                if config.collapsible {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        isExpanded = false
                    }
                    config.onExpand?(false)
                }
            }
        }

        /// 收起状态视图
        private func collapsedTextView(_ config: EllipsisConfig) -> some View {
            textView
                .lineLimit(config.rows)
                .applyingTruncationMask(size: moreTextSize, enabled: isTruncated)
                .readSize { size in
                    truncatedSize = size
                }
                // 背景层1：测量完整文本尺寸
                .background(
                    textView
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                        .hidden()
                        .readSize { size in
                            intrinsicSize = size
                        }
                )
                // 背景层2：测量按钮尺寸
                .background(
                    SwiftUI.Text(config.expandSymbol)
                        .font(textFont)
                        .hidden()
                        .readSize { moreTextSize = $0 }
                )
                .contentShape(Rectangle())
                .onTapGesture {
                    if isTruncated {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            isExpanded = true
                        }
                        config.onExpand?(true)
                    }
                }
                // 覆盖层：展开链接
                .overlay(alignment: .trailingLastTextBaseline) {
                    if isTruncated {
                        SwiftUI.Text(config.expandSymbol)
                            .font(textFont)
                            .foregroundColor(token.colorLink)
                            .onTapGesture {
                                withAnimation(.easeInOut(duration: 0.2)) {
                                    isExpanded = true
                                }
                                config.onExpand?(true)
                            }
                    }
                }
        }

        /// 文本视图（用于测量）
        private var textView: some View {
            styledText
                .font(textFont)
                .foregroundStyle(textColor)
                .lineSpacing((token.lineHeight - token.fontSize) / 2)
                .frame(maxWidth: .infinity, alignment: .leading)
        }

        private var plainText: some View {
            styledText
                .font(textFont)
                .foregroundStyle(textColor)
                .lineSpacing((token.lineHeight - token.fontSize) / 2)
        }

        private var styledText: some View {
            var text = SwiftUI.Text(content)
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

public extension Moin.Typography {
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
            SwiftUI.Text(content)
                .font(.system(size: token.fontSize))
                .foregroundStyle(linkColor)
                .underline(isHovered && !disabled)
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
