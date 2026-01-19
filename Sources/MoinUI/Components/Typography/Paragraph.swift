import SwiftUI

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
            .lineSpacing(max(0, token.lineHeight - token.fontSize))
            .padding(.vertical, max(0, (token.lineHeight - token.fontSize) / 2))
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
                .lineSpacing(max(0, token.lineHeight - token.fontSize))
                .padding(.vertical, max(0, (token.lineHeight - token.fontSize) / 2))
                .frame(maxWidth: .infinity, alignment: .leading)
        }

        private var plainText: some View {
            styledText
                .font(textFont)
                .foregroundStyle(textColor)
                .lineSpacing(max(0, token.lineHeight - token.fontSize))
                .padding(.vertical, max(0, (token.lineHeight - token.fontSize) / 2))
        }

        private var styledText: some View {
            var text = SwiftUI.Text(content)
            if underline { text = text.underline() }
            if delete { text = text.strikethrough() }
            if italic { text = text.italic() }
            return text
                .background(mark ? Moin.Typography.colorMarkBg : Color.clear)
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
