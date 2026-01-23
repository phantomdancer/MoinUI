import SwiftUI

// MARK: - Moin.ButtonToken

public extension Moin {
    struct ButtonToken {
        // MARK: - Typography
        public var fontWeight: Font.Weight
        public var contentFontSize: CGFloat
        public var contentFontSizeLG: CGFloat
        public var contentFontSizeSM: CGFloat
        public var contentLineHeight: CGFloat
        public var contentLineHeightLG: CGFloat
        public var contentLineHeightSM: CGFloat
        
        // MARK: - Layout
        public var paddingInline: CGFloat
        public var paddingInlineLG: CGFloat
        public var paddingInlineSM: CGFloat
        public var paddingBlock: CGFloat
        public var paddingBlockLG: CGFloat
        public var paddingBlockSM: CGFloat
        
        public var iconGap: CGFloat
        public var onlyIconSize: CGFloat
        public var onlyIconSizeLG: CGFloat
        public var onlyIconSizeSM: CGFloat

        // MARK: - Style (Component Specific)
        public var groupBorderColor: Color
        public var defaultShadow: String
        public var primaryShadow: String
        public var dangerShadow: String
        
        // MARK: - Text Button Specific
        public var textTextColor: Color // 用于覆盖 Text 按钮默认颜色
        
        // Note: Default/Primary/Danger colors are derived directly from Global Token in Component.
        
        public static func generate(from token: Token, isDark: Bool = false) -> ButtonToken {
            ButtonToken(
                fontWeight: .medium,
                contentFontSize: token.fontSize,
                contentFontSizeLG: token.fontSizeLG,
                contentFontSizeSM: token.fontSizeSM,
                contentLineHeight: token.lineHeight,
                contentLineHeightLG: token.lineHeightLG,
                contentLineHeightSM: token.lineHeightSM,
                paddingInline: token.paddingMD - 1,   // 15
                paddingInlineLG: token.padding - 1,   // 23
                paddingInlineSM: token.paddingXS - 1, // 7
                paddingBlock: 0,
                paddingBlockLG: 0,
                paddingBlockSM: 0,
                iconGap: 6,
                onlyIconSize: 16,
                onlyIconSizeLG: 18,
                onlyIconSizeSM: 14,
                groupBorderColor: token.colorPrimaryHover,
                defaultShadow: "0 2px 0 rgba(0, 0, 0, 0.02)",
                primaryShadow: "0 2px 0 rgba(5, 145, 255, 0.1)",
                dangerShadow: "0 2px 0 rgba(255, 38, 5, 0.06)",
                textTextColor: token.colorText
            )
        }

        public static let light = generate(from: .light, isDark: false)
        public static let dark = generate(from: .dark, isDark: true)
        public static let `default` = light
    }
}
