import SwiftUI

// MARK: - _DividerVariant (internal name, use Moin.Divider.Variant)

/// Divider line variant
public enum _DividerVariant: String, CaseIterable {
    case solid
    case dashed
    case dotted
}

// MARK: - Moin.Divider.Variant typealias

public extension Moin.Divider {
    typealias Variant = _DividerVariant
}
