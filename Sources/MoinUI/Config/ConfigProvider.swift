import SwiftUI

// MARK: - Moin.SeedToken

/// 线条样式枚举
public enum MoinLineType: String {
    case solid = "solid"
    case dashed = "dashed"
}

/// 缓动曲线枚举
public enum MoinMotionEase: String {
    case easeInOut = "easeInOut"
    case easeOut = "easeOut"
    case easeIn = "easeIn"
    case linear = "linear"
}

public extension Moin {
    /// 种子 Token - 核心可配置值，派生出完整 Token 系统
    /// 对应 Ant Design 的 SeedToken (24 个属性)
    struct SeedToken {
        // MARK: - 品牌色 (6个)
        /// 主色
        public var colorPrimary: Color
        /// 成功色
        public var colorSuccess: Color
        /// 警告色
        public var colorWarning: Color
        /// 错误色 (对应 colorDanger)
        public var colorError: Color
        /// 信息色
        public var colorInfo: Color
        /// 链接色
        public var colorLink: Color

        // MARK: - 派生基础色 (2个)
        /// 文字色派生基础
        public var colorTextBase: Color
        /// 背景色派生基础
        public var colorBgBase: Color

        // MARK: - 字体 (3个)
        /// 基础字号
        public var fontSize: CGFloat
        /// 字体族
        public var fontFamily: String
        /// 代码字体族
        public var fontFamilyCode: String

        // MARK: - 线条 (2个)
        /// 线条宽度
        public var lineWidth: CGFloat
        /// 线条样式
        public var lineType: MoinLineType

        // MARK: - 圆角 (1个)
        /// 基础圆角
        public var borderRadius: CGFloat

        // MARK: - 尺寸 (4个)
        /// 尺寸步进单位
        public var sizeUnit: CGFloat
        /// 尺寸步进
        public var sizeStep: CGFloat
        /// 弹出箭头尺寸
        public var sizePopupArrow: CGFloat
        /// 控件基础高度
        public var controlHeight: CGFloat

        // MARK: - 层级 (2个)
        /// Z轴基础值
        public var zIndexBase: Int
        /// 弹层Z轴基础值
        public var zIndexPopupBase: Int

        // MARK: - 动画 (3个)
        /// 动画开关
        public var motion: Bool
        /// 动画时长基础单位 (秒)
        public var motionUnit: Double
        /// 动画基础时长倍数
        public var motionBase: Int
        /// 缓动曲线
        public var motionEase: MoinMotionEase

        // MARK: - 其他 (2个)
        /// 图片透明度
        public var opacityImage: Double
        /// 线框模式
        public var wireframe: Bool

        public init(
            colorPrimary: Color = Moin.Colors.blue,
            colorSuccess: Color = Moin.Colors.green,
            colorWarning: Color = Moin.Colors.gold,
            colorError: Color = Moin.Colors.red,
            colorInfo: Color = Color(red: 0.55, green: 0.55, blue: 0.60),
            colorLink: Color = Moin.Colors.blue,
            colorTextBase: Color = Color(white: 0.0),
            colorBgBase: Color = Color.white,
            fontSize: CGFloat = 14,
            fontFamily: String = "-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial",
            fontFamilyCode: String = "'SFMono-Regular', Consolas, 'Liberation Mono', Menlo, Courier, monospace",
            lineWidth: CGFloat = 1,
            lineType: MoinLineType = .solid,
            borderRadius: CGFloat = 6,
            sizeUnit: CGFloat = 4,
            sizeStep: CGFloat = 4,
            sizePopupArrow: CGFloat = 16,
            controlHeight: CGFloat = 32,
            zIndexBase: Int = 0,
            zIndexPopupBase: Int = 1000,
            motion: Bool = true,
            motionUnit: Double = 0.1,
            motionBase: Int = 2,
            motionEase: MoinMotionEase = .easeInOut,
            opacityImage: Double = 1.0,
            wireframe: Bool = false
        ) {
            self.colorPrimary = colorPrimary
            self.colorSuccess = colorSuccess
            self.colorWarning = colorWarning
            self.colorError = colorError
            self.colorInfo = colorInfo
            self.colorLink = colorLink
            self.colorTextBase = colorTextBase
            self.colorBgBase = colorBgBase
            self.fontSize = fontSize
            self.fontFamily = fontFamily
            self.fontFamilyCode = fontFamilyCode
            self.lineWidth = lineWidth
            self.lineType = lineType
            self.borderRadius = borderRadius
            self.sizeUnit = sizeUnit
            self.sizeStep = sizeStep
            self.sizePopupArrow = sizePopupArrow
            self.controlHeight = controlHeight
            self.zIndexBase = zIndexBase
            self.zIndexPopupBase = zIndexPopupBase
            self.motion = motion
            self.motionUnit = motionUnit
            self.motionBase = motionBase
            self.motionEase = motionEase
            self.opacityImage = opacityImage
            self.wireframe = wireframe
        }

