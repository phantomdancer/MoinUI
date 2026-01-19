import SwiftUI
import AppKit

public extension Moin.Typography {
    /// Link component for clickable text
    struct Link: View {
        @Environment(\.moinToken) private var token

        private let content: String
        private let disabled: Bool
        private let href: URL?
        private let action: (() -> Void)?

        @State private var isHovered = false

        /// Initialize with action callback
        public init(
            _ content: String,
            disabled: Bool = false,
            action: @escaping () -> Void
        ) {
            self.content = content
            self.disabled = disabled
            self.href = nil
            self.action = action
        }

        /// Initialize with href URL
        public init(
            _ content: String,
            href: URL?,
            disabled: Bool = false
        ) {
            self.content = content
            self.disabled = disabled
            self.href = href
            self.action = nil
        }

        public var body: some View {
            SwiftUI.Text(content)
                .font(.system(size: token.fontSize))
                .foregroundStyle(linkColor)
                .underline(isHovered && !disabled)
                .lineSpacing(max(0, token.lineHeight - token.fontSize))
                .padding(.vertical, max(0, (token.lineHeight - token.fontSize) / 2))
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
                    guard !disabled else { return }
                    if let href = href {
                        NSWorkspace.shared.open(href)
                    } else {
                        action?()
                    }
                }
        }

        private var linkColor: Color {
            if disabled { return token.colorTextDisabled }
            if isHovered { return token.colorLinkHover }
            return token.colorLink
        }
    }
}
