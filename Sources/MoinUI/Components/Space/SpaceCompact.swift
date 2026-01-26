// Moin.SpaceCompactPosition, Moin.SpaceCompactContext
import SwiftUI

public extension Moin {
    /// Position within a compact group
    enum SpaceCompactPosition: Equatable, Sendable {
        case none
        case only
        case first
        case middle
        case last
    }

    /// Compact context passed through environment
    struct SpaceCompactContext: Equatable, Sendable {
        public let isCompact: Bool
        public let direction: _SpaceDirection
        public let position: SpaceCompactPosition
        public let fillWidth: Bool  // For vertical compact: fill to max width

        public static let none = SpaceCompactContext(
            isCompact: false,
            direction: .horizontal,
            position: .none,
            fillWidth: false
        )

        public init(
            isCompact: Bool,
            direction: _SpaceDirection,
            position: SpaceCompactPosition,
            fillWidth: Bool = false
        ) {
            self.isCompact = isCompact
            self.direction = direction
            self.position = position
            self.fillWidth = fillWidth
        }
    }
}

// MARK: - Environment

private struct MoinSpaceCompactContextKey: EnvironmentKey {
    static let defaultValue = Moin.SpaceCompactContext.none
}

public extension EnvironmentValues {
    var moinSpaceCompactContext: Moin.SpaceCompactContext {
        get { self[MoinSpaceCompactContextKey.self] }
        set { self[MoinSpaceCompactContextKey.self] = newValue }
    }
}
