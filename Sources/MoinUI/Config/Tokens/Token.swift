import SwiftUI

// MARK: - Moin.Token

public extension Moin {
    struct Token {
        // MARK: - Primary Colors
        public var colorPrimary: Color
        public var colorPrimaryHover: Color
        public var colorPrimaryActive: Color
        public var colorPrimaryBg: Color
        public var colorPrimaryBorder: Color
        public var colorPrimaryBorderHover: Color

        // MARK: - Success Colors
        public var colorSuccess: Color
        public var colorSuccessHover: Color
        public var colorSuccessActive: Color
        public var colorSuccessBg: Color
        public var colorSuccessBorder: Color

        // MARK: - Warning Colors
        public var colorWarning: Color
        public var colorWarningHover: Color
        public var colorWarningActive: Color
        public var colorWarningBg: Color
        public var colorWarningBorder: Color

        // MARK: - Danger Colors
        public var colorDanger: Color
        public var colorDangerHover: Color
        public var colorDangerActive: Color
        public var colorDangerBg: Color
        public var colorDangerBorder: Color

        // MARK: - Info Colors
        public var colorInfo: Color
        public var colorInfoHover: Color
        public var colorInfoActive: Color
        public var colorInfoBg: Color
        public var colorInfoBorder: Color

        // MARK: - Link Colors
        public var colorLink: Color
        public var colorLinkHover: Color
        public var colorLinkActive: Color

        // MARK: - Text Colors
        public var colorText: Color
        public var colorTextSecondary: Color
        public var colorTextTertiary: Color
        public var colorTextQuaternary: Color
        public var colorTextLightSolid: Color  // #fff - 用于带背景色的文本
        public var colorTextPlaceholder: Color // 占位文本颜色
        public var colorTextDisabled: Color

        // MARK: - Background Colors
        public var colorBgContainer: Color
        public var colorBgElevated: Color
        public var colorBgLayout: Color
        public var colorBgSpotlight: Color
        public var colorBgMask: Color
        public var colorBgHover: Color
        public var colorBgDisabled: Color

        // MARK: - Fill Colors
        public var colorFill: Color
        public var colorFillSecondary: Color
        public var colorFillTertiary: Color
        public var colorFillQuaternary: Color

        // MARK: - Border Colors
        public var colorBorder: Color
        public var colorBorderSecondary: Color
        public var colorBorderHover: Color

        // MARK: - Border Radius
        public var borderRadius: CGFloat
        public var borderRadiusXS: CGFloat
        public var borderRadiusSM: CGFloat
        public var borderRadiusLG: CGFloat
        public var borderRadiusOuter: CGFloat

        // MARK: - Control Height
        public var controlHeight: CGFloat
        public var controlHeightXS: CGFloat
        public var controlHeightSM: CGFloat
        public var controlHeightLG: CGFloat

        // MARK: - Font Size
        public var fontSize: CGFloat
        public var fontSizeSM: CGFloat
        public var fontSizeLG: CGFloat
        public var fontSizeXL: CGFloat
        public var fontSizeHeading1: CGFloat
        public var fontSizeHeading2: CGFloat
        public var fontSizeHeading3: CGFloat
        public var fontSizeHeading4: CGFloat
        public var fontSizeHeading5: CGFloat

        // MARK: - Line Height
        public var lineHeight: CGFloat
        public var lineHeightSM: CGFloat
        public var lineHeightLG: CGFloat
        public var lineHeightHeading1: CGFloat
        public var lineHeightHeading2: CGFloat
        public var lineHeightHeading3: CGFloat
        public var lineHeightHeading4: CGFloat
        public var lineHeightHeading5: CGFloat

        // MARK: - Padding
        public var paddingXXS: CGFloat
        public var paddingXS: CGFloat
        public var paddingSM: CGFloat
        public var padding: CGFloat
        public var paddingMD: CGFloat
        public var paddingLG: CGFloat
        public var paddingXL: CGFloat

