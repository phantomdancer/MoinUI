import SwiftUI

// MARK: - Moin.ResultToken

public extension Moin {
    struct ResultToken {
        // MARK: - Component Token (Ant Design)

        /// 标题字号 (Ant Design: fontSizeHeading3)
        public var titleFontSize: CGFloat
        /// 副标题字号 (Ant Design: fontSize)
        public var subtitleFontSize: CGFloat
        /// 图标大小 (Ant Design: fontSizeHeading3 × 3)
        public var iconFontSize: CGFloat
        /// 操作区外边距 (Ant Design: paddingLG)
        public var extraMargin: CGFloat
        /// 内间距
        public var padding: CGFloat

        // MARK: - Factory

        public static func generate(from token: Token) -> ResultToken {
            ResultToken(
                titleFontSize: token.fontSizeHeading3,
                subtitleFontSize: token.fontSize,
                iconFontSize: token.fontSizeHeading3 * 3,
                extraMargin: token.paddingLG,
                padding: token.paddingLG * 2
            )
        }

        public static let light = generate(from: .light)
        public static let dark = generate(from: .dark)
        public static let `default` = light
    }
}

// MARK: - Environment Key

private struct MoinResultTokenKey: EnvironmentKey {
    static let defaultValue = Moin.ResultToken.default
}

public extension EnvironmentValues {
    var moinResultToken: Moin.ResultToken {
        get { self[MoinResultTokenKey.self] }
        set { self[MoinResultTokenKey.self] = newValue }
    }
}
