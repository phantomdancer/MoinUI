import SwiftUI

// MARK: - Moin.ButtonColor

public extension Moin {
    /// Button color - 支持预设色和自定义 Color
    enum ButtonColor: Hashable {
        case `default`
        case primary
        case success
        case warning
        case danger
        case info
        case custom(SwiftUI.Color)

        /// 是否为默认颜色
        public var isDefault: Bool {
            if case .default = self { return true }
            return false
        }

        public func hash(into hasher: inout Hasher) {
            switch self {
            case .default: hasher.combine(0)
            case .primary: hasher.combine(1)
            case .success: hasher.combine(2)
            case .warning: hasher.combine(3)
            case .danger: hasher.combine(4)
            case .info: hasher.combine(5)
            case .custom(let color): hasher.combine(color.description)
            }
        }
    }
}

/// 旧名别名（已弃用）
@available(*, deprecated, renamed: "Moin.ButtonColor")
public typealias MoinUIButtonColor = Moin.ButtonColor
