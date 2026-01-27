import SwiftUI

// MARK: - _ButtonColor (internal name, use Moin.Button.Color)

/// Button color - 支持预设色和自定义 Color
public enum _ButtonColor: Hashable, Moin.PresetColorConvertible {
    case `default`
    case primary
    case success
    case warning
    case danger
    case info
    case custom(SwiftUI.Color)

    // MARK: - Properties

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

