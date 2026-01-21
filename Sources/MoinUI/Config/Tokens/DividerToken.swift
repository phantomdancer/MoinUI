import SwiftUI

// MARK: - Moin.DividerToken

public extension Moin {
    struct DividerToken {
        public var lineColor: Color
        public var textColor: Color
        public var fontSize: CGFloat
        public var verticalMargin: CGFloat
        public var horizontalMargin: CGFloat
        public var textPadding: CGFloat
        public var lineWidth: CGFloat
        public var dashLength: CGFloat
        public var dashGap: CGFloat

        public static func generate(from token: Token) -> DividerToken {
            DividerToken(
                lineColor: token.colorBorder,
                textColor: token.colorText,
                fontSize: token.fontSize,
                verticalMargin: token.paddingLG,
                horizontalMargin: token.paddingSM,
                textPadding: token.padding,
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
