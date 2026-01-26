import SwiftUI

// MARK: - _ButtonVariant (internal name, use Moin.Button.Variant)

/// Button variant (style) - 与 antd 保持一致
public enum _ButtonVariant {
    /// Solid filled button (实心按钮)
    case solid
    /// Outlined button with border (描边按钮)
    case outlined
    /// Dashed border button (虚线按钮)
    case dashed
    /// Filled button with light background (填充按钮，比 solid 淡)
    case filled
    /// Plain text button without background (文本按钮)
    case text
    /// Link style button (链接按钮)
    case link
}

// MARK: - Moin.Button.Variant typealias

public extension Moin.Button {
    typealias Variant = _ButtonVariant
}
