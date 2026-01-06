import SwiftUI

/// Button shape
public enum MoinUIButtonShape: Sendable {
    /// Default rounded corners based on size
    case `default`
    /// Fully rounded corners (pill shape)
    case round
    /// Circular button (equal width and height)
    case circle
}
