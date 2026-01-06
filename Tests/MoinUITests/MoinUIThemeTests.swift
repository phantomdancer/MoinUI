import XCTest
import SwiftUI
@testable import MoinUI

final class MoinUIThemeTests: XCTestCase {

    // MARK: - MoinUITheme Enum Tests

    func testThemeRawValues() {
        XCTAssertEqual(MoinUITheme.light.rawValue, "light")
        XCTAssertEqual(MoinUITheme.dark.rawValue, "dark")
        XCTAssertEqual(MoinUITheme.system.rawValue, "system")
    }

    func testThemeAllCases() {
        let allCases = MoinUITheme.allCases
        XCTAssertEqual(allCases.count, 3)
        XCTAssertTrue(allCases.contains(.light))
        XCTAssertTrue(allCases.contains(.dark))
        XCTAssertTrue(allCases.contains(.system))
    }

    func testThemeDisplayName() {
        XCTAssertEqual(MoinUITheme.light.displayName, "浅色")
        XCTAssertEqual(MoinUITheme.dark.displayName, "深色")
        XCTAssertEqual(MoinUITheme.system.displayName, "跟随系统")
    }

    func testThemeIconName() {
        XCTAssertEqual(MoinUITheme.light.iconName, "sun.max.fill")
        XCTAssertEqual(MoinUITheme.dark.iconName, "moon.fill")
        XCTAssertEqual(MoinUITheme.system.iconName, "circle.lefthalf.filled")
    }

    // MARK: - DarkColors Tests

    func testDarkColorsPrimary() {
        XCTAssertEqual(DarkColors.primary, Color(red: 0.22, green: 0.54, blue: 1.0))
        XCTAssertEqual(DarkColors.primaryHover, Color(red: 0.35, green: 0.63, blue: 1.0))
        XCTAssertEqual(DarkColors.primaryActive, Color(red: 0.15, green: 0.45, blue: 0.90))
    }

    func testDarkColorsSuccess() {
        XCTAssertEqual(DarkColors.success, Color(red: 0.40, green: 0.78, blue: 0.35))
        XCTAssertEqual(DarkColors.successHover, Color(red: 0.50, green: 0.85, blue: 0.45))
        XCTAssertEqual(DarkColors.successActive, Color(red: 0.32, green: 0.68, blue: 0.28))
    }

    func testDarkColorsWarning() {
        XCTAssertEqual(DarkColors.warning, Color(red: 1.0, green: 0.72, blue: 0.30))
        XCTAssertEqual(DarkColors.warningHover, Color(red: 1.0, green: 0.80, blue: 0.45))
        XCTAssertEqual(DarkColors.warningActive, Color(red: 0.90, green: 0.62, blue: 0.20))
    }

    func testDarkColorsDanger() {
        XCTAssertEqual(DarkColors.danger, Color(red: 1.0, green: 0.40, blue: 0.40))
        XCTAssertEqual(DarkColors.dangerHover, Color(red: 1.0, green: 0.55, blue: 0.55))
        XCTAssertEqual(DarkColors.dangerActive, Color(red: 0.90, green: 0.30, blue: 0.30))
    }

    func testDarkColorsInfo() {
        XCTAssertEqual(DarkColors.info, Color(red: 0.65, green: 0.65, blue: 0.70))
        XCTAssertEqual(DarkColors.infoHover, Color(red: 0.75, green: 0.75, blue: 0.80))
        XCTAssertEqual(DarkColors.infoActive, Color(red: 0.55, green: 0.55, blue: 0.60))
    }

    func testDarkColorsBackgroundAndText() {
        XCTAssertEqual(DarkColors.background, Color(red: 0.10, green: 0.10, blue: 0.12))
        XCTAssertEqual(DarkColors.backgroundHover, Color(red: 0.15, green: 0.15, blue: 0.17))
        XCTAssertEqual(DarkColors.backgroundElevated, Color(red: 0.14, green: 0.14, blue: 0.16))
        XCTAssertEqual(DarkColors.border, Color(white: 0.25))
        XCTAssertEqual(DarkColors.borderHover, Color(red: 0.22, green: 0.54, blue: 1.0))
        XCTAssertEqual(DarkColors.textPrimary, Color(white: 0.92))
        XCTAssertEqual(DarkColors.textSecondary, Color(white: 0.65))
        XCTAssertEqual(DarkColors.textDisabled, Color(white: 0.40))
        XCTAssertEqual(DarkColors.backgroundDisabled, Color(white: 0.18))
    }
}