        // MARK: - Margin
        public var marginXXS: CGFloat
        public var marginXS: CGFloat
        public var marginSM: CGFloat
        public var margin: CGFloat
        public var marginMD: CGFloat
        public var marginLG: CGFloat
        public var marginXL: CGFloat
        public var marginXXL: CGFloat

        // MARK: - Line
        public var lineWidth: CGFloat
        public var lineWidthBold: CGFloat
        public var lineType: MoinLineType

        // MARK: - Motion
        public var motion: Bool
        public var motionDuration: Double
        public var motionDurationFast: Double
        public var motionDurationMid: Double
        public var motionDurationSlow: Double
        public var motionEase: MoinMotionEase

        // MARK: - Font Family
        public var fontFamily: String
        public var fontFamilyCode: String

        // MARK: - Other
        public var opacityImage: Double
        public var wireframe: Bool

        // MARK: - Z-Index
        public var zIndexBase: Int
        public var zIndexPopupBase: Int

        // MARK: - Elevation (阴影层级)
        /// 一级阴影 (按钮等低层元素)
        public var shadowRadius1: CGFloat
        public var shadowOpacity1: Double
        /// 二级阴影 (卡片、下拉菜单)
        public var shadowRadius2: CGFloat
        public var shadowOpacity2: Double
        /// 三级阴影 (弹窗、抽屉)
        public var shadowRadius3: CGFloat
        public var shadowOpacity3: Double

