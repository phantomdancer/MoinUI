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
}
