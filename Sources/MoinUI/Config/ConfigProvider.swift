import SwiftUI

// MARK: - Moin.SeedToken

public extension Moin {
    /// 种子 Token - 核心可配置值，派生出完整 Token 系统
    /// 对应 Ant Design 的 SeedToken
    struct SeedToken {
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
        /// 基础字号
        public var fontSize: CGFloat
        /// 基础圆角
        public var borderRadius: CGFloat
        /// 控件基础高度
        public var controlHeight: CGFloat
        /// 基础内边距
        public var padding: CGFloat
        /// 动画时长
        public var motionDuration: Double

        public init(
            colorPrimary: Color = Moin.Colors.blue,
            colorSuccess: Color = Moin.Colors.green,
            colorWarning: Color = Moin.Colors.gold,
            colorError: Color = Moin.Colors.red,
            colorInfo: Color = Color(red: 0.55, green: 0.55, blue: 0.60),
            fontSize: CGFloat = 14,
            borderRadius: CGFloat = 6,
            controlHeight: CGFloat = 32,
            padding: CGFloat = 12,
            motionDuration: Double = 0.25
        ) {
            self.colorPrimary = colorPrimary
            self.colorSuccess = colorSuccess
            self.colorWarning = colorWarning
            self.colorError = colorError
            self.colorInfo = colorInfo
            self.fontSize = fontSize
            self.borderRadius = borderRadius
            self.controlHeight = controlHeight
            self.padding = padding
            self.motionDuration = motionDuration
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
        public var colorPrimaryBorder: Color { primaryPalette[3] }

        // MARK: - Success 颜色
        public var colorSuccess: Color { successPalette[6] }
        public var colorSuccessHover: Color { successPalette[5] }
        public var colorSuccessActive: Color { successPalette[7] }

        // MARK: - Warning 颜色
        public var colorWarning: Color { warningPalette[6] }
        public var colorWarningHover: Color { warningPalette[5] }
        public var colorWarningActive: Color { warningPalette[7] }

        // MARK: - Error/Danger 颜色
        public var colorError: Color { errorPalette[6] }
        public var colorErrorHover: Color { errorPalette[5] }
        public var colorErrorActive: Color { errorPalette[7] }

        // MARK: - Info 颜色
        public var colorInfo: Color { infoPalette[6] }
        public var colorInfoHover: Color { infoPalette[5] }
        public var colorInfoActive: Color { infoPalette[7] }

        // MARK: - 文字颜色 (透明度梯度)
        public let colorText: Color           // 0.88
        public let colorTextSecondary: Color  // 0.65
        public let colorTextTertiary: Color   // 0.45
        public let colorTextQuaternary: Color // 0.25

        // MARK: - 背景颜色
        public let colorBgContainer: Color
        public let colorBgElevated: Color
        public let colorBgHover: Color
        public let colorBgDisabled: Color

        // MARK: - 边框颜色
        public let colorBorder: Color
        public let colorBorderHover: Color

        // MARK: - 尺寸派生
        public let fontSize: CGFloat
        public let fontSizeSM: CGFloat
        public let fontSizeLG: CGFloat

        public let controlHeight: CGFloat
        public let controlHeightSM: CGFloat
        public let controlHeightLG: CGFloat

        public let borderRadius: CGFloat
        public let borderRadiusSM: CGFloat
        public let borderRadiusLG: CGFloat

        public let padding: CGFloat
        public let paddingSM: CGFloat
        public let paddingLG: CGFloat

        public let motionDuration: Double

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

            // 文字颜色 (透明度梯度)
            let textBase: Color = isDark ? Color(white: 0.92) : Color(white: 0.13)
            let colorText = textBase.opacity(0.88)
            let colorTextSecondary = textBase.opacity(0.65)
            let colorTextTertiary = textBase.opacity(0.45)
            let colorTextQuaternary = textBase.opacity(0.25)

            // 背景颜色
            let colorBgContainer: Color = isDark ? Color(hex: 0x141414) : .white
            let colorBgElevated: Color = isDark ? Color(red: 0.14, green: 0.14, blue: 0.16) : .white
            let colorBgHover: Color = isDark ? Color(red: 0.15, green: 0.15, blue: 0.17) : Color(white: 0.96)
            let colorBgDisabled: Color = isDark ? Color(white: 0.22) : Color(white: 0.96)

            // 边框颜色
            let colorBorder: Color = isDark ? Color(white: 0.25) : Color(white: 0.85)
            let colorBorderHover: Color = primaryPalette[5]

            // 尺寸派生
            let fontSizeSM = seed.fontSize - 2
            let fontSizeLG = seed.fontSize + 2

            let controlHeightSM = round(seed.controlHeight * 0.75)
            let controlHeightLG = round(seed.controlHeight * 1.25)

            let borderRadiusSM = max(seed.borderRadius - 2, 2)
            let borderRadiusLG = seed.borderRadius + 2

            let paddingSM = seed.padding - 4
            let paddingLG = seed.padding + 4

            return MapToken(
                primaryPalette: primaryPalette,
                successPalette: successPalette,
                warningPalette: warningPalette,
                errorPalette: errorPalette,
                infoPalette: infoPalette,
                colorText: colorText,
                colorTextSecondary: colorTextSecondary,
                colorTextTertiary: colorTextTertiary,
                colorTextQuaternary: colorTextQuaternary,
                colorBgContainer: colorBgContainer,
                colorBgElevated: colorBgElevated,
                colorBgHover: colorBgHover,
                colorBgDisabled: colorBgDisabled,
                colorBorder: colorBorder,
                colorBorderHover: colorBorderHover,
                fontSize: seed.fontSize,
                fontSizeSM: fontSizeSM,
                fontSizeLG: fontSizeLG,
                controlHeight: seed.controlHeight,
                controlHeightSM: controlHeightSM,
                controlHeightLG: controlHeightLG,
                borderRadius: seed.borderRadius,
                borderRadiusSM: borderRadiusSM,
                borderRadiusLG: borderRadiusLG,
                padding: seed.padding,
                paddingSM: paddingSM,
                paddingLG: paddingLG,
                motionDuration: seed.motionDuration
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

        // MARK: - Success Colors
        public var colorSuccess: Color
        public var colorSuccessHover: Color
        public var colorSuccessActive: Color

        // MARK: - Warning Colors
        public var colorWarning: Color
        public var colorWarningHover: Color
        public var colorWarningActive: Color

        // MARK: - Danger Colors
        public var colorDanger: Color
        public var colorDangerHover: Color
        public var colorDangerActive: Color

        // MARK: - Info Colors
        public var colorInfo: Color
        public var colorInfoHover: Color
        public var colorInfoActive: Color

        // MARK: - Background & Text
        public var colorBgContainer: Color
        public var colorBgElevated: Color
        public var colorBgHover: Color
        public var colorText: Color
        public var colorTextSecondary: Color
        public var colorTextDisabled: Color
        public var colorBgDisabled: Color
        public var colorBorder: Color
        public var colorBorderHover: Color

        // MARK: - Border
        public var borderRadius: CGFloat
        public var borderRadiusLG: CGFloat
        public var borderRadiusSM: CGFloat

        // MARK: - Size
        public var controlHeight: CGFloat
        public var controlHeightLG: CGFloat
        public var controlHeightSM: CGFloat

        // MARK: - Font
        public var fontSize: CGFloat
        public var fontSizeLG: CGFloat
        public var fontSizeSM: CGFloat

        // MARK: - Spacing
        public var padding: CGFloat
        public var paddingLG: CGFloat
        public var paddingSM: CGFloat

        // MARK: - Animation
        public var motionDuration: Double

        public init(from map: MapToken) {
            self.colorPrimary = map.colorPrimary
            self.colorPrimaryHover = map.colorPrimaryHover
            self.colorPrimaryActive = map.colorPrimaryActive
            self.colorSuccess = map.colorSuccess
            self.colorSuccessHover = map.colorSuccessHover
            self.colorSuccessActive = map.colorSuccessActive
            self.colorWarning = map.colorWarning
            self.colorWarningHover = map.colorWarningHover
            self.colorWarningActive = map.colorWarningActive
            self.colorDanger = map.colorError
            self.colorDangerHover = map.colorErrorHover
            self.colorDangerActive = map.colorErrorActive
            self.colorInfo = map.colorInfo
            self.colorInfoHover = map.colorInfoHover
            self.colorInfoActive = map.colorInfoActive
            self.colorBgContainer = map.colorBgContainer
            self.colorBgElevated = map.colorBgElevated
            self.colorBgHover = map.colorBgHover
            self.colorText = map.colorText
            self.colorTextSecondary = map.colorTextSecondary
            self.colorTextDisabled = map.colorTextTertiary
            self.colorBgDisabled = map.colorBgDisabled
            self.colorBorder = map.colorBorder
            self.colorBorderHover = map.colorBorderHover
            self.borderRadius = map.borderRadius
            self.borderRadiusLG = map.borderRadiusLG
            self.borderRadiusSM = map.borderRadiusSM
            self.controlHeight = map.controlHeight
            self.controlHeightLG = map.controlHeightLG
            self.controlHeightSM = map.controlHeightSM
            self.fontSize = map.fontSize
            self.fontSizeLG = map.fontSizeLG
            self.fontSizeSM = map.fontSizeSM
            self.padding = map.padding
            self.paddingLG = map.paddingLG
            self.paddingSM = map.paddingSM
            self.motionDuration = map.motionDuration
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

        // MARK: - 禁用态
        public var borderColorDisabled: Color
        public var defaultBgDisabled: Color

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
                paddingInline: token.padding + 3,
                paddingInlineLG: token.padding + 3,
                paddingInlineSM: token.paddingSM - 1,
                paddingBlock: 0,
                paddingBlockLG: 0,
                paddingBlockSM: 0,
                onlyIconSize: 16,
                onlyIconSizeLG: 18,
                onlyIconSizeSM: 14,
                contentFontSize: token.fontSize,
                contentFontSizeLG: token.fontSizeLG,
                contentFontSizeSM: token.fontSizeSM,
                borderColorDisabled: token.colorBorder.opacity(0.5),
                defaultBgDisabled: token.colorBgDisabled
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


// MARK: - Moin.ComponentToken

public extension Moin {
    /// Component-level tokens
    struct ComponentToken {
        public var button: Moin.ButtonToken
        public var space: Moin.SpaceToken
        public var divider: Moin.DividerToken

        public static func generate(from token: Token, isDark: Bool = false) -> ComponentToken {
            ComponentToken(
                button: .generate(from: token, isDark: isDark),
                space: .generate(from: token),
                divider: .generate(from: token)
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

        /// Animation duration (从 seed 读取)
        public var animationDuration: Double {
            get { seed.motionDuration }
            set {
                seed.motionDuration = newValue
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
