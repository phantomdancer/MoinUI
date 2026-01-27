import SwiftUI

// MARK: - _ButtonShape (internal name, use Moin.Button.Shape)

/// Button shape
public enum _ButtonShape: Sendable {
    /// Default rounded corners based on size
    case `default`
    /// Fully rounded corners (pill shape)
    case round
    /// Circular button (equal width and height)
    case circle
}

