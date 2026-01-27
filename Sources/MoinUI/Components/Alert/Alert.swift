import SwiftUI
import AppKit


// MARK: - _Alert (internal name, use Moin.Alert.View)

/// Alert 警告提示
///
/// 警告提示，展示需要关注的信息。
///
/// - 当你需要向用户显示警告消息时
/// - 当你需要一个可被用户关闭的持久静态容器时
public struct _Alert<Action: View>: View {
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
        let colors = colorsForType()
        let hasDescription = description != nil

        // 组件Token：padding 和 withDescriptionIconSize
        let padding = hasDescription ? alertToken.withDescriptionPadding : alertToken.defaultPadding
        // 全局Token：fontSize
        let titleFontSize = hasDescription ? token.fontSizeLG : token.fontSize
        let currentIconSize = hasDescription ? alertToken.withDescriptionIconSize : token.fontSizeLG

        HStack(alignment: hasDescription ? .top : .center, spacing: 0) {
            // Icon
            if showIcon {
                iconForType
                    .font(.system(size: currentIconSize))
                    .foregroundStyle(colors.icon)
                    .frame(minHeight: hasDescription ? token.lineHeightLG : nil)
                    .padding(.trailing, hasDescription ? token.marginSM : token.marginXS)
            }

            // Section (title + description)
            VStack(alignment: .leading, spacing: hasDescription ? token.marginXS : 0) {
                if !title.isEmpty {
                    Text(title)
                        .font(.system(size: titleFontSize, weight: hasDescription ? .medium : .regular))
                        .foregroundStyle(token.colorText) // 全局Token
                        .fixedSize(horizontal: false, vertical: true)
                }

                if let desc = description {
                    Text(desc)
                        .font(.system(size: token.fontSize)) // 全局Token
                        .foregroundStyle(token.colorText) // 全局Token
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            // Actions
            if Action.self != EmptyView.self {
                action
                    .padding(.leading, token.marginXS)
            }

            // Close button
            if closable {
                closeButton
            }
        }
        .padding(padding)
        .background(colors.bg)
        .overlay(
            RoundedRectangle(cornerRadius: banner ? 0 : token.borderRadiusLG) // 全局Token
                .stroke(colors.border, lineWidth: banner ? 0 : token.lineWidth) // 全局Token
        )
        .clipShape(RoundedRectangle(cornerRadius: banner ? 0 : token.borderRadiusLG)) // 全局Token
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
            .font(.system(size: token.fontSizeSM)) // 全局Token: fontSizeIcon = fontSizeSM
            .foregroundStyle(isCloseHovered ? token.colorText : token.colorTextTertiary) // 全局Token
            .contentShape(Rectangle())
            .padding(.leading, token.marginXS)
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

    private func colorsForType() -> (bg: Color, border: Color, icon: Color) {
        // 全局Token: 状态颜色
        switch type {
        case .success: return (token.colorSuccessBg, token.colorSuccessBorder, token.colorSuccess)
        case .info: return (token.colorInfoBg, token.colorInfoBorder, token.colorInfo)
        case .warning: return (token.colorWarningBg, token.colorWarningBorder, token.colorWarning)
        case .error: return (token.colorDangerBg, token.colorDangerBorder, token.colorDanger)
        }
    }

    private func handleClose() {
        withAnimation(.easeInOut(duration: 0.2)) {
            isVisible = false
        }
        onClose?()
    }
}

// MARK: - Convenience Initializer (without action)

public extension _Alert where Action == EmptyView {
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



