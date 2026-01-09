import SwiftUI

// MARK: - Moin.ButtonSize

public extension Moin {
    /// Button size
    enum ButtonSize {
        case small
        case medium
        case large
    }
}

/// 旧名别名（已弃用）
@available(*, deprecated, renamed: "Moin.ButtonSize")
public typealias MoinUIButtonSize = Moin.ButtonSize
