import SwiftUI

// MARK: - Moin.Theme

public extension Moin {
    /// 主题类型枚举
    enum Theme: String, CaseIterable {
        case light
        case dark
        case system

        /// 默认主题
        public static let `default`: Theme = .system

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
}


// MARK: - Moin.DarkColors

public extension Moin {
    /// 暗色模式颜色定义 - 使用 Ant Design 暗色主题色板
    enum DarkColors {
        /// 暗色主题背景色
        private static let darkBackground = Color(hex: 0x141414)

        // Primary (Blue) - 暗色主题 level 6/5/7
        public static var primary: Color { darkBluePalette[6] }
        public static var primaryHover: Color { darkBluePalette[5] }
        public static var primaryActive: Color { darkBluePalette[7] }

        // Success (Green) - 暗色主题 level 6/5/7
        public static var success: Color { darkGreenPalette[6] }
        public static var successHover: Color { darkGreenPalette[5] }
        public static var successActive: Color { darkGreenPalette[7] }

        // Warning (Gold) - 暗色主题 level 6/5/7
        public static var warning: Color { darkGoldPalette[6] }
        public static var warningHover: Color { darkGoldPalette[5] }
        public static var warningActive: Color { darkGoldPalette[7] }

        // Danger (Red) - 暗色主题 level 6/5/7
        public static var danger: Color { darkRedPalette[6] }
        public static var dangerHover: Color { darkRedPalette[5] }
        public static var dangerActive: Color { darkRedPalette[7] }

        // Info (灰色系)
        public static let info = Color(red: 0.65, green: 0.65, blue: 0.70)
        public static let infoHover = Color(red: 0.75, green: 0.75, blue: 0.80)
        public static let infoActive = Color(red: 0.55, green: 0.55, blue: 0.60)

        // 背景和文字
        public static let background = Color(hex: 0x141414)
        public static let backgroundHover = Color(red: 0.15, green: 0.15, blue: 0.17)
        public static let backgroundElevated = Color(red: 0.14, green: 0.14, blue: 0.16)
        public static let border = Color(white: 0.25)
        public static var borderHover: Color { darkBluePalette[5] }
        public static let textPrimary = Color(white: 0.92)
        public static let textSecondary = Color(white: 0.65)
        public static let textDisabled = Color(white: 0.45)
        public static let backgroundDisabled = Color(white: 0.22)

        // MARK: - 暗色主题色板

        private static let darkBluePalette = Moin.ColorPalette.generate(
            from: Moin.Colors.blue, theme: .dark, backgroundColor: darkBackground
        )
        private static let darkGreenPalette = Moin.ColorPalette.generate(
            from: Moin.Colors.green, theme: .dark, backgroundColor: darkBackground
        )
        private static let darkGoldPalette = Moin.ColorPalette.generate(
            from: Moin.Colors.gold, theme: .dark, backgroundColor: darkBackground
        )
        private static let darkRedPalette = Moin.ColorPalette.generate(
            from: Moin.Colors.red, theme: .dark, backgroundColor: darkBackground
        )
    }
}
