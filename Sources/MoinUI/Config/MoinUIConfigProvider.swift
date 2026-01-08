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

/// Button-specific token (参照 antd ComponentToken)
public struct MoinUIButtonToken {
    // MARK: - 字体
    /// 文字字重
    public var fontWeight: Font.Weight
    /// 图标文字间距
    public var iconGap: CGFloat

    // MARK: - 阴影
    /// 默认按钮阴影
    public var defaultShadow: String
    /// 主要按钮阴影
    public var primaryShadow: String
    /// 危险按钮阴影
    public var dangerShadow: String

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
    public static let light = MoinUIButtonToken(
        fontWeight: .medium,
        iconGap: MoinUIConstants.Spacing.xs + 2, // 6
        defaultShadow: "",
        primaryShadow: "",
        dangerShadow: "",
        defaultColor: MoinUIConstants.Colors.textPrimary,
        defaultBg: MoinUIConstants.Colors.background,
        defaultBorderColor: MoinUIConstants.Colors.border,
        defaultHoverBg: MoinUIConstants.Colors.background,
        defaultHoverColor: MoinUIConstants.Colors.primaryHover,
        defaultHoverBorderColor: MoinUIConstants.Colors.primaryHover,
        defaultActiveBg: MoinUIConstants.Colors.background,
        defaultActiveColor: MoinUIConstants.Colors.primaryActive,
        defaultActiveBorderColor: MoinUIConstants.Colors.primaryActive,
        primaryColor: .white,
        dangerColor: .white,
        ghostBg: .clear,
        defaultGhostColor: .white,
        defaultGhostBorderColor: .white,
        solidTextColor: .white,
        textTextColor: MoinUIConstants.Colors.textPrimary,
        textTextHoverColor: MoinUIConstants.Colors.textPrimary,
        textTextActiveColor: MoinUIConstants.Colors.textPrimary,
        textHoverBg: Color.black.opacity(0.04),
        linkHoverBg: .clear,
        paddingInline: MoinUIConstants.Spacing.md + 3, // 15
        paddingInlineLG: MoinUIConstants.Spacing.md + 3,
        paddingInlineSM: MoinUIConstants.Spacing.sm - 1, // 7
        paddingBlock: 0,
        paddingBlockLG: 0,
        paddingBlockSM: 0,
        onlyIconSize: 16,
        onlyIconSizeLG: 18,
        onlyIconSizeSM: 14,
        contentFontSize: 14,
        contentFontSizeLG: 16,
        contentFontSizeSM: 12,
        borderColorDisabled: MoinUIConstants.Colors.border.opacity(0.5),
        defaultBgDisabled: MoinUIConstants.Colors.backgroundDisabled
    )

    // MARK: - 暗色主题默认值
    public static let dark = MoinUIButtonToken(
        fontWeight: .medium,
        iconGap: MoinUIConstants.Spacing.xs + 2,
        defaultShadow: "",
        primaryShadow: "",
        dangerShadow: "",
        defaultColor: DarkColors.textPrimary,
        defaultBg: DarkColors.background,
        defaultBorderColor: DarkColors.border,
        defaultHoverBg: DarkColors.background,
        defaultHoverColor: DarkColors.primaryHover,
        defaultHoverBorderColor: DarkColors.primaryHover,
        defaultActiveBg: DarkColors.background,
        defaultActiveColor: DarkColors.primaryActive,
        defaultActiveBorderColor: DarkColors.primaryActive,
        primaryColor: .white,
        dangerColor: .white,
        ghostBg: .clear,
        defaultGhostColor: .white,
        defaultGhostBorderColor: .white,
        solidTextColor: .white,
        textTextColor: DarkColors.textPrimary,
        textTextHoverColor: DarkColors.textPrimary,
        textTextActiveColor: DarkColors.textPrimary,
        textHoverBg: Color.white.opacity(0.08),
        linkHoverBg: .clear,
        paddingInline: MoinUIConstants.Spacing.md + 3,
        paddingInlineLG: MoinUIConstants.Spacing.md + 3,
        paddingInlineSM: MoinUIConstants.Spacing.sm - 1,
        paddingBlock: 0,
        paddingBlockLG: 0,
        paddingBlockSM: 0,
        onlyIconSize: 16,
        onlyIconSizeLG: 18,
        onlyIconSizeSM: 14,
        contentFontSize: 14,
        contentFontSizeLG: 16,
        contentFontSizeSM: 12,
        borderColorDisabled: DarkColors.border.opacity(0.5),
        defaultBgDisabled: DarkColors.backgroundDisabled
    )

    public static let `default` = light
}

// MARK: - Component Token

/// Component-level tokens
public struct MoinUIComponentToken {
    public var button: MoinUIButtonToken

    public static let light = MoinUIComponentToken(
        button: .light
    )

    public static let dark = MoinUIComponentToken(
        button: .dark
    )

    public static let `default` = light
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
