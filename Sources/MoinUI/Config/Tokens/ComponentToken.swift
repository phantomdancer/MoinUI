import SwiftUI

// MARK: - Moin.ComponentToken

public extension Moin {
    struct ComponentToken {
        public var button: Moin.ButtonToken
        public var space: Moin.SpaceToken
        public var divider: Moin.DividerToken
        public var tag: Moin.TagToken
        public var badge: Moin.BadgeToken
        public var avatar: Moin.AvatarToken
        public var empty: Moin.EmptyToken
        public var spin: Moin.SpinToken
        public var statistic: Moin.StatisticToken
        public var alert: Moin.AlertToken
        public var progress: Moin.ProgressToken
        public var `switch`: Moin.SwitchToken

        public static func generate(from token: Token, isDark: Bool = false) -> ComponentToken {
            ComponentToken(
                button: .generate(from: token, isDark: isDark),
                space: .generate(from: token),
                divider: .generate(from: token),
                tag: .generate(from: token),
                badge: .generate(from: token),
                avatar: .generate(from: token),
                empty: .generate(from: token),
                spin: .generate(from: token),
                statistic: .resolve(token: token),
                alert: .generate(from: token),
                progress: .generate(from: token),
                switch: .resolve(token: token, isDark: isDark)
            )
        }

        public static let light = generate(from: .light, isDark: false)
        public static let dark = generate(from: .dark, isDark: true)
        public static let `default` = light
    }
}
