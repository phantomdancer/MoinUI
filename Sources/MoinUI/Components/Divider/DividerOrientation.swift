import SwiftUI

// MARK: - _DividerOrientation (internal name, use Moin.Divider.Orientation)

/// Divider orientation
public enum _DividerOrientation: String, CaseIterable {
    case horizontal
    case vertical
}

// MARK: - Moin.Divider.Orientation typealias

public extension Moin.Divider {
    typealias Orientation = _DividerOrientation
}
