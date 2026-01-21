import SwiftUI

// MARK: - Moin.ConfigProvider

public extension Moin {
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

private struct MoinAvatarTokenKey: EnvironmentKey {
    static let defaultValue = Moin.AvatarToken.default
}

private struct MoinEmptyTokenKey: EnvironmentKey {
    static let defaultValue = Moin.EmptyToken.default
}

private struct MoinSpinTokenKey: EnvironmentKey {
    static let defaultValue = Moin.SpinToken.default
}

private struct MoinStatisticTokenKey: EnvironmentKey {
    // We need to resolve from default token to get a valid default
    static let defaultValue = Moin.StatisticToken.resolve(token: .default)
}

private struct MoinThemeKey: EnvironmentKey {
    static let defaultValue = Moin.Theme.default
}

private struct MoinComponentsKey: EnvironmentKey {
    static let defaultValue = Moin.ComponentToken.default
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

    var moinAvatarToken: Moin.AvatarToken {
        get { self[MoinAvatarTokenKey.self] }
        set { self[MoinAvatarTokenKey.self] = newValue }
    }

    var moinEmptyToken: Moin.EmptyToken {
        get { self[MoinEmptyTokenKey.self] }
        set { self[MoinEmptyTokenKey.self] = newValue }
    }

    var moinSpinToken: Moin.SpinToken {
        get { self[MoinSpinTokenKey.self] }
        set { self[MoinSpinTokenKey.self] = newValue }
    }

    var moinStatisticToken: Moin.StatisticToken {
        get { self[MoinStatisticTokenKey.self] }
        set { self[MoinStatisticTokenKey.self] = newValue }
    }

    var moinTheme: Moin.Theme {
        get { self[MoinThemeKey.self] }
        set { self[MoinThemeKey.self] = newValue }
    }

    var moinComponents: Moin.ComponentToken {
        get { self[MoinComponentsKey.self] }
        set { self[MoinComponentsKey.self] = newValue }
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
                .environment(\.moinAvatarToken, config.components.avatar)
                .environment(\.moinEmptyToken, config.components.empty)
                .environment(\.moinSpinToken, config.components.spin)
                .environment(\.moinStatisticToken, config.components.statistic)
                .environment(\.moinSpaceToken, config.components.space)
                .environment(\.moinDividerToken, config.components.divider)
                .environment(\.moinTheme, config.theme)
                .environment(\.moinComponents, config.components)
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
