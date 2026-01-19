import SwiftUI

// MARK: - Moin.MapToken

public extension Moin {
    struct MapToken {
        // MARK: - 色板
        public let primaryPalette: Moin.ColorPalette
        public let successPalette: Moin.ColorPalette
        public let warningPalette: Moin.ColorPalette
        public let errorPalette: Moin.ColorPalette
        public let infoPalette: Moin.ColorPalette

        // MARK: - Primary 颜色 (从色板派生)
        public var colorPrimary: Color { primaryPalette[6] }
        public var colorPrimaryHover: Color { primaryPalette[5] }
        public var colorPrimaryActive: Color { primaryPalette[7] }
        public var colorPrimaryBg: Color { primaryPalette[1] }
        public var colorPrimaryBgHover: Color { primaryPalette[2] }
        public var colorPrimaryBorder: Color { primaryPalette[3] }
        public var colorPrimaryBorderHover: Color { primaryPalette[4] }
        public var colorPrimaryText: Color { primaryPalette[6] }
        public var colorPrimaryTextHover: Color { primaryPalette[5] }
        public var colorPrimaryTextActive: Color { primaryPalette[7] }

        // MARK: - Success 颜色
        public var colorSuccess: Color { successPalette[6] }
        public var colorSuccessHover: Color { successPalette[5] }
        public var colorSuccessActive: Color { successPalette[7] }
        public var colorSuccessBg: Color { successPalette[1] }
        public var colorSuccessBorder: Color { successPalette[3] }

        // MARK: - Warning 颜色
        public var colorWarning: Color { warningPalette[6] }
        public var colorWarningHover: Color { warningPalette[5] }
        public var colorWarningActive: Color { warningPalette[7] }
        public var colorWarningBg: Color { warningPalette[1] }
        public var colorWarningBorder: Color { warningPalette[3] }

        // MARK: - Error/Danger 颜色
        public var colorError: Color { errorPalette[6] }
        public var colorErrorHover: Color { errorPalette[5] }
        public var colorErrorActive: Color { errorPalette[7] }
        public var colorErrorBg: Color { errorPalette[1] }
        public var colorErrorBorder: Color { errorPalette[3] }

        // MARK: - Info 颜色
        public var colorInfo: Color { infoPalette[6] }
        public var colorInfoHover: Color { infoPalette[5] }
        public var colorInfoActive: Color { infoPalette[7] }
        public var colorInfoBg: Color { infoPalette[1] }
        public var colorInfoBorder: Color { infoPalette[3] }

        // MARK: - 链接颜色
        public let colorLink: Color
        public let colorLinkHover: Color
        public let colorLinkActive: Color

        // MARK: - 文字颜色 (透明度梯度)
        public let colorText: Color           // 0.88
        public let colorTextSecondary: Color  // 0.65
        public let colorTextTertiary: Color   // 0.45
        public let colorTextQuaternary: Color // 0.25
        public let colorTextLightSolid: Color // #fff - 用于带背景色的文本
        public let colorTextPlaceholder: Color // 占位文本颜色

        // MARK: - 背景颜色
        public let colorBgContainer: Color
        public let colorBgElevated: Color
        public let colorBgLayout: Color
        public let colorBgSpotlight: Color
        public let colorBgMask: Color
        public let colorFill: Color
        public let colorFillSecondary: Color
        public let colorFillTertiary: Color
        public let colorFillQuaternary: Color
        public let colorBgHover: Color
        public let colorBgDisabled: Color

        // MARK: - 边框颜色
        public let colorBorder: Color
        public let colorBorderSecondary: Color
        public let colorBorderHover: Color

        // MARK: - 字体尺寸
        public let fontSize: CGFloat
        public let fontSizeSM: CGFloat
        public let fontSizeLG: CGFloat
        public let fontSizeXL: CGFloat
        public let fontSizeHeading1: CGFloat
        public let fontSizeHeading2: CGFloat
        public let fontSizeHeading3: CGFloat
        public let fontSizeHeading4: CGFloat
        public let fontSizeHeading5: CGFloat

