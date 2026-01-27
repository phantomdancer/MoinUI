import SwiftUI

// MARK: - _SpaceCompactPosition (internal name, use Moin.Space.CompactPosition)

/// Position within a compact group
public enum _SpaceCompactPosition: Equatable, Sendable {
    case none
    case only
    case first
    case middle
    case last
}

// MARK: - _SpaceCompactContext (internal name, use Moin.Space.CompactContext)

/// Compact context passed through environment
public struct _SpaceCompactContext: Equatable, Sendable {
    public let isCompact: Bool
    public let direction: _SpaceDirection
    public let position: _SpaceCompactPosition
    public let fillWidth: Bool  // For vertical compact: fill to max width

    public static let none = _SpaceCompactContext(
        isCompact: false,
        direction: .horizontal,
        position: .none,
        fillWidth: false
    )

    public init(
        isCompact: Bool,
        direction: _SpaceDirection,
        position: _SpaceCompactPosition,
        fillWidth: Bool = false
    ) {
        self.isCompact = isCompact
        self.direction = direction
        self.position = position
        self.fillWidth = fillWidth
    }
}

// MARK: - Environment

private struct MoinSpaceCompactContextKey: EnvironmentKey {
    static let defaultValue = _SpaceCompactContext.none
}

public extension EnvironmentValues {
    var moinSpaceCompactContext: _SpaceCompactContext {
        get { self[MoinSpaceCompactContextKey.self] }
        set { self[MoinSpaceCompactContextKey.self] = newValue }
    }
}