        public static let `default` = SeedToken()
    }
}


// MARK: - Moin.MapToken

public extension Moin {
    /// 映射 Token - 从 SeedToken 派生
    /// 对应 Ant Design 的 MapToken
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

            // 行高派生 (Ant Design 默认 1.5714)
            let lineHeight: CGFloat = 1.5714
            let lineHeightSM: CGFloat = 1.6667
            let lineHeightLG: CGFloat = 1.5
            let lineHeightHeading1: CGFloat = 1.2105
            let lineHeightHeading2: CGFloat = 1.2667
            let lineHeightHeading3: CGFloat = 1.3333
            let lineHeightHeading4: CGFloat = 1.4
            let lineHeightHeading5: CGFloat = 1.5

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


// MARK: - Moin.Token

public extension Moin {
    /// 别名 Token - 对外暴露的 API 层，从 MapToken 派生
    /// 保持现有 API 兼容，支持临时覆盖
    struct Token {
        // MARK: - Primary Colors
        public var colorPrimary: Color
        public var colorPrimaryHover: Color
        public var colorPrimaryActive: Color
        public var colorPrimaryBg: Color
        public var colorPrimaryBorder: Color

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


// MARK: - Moin.ButtonToken

public extension Moin {
    /// Button-specific token (参照 antd ComponentToken)
    struct ButtonToken {
        // MARK: - 字体
        public var fontWeight: Font.Weight
        public var iconGap: CGFloat

        // MARK: - 默认按钮
        public var defaultColor: Color
        public var defaultBg: Color
        public var defaultBorderColor: Color
        public var defaultHoverBg: Color
        public var defaultHoverColor: Color
        public var defaultHoverBorderColor: Color
        public var defaultActiveBg: Color
        public var defaultActiveColor: Color
        public var defaultActiveBorderColor: Color

        // MARK: - 主要按钮
        public var primaryColor: Color

        // MARK: - 危险按钮
        public var dangerColor: Color

        // MARK: - Ghost 按钮
        public var ghostBg: Color
        public var defaultGhostColor: Color
        public var defaultGhostBorderColor: Color

        // MARK: - Solid 按钮
        public var solidTextColor: Color

        // MARK: - Text 按钮
        public var textTextColor: Color
        public var textTextHoverColor: Color
        public var textTextActiveColor: Color
        public var textHoverBg: Color
        public var linkHoverBg: Color

        // MARK: - 内边距
        public var paddingInline: CGFloat
        public var paddingInlineLG: CGFloat
        public var paddingInlineSM: CGFloat
        public var paddingBlock: CGFloat
        public var paddingBlockLG: CGFloat
        public var paddingBlockSM: CGFloat

        // MARK: - 图标尺寸
        public var onlyIconSize: CGFloat
        public var onlyIconSizeLG: CGFloat
        public var onlyIconSizeSM: CGFloat

