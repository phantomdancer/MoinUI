import XCTest
import SwiftUI
@testable import MoinUI

final class ColorUtilsTests: XCTestCase {

    // MARK: - Darken Tests

    func testDarkenColor() {
        let color = Color(red: 0.5, green: 0.5, blue: 0.5)
        let darkened = color.darkened(by: 0.1)
        XCTAssertNotNil(darkened)
    }

    func testDarkenColorBoundary() {
        let color = Color(red: 0.05, green: 0.05, blue: 0.05)
        let darkened = color.darkened(by: 0.1)
        XCTAssertNotNil(darkened)
    }

    // MARK: - Lighten Tests

    func testLightenColor() {
        let color = Color(red: 0.5, green: 0.5, blue: 0.5)
        let lightened = color.lightened(by: 0.1)
        XCTAssertNotNil(lightened)
    }

    func testLightenColorBoundary() {
        let color = Color(red: 0.95, green: 0.95, blue: 0.95)
        let lightened = color.lightened(by: 0.1)
        XCTAssertNotNil(lightened)
    }

    // MARK: - Luminance Tests

    func testLuminanceWhite() {
        let white = Color.white
        XCTAssertGreaterThan(white.luminance, 0.5)
    }

    func testLuminanceBlack() {
        let black = Color.black
        XCTAssertLessThan(black.luminance, 0.5)
    }

    // MARK: - Contrasting Text Color Tests

    func testContrastingTextColorOnLight() {
        let lightColor = Color(red: 0.9, green: 0.9, blue: 0.9)
        let textColor = lightColor.contrastingTextColor
        XCTAssertEqual(textColor, .black)
    }

    func testContrastingTextColorOnDark() {
        let darkColor = Color(red: 0.1, green: 0.1, blue: 0.1)
        let textColor = darkColor.contrastingTextColor
        XCTAssertEqual(textColor, .white)
    }

    func testContrastingTextColorOnPrimary() {
        let primary = Color(red: 0.09, green: 0.47, blue: 1.0)
        let textColor = primary.contrastingTextColor
        XCTAssertEqual(textColor, .white)
    }

    func testContrastingTextColorOnYellow() {
        let yellow = Color(red: 1.0, green: 0.9, blue: 0.0)
        let textColor = yellow.contrastingTextColor
        XCTAssertEqual(textColor, .black)
    }
}
