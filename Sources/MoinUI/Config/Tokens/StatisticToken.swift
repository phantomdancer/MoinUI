import SwiftUI

// MARK: - Moin.StatisticToken

public extension Moin {
    /// Statistic 组件的设计变量（仅组件专属Token）
    ///
    /// 参考 Ant Design Statistic ComponentToken
    /// 全局Token（colorTextDescription、colorTextHeading、marginXXS）直接从全局token读取
    struct StatisticToken {
        public var titleFontSize: CGFloat
        public var contentFontSize: CGFloat

        public init(titleFontSize: CGFloat, contentFontSize: CGFloat) {
            self.titleFontSize = titleFontSize
            self.contentFontSize = contentFontSize
        }

        public static func generate(from token: Token) -> StatisticToken {
            StatisticToken(
                titleFontSize: token.fontSize,
                contentFontSize: token.fontSizeHeading3
            )
        }
        
        // 兼容现有调用
        public static func resolve(token: Token) -> StatisticToken {
            generate(from: token)
        }

        public static let light = generate(from: .light)
        public static let dark = generate(from: .dark)
        public static let `default` = light
    }
}
