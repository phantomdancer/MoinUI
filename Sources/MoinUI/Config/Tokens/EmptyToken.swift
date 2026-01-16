import SwiftUI

// MARK: - Moin.EmptyToken

public extension Moin {
    struct EmptyToken {
        // MARK: - Image
        public var imageHeight: CGFloat
        public var imageHeightSM: CGFloat
        public var imageColor: Color
        public var imageOpacity: Double

        // MARK: - Description
        public var descriptionColor: Color
        public var descriptionFontSize: CGFloat

        // MARK: - Spacing
        public var imageMarginBottom: CGFloat
        public var contentMarginTop: CGFloat

        public static func generate(from token: Token) -> EmptyToken {
            EmptyToken(
                imageHeight: 100,
                imageHeightSM: 40,
                imageColor: token.colorTextQuaternary,
                imageOpacity: 1.0,
                descriptionColor: token.colorTextSecondary,
                descriptionFontSize: token.fontSize,
                imageMarginBottom: token.marginXS,
                contentMarginTop: token.marginSM
            )
        }

        public static let light = generate(from: .light)
        public static let dark = generate(from: .dark)
        public static let `default` = light
    }
}