        // MARK: - 行高
        public let lineHeight: CGFloat
        public let lineHeightSM: CGFloat
        public let lineHeightLG: CGFloat
        public let lineHeightHeading1: CGFloat
        public let lineHeightHeading2: CGFloat
        public let lineHeightHeading3: CGFloat
        public let lineHeightHeading4: CGFloat
        public let lineHeightHeading5: CGFloat

        // MARK: - 控件高度
        public let controlHeight: CGFloat
        public let controlHeightXS: CGFloat
        public let controlHeightSM: CGFloat
        public let controlHeightLG: CGFloat

        // MARK: - 圆角
        public let borderRadius: CGFloat
        public let borderRadiusXS: CGFloat
        public let borderRadiusSM: CGFloat
        public let borderRadiusLG: CGFloat
        public let borderRadiusOuter: CGFloat

        // MARK: - 内边距
        public let paddingXXS: CGFloat
        public let paddingXS: CGFloat
        public let paddingSM: CGFloat
        public let padding: CGFloat
        public let paddingMD: CGFloat
        public let paddingLG: CGFloat
        public let paddingXL: CGFloat

        // MARK: - 外边距
        public let marginXXS: CGFloat
        public let marginXS: CGFloat
        public let marginSM: CGFloat
        public let margin: CGFloat
        public let marginMD: CGFloat
        public let marginLG: CGFloat
        public let marginXL: CGFloat
        public let marginXXL: CGFloat

        // MARK: - 线条
        public let lineWidth: CGFloat
        public let lineWidthBold: CGFloat
        public let lineType: MoinLineType

        // MARK: - 动画
        public let motion: Bool
        public let motionDuration: Double
        public let motionDurationFast: Double
        public let motionDurationMid: Double
        public let motionDurationSlow: Double
        public let motionEase: MoinMotionEase

        // MARK: - 字体族
        public let fontFamily: String
        public let fontFamilyCode: String

        // MARK: - 其他
        public let opacityImage: Double
        public let wireframe: Bool

        // MARK: - 层级
        public let zIndexBase: Int
        public let zIndexPopupBase: Int

