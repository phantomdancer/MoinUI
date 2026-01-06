import SwiftUI

/// Button type (color variant)
public enum MoinUIButtonType {
    case `default`
    case primary
    case success
    case warning
    case danger
    case info

    var backgroundColor: Color {
        switch self {
        case .default: return Constants.Colors.background
        case .primary: return Constants.Colors.primary
        case .success: return Constants.Colors.success
        case .warning: return Constants.Colors.warning
        case .danger: return Constants.Colors.danger
        case .info: return Constants.Colors.info
        }
    }

    var hoverBackgroundColor: Color {
        switch self {
        case .default: return Constants.Colors.backgroundHover
        case .primary: return Constants.Colors.primaryHover
        case .success: return Constants.Colors.successHover
        case .warning: return Constants.Colors.warningHover
        case .danger: return Constants.Colors.dangerHover
        case .info: return Constants.Colors.infoHover
        }
    }

    var activeBackgroundColor: Color {
        switch self {
        case .default: return Constants.Colors.background
        case .primary: return Constants.Colors.primaryActive
        case .success: return Constants.Colors.successActive
        case .warning: return Constants.Colors.warningActive
        case .danger: return Constants.Colors.dangerActive
        case .info: return Constants.Colors.infoActive
        }
    }

    var foregroundColor: Color {
        switch self {
        case .default: return Constants.Colors.textPrimary
        default: return .white
        }
    }

    var borderColor: Color {
        switch self {
        case .default: return Constants.Colors.border
        default: return .clear
        }
    }

    var hoverBorderColor: Color {
        switch self {
        case .default: return Constants.Colors.borderHover
        default: return .clear
        }
    }
}
