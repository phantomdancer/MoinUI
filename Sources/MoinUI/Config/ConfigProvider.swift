import SwiftUI

// MARK: - Moin.Token

public extension Moin {
    /// Global design token for component styling
    struct Token {
        // Colors
        public var colorPrimary: Color
        public var colorPrimaryHover: Color
        public var colorPrimaryActive: Color
        public var colorSuccess: Color
        public var colorWarning: Color
        public var colorDanger: Color
        public var colorInfo: Color

        // Background & Text
        public var colorBgContainer: Color
        public var colorBgElevated: Color
        public var colorBgHover: Color
        public var colorText: Color
        public var colorTextSecondary: Color
        public var colorTextDisabled: Color
        public var colorBgDisabled: Color
        public var colorBorder: Color
        public var colorBorderHover: Color

        // Border
        public var borderRadius: CGFloat
        public var borderRadiusLG: CGFloat
        public var borderRadiusSM: CGFloat

        // Size
        public var controlHeight: CGFloat
        public var controlHeightLG: CGFloat
        public var controlHeightSM: CGFloat

        // Font
        public var fontSize: CGFloat
        public var fontSizeLG: CGFloat
        public var fontSizeSM: CGFloat

        // Spacing
        public var padding: CGFloat
        public var paddingLG: CGFloat
        public var paddingSM: CGFloat

        // Animation
        public var motionDuration: Double

        /// 浅色主题默认Token
        public static let light = Token(
            colorPrimary: Moin.Constants.Colors.primary,
            colorPrimaryHover: Moin.Constants.Colors.primaryHover,
            colorPrimaryActive: Moin.Constants.Colors.primaryActive,
            colorSuccess: Moin.Constants.Colors.success,
            colorWarning: Moin.Constants.Colors.warning,
            colorDanger: Moin.Constants.Colors.danger,
            colorInfo: Moin.Constants.Colors.info,
            colorBgContainer: Moin.Constants.Colors.background,
            colorBgElevated: Color.white,
            colorBgHover: Moin.Constants.Colors.backgroundHover,
            colorText: Moin.Constants.Colors.textPrimary,
            colorTextSecondary: Moin.Constants.Colors.textSecondary,
            colorTextDisabled: Moin.Constants.Colors.textDisabled,
            colorBgDisabled: Moin.Constants.Colors.backgroundDisabled,
            colorBorder: Moin.Constants.Colors.border,
            colorBorderHover: Moin.Constants.Colors.borderHover,
            borderRadius: Moin.Constants.Radius.md,
            borderRadiusLG: Moin.Constants.Radius.lg,
            borderRadiusSM: Moin.Constants.Radius.sm,
            controlHeight: 32,
            controlHeightLG: 40,
            controlHeightSM: 24,
            fontSize: 14,
            fontSizeLG: 16,
            fontSizeSM: 12,
            padding: Moin.Constants.Spacing.md,
            paddingLG: Moin.Constants.Spacing.lg,
            paddingSM: Moin.Constants.Spacing.sm,
            motionDuration: Moin.Constants.Duration.normal
        )

        /// 暗色主题默认Token
        public static let dark = Token(
            colorPrimary: Moin.DarkColors.primary,
            colorPrimaryHover: Moin.DarkColors.primaryHover,
            colorPrimaryActive: Moin.DarkColors.primaryActive,
            colorSuccess: Moin.DarkColors.success,
            colorWarning: Moin.DarkColors.warning,
            colorDanger: Moin.DarkColors.danger,
            colorInfo: Moin.DarkColors.info,
            colorBgContainer: Moin.DarkColors.background,
            colorBgElevated: Moin.DarkColors.backgroundElevated,
            colorBgHover: Moin.DarkColors.backgroundHover,
            colorText: Moin.DarkColors.textPrimary,
            colorTextSecondary: Moin.DarkColors.textSecondary,
            colorTextDisabled: Moin.DarkColors.textDisabled,
            colorBgDisabled: Moin.DarkColors.backgroundDisabled,
            colorBorder: Moin.DarkColors.border,
            colorBorderHover: Moin.DarkColors.borderHover,
            borderRadius: Moin.Constants.Radius.md,
            borderRadiusLG: Moin.Constants.Radius.lg,
            borderRadiusSM: Moin.Constants.Radius.sm,
            controlHeight: 32,
            controlHeightLG: 40,
            controlHeightSM: 24,
            fontSize: 14,
            fontSizeLG: 16,
            fontSizeSM: 12,
            padding: Moin.Constants.Spacing.md,
            paddingLG: Moin.Constants.Spacing.lg,
            paddingSM: Moin.Constants.Spacing.sm,
            motionDuration: Moin.Constants.Duration.normal
        )

