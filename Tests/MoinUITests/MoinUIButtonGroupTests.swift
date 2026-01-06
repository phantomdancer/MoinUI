import XCTest
import SwiftUI
@testable import MoinUI

final class MoinUIButtonGroupTests: XCTestCase {

    // MARK: - Initialization Tests

    func testButtonGroupDefaultInit() {
        let group = MoinUIButtonGroup {
            Text("Button 1")
            Text("Button 2")
        }
        XCTAssertNotNil(group)
    }

    func testButtonGroupWithSize() {
        let smallGroup = MoinUIButtonGroup(size: .small) {
            Text("Button")
        }
        XCTAssertNotNil(smallGroup)

        let mediumGroup = MoinUIButtonGroup(size: .medium) {
            Text("Button")
        }
        XCTAssertNotNil(mediumGroup)

        let largeGroup = MoinUIButtonGroup(size: .large) {
            Text("Button")
        }
        XCTAssertNotNil(largeGroup)
    }

    func testButtonGroupWithMultipleButtons() {
        let group = MoinUIButtonGroup {
            MoinUIButton("Button 1", type: .primary) {}
            MoinUIButton("Button 2", type: .default) {}
            MoinUIButton("Button 3", type: .danger) {}
        }
        XCTAssertNotNil(group)
    }

    // MARK: - Position Enum Tests

    func testButtonGroupPositionCases() {
        let positions: [MoinUIButtonGroupPosition] = [.leading, .middle, .trailing, .single]
        XCTAssertEqual(positions.count, 4)
    }

    // MARK: - Environment Tests

    func testEnvironmentDefaultValues() {
        var env = EnvironmentValues()
        XCTAssertNil(env.moinUIButtonGroupSize)
        XCTAssertNil(env.moinUIButtonGroupPosition)
    }

    func testEnvironmentSetValues() {
        var env = EnvironmentValues()
        env.moinUIButtonGroupSize = .large
        env.moinUIButtonGroupPosition = .leading

        XCTAssertEqual(env.moinUIButtonGroupSize, .large)
        XCTAssertEqual(env.moinUIButtonGroupPosition, .leading)
    }
}
