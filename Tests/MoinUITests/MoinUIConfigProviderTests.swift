import XCTest
import SwiftUI
@testable import MoinUI

final class MoinUIConfigProviderTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Reset to default before each test
        MoinUIConfigProvider.shared.reset()
    }

    // MARK: - Token Tests

    func testDefaultToken() {
        let token = MoinUIToken.default

        XCTAssertEqual(token.colorPrimary, MoinUIConstants.Colors.primary)
        XCTAssertEqual(token.colorSuccess, MoinUIConstants.Colors.success)
        XCTAssertEqual(token.colorWarning, MoinUIConstants.Colors.warning)
        XCTAssertEqual(token.colorDanger, MoinUIConstants.Colors.danger)
        XCTAssertEqual(token.colorInfo, MoinUIConstants.Colors.info)

        XCTAssertEqual(token.borderRadius, MoinUIConstants.Radius.md)
        XCTAssertEqual(token.borderRadiusLG, MoinUIConstants.Radius.lg)
        XCTAssertEqual(token.borderRadiusSM, MoinUIConstants.Radius.sm)

        XCTAssertEqual(token.controlHeight, 32)
        XCTAssertEqual(token.controlHeightLG, 40)
        XCTAssertEqual(token.controlHeightSM, 24)

        XCTAssertEqual(token.fontSize, 14)
        XCTAssertEqual(token.fontSizeLG, 16)
        XCTAssertEqual(token.fontSizeSM, 12)

        XCTAssertEqual(token.padding, MoinUIConstants.Spacing.md)
        XCTAssertEqual(token.paddingLG, MoinUIConstants.Spacing.lg)
        XCTAssertEqual(token.paddingSM, MoinUIConstants.Spacing.sm)

        XCTAssertEqual(token.motionDuration, MoinUIConstants.Duration.normal)
    }

    func testTokenModification() {
        let provider = MoinUIConfigProvider.shared

        provider.token.colorPrimary = .purple
        XCTAssertEqual(provider.token.colorPrimary, .purple)

        provider.token.borderRadius = 10
        XCTAssertEqual(provider.token.borderRadius, 10)

        provider.token.controlHeight = 36
        XCTAssertEqual(provider.token.controlHeight, 36)
    }

    // MARK: - Button Token Tests

    func testDefaultButtonToken() {
        let buttonToken = MoinUIButtonToken.default

        XCTAssertEqual(buttonToken.primaryColor, .white)
        XCTAssertEqual(buttonToken.fontWeight, .medium)
        XCTAssertEqual(buttonToken.contentFontSize, 14)
        XCTAssertEqual(buttonToken.contentFontSizeLG, 16)
        XCTAssertEqual(buttonToken.contentFontSizeSM, 12)
        XCTAssertEqual(buttonToken.iconGap, 6)
        XCTAssertEqual(buttonToken.onlyIconSize, 16)
    }

    // MARK: - Component Token Tests

    func testDefaultComponentToken() {
        let componentToken = MoinUIComponentToken.default

        XCTAssertEqual(componentToken.button.primaryColor, .white)
    }

    // MARK: - Config Tests

    func testDefaultConfig() {
        let config = MoinUIConfig.default

        XCTAssertEqual(config.locale, .zhCN)
        XCTAssertEqual(config.token.colorPrimary, MoinUIConstants.Colors.primary)
    }

    func testConfigInitializer() {
        var token = MoinUIToken.default
        token.colorPrimary = .orange

        let config = MoinUIConfig(
            locale: .enUS,
            token: token
        )

        XCTAssertEqual(config.locale, .enUS)
        XCTAssertEqual(config.token.colorPrimary, .orange)
    }

    // MARK: - ConfigProvider Tests

    func testSharedInstance() {
        let provider1 = MoinUIConfigProvider.shared
        let provider2 = MoinUIConfigProvider.shared

        XCTAssertTrue(provider1 === provider2)
    }

    func testLocaleAccessor() {
        let provider = MoinUIConfigProvider.shared

        provider.locale = .enUS
        XCTAssertEqual(provider.locale, .enUS)
        XCTAssertEqual(provider.localization.locale, .enUS)

        provider.locale = .zhCN
        XCTAssertEqual(provider.locale, .zhCN)
        XCTAssertEqual(provider.localization.locale, .zhCN)
    }

    func testPrimaryColorAccessor() {
        let provider = MoinUIConfigProvider.shared

        provider.primaryColor = .green
        XCTAssertEqual(provider.primaryColor, .green)
        XCTAssertEqual(provider.token.colorPrimary, .green)
    }

    func testBorderRadiusAccessor() {
        let provider = MoinUIConfigProvider.shared

        provider.borderRadius = 12
        XCTAssertEqual(provider.borderRadius, 12)
        XCTAssertEqual(provider.token.borderRadius, 12)
    }

    func testAnimationDurationAccessor() {
        let provider = MoinUIConfigProvider.shared

        provider.animationDuration = 0.5
        XCTAssertEqual(provider.animationDuration, 0.5)
        XCTAssertEqual(provider.token.motionDuration, 0.5)
    }

    func testConfigureMethod() {
        let provider = MoinUIConfigProvider.shared

        provider.configure { config in
            config.locale = .enUS
            config.token.colorPrimary = .pink
        }

        XCTAssertEqual(provider.locale, .enUS)
        XCTAssertEqual(provider.token.colorPrimary, .pink)
    }

    func testResetMethod() {
        let provider = MoinUIConfigProvider.shared

        // Modify some values
        provider.locale = .enUS
        provider.primaryColor = .purple
        provider.borderRadius = 20

        // Reset
        provider.reset()

        XCTAssertEqual(provider.locale, .zhCN)
        XCTAssertEqual(provider.token.colorPrimary, MoinUIConstants.Colors.primary)
        XCTAssertEqual(provider.token.borderRadius, MoinUIConstants.Radius.md)
    }

    func testTranslationShorthand() {
        let provider = MoinUIConfigProvider.shared
        provider.locale = .zhCN

        // Should return the key if translation not found
        let result = provider.tr("nonexistent.key")
        XCTAssertEqual(result, "nonexistent.key")
    }

    // MARK: - Token Accessor Tests

    func testTokenAccessor() {
        let provider = MoinUIConfigProvider.shared

        var newToken = MoinUIToken.default
        newToken.colorPrimary = .red
        newToken.borderRadius = 8

        provider.token = newToken

        XCTAssertEqual(provider.token.colorPrimary, .red)
        XCTAssertEqual(provider.token.borderRadius, 8)
    }

    func testComponentsAccessor() {
        let provider = MoinUIConfigProvider.shared

        var newComponents = MoinUIComponentToken.default
        newComponents.button.primaryColor = .black

        provider.components = newComponents

        XCTAssertEqual(provider.components.button.primaryColor, .black)
    }

    // MARK: - Theme Tests

    func testThemeAccessor() {
        let provider = MoinUIConfigProvider.shared

        provider.theme = .dark
        XCTAssertEqual(provider.theme, .dark)

        provider.theme = .light
        XCTAssertEqual(provider.theme, .light)

        provider.theme = .system
        XCTAssertEqual(provider.theme, .system)
    }

    func testApplyThemeLight() {
        let provider = MoinUIConfigProvider.shared

        provider.applyTheme(.light)

        XCTAssertEqual(provider.theme, .light)
        XCTAssertEqual(provider.token.colorPrimary, MoinUIConstants.Colors.primary)
        XCTAssertEqual(provider.token.colorBgContainer, MoinUIConstants.Colors.background)
    }

    func testApplyThemeDark() {
        let provider = MoinUIConfigProvider.shared

        provider.applyTheme(.dark)

        XCTAssertEqual(provider.theme, .dark)
        XCTAssertEqual(provider.token.colorPrimary, DarkColors.primary)
        XCTAssertEqual(provider.token.colorBgContainer, DarkColors.background)
    }

    // MARK: - System Appearance Update Test

    func testSystemAppearanceUpdate() {
        let provider = MoinUIConfigProvider.shared
        
        // 应用系统主题
        provider.applyTheme(.system)
        
        // 直接修改systemIsDark属性，然后重新应用主题来触发token更新
        provider.systemIsDark = !provider.systemIsDark
        provider.applyTheme(.system) // 重新应用主题来触发token更新
        
        // 验证token是否根据systemIsDark更新
        let expectedColor = provider.systemIsDark ? DarkColors.primary : MoinUIConstants.Colors.primary
        XCTAssertEqual(provider.token.colorPrimary, expectedColor)
    }

    func testIsDarkModeLight() {
        let provider = MoinUIConfigProvider.shared

        provider.applyTheme(.light)
        XCTAssertFalse(provider.isDarkMode)
    }

    func testIsDarkModeDark() {
        let provider = MoinUIConfigProvider.shared

        provider.applyTheme(.dark)
        XCTAssertTrue(provider.isDarkMode)
    }

    func testIsDarkModeSystem() {
        let provider = MoinUIConfigProvider.shared

        provider.applyTheme(.system)
        XCTAssertEqual(provider.isDarkMode, provider.systemIsDark)
    }

    func testToggleThemeFromLight() {
        let provider = MoinUIConfigProvider.shared

        provider.applyTheme(.light)
        provider.toggleTheme()

        XCTAssertEqual(provider.theme, .dark)
    }

    func testToggleThemeFromDark() {
        let provider = MoinUIConfigProvider.shared

        provider.applyTheme(.dark)
        provider.toggleTheme()

        XCTAssertEqual(provider.theme, .light)
    }

    func testConfigureWithThemeChange() {
        let provider = MoinUIConfigProvider.shared
        provider.applyTheme(.light)

        provider.configure { config in
            config.theme = .dark
        }

        XCTAssertEqual(provider.theme, .dark)
        XCTAssertEqual(provider.token.colorPrimary, DarkColors.primary)
    }

    func testConfigureWithLocaleChange() {
        let provider = MoinUIConfigProvider.shared
        provider.locale = .zhCN

        provider.configure { config in
            config.locale = .enUS
        }

        XCTAssertEqual(provider.locale, .enUS)
        XCTAssertEqual(provider.localization.locale, .enUS)
    }

    // MARK: - Dark Token Tests

    func testDarkToken() {
        let darkToken = MoinUIToken.dark

        XCTAssertEqual(darkToken.colorPrimary, DarkColors.primary)
        XCTAssertEqual(darkToken.colorPrimaryHover, DarkColors.primaryHover)
        XCTAssertEqual(darkToken.colorPrimaryActive, DarkColors.primaryActive)
        XCTAssertEqual(darkToken.colorSuccess, DarkColors.success)
        XCTAssertEqual(darkToken.colorWarning, DarkColors.warning)
        XCTAssertEqual(darkToken.colorDanger, DarkColors.danger)
        XCTAssertEqual(darkToken.colorInfo, DarkColors.info)
        XCTAssertEqual(darkToken.colorBgContainer, DarkColors.background)
        XCTAssertEqual(darkToken.colorBgElevated, DarkColors.backgroundElevated)
        XCTAssertEqual(darkToken.colorBgHover, DarkColors.backgroundHover)
        XCTAssertEqual(darkToken.colorText, DarkColors.textPrimary)
        XCTAssertEqual(darkToken.colorTextSecondary, DarkColors.textSecondary)
        XCTAssertEqual(darkToken.colorTextDisabled, DarkColors.textDisabled)
        XCTAssertEqual(darkToken.colorBgDisabled, DarkColors.backgroundDisabled)
        XCTAssertEqual(darkToken.colorBorder, DarkColors.border)
        XCTAssertEqual(darkToken.colorBorderHover, DarkColors.borderHover)
    }

    func testLightToken() {
        let lightToken = MoinUIToken.light

        XCTAssertEqual(lightToken.colorPrimary, MoinUIConstants.Colors.primary)
        XCTAssertEqual(lightToken.colorPrimaryHover, MoinUIConstants.Colors.primaryHover)
        XCTAssertEqual(lightToken.colorPrimaryActive, MoinUIConstants.Colors.primaryActive)
        XCTAssertEqual(lightToken.colorSuccess, MoinUIConstants.Colors.success)
        XCTAssertEqual(lightToken.colorWarning, MoinUIConstants.Colors.warning)
        XCTAssertEqual(lightToken.colorDanger, MoinUIConstants.Colors.danger)
        XCTAssertEqual(lightToken.colorInfo, MoinUIConstants.Colors.info)
        XCTAssertEqual(lightToken.colorBgContainer, MoinUIConstants.Colors.background)
        XCTAssertEqual(lightToken.colorBgHover, MoinUIConstants.Colors.backgroundHover)
        XCTAssertEqual(lightToken.colorText, MoinUIConstants.Colors.textPrimary)
        XCTAssertEqual(lightToken.colorTextSecondary, MoinUIConstants.Colors.textSecondary)
        XCTAssertEqual(lightToken.colorTextDisabled, MoinUIConstants.Colors.textDisabled)
        XCTAssertEqual(lightToken.colorBgDisabled, MoinUIConstants.Colors.backgroundDisabled)
        XCTAssertEqual(lightToken.colorBorder, MoinUIConstants.Colors.border)
        XCTAssertEqual(lightToken.colorBorderHover, MoinUIConstants.Colors.borderHover)
    }

    // MARK: - Reset Method Test

    func testReset() {
        let provider = MoinUIConfigProvider.shared
        
        // 修改配置
        provider.theme = .dark
        provider.locale = .enUS
        provider.token.colorPrimary = .purple
        
        // 重置配置
        provider.reset()
        
        // 验证配置是否恢复默认
        XCTAssertEqual(provider.theme, MoinUIConfig.default.theme)
        XCTAssertEqual(provider.locale, MoinUIConfig.default.locale)
        XCTAssertEqual(provider.token.colorPrimary, MoinUIToken.default.colorPrimary)
    }
    
    // MARK: - Translation Method Test
    
    func testTrMethod() {
        let provider = MoinUIConfigProvider.shared
        
        // 测试默认翻译
        let title = provider.tr("nav.overview")
        XCTAssertNotNil(title)
        XCTAssertFalse(title.isEmpty)
    }
    
    // MARK: - System Appearance Update Test
    
    func testUpdateSystemAppearance() {
        let provider = MoinUIConfigProvider.shared
        
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
        let config = MoinUIConfig(theme: .dark)

        XCTAssertEqual(config.theme, .dark)
    }
    
    // MARK: - View Modifier Tests
    
    func testViewModifiers() {
        // 测试moinUIConfig修饰器
        let testConfig = MoinUIConfig.default
        let _ = Text("Test")
            .moinUIConfig(testConfig)
        
        // 测试moinUILocale修饰器
        let _ = Text("Test")
            .moinUILocale(.enUS)
        
        // 测试moinUIPrimaryColor修饰器
        let _ = Text("Test")
            .moinUIPrimaryColor(.red)
        
        // 测试moinUITheme修饰器
        let _ = Text("Test")
            .moinUITheme(.dark)
    }
    
    // MARK: - Theme Root Modifier Tests
    
    func testThemeRootModifier() {
        // 测试MoinUIThemeRoot修饰器
        let _ = Text("Test")
            .modifier(MoinUIThemeRoot())
    }
    
    // MARK: - Environment Values Tests
    
    func testEnvironmentValues() {
        // 测试moinConfig环境值
        let provider = MoinUIConfigProvider.shared
        let environmentValues = EnvironmentValues()
        // 使用身份比较，检查是否是同一个实例
        XCTAssertTrue(environmentValues.moinConfig === provider)
    }
}

