// MARK: - Moin.RateToken

import SwiftUI

public extension Moin {
    /// Rate 评分 Token
    ///
    /// 基于 Ant Design Rate Design Token
    struct RateToken {
        // MARK: - Colors

        /// 已填充星星颜色
        public var starColor: Color
        /// 未填充星星背景色
        public var starBg: Color

        // MARK: - Sizes

        /// 默认星星尺寸
        public var starSize: CGFloat
        /// 小号星星尺寸
        public var starSizeSM: CGFloat
        /// 大号星星尺寸
        public var starSizeLG: CGFloat

        // MARK: - Interaction

        /// 悬停缩放比例
        public var starHoverScale: CGFloat

        // MARK: - Generate

        public static func generate(from token: Token) -> RateToken {
            RateToken(
                starColor: Moin.Colors.yellow6,
                starBg: token.colorFillTertiary,
                starSize: token.controlHeight * 0.625,
                starSizeSM: token.controlHeightSM * 0.625,
                starSizeLG: token.controlHeightLG * 0.625,
                starHoverScale: 1.1
            )
        }

        public static let light = generate(from: .light)
        public static let dark = generate(from: .dark)
        public static let `default` = light
    }
}
