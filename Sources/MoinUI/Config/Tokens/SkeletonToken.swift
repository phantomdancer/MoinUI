// MARK: - Moin.SkeletonToken

import SwiftUI

public extension Moin {
    /// Skeleton 骨架屏 Token
    ///
    /// 基于 Ant Design Skeleton Design Token
    struct SkeletonToken {
        // MARK: - Colors

        /// 骨架屏基础颜色
        public var color: Color
        /// 渐变结束颜色
        public var colorGradientEnd: Color

        // MARK: - Sizes

        /// 标题高度
        public var titleHeight: CGFloat
        /// 段落行高
        public var paragraphLineHeight: CGFloat
        /// 段落行间距
        public var paragraphLineMarginTop: CGFloat
        /// 圆角
        public var blockRadius: CGFloat
        /// 头像尺寸 - 默认
        public var avatarSize: CGFloat
        /// 头像尺寸 - 小
        public var avatarSizeSM: CGFloat
        /// 头像尺寸 - 大
        public var avatarSizeLG: CGFloat
        /// 按钮高度
        public var buttonHeight: CGFloat
        /// 按钮高度 - 小
        public var buttonHeightSM: CGFloat
        /// 按钮高度 - 大
        public var buttonHeightLG: CGFloat
        /// 输入框高度
        public var inputHeight: CGFloat
        /// 输入框高度 - 小
        public var inputHeightSM: CGFloat
        /// 输入框高度 - 大
        public var inputHeightLG: CGFloat

        // MARK: - Animation

        /// 动画时长(秒)
        public var motionDuration: Double

        // MARK: - Generate

        public static func generate(from token: Token) -> SkeletonToken {
            SkeletonToken(
                color: token.colorFillSecondary,
                colorGradientEnd: token.colorFill,
                titleHeight: 16,
                paragraphLineHeight: 16,
                paragraphLineMarginTop: 24,
                blockRadius: token.borderRadiusSM,
                avatarSize: token.controlHeight,
                avatarSizeSM: token.controlHeightSM,
                avatarSizeLG: token.controlHeightLG,
                buttonHeight: token.controlHeight,
                buttonHeightSM: token.controlHeightSM,
                buttonHeightLG: token.controlHeightLG,
                inputHeight: token.controlHeight,
                inputHeightSM: token.controlHeightSM,
                inputHeightLG: token.controlHeightLG,
                motionDuration: 1.5
            )
        }

        public static let light = generate(from: .light)
        public static let dark = generate(from: .dark)
        public static let `default` = light
    }
}
