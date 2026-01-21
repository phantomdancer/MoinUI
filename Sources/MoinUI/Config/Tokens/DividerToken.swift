import SwiftUI

// MARK: - Moin.DividerToken

public extension Moin {
    struct DividerToken {
        // MARK: - Component Token (对齐 Ant Design 命名)
        
        /// 文本横向内间距
        public var textPaddingInline: CGFloat
        /// 文本与边缘距离比例 (0~1)，用于 left/right 对齐
        public var orientationMargin: CGFloat
        /// 纵向分割线的横向外间距
        public var verticalMarginInline: CGFloat
        
        // MARK: - Extended Token (MoinUI 扩展)
        
        /// 分割线颜色
        public var lineColor: Color
        /// 带文本时的文本颜色
        public var textColor: Color
        /// 带文本时的字号
        public var fontSize: CGFloat
        /// 水平分割线的垂直外间距
        public var horizontalMarginBlock: CGFloat
        /// 分割线宽度
        public var lineWidth: CGFloat
        /// 虚线长度
        public var dashLength: CGFloat
        /// 虚线间隙
        public var dashGap: CGFloat

        public static func generate(from token: Token) -> DividerToken {
            DividerToken(
                textPaddingInline: token.padding,
                orientationMargin: 0.05,
                verticalMarginInline: token.marginXS,
                lineColor: token.colorBorder,
                textColor: token.colorText,
                fontSize: token.fontSizeLG,
                horizontalMarginBlock: token.marginLG,
                lineWidth: token.lineWidth,
                dashLength: 4,
                dashGap: 4
            )
        }

        public static let light = generate(from: .light)
        public static let dark = generate(from: .dark)
        public static let `default` = light
    }
}