        public init(from map: MapToken) {
            // Primary
            self.colorPrimary = map.colorPrimary
            self.colorPrimaryHover = map.colorPrimaryHover
            self.colorPrimaryActive = map.colorPrimaryActive
            self.colorPrimaryBg = map.colorPrimaryBg
            self.colorPrimaryBorder = map.colorPrimaryBorder
            self.colorPrimaryBorderHover = map.colorPrimaryBorderHover
            // Success
            self.colorSuccess = map.colorSuccess
            self.colorSuccessHover = map.colorSuccessHover
            self.colorSuccessActive = map.colorSuccessActive
            self.colorSuccessBg = map.colorSuccessBg
            self.colorSuccessBorder = map.colorSuccessBorder
            // Warning
            self.colorWarning = map.colorWarning
            self.colorWarningHover = map.colorWarningHover
            self.colorWarningActive = map.colorWarningActive
            self.colorWarningBg = map.colorWarningBg
            self.colorWarningBorder = map.colorWarningBorder
            // Danger (Error)
            self.colorDanger = map.colorError
            self.colorDangerHover = map.colorErrorHover
            self.colorDangerActive = map.colorErrorActive
            self.colorDangerBg = map.colorErrorBg
            self.colorDangerBorder = map.colorErrorBorder
            // Info
            self.colorInfo = map.colorInfo
            self.colorInfoHover = map.colorInfoHover
            self.colorInfoActive = map.colorInfoActive
            self.colorInfoBg = map.colorInfoBg
            self.colorInfoBorder = map.colorInfoBorder
            // Link
            self.colorLink = map.colorLink
            self.colorLinkHover = map.colorLinkHover
            self.colorLinkActive = map.colorLinkActive
            // Text
            self.colorText = map.colorText
            self.colorTextSecondary = map.colorTextSecondary
            self.colorTextTertiary = map.colorTextTertiary
            self.colorTextQuaternary = map.colorTextQuaternary
            self.colorTextLightSolid = map.colorTextLightSolid
            self.colorTextPlaceholder = map.colorTextPlaceholder
            self.colorTextDisabled = map.colorTextTertiary
            // Background
            self.colorBgContainer = map.colorBgContainer
            self.colorBgElevated = map.colorBgElevated
            self.colorBgLayout = map.colorBgLayout
            self.colorBgSpotlight = map.colorBgSpotlight
            self.colorBgMask = map.colorBgMask
            self.colorBgHover = map.colorBgHover
            self.colorBgDisabled = map.colorBgDisabled
            // Fill
            self.colorFill = map.colorFill
            self.colorFillSecondary = map.colorFillSecondary
            self.colorFillTertiary = map.colorFillTertiary
            self.colorFillQuaternary = map.colorFillQuaternary
            // Border
            self.colorBorder = map.colorBorder
            self.colorBorderSecondary = map.colorBorderSecondary
            self.colorBorderHover = map.colorBorderHover
            // Border Radius
            self.borderRadius = map.borderRadius
            self.borderRadiusXS = map.borderRadiusXS
            self.borderRadiusSM = map.borderRadiusSM
            self.borderRadiusLG = map.borderRadiusLG
            self.borderRadiusOuter = map.borderRadiusOuter
            // Control Height
            self.controlHeight = map.controlHeight
            self.controlHeightXS = map.controlHeightXS
            self.controlHeightSM = map.controlHeightSM
            self.controlHeightLG = map.controlHeightLG
            // Font Size
            self.fontSize = map.fontSize
            self.fontSizeSM = map.fontSizeSM
            self.fontSizeLG = map.fontSizeLG
            self.fontSizeXL = map.fontSizeXL
            self.fontSizeHeading1 = map.fontSizeHeading1
            self.fontSizeHeading2 = map.fontSizeHeading2
            self.fontSizeHeading3 = map.fontSizeHeading3
            self.fontSizeHeading4 = map.fontSizeHeading4
            self.fontSizeHeading5 = map.fontSizeHeading5
            // Line Height
            self.lineHeight = map.lineHeight
            self.lineHeightSM = map.lineHeightSM
            self.lineHeightLG = map.lineHeightLG
            self.lineHeightHeading1 = map.lineHeightHeading1
            self.lineHeightHeading2 = map.lineHeightHeading2
            self.lineHeightHeading3 = map.lineHeightHeading3
            self.lineHeightHeading4 = map.lineHeightHeading4
            self.lineHeightHeading5 = map.lineHeightHeading5
            // Padding
            self.paddingXXS = map.paddingXXS
            self.paddingXS = map.paddingXS
            self.paddingSM = map.paddingSM
            self.padding = map.padding
            self.paddingMD = map.paddingMD
            self.paddingLG = map.paddingLG
            self.paddingXL = map.paddingXL
            // Margin
            self.marginXXS = map.marginXXS
            self.marginXS = map.marginXS
            self.marginSM = map.marginSM
            self.margin = map.margin
            self.marginMD = map.marginMD
            self.marginLG = map.marginLG
            self.marginXL = map.marginXL
            self.marginXXL = map.marginXXL
            // Line
            self.lineWidth = map.lineWidth
            self.lineWidthBold = map.lineWidthBold
            self.lineType = map.lineType
            // Motion
            self.motion = map.motion
            self.motionDuration = map.motionDuration
            self.motionDurationFast = map.motionDurationFast
            self.motionDurationMid = map.motionDurationMid
            self.motionDurationSlow = map.motionDurationSlow
            self.motionEase = map.motionEase
            // Font Family
            self.fontFamily = map.fontFamily
            self.fontFamilyCode = map.fontFamilyCode
            // Other
            self.opacityImage = map.opacityImage
            self.wireframe = map.wireframe
            // Z-Index
            self.zIndexBase = map.zIndexBase
            self.zIndexPopupBase = map.zIndexPopupBase
            // Elevation (阴影层级)
            self.shadowRadius1 = 2
            self.shadowOpacity1 = 0.08
            self.shadowRadius2 = 8
            self.shadowOpacity2 = 0.12
            self.shadowRadius3 = 16
            self.shadowOpacity3 = 0.16
        }

        public static func generate(from seed: SeedToken, theme: Theme) -> Token {
            Token(from: MapToken.generate(from: seed, theme: theme))
        }

        /// 浅色主题默认 Token
        public static let light = generate(from: .default, theme: .light)

        /// 暗色主题默认 Token
        public static let dark = generate(from: .default, theme: .dark)

        public static let `default` = light
    }
}
