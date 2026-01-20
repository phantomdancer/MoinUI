import SwiftUI

public extension Moin {
    /// 徽标颜色
    enum BadgeColor: Hashable, PresetColorConvertible {
        case `default`
        case success
        case processing
        case warning
        case error
        case custom(Color)
        

    }
}
