import SwiftUI

// MARK: - _TagSize (internal name, use Moin.Tag.Size)

/// 标签尺寸
public enum _TagSize {
    case small
    case medium
    case large
}

// MARK: - Moin.Tag.Size typealias

public extension Moin.Tag {
    typealias Size = _TagSize
}
