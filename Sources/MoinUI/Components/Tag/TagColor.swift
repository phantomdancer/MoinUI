import SwiftUI

// MARK: - _TagColor (internal name, use Moin.Tag.Color)

/// Tag 颜色
public enum _TagColor: Hashable, Moin.PresetColorConvertible {
    case `default`      // 灰色
    case success        // 绿色
    case processing     // 主色（进行中）
    case warning        // 橙色
    case error          // 红色
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
        case .success: hasher.combine(1)
        case .processing: hasher.combine(2)
        case .warning: hasher.combine(3)
        case .error: hasher.combine(4)
        case .custom(let color): hasher.combine(color.description)
        }
    }
}

// MARK: - Moin.Tag.Color typealias

public extension Moin.Tag {
    typealias Color = _TagColor
}