        public static let `default` = light
    }
}


// MARK: - Moin.ButtonToken

public extension Moin {
    /// Button-specific token (参照 antd ComponentToken)
    struct ButtonToken {
        // MARK: - 字体
        /// 文字字重
        public var fontWeight: Font.Weight
        /// 图标文字间距
        public var iconGap: CGFloat

        // MARK: - 默认按钮
        /// 默认按钮文本颜色
        public var defaultColor: Color
        /// 默认按钮背景色
        public var defaultBg: Color
        /// 默认按钮边框颜色
        public var defaultBorderColor: Color
        /// 默认按钮悬浮态背景色
        public var defaultHoverBg: Color
        /// 默认按钮悬浮态文本颜色
        public var defaultHoverColor: Color
        /// 默认按钮悬浮态边框颜色
        public var defaultHoverBorderColor: Color
        /// 默认按钮激活态背景色
        public var defaultActiveBg: Color
        /// 默认按钮激活态文字颜色
        public var defaultActiveColor: Color
        /// 默认按钮激活态边框颜色
        public var defaultActiveBorderColor: Color

        // MARK: - 主要按钮
        /// 主要按钮文本颜色
        public var primaryColor: Color

        // MARK: - 危险按钮
        /// 危险按钮文本颜色
        public var dangerColor: Color

        // MARK: - Ghost 按钮
        /// 幽灵按钮背景色
        public var ghostBg: Color
        /// 默认幽灵按钮文本颜色
        public var defaultGhostColor: Color
        /// 默认幽灵按钮边框颜色
        public var defaultGhostBorderColor: Color

        // MARK: - Solid 按钮
        /// 默认实心按钮的文本色
        public var solidTextColor: Color

        // MARK: - Text 按钮
        /// 默认文本按钮的文本色
        public var textTextColor: Color
        /// 默认文本按钮悬浮态文本颜色
        public var textTextHoverColor: Color
        /// 默认文本按钮激活态文字颜色
        public var textTextActiveColor: Color
        /// 文本按钮悬浮态背景色
        public var textHoverBg: Color
        /// 链接按钮悬浮态背景色
        public var linkHoverBg: Color

        // MARK: - 内边距
        /// 按钮横向内间距
        public var paddingInline: CGFloat
        /// 大号按钮横向内间距
        public var paddingInlineLG: CGFloat
        /// 小号按钮横向内间距
        public var paddingInlineSM: CGFloat
        /// 按钮纵向内间距
        public var paddingBlock: CGFloat
        /// 大号按钮纵向内间距
        public var paddingBlockLG: CGFloat
        /// 小号按钮纵向内间距
        public var paddingBlockSM: CGFloat

        // MARK: - 图标尺寸
        /// 只有图标的按钮图标尺寸
        public var onlyIconSize: CGFloat
        /// 大号只有图标的按钮图标尺寸
        public var onlyIconSizeLG: CGFloat
        /// 小号只有图标的按钮图标尺寸
        public var onlyIconSizeSM: CGFloat

        // MARK: - 字体尺寸
        /// 按钮内容字体大小
        public var contentFontSize: CGFloat
        /// 大号按钮内容字体大小
        public var contentFontSizeLG: CGFloat
        /// 小号按钮内容字体大小
        public var contentFontSizeSM: CGFloat

        // MARK: - 禁用态
        /// 禁用状态边框颜色
        public var borderColorDisabled: Color
        /// type='default' 禁用状态下的背景颜色
        public var defaultBgDisabled: Color

        // MARK: - 浅色主题默认值
        public static let light = ButtonToken(
            fontWeight: .medium,
            iconGap: Moin.Constants.Spacing.xs + 2, // 6
            defaultColor: Moin.Constants.Colors.textPrimary,
            defaultBg: Moin.Constants.Colors.background,
            defaultBorderColor: Moin.Constants.Colors.border,
            defaultHoverBg: Moin.Constants.Colors.background,
            defaultHoverColor: Moin.Constants.Colors.primaryHover,
            defaultHoverBorderColor: Moin.Constants.Colors.primaryHover,
            defaultActiveBg: Moin.Constants.Colors.background,
            defaultActiveColor: Moin.Constants.Colors.primaryActive,
            defaultActiveBorderColor: Moin.Constants.Colors.primaryActive,
            primaryColor: .white,
            dangerColor: .white,
            ghostBg: .clear,
            defaultGhostColor: .white,
            defaultGhostBorderColor: .white,
            solidTextColor: .white,
            textTextColor: Moin.Constants.Colors.textPrimary,
            textTextHoverColor: Moin.Constants.Colors.textPrimary,
            textTextActiveColor: Moin.Constants.Colors.textPrimary,
            textHoverBg: Color.black.opacity(0.04),
            linkHoverBg: .clear,
            paddingInline: Moin.Constants.Spacing.md + 3, // 15
            paddingInlineLG: Moin.Constants.Spacing.md + 3,
            paddingInlineSM: Moin.Constants.Spacing.sm - 1, // 7
            paddingBlock: 0,
            paddingBlockLG: 0,
            paddingBlockSM: 0,
            onlyIconSize: 16,
            onlyIconSizeLG: 18,
            onlyIconSizeSM: 14,
            contentFontSize: 14,
            contentFontSizeLG: 16,
            contentFontSizeSM: 12,
            borderColorDisabled: Moin.Constants.Colors.border.opacity(0.5),
            defaultBgDisabled: Moin.Constants.Colors.backgroundDisabled
        )

