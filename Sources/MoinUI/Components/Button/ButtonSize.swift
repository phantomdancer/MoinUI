import SwiftUI

// MARK: - _ButtonSize (internal name, use Moin.Button.Size)

/// Button size
public enum _ButtonSize {
    case small
    case medium
    case large
}

// MARK: - Moin.Button.Size typealias

public extension Moin.Button {
    typealias Size = _ButtonSize
}
