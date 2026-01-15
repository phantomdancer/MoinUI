import SwiftUI

// MARK: - Moin.Config

public extension Moin {
    struct Config {
        public var locale: Moin.Locale
        public var theme: Moin.Theme
        public var token: Moin.Token
        public var components: Moin.ComponentToken

        public static let `default` = Config(
            locale: .default,
            theme: .default,
            token: .default,
            components: .default
        )

        public init(
            locale: Moin.Locale = .default,
            theme: Moin.Theme = .default,
            token: Moin.Token = .default,
            components: Moin.ComponentToken = .default
        ) {
            self.locale = locale
            self.theme = theme
            self.token = token
            self.components = components
        }
    }
}
