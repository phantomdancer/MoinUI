import SwiftUI
import AppKit

public extension Moin {
    struct Alert<Action: View>: View {
        @Environment(\.moinToken) private var token
        @Environment(\.moinTheme) private var theme
        @Environment(\.moinAlertToken) private var alertToken
        
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
        let action: Action
        
        @State private var isVisible = true
        @State private var isCloseHovered = false
        
        public init(
            type: AlertType = .info,
            title: String,
            description: String? = nil,
            showIcon: Bool = false,
            closable: Bool = false,
            banner: Bool = false,
            onClose: (() -> Void)? = nil,
            @ViewBuilder action: () -> Action
        ) {
            self.type = type
            self.title = title
            self.description = description
            self.showIcon = showIcon
            self.closable = closable
            self.banner = banner
            self.onClose = onClose
            self.action = action()
        }
        
        public var body: some View {
            if isVisible {
                let colors = colorsForType(alertToken)
                let hasDescription = description != nil
                // Layout selection based on description presence
                let padding = hasDescription ? alertToken.withDescriptionPadding : alertToken.defaultPadding
                let titleSize = hasDescription ? alertToken.titleFontSize : alertToken.fontSize
                let currentIconSize = hasDescription ? alertToken.withDescriptionIconSize : alertToken.iconSize
                
                HStack(alignment: hasDescription ? .top : .center, spacing: alertToken.gap) {
                    if showIcon {
                        iconForType
                            .font(.system(size: currentIconSize))
                            .foregroundStyle(colors.icon)
                            .padding(.top, hasDescription ? 4 : 0) // Optical alignment for top-aligned icon
                    }
                    
                    VStack(alignment: .leading, spacing: alertToken.titleGap) {
                        Text(title)
                            .font(.system(size: titleSize))
                            .fontWeight(hasDescription ? .medium : .regular)
                            .fixedSize(horizontal: false, vertical: true)
                            .frame(minHeight: hasDescription ? 22 : nil, alignment: .leading) // Min height mostly relevant for top alignment
                        
                        if let description = description {
                            Text(description)
                                .font(.system(size: alertToken.fontSize))
                                .fixedSize(horizontal: false, vertical: true)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    action
                        .padding(.top, hasDescription ? 4 : 0) // Align with icon/title top if top-aligned
                    
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
                            .padding(.top, hasDescription ? 4 : 0) // Align with icon/title top if top-aligned
                    }
                }
                .padding(padding)
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
            case .success: return (alertToken.colorSuccessBg, alertToken.colorSuccessBorder, alertToken.colorSuccess)
            case .info: return (alertToken.colorInfoBg, alertToken.colorInfoBorder, alertToken.colorInfo)
            case .warning: return (alertToken.colorWarningBg, alertToken.colorWarningBorder, alertToken.colorWarning)
            case .error: return (alertToken.colorErrorBg, alertToken.colorErrorBorder, alertToken.colorError)
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

public extension Moin.Alert where Action == EmptyView {
    init(
        type: AlertType = .info,
        title: String,
        description: String? = nil,
        showIcon: Bool = false,
        closable: Bool = false,
        banner: Bool = false,
        onClose: (() -> Void)? = nil
    ) {
        self.init(
            type: type,
            title: title,
            description: description,
            showIcon: showIcon,
            closable: closable,
            banner: banner,
            onClose: onClose
        ) {
            EmptyView()
        }
    }
}
