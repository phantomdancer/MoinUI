import SwiftUI
import AppKit

public extension Moin {
    struct Alert: View {
        @Environment(\.moinToken) private var token
        @Environment(\.moinTheme) private var theme
        
        public enum AlertType {
            case success, info, warning, error
        }
        
        let type: AlertType
        let title: String
        let description: String?
        let showIcon: Bool
        let closable: Bool
        let banner: Bool
        let onClose: (() -> Void)?
        
        @State private var isVisible = true
        @State private var isCloseHovered = false
        
        public init(
            type: AlertType = .info,
            title: String,
            description: String? = nil,
            showIcon: Bool = false,
            closable: Bool = false,
            banner: Bool = false,
            onClose: (() -> Void)? = nil
        ) {
            self.type = type
            self.title = title
            self.description = description
            self.showIcon = showIcon
            self.closable = closable
            self.banner = banner
            self.onClose = onClose
        }
        
        public var body: some View {
            if isVisible {
                let alertToken = AlertToken.generate(from: token)
                let colors = colorsForType(alertToken)
                
                HStack(alignment: .top, spacing: alertToken.gap) {
                    if showIcon {
                        iconForType
                            .font(.system(size: alertToken.iconSize))
                            .foregroundStyle(colors.icon)
                    }
                    
                    VStack(alignment: .leading, spacing: alertToken.titleGap) {
                        Text(title)
                            .font(.system(size: alertToken.titleFontSize))
                            .fontWeight(.medium)
                        
                        if let description = description {
                            Text(description)
                                .font(.system(size: alertToken.fontSize))
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    if closable {
                        Image(systemName: "xmark")
                            .font(.system(size: 12))
                            .foregroundStyle(isCloseHovered ? Color.secondary : Color.secondary.opacity(0.6))
                            .contentShape(Rectangle())
                            .onHover { hovering in
                                isCloseHovered = hovering
                                if hovering {
                                    NSCursor.pointingHand.push()
                                } else {
                                    NSCursor.pop()
                                }
                            }
                            .onTapGesture {
                                handleClose()
                            }
                    }
                }
                .padding(alertToken.padding)
                .background(colors.bg)
                .overlay(
                    RoundedRectangle(cornerRadius: banner ? 0 : alertToken.cornerRadius)
                        .stroke(colors.border, lineWidth: banner ? 0 : alertToken.borderWidth)
                )
                .cornerRadius(banner ? 0 : alertToken.cornerRadius)
            }
        }
        
        private var iconForType: Image {
            switch type {
            case .success: return Image(systemName: "checkmark.circle.fill")
            case .info: return Image(systemName: "info.circle.fill")
            case .warning: return Image(systemName: "exclamationmark.triangle.fill")
            case .error: return Image(systemName: "xmark.octagon.fill")
            }
        }
        
        private func colorsForType(_ alertToken: AlertToken) -> (bg: Color, border: Color, icon: Color) {
            switch type {
            case .success: return (alertToken.successBg, alertToken.successBorder, alertToken.successIcon)
            case .info: return (alertToken.infoBg, alertToken.infoBorder, alertToken.infoIcon)
            case .warning: return (alertToken.warningBg, alertToken.warningBorder, alertToken.warningIcon)
            case .error: return (alertToken.errorBg, alertToken.errorBorder, alertToken.errorIcon)
            }
        }
        
        private func handleClose() {
            withAnimation {
                isVisible = false
            }
            onClose?()
        }
    }
}
