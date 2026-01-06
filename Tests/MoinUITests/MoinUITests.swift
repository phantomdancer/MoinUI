import Testing
import XCTest
@testable import MoinUI

@Test func example() async throws {
    // Write your test here and use APIs like `#expect(...)` to check expected conditions.
}

// MARK: - MoinUI Tests

final class MoinUIMainTests: XCTestCase {

    func testVersion() {
        let version = MoinUI.version
        XCTAssertFalse(version.isEmpty)
        // Version format: semver (e.g., 0.1.0, 1.0.0)
        let semverPattern = #"^\d+\.\d+\.\d+$"#
        XCTAssertNotNil(version.range(of: semverPattern, options: .regularExpression))
    }

    func testInit() {
        let moinUI = MoinUI()
        XCTAssertNotNil(moinUI)
    }
}