        // MARK: - 字体尺寸
        public var contentFontSize: CGFloat
        public var contentFontSizeLG: CGFloat
        public var contentFontSizeSM: CGFloat

        // MARK: - 行高
        public var contentLineHeight: CGFloat
        public var contentLineHeightLG: CGFloat
        public var contentLineHeightSM: CGFloat

        // MARK: - 阴影
        public var defaultShadow: String
        public var primaryShadow: String
        public var dangerShadow: String

        // MARK: - 按钮组
        public var groupBorderColor: Color

        // MARK: - 禁用态
        public var borderColorDisabled: Color
        public var defaultBgDisabled: Color
        public var dashedBgDisabled: Color

        // MARK: - 从全局 Token 生成
        public static func generate(from token: Token, isDark: Bool = false) -> ButtonToken {
            ButtonToken(
                fontWeight: .medium,
                iconGap: 6,
                defaultColor: token.colorText,
                defaultBg: token.colorBgContainer,
                defaultBorderColor: token.colorBorder,
                defaultHoverBg: token.colorBgContainer,
                defaultHoverColor: token.colorPrimaryHover,
                defaultHoverBorderColor: token.colorPrimaryHover,
                defaultActiveBg: token.colorBgContainer,
                defaultActiveColor: token.colorPrimaryActive,
                defaultActiveBorderColor: token.colorPrimaryActive,
                primaryColor: .white,
                dangerColor: .white,
                ghostBg: .clear,
                defaultGhostColor: .white,
                defaultGhostBorderColor: .white,
                solidTextColor: .white,
                textTextColor: token.colorText,
                textTextHoverColor: token.colorText,
                textTextActiveColor: token.colorText,
                textHoverBg: isDark ? Color.white.opacity(0.08) : Color.black.opacity(0.04),
                linkHoverBg: .clear,
                paddingInline: token.paddingMD - 1,
                paddingInlineLG: token.padding - 1,
                paddingInlineSM: token.paddingXS - 1,
                paddingBlock: 0,
                paddingBlockLG: 0,
                paddingBlockSM: 0,
                onlyIconSize: 16,
                onlyIconSizeLG: 18,
                onlyIconSizeSM: 14,
                contentFontSize: token.fontSize,
                contentFontSizeLG: token.fontSizeLG,
                contentFontSizeSM: token.fontSizeSM,
                contentLineHeight: token.lineHeight,
                contentLineHeightLG: token.lineHeightLG,
                contentLineHeightSM: token.lineHeightSM,
                defaultShadow: "0 2px 0 rgba(0, 0, 0, 0.02)",
                primaryShadow: "0 2px 0 rgba(5, 145, 255, 0.1)",
                dangerShadow: "0 2px 0 rgba(255, 38, 5, 0.06)",
                groupBorderColor: token.colorPrimaryHover,
                borderColorDisabled: token.colorBorder.opacity(0.5),
                defaultBgDisabled: token.colorBgDisabled,
                dashedBgDisabled: token.colorBgDisabled
            )
        }

        public static let light = generate(from: .light, isDark: false)
        public static let dark = generate(from: .dark, isDark: true)
        public static let `default` = light
    }
}


// MARK: - Moin.SpaceToken

public extension Moin {
    /// Space component token
    struct SpaceToken {
        public var sizeSmall: CGFloat
        public var sizeMedium: CGFloat
        public var sizeLarge: CGFloat

        public static func generate(from token: Token) -> SpaceToken {
            SpaceToken(
                sizeSmall: token.paddingSM,
                sizeMedium: token.padding,
                sizeLarge: token.paddingLG
            )
        }

        public static let light = generate(from: .light)
        public static let dark = generate(from: .dark)
        public static let `default` = light
    }
}


// MARK: - Moin.DividerToken

public extension Moin {
    /// Divider component token
    struct DividerToken {
        public var lineColor: Color
        public var textColor: Color
        public var fontSize: CGFloat
        public var verticalMargin: CGFloat
        public var horizontalMargin: CGFloat
        public var textPadding: CGFloat
        public var lineWidth: CGFloat
        public var dashLength: CGFloat
        public var dashGap: CGFloat

