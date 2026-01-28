// MARK: - Moin.SkeletonToken

import SwiftUI

public extension Moin {
    /// Skeleton 骨架屏 Token
    ///
    /// 基于 Ant Design Skeleton Design Token
    struct SkeletonToken {
        // MARK: - Colors

        /// 渐变色起点颜色
        public var gradientFromColor: Color
        /// 渐变色终点颜色
        public var gradientToColor: Color

        // MARK: - Sizes

        /// 标题高度
        public var titleHeight: CGFloat
        /// 骨架屏圆角
        public var blockRadius: CGFloat
        /// 段落骨架屏上间距
        public var paragraphMarginTop: CGFloat
        /// 段落骨架屏单行高度
        public var paragraphLiHeight: CGFloat

        // MARK: - Generate

        public static func generate(from token: Token) -> SkeletonToken {
            SkeletonToken(
                gradientFromColor: token.colorFillSecondary,
                gradientToColor: token.colorFill,
                titleHeight: token.controlHeight / 2,
                blockRadius: token.borderRadiusSM,
                paragraphMarginTop: token.marginLG + token.marginXXS,
                paragraphLiHeight: token.controlHeight / 2
            )
        }

        public static let light = generate(from: .light)
        public static let dark = generate(from: .dark)
        public static let `default` = light
    }
}
