import SwiftUI

// MARK: - Token

/// Global design token for component styling
public struct MoinUIToken {
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
    public static let light = MoinUIToken(
        colorPrimary: MoinUIConstants.Colors.primary,
        colorPrimaryHover: MoinUIConstants.Colors.primaryHover,
        colorPrimaryActive: MoinUIConstants.Colors.primaryActive,
        colorSuccess: MoinUIConstants.Colors.success,
        colorWarning: MoinUIConstants.Colors.warning,
        colorDanger: MoinUIConstants.Colors.danger,
        colorInfo: MoinUIConstants.Colors.info,
        colorBgContainer: MoinUIConstants.Colors.background,
        colorBgElevated: Color.white,
        colorBgHover: MoinUIConstants.Colors.backgroundHover,
        colorText: MoinUIConstants.Colors.textPrimary,
        colorTextSecondary: MoinUIConstants.Colors.textSecondary,
        colorTextDisabled: MoinUIConstants.Colors.textDisabled,
        colorBgDisabled: MoinUIConstants.Colors.backgroundDisabled,
        colorBorder: MoinUIConstants.Colors.border,
        colorBorderHover: MoinUIConstants.Colors.borderHover,
        borderRadius: MoinUIConstants.Radius.md,
        borderRadiusLG: MoinUIConstants.Radius.lg,
        borderRadiusSM: MoinUIConstants.Radius.sm,
        controlHeight: 32,
        controlHeightLG: 40,
        controlHeightSM: 24,
        fontSize: 14,
        fontSizeLG: 16,
        fontSizeSM: 12,
        padding: MoinUIConstants.Spacing.md,
        paddingLG: MoinUIConstants.Spacing.lg,
        paddingSM: MoinUIConstants.Spacing.sm,
        motionDuration: MoinUIConstants.Duration.normal
    )

    /// 暗色主题默认Token
    public static let dark = MoinUIToken(
        colorPrimary: DarkColors.primary,
        colorPrimaryHover: DarkColors.primaryHover,
        colorPrimaryActive: DarkColors.primaryActive,
        colorSuccess: DarkColors.success,
        colorWarning: DarkColors.warning,
        colorDanger: DarkColors.danger,
        colorInfo: DarkColors.info,
        colorBgContainer: DarkColors.background,
        colorBgElevated: DarkColors.backgroundElevated,
        colorBgHover: DarkColors.backgroundHover,
        colorText: DarkColors.textPrimary,
        colorTextSecondary: DarkColors.textSecondary,
        colorTextDisabled: DarkColors.textDisabled,
        colorBgDisabled: DarkColors.backgroundDisabled,
        colorBorder: DarkColors.border,
        colorBorderHover: DarkColors.borderHover,
        borderRadius: MoinUIConstants.Radius.md,
        borderRadiusLG: MoinUIConstants.Radius.lg,
        borderRadiusSM: MoinUIConstants.Radius.sm,
        controlHeight: 32,
        controlHeightLG: 40,
        controlHeightSM: 24,
        fontSize: 14,
        fontSizeLG: 16,
        fontSizeSM: 12,
        padding: MoinUIConstants.Spacing.md,
        paddingLG: MoinUIConstants.Spacing.lg,
        paddingSM: MoinUIConstants.Spacing.sm,
        motionDuration: MoinUIConstants.Duration.normal
    )

    public static let `default` = light
}

// MARK: - Button Token

/// Button-specific token
public struct MoinUIButtonToken {
    public var defaultBg: Color
    public var defaultBorderColor: Color
    public var defaultColor: Color
    public var primaryColor: Color
    public var fontWeight: Font.Weight
    public var contentFontSize: CGFloat?
    public var contentFontSizeLG: CGFloat?
    public var contentFontSizeSM: CGFloat?

    public static let `default` = MoinUIButtonToken(
        defaultBg: Color(nsColor: .controlBackgroundColor),
        defaultBorderColor: Color.gray.opacity(0.3),
        defaultColor: Color.primary,
        primaryColor: .white,
        fontWeight: .medium,
        contentFontSize: nil,
        contentFontSizeLG: nil,
        contentFontSizeSM: nil
    )
}

// MARK: - Component Token

/// Component-level tokens
public struct MoinUIComponentToken {
    public var button: MoinUIButtonToken

