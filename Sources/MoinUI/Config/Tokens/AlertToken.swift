import SwiftUI

// MARK: - Moin.AlertToken

public extension Moin {
    struct AlertToken {
        // Success Colors
        public var colorSuccessBg: Color
        public var colorSuccessBorder: Color
        public var colorSuccess: Color
        
        // Info Colors
        public var colorInfoBg: Color
        public var colorInfoBorder: Color
        public var colorInfo: Color
        
        // Warning Colors
        public var colorWarningBg: Color
        public var colorWarningBorder: Color
        public var colorWarning: Color
        
        // Error Colors
        public var colorErrorBg: Color
        public var colorErrorBorder: Color
        public var colorError: Color
        
        // Layout - Standard
        public var defaultPadding: EdgeInsets
        public var iconSize: CGFloat // Not in AntD Component Token list but needed for standard mode
        
        // Layout - With Description
        public var withDescriptionPadding: EdgeInsets
        public var withDescriptionIconSize: CGFloat
        
        // Common
        public var fontSize: CGFloat
        public var titleFontSize: CGFloat // Usually derived from fontSizeLG
        public var borderWidth: CGFloat
        public var cornerRadius: CGFloat
        
        // Gap (Moin Custom)
        public var gap: CGFloat
        public var titleGap: CGFloat
        
        public static func generate(from token: Token) -> AlertToken {
            AlertToken(
                // Success
                colorSuccessBg: token.colorSuccessBg,
                colorSuccessBorder: token.colorSuccessBorder,
                colorSuccess: token.colorSuccess,
                
                // Info
                colorInfoBg: token.colorInfoBg,
                colorInfoBorder: token.colorInfoBorder,
                colorInfo: token.colorInfo,
                
                // Warning
                colorWarningBg: token.colorWarningBg,
                colorWarningBorder: token.colorWarningBorder,
                colorWarning: token.colorWarning,
                
                // Error
                colorErrorBg: token.colorDangerBg,
                colorErrorBorder: token.colorDangerBorder,
                colorError: token.colorDanger,
                
                // Layout - Standard (8px 12px)
                defaultPadding: EdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12),
                iconSize: 16, // derived from fontSize usually
                
                // Layout - With Description (User: 20px 24px)
                withDescriptionPadding: EdgeInsets(top: 20, leading: 24, bottom: 20, trailing: 24),
                withDescriptionIconSize: 24,
                
                // Common
                fontSize: token.fontSize,
                titleFontSize: token.fontSizeLG,
                borderWidth: token.lineWidth,
                cornerRadius: token.borderRadius,
                
                // Gap
                gap: token.marginXS,
                titleGap: token.marginXXS
            )
        }

        public static let light = generate(from: .light)
        public static let dark = generate(from: .dark)
        public static let `default` = light
    }
}
