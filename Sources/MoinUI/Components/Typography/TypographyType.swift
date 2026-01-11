import SwiftUI

public extension Moin {
    /// Typography semantic color type
    enum TypographyType: String, CaseIterable {
        case `default`
        case secondary
        case success
        case warning
        case danger
    }

    /// Title level (h1-h5)
    enum TitleLevel: Int, CaseIterable {
        case h1 = 1
        case h2 = 2
        case h3 = 3
        case h4 = 4
        case h5 = 5
    }
}
