import SwiftUI

// MARK: - _BadgeColor (internal name, use Moin.Badge.Color)

/// 徽标颜色
public enum _BadgeColor: Hashable, Moin.PresetColorConvertible {
    case `default`
    case success
    case processing
    case warning
    case error
    case custom(SwiftUI.Color)
}