    public static let `default` = MoinUIComponentToken(
        button: .default
    )
}

// MARK: - Config

/// MoinUI global configuration
public struct MoinUIConfig {
    /// Current locale
    public var locale: MoinUILocale

    /// Current theme
    public var theme: MoinUITheme

    /// Global token
    public var token: MoinUIToken

    /// Component tokens
    public var components: MoinUIComponentToken

    /// Default configuration
    public static let `default` = MoinUIConfig(
        locale: .default,
        theme: .default,
        token: .default,
        components: .default
    )

    public init(
        locale: MoinUILocale = .default,
        theme: MoinUITheme = .default,
        token: MoinUIToken = .default,
        components: MoinUIComponentToken = .default
    ) {
        self.locale = locale
        self.theme = theme
        self.token = token
        self.components = components
    }
}

/// MoinUI ConfigProvider - global configuration manager
public final class MoinUIConfigProvider: ObservableObject {
    public static let shared = MoinUIConfigProvider()

    @Published public var config: MoinUIConfig

    /// Localization manager
    public let localization: MoinUILocalization

    /// 系统外观监听
    @Published public var systemIsDark: Bool = false

    private init() {
        self.config = .default
        self.localization = MoinUILocalization.shared
        if let app = NSApp {
            self.systemIsDark = app.effectiveAppearance.bestMatch(from: [.darkAqua, .aqua]) == .darkAqua
        }
        // 初始化时应用系统主题
        self.config.token = systemIsDark ? .dark : .light
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
    public var theme: MoinUITheme {
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
    public func applyTheme(_ theme: MoinUITheme) {
        config.theme = theme
        switch theme {
        case .light:
            config.token = .light
        case .dark:
            config.token = .dark
        case .system:
            // 重新获取系统当前状态
            if let app = NSApp {
                systemIsDark = app.effectiveAppearance.bestMatch(from: [.darkAqua, .aqua]) == .darkAqua
            }
            config.token = systemIsDark ? .dark : .light
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
    public var locale: MoinUILocale {
        get { config.locale }
        set {
            config.locale = newValue
            localization.setLocale(newValue)
        }
    }

    /// Global token
    public var token: MoinUIToken {
        get { config.token }
        set { config.token = newValue }
    }

    /// Component tokens
    public var components: MoinUIComponentToken {
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
    public func configure(_ updates: (inout MoinUIConfig) -> Void) {
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

// MARK: - Environment Key

private struct MoinUIConfigProviderKey: EnvironmentKey {
    static let defaultValue = MoinUIConfigProvider.shared
}

public extension EnvironmentValues {
    var moinConfig: MoinUIConfigProvider {
        get { self[MoinUIConfigProviderKey.self] }
        set { self[MoinUIConfigProviderKey.self] = newValue }
    }
}

// MARK: - View Modifier

public extension View {
    /// Configure MoinUI with custom settings
    func moinUIConfig(_ config: MoinUIConfig) -> some View {
        onAppear {
            MoinUIConfigProvider.shared.configure { $0 = config }
        }
        .environmentObject(MoinUIConfigProvider.shared)
    }

    /// Set MoinUI locale
    func moinUILocale(_ locale: MoinUILocale) -> some View {
        onAppear {
            MoinUIConfigProvider.shared.locale = locale
        }
    }

    /// Set MoinUI primary color
    func moinUIPrimaryColor(_ color: Color) -> some View {
        onAppear {
            MoinUIConfigProvider.shared.primaryColor = color
        }
    }

    /// Set MoinUI theme
    func moinUITheme(_ theme: MoinUITheme) -> some View {
        onAppear {
            MoinUIConfigProvider.shared.applyTheme(theme)
        }
    }
}

// MARK: - Theme Root Modifier

/// 主题根视图修饰器 - 应用于 App 根视图，实现全局主题切换
public struct MoinUIThemeRoot: ViewModifier {
    @ObservedObject private var config = MoinUIConfigProvider.shared

    public init() {}

    public func body(content: Content) -> some View {
        content
            .preferredColorScheme(colorScheme)
            .environmentObject(config)
            .environmentObject(config.localization)
    }

    private var colorScheme: ColorScheme? {
        switch config.theme {
        case .light: return .light
        case .dark: return .dark
        case .system: return config.isDarkMode ? .dark : .light
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
        modifier(MoinUIThemeRoot())
    }
}
