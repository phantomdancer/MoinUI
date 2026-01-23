import SwiftUI

// MARK: - Moin.AvatarToken

public extension Moin {
    struct AvatarToken {
        // MARK: - Sizes
        public var size: CGFloat
        public var sizeLG: CGFloat
        public var sizeSM: CGFloat

        // MARK: - Font Sizes
        public var fontSize: CGFloat
        public var fontSizeLG: CGFloat
        public var fontSizeSM: CGFloat

        // MARK: - AvatarGroup
        public var groupSpacing: CGFloat
        public var groupBorderColor: Color
        
        // Note: groupBorderWidth removed, use global lineWidth.
        // Note: containerBg, colorText, borderRadius etc removed, use global tokens.

        public static func generate(from token: Token) -> AvatarToken {
            AvatarToken(
                size: token.controlHeight,       // 32
                sizeLG: token.controlHeightLG,   // 40
                sizeSM: token.controlHeightSM,   // 24
                fontSize: token.fontSizeHeading5,  // 18
                fontSizeLG: token.fontSizeHeading3,// 24
                fontSizeSM: token.fontSize,      // 14
                groupSpacing: 4,  // MoinUI default
                groupBorderColor: token.colorBgContainer
            )
        }

        public static let light = generate(from: .light)
        public static let dark = generate(from: .dark)
        public static let `default` = light
    }
}
