import SwiftUI

// MARK: - Moin.ButtonToken

public extension Moin {
    struct ButtonToken {
        // MARK: - 字体
        public var fontWeight: Font.Weight
        public var iconGap: CGFloat

        // MARK: - 默认按钮
        public var defaultColor: Color
        public var defaultBg: Color
        public var defaultBorderColor: Color
        public var defaultHoverBg: Color
        public var defaultHoverColor: Color
        public var defaultHoverBorderColor: Color
        public var defaultActiveBg: Color
        public var defaultActiveColor: Color
        public var defaultActiveBorderColor: Color

        // MARK: - 主要按钮
        public var primaryColor: Color

        // MARK: - 危险按钮
        public var dangerColor: Color

        // MARK: - Ghost 按钮
        public var ghostBg: Color
        public var defaultGhostColor: Color
        public var defaultGhostBorderColor: Color

        // MARK: - Solid 按钮
        public var solidTextColor: Color

        // MARK: - Text 按钮
        public var textTextColor: Color
        public var textTextHoverColor: Color
        public var textTextActiveColor: Color
        public var textHoverBg: Color
        public var linkHoverBg: Color

        // MARK: - 内边距
        public var paddingInline: CGFloat
        public var paddingInlineLG: CGFloat
        public var paddingInlineSM: CGFloat
        public var paddingBlock: CGFloat
        public var paddingBlockLG: CGFloat
        public var paddingBlockSM: CGFloat

        // MARK: - 图标尺寸
        public var onlyIconSize: CGFloat
        public var onlyIconSizeLG: CGFloat
        public var onlyIconSizeSM: CGFloat

        // MARK: - 字体尺寸
        public var contentFontSize: CGFloat
        public var contentFontSizeLG: CGFloat
        public var contentFontSizeSM: CGFloat

        // MARK: - 行高
        public var contentLineHeight: CGFloat
        public var contentLineHeightLG: CGFloat
        public var contentLineHeightSM: CGFloat

        // MARK: - 阴影
        public var defaultShadow: String
        public var primaryShadow: String
        public var dangerShadow: String

        // MARK: - 按钮组
        public var groupBorderColor: Color

        // MARK: - 禁用态
        public var borderColorDisabled: Color
        public var defaultBgDisabled: Color
        public var dashedBgDisabled: Color

        // MARK: - 从全局 Token 生成
        public static func generate(from token: Token, isDark: Bool = false) -> ButtonToken {
            ButtonToken(
                fontWeight: .medium,
                iconGap: 6,
                defaultColor: token.colorText,
                defaultBg: token.colorBgContainer,
                defaultBorderColor: token.colorBorder,
                defaultHoverBg: token.colorBgContainer,
                defaultHoverColor: token.colorPrimaryHover,
                defaultHoverBorderColor: token.colorPrimaryHover,
                defaultActiveBg: token.colorBgContainer,
                defaultActiveColor: token.colorPrimaryActive,
                defaultActiveBorderColor: token.colorPrimaryActive,
                primaryColor: .white,
                dangerColor: .white,
                ghostBg: .clear,
                defaultGhostColor: .white,
                defaultGhostBorderColor: .white,
                solidTextColor: .white,
                textTextColor: token.colorText,
                textTextHoverColor: token.colorText,
                textTextActiveColor: token.colorText,
                textHoverBg: isDark ? Color.white.opacity(0.08) : Color.black.opacity(0.04),
                linkHoverBg: .clear,
                paddingInline: token.paddingMD - 1,
                paddingInlineLG: token.padding - 1,
                paddingInlineSM: token.paddingXS - 1,
                paddingBlock: 0,
                paddingBlockLG: 0,
                paddingBlockSM: 0,
                onlyIconSize: 16,
                onlyIconSizeLG: 18,
                onlyIconSizeSM: 14,
                contentFontSize: token.fontSize,
                contentFontSizeLG: token.fontSizeLG,
                contentFontSizeSM: token.fontSizeSM,
                contentLineHeight: token.lineHeight,
                contentLineHeightLG: token.lineHeightLG,
                contentLineHeightSM: token.lineHeightSM,
                defaultShadow: "0 2px 0 rgba(0, 0, 0, 0.02)",
                primaryShadow: "0 2px 0 rgba(5, 145, 255, 0.1)",
                dangerShadow: "0 2px 0 rgba(255, 38, 5, 0.06)",
                groupBorderColor: token.colorPrimaryHover,
                borderColorDisabled: token.colorBorder.opacity(0.5),
                defaultBgDisabled: token.colorBgDisabled,
                dashedBgDisabled: token.colorBgDisabled
            )
        }

        public static let light = generate(from: .light, isDark: false)
        public static let dark = generate(from: .dark, isDark: true)
        public static let `default` = light
    }
}