        // MARK: - 暗色主题默认值
        public static let dark = ButtonToken(
            fontWeight: .medium,
            iconGap: Moin.Constants.Spacing.xs + 2,
            defaultColor: Moin.DarkColors.textPrimary,
            defaultBg: Moin.DarkColors.background,
            defaultBorderColor: Moin.DarkColors.border,
            defaultHoverBg: Moin.DarkColors.background,
            defaultHoverColor: Moin.DarkColors.primaryHover,
            defaultHoverBorderColor: Moin.DarkColors.primaryHover,
            defaultActiveBg: Moin.DarkColors.background,
            defaultActiveColor: Moin.DarkColors.primaryActive,
            defaultActiveBorderColor: Moin.DarkColors.primaryActive,
            primaryColor: .white,
            dangerColor: .white,
            ghostBg: .clear,
            defaultGhostColor: .white,
            defaultGhostBorderColor: .white,
            solidTextColor: .white,
            textTextColor: Moin.DarkColors.textPrimary,
            textTextHoverColor: Moin.DarkColors.textPrimary,
            textTextActiveColor: Moin.DarkColors.textPrimary,
            textHoverBg: Color.white.opacity(0.08),
            linkHoverBg: .clear,
            paddingInline: Moin.Constants.Spacing.md + 3,
            paddingInlineLG: Moin.Constants.Spacing.md + 3,
            paddingInlineSM: Moin.Constants.Spacing.sm - 1,
            paddingBlock: 0,
            paddingBlockLG: 0,
            paddingBlockSM: 0,
            onlyIconSize: 16,
            onlyIconSizeLG: 18,
            onlyIconSizeSM: 14,
            contentFontSize: 14,
            contentFontSizeLG: 16,
            contentFontSizeSM: 12,
            borderColorDisabled: Moin.DarkColors.border.opacity(0.5),
            defaultBgDisabled: Moin.DarkColors.backgroundDisabled
        )

        public static let `default` = light
    }
}


// MARK: - Moin.ComponentToken

public extension Moin {
    /// Component-level tokens
    struct ComponentToken {
        public var button: Moin.ButtonToken

        public static let light = ComponentToken(
            button: .light
        )

        public static let dark = ComponentToken(
            button: .dark
        )

        public static let `default` = light
    }
}


// MARK: - Moin.Config

public extension Moin {
    /// MoinUI global configuration
    struct Config {
        /// Current locale
        public var locale: Moin.Locale

        /// Current theme
        public var theme: Moin.Theme

        /// Global token
        public var token: Moin.Token

        /// Component tokens
        public var components: Moin.ComponentToken

        /// Default configuration
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

        @Published public var config: Moin.Config

        /// Localization manager
        public let localization: Moin.Localization

        /// 系统外观监听
        @Published public var systemIsDark: Bool = false

        private init() {
            self.config = .default
            self.localization = Moin.Localization.shared
            if let app = NSApp {
                self.systemIsDark = app.effectiveAppearance.bestMatch(from: [.darkAqua, .aqua]) == .darkAqua
            }
            // 初始化时应用系统主题
            self.config.token = systemIsDark ? .dark : .light
            self.config.components = systemIsDark ? .dark : .light
            observeSystemAppearance()
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
                applyTheme(.system)
            }
        }

        // MARK: - Theme

        /// 当前主题
        public var theme: Moin.Theme {
            get { config.theme }
            set { applyTheme(newValue) }
        }

        /// 当前是否为暗色模式
        public var isDarkMode: Bool {
            switch config.theme {
            case .light: return false
            case .dark: return true
            case .system: return systemIsDark
            }
        }

        /// 应用主题
        public func applyTheme(_ theme: Moin.Theme) {
            config.theme = theme
            switch theme {
            case .light:
                config.token = .light
                config.components = .light
            case .dark:
                config.token = .dark
                config.components = .dark
            case .system:
                // 重新获取系统当前状态
                if let app = NSApp {
                    systemIsDark = app.effectiveAppearance.bestMatch(from: [.darkAqua, .aqua]) == .darkAqua
                }
                config.token = systemIsDark ? .dark : .light
                config.components = systemIsDark ? .dark : .light
            }
        }

