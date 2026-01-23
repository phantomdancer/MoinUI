import SwiftUI

// MARK: - Moin.DividerToken

public extension Moin {
    /// Divider 组件的设计变量（仅组件专属Token）
    ///
    /// 参考 Ant Design Divider Component Token
    /// 全局Token（lineWidth、colorBorder、fontSize等）直接从全局token读取
    struct DividerToken {
        // MARK: - Component Token (组件专属)
        
        /// 文本与线条的间距 (textPaddingInline)
        public var textPadding: CGFloat
        /// 文本偏移比例 (0~1)，用于 left/right 对齐 (orientationMargin)
        public var orientationMargin: CGFloat
        /// 虚线长度
        public var dashLength: CGFloat
        /// 虚线间隙
        public var dashGap: CGFloat

        public static func generate(from token: Token) -> DividerToken {
            DividerToken(
                textPadding: token.padding,      // 1em ≈ 16px
                orientationMargin: 0.05,         // Ant Design default
                dashLength: 4,
                dashGap: 4
            )
        }

        public static let light = generate(from: .light)
        public static let dark = generate(from: .dark)
        public static let `default` = light
    }
}