        public static func generate(from token: Token) -> DividerToken {
            DividerToken(
                lineColor: token.colorBorder,
                textColor: token.colorText,
                fontSize: token.fontSize,
                verticalMargin: token.paddingLG,
                horizontalMargin: token.paddingSM,
                textPadding: token.padding,
                lineWidth: 1,
                dashLength: 4,
                dashGap: 4
            )
        }

        public static let light = generate(from: .light)
        public static let dark = generate(from: .dark)
        public static let `default` = light
    }
}


// MARK: - Moin.TagToken

public extension Moin {
    /// Tag component token
    struct TagToken {
        /// 默认背景色
        public var defaultBg: Color
        /// 默认文字颜色
        public var defaultColor: Color
        /// 实心标签文字颜色
        public var solidTextColor: Color
        /// 边框宽度
        public var lineWidth: CGFloat

        // MARK: - 尺寸相关 Token
        /// 字号 (Large)
        public var fontSizeLG: CGFloat
        /// 字号 (Medium)
        public var fontSize: CGFloat
        /// 字号 (Small)
        public var fontSizeSM: CGFloat
        /// 图标尺寸 (Large)
        public var iconSizeLG: CGFloat
        /// 图标尺寸 (Medium)
        public var iconSize: CGFloat
        /// 图标尺寸 (Small)
        public var iconSizeSM: CGFloat
        /// 关闭图标尺寸 (Large)
        public var closeIconSizeLG: CGFloat
        /// 关闭图标尺寸 (Medium)
        public var closeIconSize: CGFloat
        /// 关闭图标尺寸 (Small)
        public var closeIconSizeSM: CGFloat
        /// 图标间距 (Large)
        public var iconGapLG: CGFloat
        /// 图标间距 (Medium)
        public var iconGap: CGFloat
        /// 图标间距 (Small)
        public var iconGapSM: CGFloat
        /// 水平内边距 (Large)
        public var paddingHLG: CGFloat
        /// 水平内边距 (Medium)
        public var paddingH: CGFloat
        /// 水平内边距 (Small)
        public var paddingHSM: CGFloat
        /// 垂直内边距 (Large)
        public var paddingVLG: CGFloat
        /// 垂直内边距 (Medium)
        public var paddingV: CGFloat
        /// 垂直内边距 (Small)
        public var paddingVSM: CGFloat

        public static func generate(from token: Token) -> TagToken {
            TagToken(
                defaultBg: token.colorFillSecondary,
                defaultColor: token.colorText,
                solidTextColor: .white,
                lineWidth: token.lineWidth,
                // 字号
                fontSizeLG: token.fontSize,
                fontSize: token.fontSizeSM,
                fontSizeSM: token.fontSizeSM - 2,
                // 图标尺寸
                iconSizeLG: 12,
                iconSize: 10,
                iconSizeSM: 8,
                // 关闭图标尺寸
                closeIconSizeLG: 9,
                closeIconSize: 8,
                closeIconSizeSM: 7,
                // 图标间距
                iconGapLG: token.paddingXS,
                iconGap: token.paddingXXS,
                iconGapSM: 2,
                // 水平内边距
                paddingHLG: token.paddingMD,
                paddingH: token.paddingSM,
                paddingHSM: token.paddingXS,
                // 垂直内边距
                paddingVLG: token.paddingXXS + 2,
                paddingV: token.paddingXXS,
                paddingVSM: 1
            )
        }

