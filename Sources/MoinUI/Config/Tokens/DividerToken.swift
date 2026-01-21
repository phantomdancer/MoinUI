import SwiftUI

// MARK: - Moin.DividerToken

public extension Moin {
    struct DividerToken {
        // MARK: - Component Token
        
        /// 分割线颜色
        public var lineColor: Color
        /// 带文本时的文本颜色
        public var textColor: Color
        /// 带文本时的字号
        public var fontSize: CGFloat
        /// 水平分割线的垂直外间距
        public var verticalMargin: CGFloat
        /// 垂直分割线的水平外间距
        public var horizontalMargin: CGFloat
        /// 文本与线条的间距
        public var textPadding: CGFloat
        /// 分割线宽度
        public var lineWidth: CGFloat
        /// 虚线长度
        public var dashLength: CGFloat
        /// 虚线间隙
        public var dashGap: CGFloat
        /// 文本偏移比例 (0~1)，用于 left/right 对齐
        public var orientationMargin: CGFloat

        public static func generate(from token: Token) -> DividerToken {
            DividerToken(
                lineColor: token.colorBorder,
                textColor: token.colorText,
                fontSize: token.fontSizeLG,
                verticalMargin: token.marginLG,
                horizontalMargin: token.marginXS,
                textPadding: token.padding,
                lineWidth: token.lineWidth,
                dashLength: 4,
                dashGap: 4,
                orientationMargin: 0.05
            )
        }

        public static let light = generate(from: .light)
        public static let dark = generate(from: .dark)
        public static let `default` = light
    }
}
