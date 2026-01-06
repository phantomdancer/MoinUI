import SwiftUI

/// 主题类型枚举
public enum MoinUITheme: String, CaseIterable {
    case light
    case dark
    case system

    /// 默认主题
    public static let `default`: MoinUITheme = .system

    /// 显示名称
    public var displayName: String {
        switch self {
        case .light: return "浅色"
        case .dark: return "深色"
        case .system: return "跟随系统"
        }
    }

    /// 图标名称
    public var iconName: String {
        switch self {
        case .light: return "sun.max.fill"
        case .dark: return "moon.fill"
        case .system: return "circle.lefthalf.filled"
        }
    }
}

/// 暗色模式颜色定义
public enum DarkColors {
    // Primary - 暗色模式下稍微调亮
    public static let primary = Color(red: 0.22, green: 0.54, blue: 1.0)
    public static let primaryHover = Color(red: 0.35, green: 0.63, blue: 1.0)
    public static let primaryActive = Color(red: 0.15, green: 0.45, blue: 0.90)

    // Success
    public static let success = Color(red: 0.40, green: 0.78, blue: 0.35)
    public static let successHover = Color(red: 0.50, green: 0.85, blue: 0.45)
    public static let successActive = Color(red: 0.32, green: 0.68, blue: 0.28)

    // Warning
    public static let warning = Color(red: 1.0, green: 0.72, blue: 0.30)
    public static let warningHover = Color(red: 1.0, green: 0.80, blue: 0.45)
    public static let warningActive = Color(red: 0.90, green: 0.62, blue: 0.20)

    // Danger
    public static let danger = Color(red: 1.0, green: 0.40, blue: 0.40)
    public static let dangerHover = Color(red: 1.0, green: 0.55, blue: 0.55)
    public static let dangerActive = Color(red: 0.90, green: 0.30, blue: 0.30)

    // Info
    public static let info = Color(red: 0.65, green: 0.65, blue: 0.70)
    public static let infoHover = Color(red: 0.75, green: 0.75, blue: 0.80)
    public static let infoActive = Color(red: 0.55, green: 0.55, blue: 0.60)

    // 背景和文字
    public static let background = Color(red: 0.10, green: 0.10, blue: 0.12)
    public static let backgroundHover = Color(red: 0.15, green: 0.15, blue: 0.17)
    public static let backgroundElevated = Color(red: 0.14, green: 0.14, blue: 0.16)
    public static let border = Color(white: 0.25)
    public static let borderHover = Color(red: 0.22, green: 0.54, blue: 1.0)
    public static let textPrimary = Color(white: 0.92)
    public static let textSecondary = Color(white: 0.65)
    public static let textDisabled = Color(white: 0.45)
    public static let backgroundDisabled = Color(white: 0.22)
}