        public static let light = generate(from: .light)
        public static let dark = generate(from: .dark)
        public static let `default` = light
    }
}


// MARK: - Moin.BadgeToken

public extension Moin {
    /// Badge component token
    struct BadgeToken {
        /// 徽标高度
        public var indicatorHeight: CGFloat
        /// 小号徽标高度
        public var indicatorHeightSM: CGFloat
        /// 点状徽标尺寸
        public var dotSize: CGFloat
        /// 小号点状尺寸
        public var dotSizeSM: CGFloat
        /// 徽标文字尺寸
        public var textFontSize: CGFloat
        /// 小号文字尺寸
        public var textFontSizeSM: CGFloat
        /// 文字粗细
        public var textFontWeight: Font.Weight
        /// 状态点尺寸
        public var statusSize: CGFloat
        /// 阴影半径
        public var shadowRadius: CGFloat
        /// 阴影透明度
        public var shadowOpacity: Double
        /// 水平内边距
        public var paddingH: CGFloat
        /// 小号水平内边距
        public var paddingHSM: CGFloat
        /// 徽标文字颜色
        public var textColor: Color
        /// 徽标背景色
        public var badgeColor: Color

        public static func generate(from token: Token) -> BadgeToken {
            BadgeToken(
                indicatorHeight: 18,
                indicatorHeightSM: 14,
                dotSize: 8,
                dotSizeSM: 6,
                textFontSize: 11,
                textFontSizeSM: 10,
                textFontWeight: .medium,
                statusSize: 6,
                shadowRadius: 2,
                shadowOpacity: 0.3,
                paddingH: 6,
                paddingHSM: 4,
                textColor: .white,
                badgeColor: token.colorDanger
            )
        }

        public static let light = generate(from: .light)
        public static let dark = generate(from: .dark)
        public static let `default` = light
    }
}


// MARK: - Moin.ComponentToken

public extension Moin {
    /// Component-level tokens
    struct ComponentToken {
        public var button: Moin.ButtonToken
        public var space: Moin.SpaceToken
        public var divider: Moin.DividerToken
        public var tag: Moin.TagToken
        public var badge: Moin.BadgeToken

        public static func generate(from token: Token, isDark: Bool = false) -> ComponentToken {
            ComponentToken(
                button: .generate(from: token, isDark: isDark),
                space: .generate(from: token),
                divider: .generate(from: token),
                tag: .generate(from: token),
                badge: .generate(from: token)
            )
        }

        public static let light = generate(from: .light, isDark: false)
        public static let dark = generate(from: .dark, isDark: true)
        public static let `default` = light
    }
}


// MARK: - Moin.Config

public extension Moin {
    /// MoinUI global configuration
    struct Config {
        public var locale: Moin.Locale
        public var theme: Moin.Theme
        public var token: Moin.Token
        public var components: Moin.ComponentToken

        public static let `default` = Config(
            locale: .default,
            theme: .default,
            token: .default,
            components: .default
        )

        public init(
            locale: Moin.Locale = .default,
            theme: Moin.Theme = .default,
            token: Moin.Token = .default,
            components: Moin.ComponentToken = .default
        ) {
            self.locale = locale
            self.theme = theme
            self.token = token
            self.components = components
        }
    }
}


// MARK: - Moin.ConfigProvider

public extension Moin {
    /// MoinUI ConfigProvider - global configuration manager
    final class ConfigProvider: ObservableObject {
        public static let shared = ConfigProvider()

        /// 种子 Token - 核心可配置值
        @Published public var seed: SeedToken

        @Published public var config: Moin.Config

        /// 系统外观监听
        @Published public var systemIsDark: Bool = false

        private init() {
            self.seed = .default
            self.config = .default
            if let app = NSApp {
                self.systemIsDark = app.effectiveAppearance.bestMatch(from: [.darkAqua, .aqua]) == .darkAqua
            }
            regenerateTokens()
            observeSystemAppearance()
        }

        /// 重新生成所有 Token
        public func regenerateTokens() {
            let isDark = effectiveIsDark
            let theme: Moin.Theme = isDark ? .dark : .light
            config.token = Token.generate(from: seed, theme: theme)
            config.components = ComponentToken.generate(from: config.token, isDark: isDark)
        }

