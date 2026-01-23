import SwiftUI
import AppKit

// MARK: - Moin.Alert

public extension Moin {
    /// Alert 警告提示
    /// 
    /// 警告提示，展示需要关注的信息。
    /// 
    /// - 当你需要向用户显示警告消息时
    /// - 当你需要一个可被用户关闭的持久静态容器时
    struct Alert<Action: View>: View {
        @Environment(\.moinToken) private var token
        @Environment(\.moinTheme) private var theme
        @Environment(\.moinAlertToken) private var alertToken
        
        /// Alert 类型
        public enum AlertType {
            case success
            case info
            case warning
            case error
        }
        
        // MARK: - Properties
        
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
        
        // MARK: - Initializer
        
        /// 创建一个 Alert 警告提示
        /// - Parameters:
        ///   - type: 警告类型 (success, info, warning, error)，默认 .info，banner 模式下默认 .warning
        ///   - title: 警告标题
        ///   - description: 警告的辅助性文字介绍
        ///   - showIcon: 是否显示图标，banner 模式下默认 true
        ///   - closable: 是否可关闭
        ///   - banner: 是否为 Banner 模式
        ///   - onClose: 关闭时的回调函数
        ///   - action: 自定义操作视图
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
            // banner 模式下默认类型为 warning
            self.type = banner && type == .info ? .warning : type
            self.title = title
            self.description = description
            // banner 模式下默认显示图标
            self.showIcon = banner ? (showIcon || true) : showIcon
            self.closable = closable
            self.banner = banner
            self.onClose = onClose
            self.action = action()
        }
        
        // MARK: - Body
        
        public var body: some View {
            if isVisible {
                alertContent
            }
        }
        
        @ViewBuilder
        private var alertContent: some View {
            let colors = colorsForType(alertToken)
            let hasDescription = description != nil
            
            // 根据是否有描述选择 padding 和尺寸
            let padding = hasDescription ? alertToken.withDescriptionPadding : alertToken.defaultPadding
            let titleFontSize = hasDescription ? alertToken.fontSizeLG : alertToken.fontSize
            let currentIconSize = hasDescription ? alertToken.withDescriptionIconSize : alertToken.iconSize
            
            HStack(alignment: hasDescription ? .top : .center, spacing: 0) {
                // Icon
                if showIcon {
                    iconForType
                        .font(.system(size: currentIconSize))
                        .foregroundStyle(colors.icon)
                        .frame(minHeight: hasDescription ? alertToken.lineHeightLG : nil)
                        .padding(.trailing, hasDescription ? alertToken.marginSM : alertToken.marginXS)
                }
                
                // Section (title + description)
                VStack(alignment: .leading, spacing: hasDescription ? alertToken.marginXS : 0) {
                    if !title.isEmpty {
                        Text(title)
                            .font(.system(size: titleFontSize, weight: hasDescription ? .medium : .regular))
                            .foregroundStyle(alertToken.colorTextHeading)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    
                    if let desc = description {
                        Text(desc)
                            .font(.system(size: alertToken.fontSize))
                            .foregroundStyle(alertToken.colorText)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                // Actions
                if Action.self != EmptyView.self {
                    action
                        .padding(.leading, alertToken.marginXS)
                }
                
                // Close button
                if closable {
                    closeButton
                }
            }
            .padding(padding)
            .background(colors.bg)
            .overlay(
                RoundedRectangle(cornerRadius: banner ? 0 : alertToken.borderRadiusLG)
                    .stroke(colors.border, lineWidth: banner ? 0 : alertToken.lineWidth)
            )
            .clipShape(RoundedRectangle(cornerRadius: banner ? 0 : alertToken.borderRadiusLG))
        }
        
        // MARK: - Subviews
        
        private var iconForType: Image {
            switch type {
            case .success: return Image(systemName: "checkmark.circle.fill")
            case .info: return Image(systemName: "info.circle.fill")
            case .warning: return Image(systemName: "exclamationmark.triangle.fill")
            case .error: return Image(systemName: "xmark.circle.fill")
            }
        }
        
        private var closeButton: some View {
            Image(systemName: "xmark")
                .font(.system(size: alertToken.fontSizeIcon))
                .foregroundStyle(isCloseHovered ? alertToken.colorIconHover : alertToken.colorIcon)
                .contentShape(Rectangle())
                .padding(.leading, alertToken.marginXS)
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
        
        // MARK: - Helpers
        
        private func colorsForType(_ alertToken: AlertToken) -> (bg: Color, border: Color, icon: Color) {
            switch type {
            case .success: return (alertToken.colorSuccessBg, alertToken.colorSuccessBorder, alertToken.colorSuccess)
            case .info: return (alertToken.colorInfoBg, alertToken.colorInfoBorder, alertToken.colorInfo)
            case .warning: return (alertToken.colorWarningBg, alertToken.colorWarningBorder, alertToken.colorWarning)
            case .error: return (alertToken.colorErrorBg, alertToken.colorErrorBorder, alertToken.colorError)
            }
        }
        
        private func handleClose() {
            withAnimation(.easeInOut(duration: 0.2)) {
                isVisible = false
            }
            onClose?()
        }
    }
}

// MARK: - Convenience Initializer (without action)

public extension Moin.Alert where Action == EmptyView {
    /// 创建一个无操作按钮的 Alert 警告提示
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
