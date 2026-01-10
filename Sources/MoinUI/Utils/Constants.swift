import SwiftUI

// MARK: - Moin.Constants

public extension Moin {
    /// Constants definition
    enum Constants {
        /// Spacing
        public enum Spacing {
            public static let xs: CGFloat = 4
            public static let sm: CGFloat = 8
            public static let md: CGFloat = 12
            public static let lg: CGFloat = 16
            public static let xl: CGFloat = 24
            public static let xxl: CGFloat = 40
        }

        /// Border radius
        public enum Radius {
            public static let sm: CGFloat = 4
            public static let md: CGFloat = 6
            public static let lg: CGFloat = 8
            public static let full: CGFloat = 9999
        }

        /// Animation duration
        public enum Duration {
            public static let fast: Double = 0.15
            public static let normal: Double = 0.25
            public static let slow: Double = 0.35
        }

        /// Button constants
        public enum Button {
            /// Height
            public static let heightSm: CGFloat = 24
            public static let heightMd: CGFloat = 32
            public static let heightLg: CGFloat = 40

            /// Horizontal padding
            public static let paddingHorizontalSm: CGFloat = 8
            public static let paddingHorizontalMd: CGFloat = 16
            public static let paddingHorizontalLg: CGFloat = 20

            /// Font size
            public static let fontSizeSm: CGFloat = 12
            public static let fontSizeMd: CGFloat = 14
            public static let fontSizeLg: CGFloat = 16

            /// Icon size
            public static let iconSizeSm: CGFloat = 14
            public static let iconSizeMd: CGFloat = 16
            public static let iconSizeLg: CGFloat = 18

            /// Icon spacing
            public static let iconSpacing: CGFloat = 6

            /// Border width
            public static let borderWidth: CGFloat = 1
        }

        /// Colors - 使用 Ant Design 色板 (计算属性避免循环依赖)
        public enum Colors {
            // Primary (Blue) - level 6/5/7
            public static var primary: Color { Moin.Colors.bluePalette[6] }
            public static var primaryHover: Color { Moin.Colors.bluePalette[5] }
            public static var primaryActive: Color { Moin.Colors.bluePalette[7] }

            // Success (Green) - level 6/5/7
            public static var success: Color { Moin.Colors.greenPalette[6] }
            public static var successHover: Color { Moin.Colors.greenPalette[5] }
            public static var successActive: Color { Moin.Colors.greenPalette[7] }

            // Warning (Gold) - level 6/5/7
            public static var warning: Color { Moin.Colors.goldPalette[6] }
            public static var warningHover: Color { Moin.Colors.goldPalette[5] }
            public static var warningActive: Color { Moin.Colors.goldPalette[7] }

            // Danger (Red) - level 6/5/7
            public static var danger: Color { Moin.Colors.redPalette[6] }
            public static var dangerHover: Color { Moin.Colors.redPalette[5] }
            public static var dangerActive: Color { Moin.Colors.redPalette[7] }

            // Info (灰色系)
            public static let info = Color(red: 0.55, green: 0.55, blue: 0.55)
            public static let infoHover = Color(red: 0.65, green: 0.65, blue: 0.65)
            public static let infoActive = Color(red: 0.45, green: 0.45, blue: 0.45)

            // Default / neutral
            public static let border = Color(red: 0.85, green: 0.85, blue: 0.85)
            public static var borderHover: Color { Moin.Colors.bluePalette[5] }
            public static let background = Color.white
            public static let backgroundHover = Color(white: 0.98)
            public static let textPrimary = Color(white: 0.13)
            public static let textSecondary = Color(white: 0.45)
            public static let textDisabled = Color(white: 0.55)
            public static let backgroundDisabled = Color(white: 0.92)
        }
    }
}
