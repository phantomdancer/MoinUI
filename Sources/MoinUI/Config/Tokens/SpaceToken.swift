import SwiftUI

// MARK: - Moin.SpaceToken

public extension Moin {
    struct SpaceToken {
        public var sizeSmall: CGFloat
        public var sizeMedium: CGFloat
        public var sizeLarge: CGFloat

        public static func generate(from token: Token) -> SpaceToken {
            SpaceToken(
                sizeSmall: token.paddingXS,
                sizeMedium: token.padding,
                sizeLarge: token.paddingLG
            )
        }

        public static let light = generate(from: .light)
        public static let dark = generate(from: .dark)
        public static let `default` = light
    }
}
