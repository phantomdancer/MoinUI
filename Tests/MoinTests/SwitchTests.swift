import XCTest
import SwiftUI
@testable import MoinUI

final class SwitchTests: XCTestCase {
    
    func testSwitchTokenResolution() {
        let lightToken = Moin.SwitchToken.resolve(token: .light, isDark: false)
        XCTAssertEqual(lightToken.trackHeight, 22)
        XCTAssertEqual(lightToken.handleBg, .white)
        
        let darkToken = Moin.SwitchToken.resolve(token: .dark, isDark: true)
        XCTAssertEqual(darkToken.trackHeight, 22)
        XCTAssertEqual(darkToken.handleBg, Color(hex: 0x141414))
    }
    
    func testSwitchDefaults() {
        let switchView = Moin.Switch(isOn: .constant(true))
        // Verify initialization doesn't crash
        XCTAssertNotNil(switchView)
    }
}
