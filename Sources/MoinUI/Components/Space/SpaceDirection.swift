import SwiftUI

// MARK: - _SpaceDirection (internal name, use Moin.Space.Direction)

/// Space direction
public enum _SpaceDirection: Sendable {
    case horizontal
    case vertical
}

// MARK: - Moin.Space.Direction typealias

public extension Moin.Space {
    typealias Direction = _SpaceDirection
}
