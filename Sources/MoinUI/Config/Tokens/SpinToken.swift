import SwiftUI

// MARK: - Moin.SpinToken

public extension Moin {
    /// Spin 组件的设计变量（仅组件专属Token）
    ///
    /// 参考 Ant Design Spin ComponentToken
    /// 全局Token（colorPrimary、colorTextTertiary、colorBgMask）直接从全局token读取
    struct SpinToken {
        // MARK: - Size (组件专属)
        /// 默认加载图标尺寸
        public var dotSize: CGFloat
        /// 小尺寸加载图标
        public var dotSizeSM: CGFloat
        /// 大尺寸加载图标
        public var dotSizeLG: CGFloat
        /// 嵌套模式最大内容高度
        public var contentHeight: CGFloat
        /// 动画时长(秒)
        public var motionDuration: Double

        // MARK: - Generate

        public static func generate(from token: Token) -> SpinToken {
            SpinToken(
                dotSize: token.controlHeightLG / 2,           // 20
                dotSizeSM: token.controlHeightLG * 0.35,      // 14
                dotSizeLG: token.controlHeight,               // 32
                contentHeight: 400,
                motionDuration: 1.2  // antd: animation 1.2s infinite linear
            )
        }

        public static let light = generate(from: .light)
        public static let dark = generate(from: .dark)
        public static let `default` = light
    }
}