        // MARK: - 派生算法
        public static func generate(from seed: SeedToken, theme: Moin.Theme) -> MapToken {
            let isDark = (theme == .dark)
            let paletteTheme: Moin.ColorPalette.Theme = isDark ? .dark : .light
            let darkBg = Color(hex: 0x141414)

            // 生成色板
            let primaryPalette = Moin.ColorPalette.generate(
                from: seed.colorPrimary,
                theme: paletteTheme,
                backgroundColor: darkBg
            )
            let successPalette = Moin.ColorPalette.generate(
                from: seed.colorSuccess,
                theme: paletteTheme,
                backgroundColor: darkBg
            )
            let warningPalette = Moin.ColorPalette.generate(
                from: seed.colorWarning,
                theme: paletteTheme,
                backgroundColor: darkBg
            )
            let errorPalette = Moin.ColorPalette.generate(
                from: seed.colorError,
                theme: paletteTheme,
                backgroundColor: darkBg
            )
            let infoPalette = Moin.ColorPalette.generate(
                from: seed.colorInfo,
                theme: paletteTheme,
                backgroundColor: darkBg
            )

            // 链接颜色 (从 colorLink 生成)
            let linkPalette = Moin.ColorPalette.generate(
                from: seed.colorLink,
                theme: paletteTheme,
                backgroundColor: darkBg
            )
            let colorLink = linkPalette[6]
            let colorLinkHover = linkPalette[5]
            let colorLinkActive = linkPalette[7]

            // 文字颜色 (从 colorTextBase 派生，透明度梯度)
            // 注意：colorTextTertiary 提升至 0.55 以满足 WCAG AA 对比度要求
            let textBase: Color = isDark ? Color(white: 0.92) : seed.colorTextBase
            let colorText = textBase.opacity(0.88)
            let colorTextSecondary = textBase.opacity(0.65)
            let colorTextTertiary = textBase.opacity(0.55)
            let colorTextQuaternary = textBase.opacity(0.30)

            // 背景颜色 (从 colorBgBase 派生)
            let bgBase = seed.colorBgBase
            let colorBgContainer: Color = isDark ? Color(hex: 0x141414) : bgBase
            let colorBgElevated: Color = isDark ? Color(hex: 0x1f1f1f) : bgBase
            let colorBgLayout: Color = isDark ? Color(hex: 0x000000) : Color(hex: 0xf5f5f5)
            let colorBgSpotlight: Color = isDark ? Color(hex: 0x424242) : Color(white: 0, opacity: 0.85)
            let colorBgMask: Color = Color(white: 0, opacity: isDark ? 0.45 : 0.45)
            let colorBgHover: Color = isDark ? Color(white: 1, opacity: 0.08) : Color(white: 0, opacity: 0.04)
            let colorBgDisabled: Color = isDark ? Color(white: 1, opacity: 0.08) : Color(white: 0, opacity: 0.04)

            // 填充颜色
            let colorFill: Color = isDark ? Color(white: 1, opacity: 0.18) : Color(white: 0, opacity: 0.15)
            let colorFillSecondary: Color = isDark ? Color(white: 1, opacity: 0.12) : Color(white: 0, opacity: 0.06)
            let colorFillTertiary: Color = isDark ? Color(white: 1, opacity: 0.08) : Color(white: 0, opacity: 0.04)
            let colorFillQuaternary: Color = isDark ? Color(white: 1, opacity: 0.04) : Color(white: 0, opacity: 0.02)

            // 边框颜色
            let colorBorder: Color = isDark ? Color(hex: 0x424242) : Color(hex: 0xd9d9d9)
            let colorBorderSecondary: Color = isDark ? Color(hex: 0x303030) : Color(hex: 0xf0f0f0)
            let colorBorderHover: Color = primaryPalette[5]

            // 字体尺寸派生
            let fontSizeSM = seed.fontSize - 2      // 12
            let fontSizeLG = seed.fontSize + 2      // 16
            let fontSizeXL = seed.fontSize + 6      // 20
            let fontSizeHeading1: CGFloat = 38
            let fontSizeHeading2: CGFloat = 30
            let fontSizeHeading3: CGFloat = 24
            let fontSizeHeading4: CGFloat = 20
            let fontSizeHeading5: CGFloat = 16

            // 行高派生 (比率，与 Ant Design 一致: (fontSize + 8) / fontSize)
            let lineHeight: CGFloat = 1.5714          // (14 + 8) / 14
            let lineHeightSM: CGFloat = 1.6667        // (12 + 8) / 12
            let lineHeightLG: CGFloat = 1.5           // (16 + 8) / 16
            let lineHeightHeading1: CGFloat = 1.2105  // (38 + 8) / 38
            let lineHeightHeading2: CGFloat = 1.2667  // (30 + 8) / 30
            let lineHeightHeading3: CGFloat = 1.3333  // (24 + 8) / 24
            let lineHeightHeading4: CGFloat = 1.4     // (20 + 8) / 20
            let lineHeightHeading5: CGFloat = 1.5     // (16 + 8) / 16

            // 控件高度派生
            let controlHeightXS = round(seed.controlHeight * 0.5)
            let controlHeightSM = round(seed.controlHeight * 0.75)
            let controlHeightLG = round(seed.controlHeight * 1.25)

            // 圆角派生
            let borderRadiusXS = max(seed.borderRadius - 4, 1)
            let borderRadiusSM = max(seed.borderRadius - 2, 2)
            let borderRadiusLG = seed.borderRadius + 2
            let borderRadiusOuter = seed.borderRadius + 4

            // 间距派生 (基于 sizeUnit)
            let unit = seed.sizeUnit
            let paddingXXS = unit * 1       // 4
            let paddingXS = unit * 2        // 8
            let paddingSM = unit * 3        // 12
            let paddingBase = unit * 4      // 16 (派生)
            let paddingMD = unit * 5        // 20
            let paddingLG = unit * 6        // 24
            let paddingXL = unit * 8        // 32

            let marginXXS = unit * 1        // 4
            let marginXS = unit * 2         // 8
            let marginSM = unit * 3         // 12
            let marginBase = unit * 4       // 16 (派生)
            let marginMD = unit * 5         // 20
            let marginLG = unit * 6         // 24
            let marginXL = unit * 8         // 32
            let marginXXL = unit * 12       // 48

            // 线条
            let lineWidthBold = seed.lineWidth + 1

            // 动画时长派生 (motionDuration = motionBase × motionUnit)
            let motionDuration = Double(seed.motionBase) * seed.motionUnit  // 0.2s
            let motionDurationFast = motionDuration * 0.5   // 0.1s
            let motionDurationMid = motionDuration          // 0.2s
            let motionDurationSlow = motionDuration * 1.5   // 0.3s

            return MapToken(
                primaryPalette: primaryPalette,
                successPalette: successPalette,
                warningPalette: warningPalette,
                errorPalette: errorPalette,
                infoPalette: infoPalette,
                colorLink: colorLink,
                colorLinkHover: colorLinkHover,
                colorLinkActive: colorLinkActive,
                colorText: colorText,
                colorTextSecondary: colorTextSecondary,
                colorTextTertiary: colorTextTertiary,
                colorTextQuaternary: colorTextQuaternary,
                colorTextLightSolid: Color.white,
                colorTextPlaceholder: textBase.opacity(0.25),
                colorBgContainer: colorBgContainer,
                colorBgElevated: colorBgElevated,
                colorBgLayout: colorBgLayout,
                colorBgSpotlight: colorBgSpotlight,
                colorBgMask: colorBgMask,
                colorFill: colorFill,
                colorFillSecondary: colorFillSecondary,
                colorFillTertiary: colorFillTertiary,
                colorFillQuaternary: colorFillQuaternary,
                colorBgHover: colorBgHover,
                colorBgDisabled: colorBgDisabled,
                colorBorder: colorBorder,
                colorBorderSecondary: colorBorderSecondary,
                colorBorderHover: colorBorderHover,
                fontSize: seed.fontSize,
                fontSizeSM: fontSizeSM,
                fontSizeLG: fontSizeLG,
                fontSizeXL: fontSizeXL,
                fontSizeHeading1: fontSizeHeading1,
                fontSizeHeading2: fontSizeHeading2,
                fontSizeHeading3: fontSizeHeading3,
                fontSizeHeading4: fontSizeHeading4,
                fontSizeHeading5: fontSizeHeading5,
                lineHeight: lineHeight,
                lineHeightSM: lineHeightSM,
                lineHeightLG: lineHeightLG,
                lineHeightHeading1: lineHeightHeading1,
                lineHeightHeading2: lineHeightHeading2,
                lineHeightHeading3: lineHeightHeading3,
                lineHeightHeading4: lineHeightHeading4,
                lineHeightHeading5: lineHeightHeading5,
                controlHeight: seed.controlHeight,
                controlHeightXS: controlHeightXS,
                controlHeightSM: controlHeightSM,
                controlHeightLG: controlHeightLG,
                borderRadius: seed.borderRadius,
                borderRadiusXS: borderRadiusXS,
                borderRadiusSM: borderRadiusSM,
                borderRadiusLG: borderRadiusLG,
                borderRadiusOuter: borderRadiusOuter,
                paddingXXS: paddingXXS,
                paddingXS: paddingXS,
                paddingSM: paddingSM,
                padding: paddingBase,
                paddingMD: paddingMD,
                paddingLG: paddingLG,
                paddingXL: paddingXL,
                marginXXS: marginXXS,
                marginXS: marginXS,
                marginSM: marginSM,
                margin: marginBase,
                marginMD: marginMD,
                marginLG: marginLG,
                marginXL: marginXL,
                marginXXL: marginXXL,
                lineWidth: seed.lineWidth,
                lineWidthBold: lineWidthBold,
                lineType: seed.lineType,
                motion: seed.motion,
                motionDuration: motionDuration,
                motionDurationFast: motionDurationFast,
                motionDurationMid: motionDurationMid,
                motionDurationSlow: motionDurationSlow,
                motionEase: seed.motionEase,
                fontFamily: seed.fontFamily,
                fontFamilyCode: seed.fontFamilyCode,
                opacityImage: seed.opacityImage,
                wireframe: seed.wireframe,
                zIndexBase: seed.zIndexBase,
                zIndexPopupBase: seed.zIndexPopupBase
            )
        }
    }
}
