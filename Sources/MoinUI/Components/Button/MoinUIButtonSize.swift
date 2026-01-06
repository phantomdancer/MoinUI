import SwiftUI

/// Button size
public enum MoinUIButtonSize {
    case small
    case medium
    case large

    var height: CGFloat {
        switch self {
        case .small: return Constants.Button.heightSm
        case .medium: return Constants.Button.heightMd
        case .large: return Constants.Button.heightLg
        }
    }

    var horizontalPadding: CGFloat {
        switch self {
        case .small: return Constants.Button.paddingHorizontalSm
        case .medium: return Constants.Button.paddingHorizontalMd
        case .large: return Constants.Button.paddingHorizontalLg
        }
    }

    var fontSize: CGFloat {
        switch self {
        case .small: return Constants.Button.fontSizeSm
        case .medium: return Constants.Button.fontSizeMd
        case .large: return Constants.Button.fontSizeLg
        }
    }

    var iconSize: CGFloat {
        switch self {
        case .small: return Constants.Button.iconSizeSm
        case .medium: return Constants.Button.iconSizeMd
        case .large: return Constants.Button.iconSizeLg
        }
    }

    var cornerRadius: CGFloat {
        switch self {
        case .small: return Constants.Radius.sm
        case .medium: return Constants.Radius.md
        case .large: return Constants.Radius.lg
        }
    }
}
