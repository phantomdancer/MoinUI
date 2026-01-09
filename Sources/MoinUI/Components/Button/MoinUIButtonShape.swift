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

/// 旧名别名（已弃用）
@available(*, deprecated, renamed: "Moin.ButtonShape")
public typealias MoinUIButtonShape = Moin.ButtonShape
