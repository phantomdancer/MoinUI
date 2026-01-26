import SwiftUI

// MARK: - _BadgeStatus (internal name, use Moin.Badge.Status)

/// 徽标状态
public enum _BadgeStatus {
    case success
    case processing
    case `default`
    case error
    case warning
}

// MARK: - Moin.Badge.Status typealias

public extension Moin.Badge {
    typealias Status = _BadgeStatus
}
