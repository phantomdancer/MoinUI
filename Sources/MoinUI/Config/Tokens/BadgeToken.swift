import SwiftUI

// MARK: - Moin.BadgeToken

public extension Moin {
    struct BadgeToken {
        /// 徽标高度
        public var indicatorHeight: CGFloat
        /// 小号徽标高度
        public var indicatorHeightSM: CGFloat
        /// 点状徽标尺寸
        public var dotSize: CGFloat
        /// 小号点状尺寸
        public var dotSizeSM: CGFloat
        /// 徽标文字尺寸
        public var textFontSize: CGFloat
        /// 小号文字尺寸
        public var textFontSizeSM: CGFloat
        /// 文字粗细
        public var textFontWeight: Font.Weight
        /// 状态点尺寸
        public var statusSize: CGFloat
        /// 阴影半径
        public var shadowRadius: CGFloat
        /// 阴影透明度
        public var shadowOpacity: Double
        /// 水平内边距
        public var paddingH: CGFloat
        /// 小号水平内边距
        public var paddingHSM: CGFloat
        /// 徽标文字颜色
        public var textColor: Color
        /// 徽标背景色
        public var badgeColor: Color

        public static func generate(from token: Token) -> BadgeToken {
            BadgeToken(
                indicatorHeight: 18,
                indicatorHeightSM: 14,
                dotSize: 8,
                dotSizeSM: 6,
                textFontSize: 11,
                textFontSizeSM: 10,
                textFontWeight: .medium,
                statusSize: 6,
                shadowRadius: 2,
                shadowOpacity: 0.3,
                paddingH: 6,
                paddingHSM: 4,
                textColor: .white,
                badgeColor: token.colorDanger
            )
        }

        public static let light = generate(from: .light)
        public static let dark = generate(from: .dark)
        public static let `default` = light
    }
}
