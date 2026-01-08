import SwiftUI

/// Constants definition
public enum MoinUIConstants {
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

    /// Colors
    public enum Colors {
        // Primary
        public static let primary = Color(red: 0.09, green: 0.47, blue: 1.0)
        public static let primaryHover = Color(red: 0.25, green: 0.59, blue: 1.0)
        public static let primaryActive = Color(red: 0.04, green: 0.35, blue: 0.85)

        // Success
        public static let success = Color(red: 0.32, green: 0.73, blue: 0.27)
        public static let successHover = Color(red: 0.45, green: 0.80, blue: 0.40)
        public static let successActive = Color(red: 0.25, green: 0.60, blue: 0.20)

        // Warning
        public static let warning = Color(red: 0.98, green: 0.67, blue: 0.20)
        public static let warningHover = Color(red: 1.0, green: 0.78, blue: 0.40)
        public static let warningActive = Color(red: 0.85, green: 0.55, blue: 0.10)

        // Danger
        public static let danger = Color(red: 1.0, green: 0.30, blue: 0.31)
        public static let dangerHover = Color(red: 1.0, green: 0.47, blue: 0.47)
        public static let dangerActive = Color(red: 0.85, green: 0.20, blue: 0.22)

        // Info (secondary)
        public static let info = Color(red: 0.55, green: 0.55, blue: 0.55)
        public static let infoHover = Color(red: 0.65, green: 0.65, blue: 0.65)
        public static let infoActive = Color(red: 0.45, green: 0.45, blue: 0.45)

        // Default / neutral
        public static let border = Color(red: 0.85, green: 0.85, blue: 0.85)
        public static let borderHover = Color(red: 0.09, green: 0.47, blue: 1.0)
        public static let background = Color.white
        public static let backgroundHover = Color(white: 0.98)
        public static let textPrimary = Color(white: 0.13)
        public static let textSecondary = Color(white: 0.45)
        public static let textDisabled = Color(white: 0.55)
        public static let backgroundDisabled = Color(white: 0.92)
    }
}
