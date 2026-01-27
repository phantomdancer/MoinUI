import SwiftUI

// MARK: - _TagVariant (internal name, use Moin.Tag.Variant)

/// Tag 变体
public enum _TagVariant {
    /// 填充背景（默认）- 浅色背景有边框
    case filled
    /// 仅边框
    case outlined
    /// 实心背景 - 深色背景白字
    case solid
    /// 无边框 - 浅色背景无边框
    case borderless
}


