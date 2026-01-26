import SwiftUI

// MARK: - _DividerTitlePlacement (internal name, use Moin.Divider.TitlePlacement)

/// Title placement for horizontal divider with text
public enum _DividerTitlePlacement: String, CaseIterable {
    case left
    case center
    case right
}

// MARK: - Moin.Divider.TitlePlacement typealias

public extension Moin.Divider {
    typealias TitlePlacement = _DividerTitlePlacement
}