        /// 切换主题（light <-> dark）
        public func toggleTheme() {
            if isDarkMode {
                applyTheme(.light)
            } else {
                applyTheme(.dark)
            }
        }

        // MARK: - Convenience accessors

        /// Current locale
        public var locale: Moin.Locale {
            get { config.locale }
            set {
                config.locale = newValue
                localization.setLocale(newValue)
            }
        }

        /// Global token
        public var token: Moin.Token {
            get { config.token }
            set { config.token = newValue }
        }

        /// Component tokens
        public var components: Moin.ComponentToken {
            get { config.components }
            set { config.components = newValue }
        }

        /// Primary color (shortcut to token.colorPrimary)
        public var primaryColor: Color {
            get { config.token.colorPrimary }
            set { config.token.colorPrimary = newValue }
        }

        /// Border radius (shortcut to token.borderRadius)
        public var borderRadius: CGFloat {
            get { config.token.borderRadius }
            set { config.token.borderRadius = newValue }
        }

        /// Animation duration (shortcut to token.motionDuration)
        public var animationDuration: Double {
            get { config.token.motionDuration }
            set { config.token.motionDuration = newValue }
        }

        // MARK: - Translation shorthand

        /// Translate string using current locale
        public func tr(_ key: String) -> String {
            localization.tr(key)
        }

        // MARK: - Configuration methods

        /// Update configuration
        public func configure(_ updates: (inout Moin.Config) -> Void) {
            var newConfig = config
            updates(&newConfig)

            // Sync locale to localization manager
            if newConfig.locale != config.locale {
                localization.setLocale(newConfig.locale)
            }

            // Sync theme
            if newConfig.theme != config.theme {
                applyTheme(newConfig.theme)
                return
            }

            config = newConfig
        }

        /// Reset to default configuration
        public func reset() {
            config = .default
            localization.setLocale(.default)
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

public extension EnvironmentValues {
    var moinConfig: Moin.ConfigProvider {
        get { self[MoinConfigProviderKey.self] }
        set { self[MoinConfigProviderKey.self] = newValue }
    }

    var moinUIToken: Moin.Token {
        get { self[MoinTokenKey.self] }
        set { self[MoinTokenKey.self] = newValue }
    }

    var moinUIButtonToken: Moin.ButtonToken {
        get { self[MoinButtonTokenKey.self] }
        set { self[MoinButtonTokenKey.self] = newValue }
    }
}

// MARK: - View Modifier

public extension View {
    /// Configure MoinUI with custom settings
    func moinUIConfig(_ config: Moin.Config) -> some View {
        onAppear {
            Moin.ConfigProvider.shared.configure { $0 = config }
        }
        .environmentObject(Moin.ConfigProvider.shared)
    }

    /// Set MoinUI locale
    func moinUILocale(_ locale: Moin.Locale) -> some View {
        onAppear {
            Moin.ConfigProvider.shared.locale = locale
        }
    }

    /// Set MoinUI primary color
    func moinUIPrimaryColor(_ color: Color) -> some View {
        onAppear {
            Moin.ConfigProvider.shared.primaryColor = color
        }
    }

    /// Set MoinUI theme
    func moinUITheme(_ theme: Moin.Theme) -> some View {
        onAppear {
            Moin.ConfigProvider.shared.applyTheme(theme)
        }
    }
}

// MARK: - Moin.ThemeRoot

public extension Moin {
    /// 主题根视图修饰器 - 应用于 App 根视图，实现全局主题切换
    struct ThemeRoot: ViewModifier {
        @ObservedObject private var config = Moin.ConfigProvider.shared

        public init() {}

        public func body(content: Content) -> some View {
            content
                .preferredColorScheme(colorScheme)
                .environment(\.moinUIToken, config.token)
                .environment(\.moinUIButtonToken, config.components.button)
                .environmentObject(config)
                .environmentObject(config.localization)
        }

        private var colorScheme: ColorScheme? {
            switch config.theme {
            case .light: return .light
            case .dark: return .dark
            // 系统主题，不能 return nil，否则会导致问题，需要返回实际的主题
            case .system: return config.isDarkMode ? .dark : .light
            }
        }
    }
}


public extension View {
    /// 应用 MoinUI 主题根修饰器，实现全局主题切换
    /// 在 App 入口使用：
    /// ```swift
    /// ContentView()
    ///     .moinUIThemeRoot()
    /// ```
    func moinUIThemeRoot() -> some View {
        modifier(Moin.ThemeRoot())
    }
}
