import SwiftUI

// MARK: - _BadgeSize (internal name, use Moin.Badge.Size)

/// 徽标尺寸
public enum _BadgeSize {
    case `default`
    case small
}

// MARK: - Moin.Badge.Size typealias

public extension Moin.Badge {
    typealias Size = _BadgeSize
}
