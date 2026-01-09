import XCTest
import SwiftUI
@testable import MoinUI

final class ConfigProviderTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Reset to default before each test
        Moin.ConfigProvider.shared.reset()
    }

    // MARK: - Token Tests

    func testTokenModification() {
        let provider = Moin.ConfigProvider.shared

        provider.token.colorPrimary = .purple
        XCTAssertEqual(provider.token.colorPrimary, .purple)

        provider.token.borderRadius = 10
        XCTAssertEqual(provider.token.borderRadius, 10)

        provider.token.controlHeight = 36
        XCTAssertEqual(provider.token.controlHeight, 36)
    }

    // MARK: - Button Token Tests

    // MARK: - Component Token Tests

    // MARK: - Config Tests

    func testDefaultConfig() {
        let config = Moin.Config.default

        XCTAssertEqual(config.locale, .zhCN)
        XCTAssertEqual(config.token.colorPrimary, Moin.Constants.Colors.primary)
    }

    func testConfigInitializer() {
        var token = Moin.Token.default
        token.colorPrimary = .orange

        let config = Moin.Config(
            locale: .enUS,
            token: token
        )

        XCTAssertEqual(config.locale, .enUS)
        XCTAssertEqual(config.token.colorPrimary, .orange)
    }

    // MARK: - ConfigProvider Tests

    func testSharedInstance() {
        let provider1 = Moin.ConfigProvider.shared
        let provider2 = Moin.ConfigProvider.shared

        XCTAssertTrue(provider1 === provider2)
    }

    func testLocaleAccessor() {
        let provider = Moin.ConfigProvider.shared

        provider.locale = .enUS
        XCTAssertEqual(provider.locale, .enUS)
        XCTAssertEqual(provider.config.locale, .enUS)

        provider.locale = .zhCN
        XCTAssertEqual(provider.locale, .zhCN)
        XCTAssertEqual(provider.config.locale, .zhCN)
    }

    func testPrimaryColorAccessor() {
        let provider = Moin.ConfigProvider.shared

        provider.primaryColor = .green
        XCTAssertEqual(provider.primaryColor, .green)
        XCTAssertEqual(provider.token.colorPrimary, .green)
    }

    func testBorderRadiusAccessor() {
        let provider = Moin.ConfigProvider.shared

        provider.borderRadius = 12
        XCTAssertEqual(provider.borderRadius, 12)
        XCTAssertEqual(provider.token.borderRadius, 12)
    }

    func testAnimationDurationAccessor() {
        let provider = Moin.ConfigProvider.shared

        provider.animationDuration = 0.5
        XCTAssertEqual(provider.animationDuration, 0.5)
        XCTAssertEqual(provider.token.motionDuration, 0.5)
    }

    func testConfigureMethod() {
        let provider = Moin.ConfigProvider.shared

        provider.configure { config in
            config.locale = .enUS
            config.token.colorPrimary = .pink
        }

        XCTAssertEqual(provider.locale, .enUS)
        XCTAssertEqual(provider.token.colorPrimary, .pink)
    }

    func testResetMethod() {
        let provider = Moin.ConfigProvider.shared

        // Modify some values
        provider.locale = .enUS
        provider.primaryColor = .purple
        provider.borderRadius = 20

        // Reset
        provider.reset()

        XCTAssertEqual(provider.locale, .zhCN)
        XCTAssertEqual(provider.token.colorPrimary, Moin.Constants.Colors.primary)
        XCTAssertEqual(provider.token.borderRadius, Moin.Constants.Radius.md)
    }

    func testTranslationShorthand() {
        let provider = Moin.ConfigProvider.shared
        provider.locale = .zhCN

        // Should return the key if translation not found
        let result = provider.tr("nonexistent.key")
        XCTAssertEqual(result, "nonexistent.key")
    }

    // MARK: - Token Accessor Tests

    func testTokenAccessor() {
        let provider = Moin.ConfigProvider.shared

        var newToken = Moin.Token.default
        newToken.colorPrimary = .red
        newToken.borderRadius = 8

        provider.token = newToken

        XCTAssertEqual(provider.token.colorPrimary, .red)
        XCTAssertEqual(provider.token.borderRadius, 8)
    }

    func testComponentsAccessor() {
        let provider = Moin.ConfigProvider.shared

        var newComponents = Moin.ComponentToken.default
        newComponents.button.primaryColor = .black

        provider.components = newComponents

        XCTAssertEqual(provider.components.button.primaryColor, .black)
    }

    // MARK: - Theme Tests

    func testThemeAccessor() {
        let provider = Moin.ConfigProvider.shared

        provider.theme = .dark
        XCTAssertEqual(provider.theme, .dark)

        provider.theme = .light
        XCTAssertEqual(provider.theme, .light)

        provider.theme = .system
        XCTAssertEqual(provider.theme, .system)
    }

    func testApplyThemeLight() {
        let provider = Moin.ConfigProvider.shared

        provider.applyTheme(.light)

        XCTAssertEqual(provider.theme, .light)
        XCTAssertEqual(provider.token.colorPrimary, Moin.Constants.Colors.primary)
        XCTAssertEqual(provider.token.colorBgContainer, Moin.Constants.Colors.background)
    }

    func testApplyThemeDark() {
        let provider = Moin.ConfigProvider.shared

        provider.applyTheme(.dark)

        XCTAssertEqual(provider.theme, .dark)
        XCTAssertEqual(provider.token.colorPrimary, Moin.DarkColors.primary)
        XCTAssertEqual(provider.token.colorBgContainer, Moin.DarkColors.background)
    }

    // MARK: - System Appearance Update Test

    func testSystemAppearanceUpdate() {
        let provider = Moin.ConfigProvider.shared
        
        // 应用系统主题
        provider.applyTheme(.system)
        
        // 直接修改systemIsDark属性，然后重新应用主题来触发token更新
        provider.systemIsDark = !provider.systemIsDark
        provider.applyTheme(.system) // 重新应用主题来触发token更新
        
        // 验证token是否根据systemIsDark更新
        let expectedColor = provider.systemIsDark ? Moin.DarkColors.primary : Moin.Constants.Colors.primary
        XCTAssertEqual(provider.token.colorPrimary, expectedColor)
    }

    func testIsDarkModeLight() {
        let provider = Moin.ConfigProvider.shared

        provider.applyTheme(.light)
        XCTAssertFalse(provider.isDarkMode)
    }

    func testIsDarkModeDark() {
        let provider = Moin.ConfigProvider.shared

        provider.applyTheme(.dark)
        XCTAssertTrue(provider.isDarkMode)
    }

    func testIsDarkModeSystem() {
        let provider = Moin.ConfigProvider.shared

        provider.applyTheme(.system)
        XCTAssertEqual(provider.isDarkMode, provider.systemIsDark)
    }

    func testToggleThemeFromLight() {
        let provider = Moin.ConfigProvider.shared

        provider.applyTheme(.light)
        provider.toggleTheme()

        XCTAssertEqual(provider.theme, .dark)
    }

    func testToggleThemeFromDark() {
        let provider = Moin.ConfigProvider.shared

        provider.applyTheme(.dark)
        provider.toggleTheme()

        XCTAssertEqual(provider.theme, .light)
    }

    func testConfigureWithThemeChange() {
        let provider = Moin.ConfigProvider.shared
        provider.applyTheme(.light)

        provider.configure { config in
            config.theme = .dark
        }

        XCTAssertEqual(provider.theme, .dark)
        XCTAssertEqual(provider.token.colorPrimary, Moin.DarkColors.primary)
    }

    func testConfigureWithLocaleChange() {
        let provider = Moin.ConfigProvider.shared
        provider.locale = .zhCN

        provider.configure { config in
            config.locale = .enUS
        }

        XCTAssertEqual(provider.locale, .enUS)
        XCTAssertEqual(provider.config.locale, .enUS)
    }

    // MARK: - Dark Token Tests

    // MARK: - Reset Method Test

    func testReset() {
        let provider = Moin.ConfigProvider.shared
        
        // 修改配置
        provider.theme = .dark
        provider.locale = .enUS
        provider.token.colorPrimary = .purple
        
        // 重置配置
        provider.reset()
        
        // 验证配置是否恢复默认
        XCTAssertEqual(provider.theme, Moin.Config.default.theme)
        XCTAssertEqual(provider.locale, Moin.Config.default.locale)
        XCTAssertEqual(provider.token.colorPrimary, Moin.Token.default.colorPrimary)
    }
    
    // MARK: - Translation Method Test
    
    func testTrMethod() {
        let provider = Moin.ConfigProvider.shared
        
        // 测试默认翻译
        let title = provider.tr("nav.overview")
        XCTAssertNotNil(title)
        XCTAssertFalse(title.isEmpty)
    }
    
    // MARK: - System Appearance Update Test
    
    func testUpdateSystemAppearance() {
        let provider = Moin.ConfigProvider.shared
        
        // 保存当前系统外观
        let currentSystemIsDark = provider.systemIsDark
        
        // 模拟系统外观更新（通过直接调用私有方法）
        // 由于是私有方法，我们可以通过设置systemIsDark属性来间接测试
        provider.systemIsDark = !currentSystemIsDark
        
        // 应用系统主题
        provider.applyTheme(.system)
        
        // 验证isDarkMode是否正确更新
        XCTAssertEqual(provider.isDarkMode, !currentSystemIsDark)
    }
    

    
    // MARK: - Config Theme Init Test

    func testConfigWithTheme() {
        let config = Moin.Config(theme: .dark)

        XCTAssertEqual(config.theme, .dark)
    }
    
    // MARK: - View Modifier Tests
    
    func testViewModifiers() {
        // 测试moinConfig修饰器
        let testConfig = Moin.Config.default
        let _ = Text("Test")
            .moinConfig(testConfig)
        
        // 测试moinLocale修饰器
        let _ = Text("Test")
            .moinLocale(.enUS)
        
        // 测试moinPrimaryColor修饰器
        let _ = Text("Test")
            .moinPrimaryColor(.red)
        
        // 测试moinTheme修饰器
        let _ = Text("Test")
            .moinTheme(.dark)
    }
    
    // MARK: - Theme Root Modifier Tests
    
    func testThemeRootModifier() {
        // 测试Moin.ThemeRoot修饰器
        let _ = Text("Test")
            .modifier(Moin.ThemeRoot())
    }
    
    // MARK: - Environment Values Tests
    
    func testEnvironmentValues() {
        // 测试moinConfig环境值
        let provider = Moin.ConfigProvider.shared
        let environmentValues = EnvironmentValues()
        // 使用身份比较，检查是否是同一个实例
        XCTAssertTrue(environmentValues.moinConfig === provider)
    }
}

