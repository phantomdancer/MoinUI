import SwiftUI

// MARK: - Moin.StatisticToken

public extension Moin {
    struct StatisticToken {
        public var titleFontSize: CGFloat
        public var contentFontSize: CGFloat
        
        public var titleColor: Color
        public var contentColor: Color
        
        // Spacing between title and content
        public var gap: CGFloat
        
        // Spacing between prefix/suffix and value
        public var contentGap: CGFloat

        public init(
            titleFontSize: CGFloat,
            contentFontSize: CGFloat,
            titleColor: Color,
            contentColor: Color,
            gap: CGFloat,
            contentGap: CGFloat
        ) {
            self.titleFontSize = titleFontSize
            self.contentFontSize = contentFontSize
            self.titleColor = titleColor
            self.contentColor = contentColor
            self.gap = gap
            self.contentGap = contentGap
        }

        public static func resolve(token: Token) -> StatisticToken {
            .init(
                titleFontSize: token.fontSize,
                contentFontSize: token.fontSizeHeading3,
                titleColor: token.colorTextSecondary,
                contentColor: token.colorText,
                gap: token.marginXXS, 
                contentGap: token.marginXXS
            )
        }
    }
}
