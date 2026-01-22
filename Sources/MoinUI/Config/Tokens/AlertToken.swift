import SwiftUI

// MARK: - Moin.AlertToken

public extension Moin {
    struct AlertToken {
        // Success 颜色
        public var successBg: Color
        public var successBorder: Color
        public var successIcon: Color
        
        // Info 颜色
        public var infoBg: Color
        public var infoBorder: Color
        public var infoIcon: Color
        
        // Warning 颜色
        public var warningBg: Color
        public var warningBorder: Color
        public var warningIcon: Color
        
        // Error 颜色
        public var errorBg: Color
        public var errorBorder: Color
        public var errorIcon: Color
        
        // 尺寸
        public var paddingVertical: CGFloat
        public var paddingHorizontal: CGFloat
        public var iconSize: CGFloat
        public var fontSize: CGFloat
        public var titleFontSize: CGFloat
        public var borderWidth: CGFloat
        public var cornerRadius: CGFloat
        
        // 间距
        public var gap: CGFloat
        public var titleGap: CGFloat
        
        public static func generate(from token: Token) -> AlertToken {
            AlertToken(
                // Success
                successBg: token.colorSuccessBg,
                successBorder: token.colorSuccessBorder,
                successIcon: token.colorSuccess,
                
                // Info
                infoBg: token.colorInfoBg,
                infoBorder: token.colorInfoBorder,
                infoIcon: token.colorInfo,
                
                // Warning
                warningBg: token.colorWarningBg,
                warningBorder: token.colorWarningBorder,
                warningIcon: token.colorWarning,
                
                // Error
                errorBg: token.colorDangerBg,
                errorBorder: token.colorDangerBorder,
                errorIcon: token.colorDanger,
                
                // 尺寸
                paddingVertical: token.paddingXS + 1, // 8 + 1 = 9 to match Ant Design 40px height (22 LH + 18 padding)
                paddingHorizontal: token.padding,
                iconSize: 16,
                fontSize: token.fontSize,
                titleFontSize: token.fontSizeLG,
                borderWidth: 1,
                cornerRadius: token.borderRadius,
                
                // 间距
                gap: token.marginXS,
                titleGap: token.marginXXS
            )
        }

        public static let light = generate(from: .light)
        public static let dark = generate(from: .dark)
        public static let `default` = light
    }
}
