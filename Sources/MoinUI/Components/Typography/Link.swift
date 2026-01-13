import SwiftUI

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
