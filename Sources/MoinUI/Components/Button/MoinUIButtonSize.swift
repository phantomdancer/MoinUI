import SwiftUI

/// Button size
public enum MoinUIButtonSize {
    case small
    case medium
    case large

    var height: CGFloat {
        switch self {
        case .small: return MoinUIConstants.Button.heightSm
        case .medium: return MoinUIConstants.Button.heightMd
        case .large: return MoinUIConstants.Button.heightLg
        }
    }

    var horizontalPadding: CGFloat {
        switch self {
        case .small: return MoinUIConstants.Button.paddingHorizontalSm
        case .medium: return MoinUIConstants.Button.paddingHorizontalMd
        case .large: return MoinUIConstants.Button.paddingHorizontalLg
        }
    }

    var fontSize: CGFloat {
        switch self {
        case .small: return MoinUIConstants.Button.fontSizeSm
        case .medium: return MoinUIConstants.Button.fontSizeMd
        case .large: return MoinUIConstants.Button.fontSizeLg
        }
    }

    var iconSize: CGFloat {
        switch self {
        case .small: return MoinUIConstants.Button.iconSizeSm
        case .medium: return MoinUIConstants.Button.iconSizeMd
        case .large: return MoinUIConstants.Button.iconSizeLg
        }
    }

    var cornerRadius: CGFloat {
        switch self {
        case .small: return MoinUIConstants.Radius.sm
        case .medium: return MoinUIConstants.Radius.md
        case .large: return MoinUIConstants.Radius.lg
        }
    }
}