        /// 当前有效的暗色模式状态
        private var effectiveIsDark: Bool {
            switch config.theme {
            case .light: return false
            case .dark: return true
            case .system: return systemIsDark
            }
        }

        /// 监听系统外观变化
        private func observeSystemAppearance() {
            DistributedNotificationCenter.default().addObserver(
                forName: Notification.Name("AppleInterfaceThemeChangedNotification"),
                object: nil,
                queue: .main
            ) { [weak self] _ in
                self?.updateSystemAppearance()
            }
        }

        private func updateSystemAppearance() {
            if let app = NSApp {
                systemIsDark = app.effectiveAppearance.bestMatch(from: [.darkAqua, .aqua]) == .darkAqua
            }
            if config.theme == .system {
                regenerateTokens()
            }
        }

        // MARK: - Theme

        public var theme: Moin.Theme {
            get { config.theme }
            set { applyTheme(newValue) }
        }

        public var isDarkMode: Bool {
            effectiveIsDark
        }

        public func applyTheme(_ theme: Moin.Theme) {
            config.theme = theme
            if theme == .system {
                if let app = NSApp {
                    systemIsDark = app.effectiveAppearance.bestMatch(from: [.darkAqua, .aqua]) == .darkAqua
                }
            }
            regenerateTokens()
        }

        public func toggleTheme() {
            if isDarkMode {
                applyTheme(.light)
            } else {
                applyTheme(.dark)
            }
        }

        // MARK: - Seed 修改方法

        /// 设置主色
        public func setPrimaryColor(_ color: Color) {
            seed.colorPrimary = color
            regenerateTokens()
        }

        /// 设置圆角
        public func setBorderRadius(_ radius: CGFloat) {
            seed.borderRadius = radius
            regenerateTokens()
        }

        /// 设置字号
        public func setFontSize(_ size: CGFloat) {
            seed.fontSize = size
            regenerateTokens()
        }

        /// 设置控件高度
        public func setControlHeight(_ height: CGFloat) {
            seed.controlHeight = height
            regenerateTokens()
        }

        /// 配置种子 Token
        public func configureSeed(_ updates: (inout SeedToken) -> Void) {
            updates(&seed)
            regenerateTokens()
        }

        // MARK: - Convenience accessors

        public var locale: Moin.Locale {
            get { config.locale }
            set { config.locale = newValue }
        }

        public var token: Moin.Token {
            get { config.token }
            set { config.token = newValue }
        }

        public var components: Moin.ComponentToken {
            get { config.components }
            set { config.components = newValue }
        }

        /// Primary color (从 seed 读取)
        public var primaryColor: Color {
            get { seed.colorPrimary }
            set { setPrimaryColor(newValue) }
        }

        /// Border radius (从 seed 读取)
        public var borderRadius: CGFloat {
            get { seed.borderRadius }
            set { setBorderRadius(newValue) }
        }

        /// Animation duration (从 motionBase × motionUnit 派生)
        public var animationDuration: Double {
            get { Double(seed.motionBase) * seed.motionUnit }
            set {
                // 反向计算 motionBase (保持 motionUnit 不变)
                seed.motionBase = Int(round(newValue / seed.motionUnit))
                regenerateTokens()
            }
        }

        // MARK: - Translation shorthand

        public func tr(_ key: String) -> String {
            Moin.Localization.shared.tr(key, locale: config.locale)
        }

        // MARK: - Configuration methods

        public func configure(_ updates: (inout Moin.Config) -> Void) {
            var newConfig = config
            updates(&newConfig)

            if newConfig.theme != config.theme {
                applyTheme(newConfig.theme)
                return
            }

            config = newConfig
        }

