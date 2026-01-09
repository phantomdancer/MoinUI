import SwiftUI

// MARK: - Moin.ButtonShape

public extension Moin {
    /// Button shape
    enum ButtonShape: Sendable {
        /// Default rounded corners based on size
        case `default`
        /// Fully rounded corners (pill shape)
        case round
        /// Circular button (equal width and height)
        case circle
    }
}

