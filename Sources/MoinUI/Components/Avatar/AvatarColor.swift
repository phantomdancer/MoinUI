import SwiftUI

// MARK: - _AvatarColor (internal name, use Moin.Avatar.Color)

/// Avatar 颜色
public enum _AvatarColor: Hashable, Moin.PresetColorConvertible {
    case custom(SwiftUI.Color)

    // MARK: - Properties

    public var color: SwiftUI.Color {
        switch self {
        case .custom(let c): return c
        }
    }
}