        public func reset() {
            seed = .default
            config = .default
            regenerateTokens()
        }
    }
}


// MARK: - Environment Key

private struct MoinConfigProviderKey: EnvironmentKey {
    static let defaultValue = Moin.ConfigProvider.shared
}

private struct MoinTokenKey: EnvironmentKey {
    static let defaultValue = Moin.Token.default
}

private struct MoinButtonTokenKey: EnvironmentKey {
    static let defaultValue = Moin.ButtonToken.default
}

private struct MoinSpaceTokenKey: EnvironmentKey {
    static let defaultValue = Moin.SpaceToken.default
}

private struct MoinDividerTokenKey: EnvironmentKey {
    static let defaultValue = Moin.DividerToken.default
}

private struct MoinTagTokenKey: EnvironmentKey {
    static let defaultValue = Moin.TagToken.default
}

private struct MoinBadgeTokenKey: EnvironmentKey {
    static let defaultValue = Moin.BadgeToken.default
}

public extension EnvironmentValues {
    var moinConfig: Moin.ConfigProvider {
        get { self[MoinConfigProviderKey.self] }
        set { self[MoinConfigProviderKey.self] = newValue }
    }

    var moinToken: Moin.Token {
        get { self[MoinTokenKey.self] }
        set { self[MoinTokenKey.self] = newValue }
    }

    var moinButtonToken: Moin.ButtonToken {
        get { self[MoinButtonTokenKey.self] }
        set { self[MoinButtonTokenKey.self] = newValue }
    }

    var moinSpaceToken: Moin.SpaceToken {
        get { self[MoinSpaceTokenKey.self] }
        set { self[MoinSpaceTokenKey.self] = newValue }
    }

    var moinDividerToken: Moin.DividerToken {
        get { self[MoinDividerTokenKey.self] }
        set { self[MoinDividerTokenKey.self] = newValue }
    }

    var moinTagToken: Moin.TagToken {
        get { self[MoinTagTokenKey.self] }
        set { self[MoinTagTokenKey.self] = newValue }
    }

    var moinBadgeToken: Moin.BadgeToken {
        get { self[MoinBadgeTokenKey.self] }
        set { self[MoinBadgeTokenKey.self] = newValue }
    }
}

// MARK: - View Modifier

public extension View {
    func moinConfig(_ config: Moin.Config) -> some View {
        onAppear {
            Moin.ConfigProvider.shared.configure { $0 = config }
        }
        .environmentObject(Moin.ConfigProvider.shared)
    }

    func moinLocale(_ locale: Moin.Locale) -> some View {
        self.environment(\.moinLocale, locale)
            .onAppear {
                Moin.ConfigProvider.shared.locale = locale
            }
    }

    func moinPrimaryColor(_ color: Color) -> some View {
        onAppear {
            Moin.ConfigProvider.shared.setPrimaryColor(color)
        }
    }

    func moinTheme(_ theme: Moin.Theme) -> some View {
        onAppear {
            Moin.ConfigProvider.shared.applyTheme(theme)
        }
    }
}

// MARK: - Moin.ThemeRoot

public extension Moin {
    struct ThemeRoot: ViewModifier {
        @ObservedObject private var config = Moin.ConfigProvider.shared

        public init() {}

        public func body(content: Content) -> some View {
            content
                .preferredColorScheme(colorScheme)
                .environment(\.moinLocale, config.locale)
                .environment(\.moinToken, config.token)
                .environment(\.moinButtonToken, config.components.button)
                .environment(\.moinTagToken, config.components.tag)
                .environment(\.moinBadgeToken, config.components.badge)
                .environment(\.moinSpaceToken, config.components.space)
                .environment(\.moinDividerToken, config.components.divider)
                .environmentObject(config)
        }

        private var colorScheme: ColorScheme? {
            switch config.theme {
            case .light: return .light
            case .dark: return .dark
            case .system: return config.isDarkMode ? .dark : .light
            }
        }
    }
}


public extension View {
    func moinThemeRoot() -> some View {
        modifier(Moin.ThemeRoot())
    }
}
