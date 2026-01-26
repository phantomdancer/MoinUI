import SwiftUI

// MARK: - _ButtonIconPlacement (internal name, use Moin.Button.IconPlacement)

/// 图标位置 - 与 antd iconPlacement 一致
public enum _ButtonIconPlacement {
    case start
    case end
}

// MARK: - Moin.Button.IconPlacement typealias

public extension Moin.Button {
    typealias IconPlacement = _ButtonIconPlacement
}
