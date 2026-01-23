import SwiftUI

public extension Moin {
    struct ProgressToken {
        // MARK: - Component Token (Strictly Ant Design)
        
        /// 进度条默认颜色
        /// Default color of progress bar
        public var defaultColor: Color
        
        /// 进度条剩余部分颜色
        /// Color of remaining part of progress bar
        public var remainingColor: Color
        
        /// 圆形进度条文字颜色
        /// Text color of circular progress bar
        public var circleTextColor: Color
        
        /// 条状进度条圆角
        /// Border radius of line progress bar
        public var lineBorderRadius: CGFloat
        
        /// 圆形进度条文本大小
        /// Text size of circular progress bar
        public var circleTextFontSize: String // "1em"
        
        /// 圆形进度条图标大小
        /// Icon size of circular progress bar
        public var circleIconFontSize: String // "14px/12px -> 1.16em"
        
        public static func generate(from token: Token) -> ProgressToken {
            return ProgressToken(
                defaultColor: token.colorInfo,
                remainingColor: token.colorFillSecondary,
                circleTextColor: token.colorText,
                lineBorderRadius: 100, // 默认很大，capsule
                circleTextFontSize: "1em",
                circleIconFontSize: String(format: "%.2fem", token.fontSize / token.fontSizeSM)
            )
        }
        
        public static let `default` = generate(from: .default)
    }
}
