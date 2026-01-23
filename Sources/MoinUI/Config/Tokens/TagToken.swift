import SwiftUI

// MARK: - Moin.TagToken

public extension Moin {
    /// Tag 组件的设计变量（仅组件专属Token）
    ///
    /// 参考 Ant Design Tag Component Token
    /// 全局Token（fontSize、lineWidth等）直接从全局token读取
    struct TagToken {
        /// 默认背景色
        public var defaultBg: Color
        /// 默认文字颜色
        public var defaultColor: Color
        /// 实心标签文字颜色
        public var solidTextColor: Color

        // MARK: - 图标相关 Token (组件专属)
        /// 图标尺寸 (Large)
        public var iconSizeLG: CGFloat
        /// 图标尺寸 (Medium)
        public var iconSize: CGFloat
        /// 图标尺寸 (Small)
        public var iconSizeSM: CGFloat
        /// 关闭图标尺寸 (Large)
        public var closeIconSizeLG: CGFloat
        /// 关闭图标尺寸 (Medium)
        public var closeIconSize: CGFloat
        /// 关闭图标尺寸 (Small)
        public var closeIconSizeSM: CGFloat
        /// 图标间距 (Large)
        public var iconGapLG: CGFloat
        /// 图标间距 (Medium)
        public var iconGap: CGFloat
        /// 图标间距 (Small)
        public var iconGapSM: CGFloat

        // MARK: - 内边距 Token (组件专属)
        /// 水平内边距 (Large)
        public var paddingHLG: CGFloat
        /// 水平内边距 (Medium)
        public var paddingH: CGFloat
        /// 水平内边距 (Small)
        public var paddingHSM: CGFloat
        /// 垂直内边距 (Large)
        public var paddingVLG: CGFloat
        /// 垂直内边距 (Medium)
        public var paddingV: CGFloat
        /// 垂直内边距 (Small)
        public var paddingVSM: CGFloat

        public static func generate(from token: Token) -> TagToken {
            TagToken(
                defaultBg: token.colorFillSecondary,
                defaultColor: token.colorText,
                solidTextColor: .white,
                // 图标尺寸
                iconSizeLG: 12,
                iconSize: 10,
                iconSizeSM: 8,
                // 关闭图标尺寸
                closeIconSizeLG: 9,
                closeIconSize: 8,
                closeIconSizeSM: 7,
                // 图标间距
                iconGapLG: token.paddingXS,
                iconGap: token.paddingXXS,
                iconGapSM: 2,
                // 水平内边距
                paddingHLG: token.paddingMD,
                paddingH: token.paddingSM,
                paddingHSM: token.paddingXS,
                // 垂直内边距
                paddingVLG: token.paddingXXS + 2,
                paddingV: token.paddingXXS,
                paddingVSM: 1
            )
        }

        public static let light = generate(from: .light)
        public static let dark = generate(from: .dark)
        public static let `default` = light
    }
}
