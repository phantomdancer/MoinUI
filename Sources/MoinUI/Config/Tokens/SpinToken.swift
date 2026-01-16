import SwiftUI

// MARK: - Moin.SpinToken

public extension Moin {
    struct SpinToken {
        // MARK: - Size
        /// 默认加载图标尺寸
        public var dotSize: CGFloat
        /// 小尺寸加载图标
        public var dotSizeSM: CGFloat
        /// 大尺寸加载图标
        public var dotSizeLG: CGFloat

        // MARK: - Color
        /// 加载点颜色
        public var dotColor: Color
        /// 提示文字颜色
        public var tipColor: Color
        /// 全屏遮罩背景色
        public var maskBackground: Color

        // MARK: - Content
        /// 嵌套模式最大内容高度
        public var contentHeight: CGFloat

        // MARK: - Animation
        /// 动画时长(秒)
        public var motionDuration: Double

        // MARK: - Generate

        public static func generate(from token: Token) -> SpinToken {
            SpinToken(
                dotSize: token.controlHeightLG / 2,           // 20
                dotSizeSM: token.controlHeightLG * 0.35,      // 14
                dotSizeLG: token.controlHeight,               // 32
                dotColor: token.colorPrimary,
                tipColor: token.colorTextTertiary,
                maskBackground: token.colorBgMask,
                contentHeight: 400,
                motionDuration: token.motionDurationSlow
            )
        }

        public static let light = generate(from: .light)
        public static let dark = generate(from: .dark)
        public static let `default` = light
    }
}
