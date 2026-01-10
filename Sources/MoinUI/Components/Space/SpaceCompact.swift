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
        public let direction: SpaceDirection
        public let position: SpaceCompactPosition
        /// Size of previous sibling (for vertical: width, for horizontal: height)
        public let prevSize: CGFloat?
        /// Size of next sibling (for vertical: width, for horizontal: height)
        public let nextSize: CGFloat?
        /// Own size (for comparison)
        public let ownSize: CGFloat?

        public static let none = SpaceCompactContext(
            isCompact: false,
            direction: .horizontal,
            position: .none,
            prevSize: nil,
            nextSize: nil,
            ownSize: nil
        )

        public init(
            isCompact: Bool,
            direction: SpaceDirection,
            position: SpaceCompactPosition,
            prevSize: CGFloat? = nil,
            nextSize: CGFloat? = nil,
            ownSize: CGFloat? = nil
        ) {
            self.isCompact = isCompact
            self.direction = direction
            self.position = position
            self.prevSize = prevSize
            self.nextSize = nextSize
            self.ownSize = ownSize
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
