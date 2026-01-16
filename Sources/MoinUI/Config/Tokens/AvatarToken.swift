import SwiftUI

// MARK: - Moin.AvatarToken

public extension Moin {
    struct AvatarToken {
        // MARK: - Colors
        public var containerBg: Color
        public var colorText: Color
        public var colorTextLight: Color // 用于彩色背景时的亮色文字

        // MARK: - Sizes
        public var size: CGFloat
        public var sizeLG: CGFloat
        public var sizeSM: CGFloat

        // MARK: - Font Sizes
        public var fontSize: CGFloat
        public var fontSizeLG: CGFloat
        public var fontSizeSM: CGFloat

        // MARK: - Border Radius
        public var borderRadius: CGFloat
        public var borderRadiusLG: CGFloat
        public var borderRadiusSM: CGFloat

        // MARK: - AvatarGroup
        public var groupSpacing: CGFloat
        public var groupBorderColor: Color
        public var groupBorderWidth: CGFloat

        public static func generate(from token: Token) -> AvatarToken {
            AvatarToken(
                // antd: background: var(--ant-color-text-placeholder)
                containerBg: token.colorTextPlaceholder,
                colorText: token.colorTextLightSolid,  // #fff
                colorTextLight: token.colorTextLightSolid,
                size: token.controlHeight,       // 32
                sizeLG: token.controlHeightLG,   // 40
                sizeSM: token.controlHeightSM,   // 24
                fontSize: token.fontSizeHeading5,  // 18 (default)
                fontSizeLG: token.fontSizeHeading3,// 24 (large)
                fontSizeSM: token.fontSize,      // 14 (small)
                borderRadius: token.borderRadius,
                borderRadiusLG: token.borderRadiusLG,
                borderRadiusSM: token.borderRadiusSM,
                groupSpacing: 4,  // 正数不重叠，负数重叠
                groupBorderColor: token.colorBgContainer,
                groupBorderWidth: token.lineWidth * 2
            )
        }

        public static let light = generate(from: .light)
        public static let dark = generate(from: .dark)
        public static let `default` = light
    }
}
