import SwiftUI

// MARK: - _SpaceAlignment (internal name, use Moin.Space.Alignment)

/// Space alignment
public enum _SpaceAlignment {
    case start
    case end
    case center
}

// MARK: - Moin.Space.Alignment typealias

public extension Moin.Space {
    typealias Alignment = _SpaceAlignment
}
