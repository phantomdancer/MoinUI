import XCTest
import SwiftUI
@testable import MoinUI

final class MoinUIButtonTests: XCTestCase {

    // MARK: - Type Tests

    func testButtonTypeBackgroundColors() {
        XCTAssertEqual(MoinUIButtonType.default.backgroundColor, Constants.Colors.background)
        XCTAssertEqual(MoinUIButtonType.primary.backgroundColor, Constants.Colors.primary)
        XCTAssertEqual(MoinUIButtonType.success.backgroundColor, Constants.Colors.success)
        XCTAssertEqual(MoinUIButtonType.warning.backgroundColor, Constants.Colors.warning)
        XCTAssertEqual(MoinUIButtonType.danger.backgroundColor, Constants.Colors.danger)
        XCTAssertEqual(MoinUIButtonType.info.backgroundColor, Constants.Colors.info)
    }

    func testButtonTypeHoverColors() {
        XCTAssertEqual(MoinUIButtonType.default.hoverBackgroundColor, Constants.Colors.backgroundHover)
        XCTAssertEqual(MoinUIButtonType.primary.hoverBackgroundColor, Constants.Colors.primaryHover)
        XCTAssertEqual(MoinUIButtonType.success.hoverBackgroundColor, Constants.Colors.successHover)
        XCTAssertEqual(MoinUIButtonType.warning.hoverBackgroundColor, Constants.Colors.warningHover)
        XCTAssertEqual(MoinUIButtonType.danger.hoverBackgroundColor, Constants.Colors.dangerHover)
        XCTAssertEqual(MoinUIButtonType.info.hoverBackgroundColor, Constants.Colors.infoHover)
    }

    func testButtonTypeActiveColors() {
        XCTAssertEqual(MoinUIButtonType.default.activeBackgroundColor, Constants.Colors.background)
        XCTAssertEqual(MoinUIButtonType.primary.activeBackgroundColor, Constants.Colors.primaryActive)
        XCTAssertEqual(MoinUIButtonType.success.activeBackgroundColor, Constants.Colors.successActive)
        XCTAssertEqual(MoinUIButtonType.warning.activeBackgroundColor, Constants.Colors.warningActive)
        XCTAssertEqual(MoinUIButtonType.danger.activeBackgroundColor, Constants.Colors.dangerActive)
        XCTAssertEqual(MoinUIButtonType.info.activeBackgroundColor, Constants.Colors.infoActive)
    }

    func testButtonTypeForegroundColors() {
        XCTAssertEqual(MoinUIButtonType.default.foregroundColor, Constants.Colors.textPrimary)
        XCTAssertEqual(MoinUIButtonType.primary.foregroundColor, Color.white)
        XCTAssertEqual(MoinUIButtonType.success.foregroundColor, Color.white)
        XCTAssertEqual(MoinUIButtonType.warning.foregroundColor, Color.white)
        XCTAssertEqual(MoinUIButtonType.danger.foregroundColor, Color.white)
        XCTAssertEqual(MoinUIButtonType.info.foregroundColor, Color.white)
    }

    func testButtonTypeBorderColors() {
        XCTAssertEqual(MoinUIButtonType.default.borderColor, Constants.Colors.border)
        XCTAssertEqual(MoinUIButtonType.primary.borderColor, Color.clear)
        XCTAssertEqual(MoinUIButtonType.success.borderColor, Color.clear)
    }

    // MARK: - Size Tests

    func testButtonSizeHeights() {
        XCTAssertEqual(MoinUIButtonSize.small.height, Constants.Button.heightSm)
        XCTAssertEqual(MoinUIButtonSize.medium.height, Constants.Button.heightMd)
        XCTAssertEqual(MoinUIButtonSize.large.height, Constants.Button.heightLg)
    }

    func testButtonSizePaddings() {
        XCTAssertEqual(MoinUIButtonSize.small.horizontalPadding, Constants.Button.paddingHorizontalSm)
        XCTAssertEqual(MoinUIButtonSize.medium.horizontalPadding, Constants.Button.paddingHorizontalMd)
        XCTAssertEqual(MoinUIButtonSize.large.horizontalPadding, Constants.Button.paddingHorizontalLg)
    }

    func testButtonSizeFontSizes() {
        XCTAssertEqual(MoinUIButtonSize.small.fontSize, Constants.Button.fontSizeSm)
        XCTAssertEqual(MoinUIButtonSize.medium.fontSize, Constants.Button.fontSizeMd)
        XCTAssertEqual(MoinUIButtonSize.large.fontSize, Constants.Button.fontSizeLg)
    }

    func testButtonSizeIconSizes() {
        XCTAssertEqual(MoinUIButtonSize.small.iconSize, Constants.Button.iconSizeSm)
        XCTAssertEqual(MoinUIButtonSize.medium.iconSize, Constants.Button.iconSizeMd)
        XCTAssertEqual(MoinUIButtonSize.large.iconSize, Constants.Button.iconSizeLg)
    }

    func testButtonSizeCornerRadius() {
        XCTAssertEqual(MoinUIButtonSize.small.cornerRadius, Constants.Radius.sm)
        XCTAssertEqual(MoinUIButtonSize.medium.cornerRadius, Constants.Radius.md)
        XCTAssertEqual(MoinUIButtonSize.large.cornerRadius, Constants.Radius.lg)
    }

    // MARK: - Variant Tests

    func testButtonVariantCases() {
        let variants: [MoinUIButtonVariant] = [.solid, .outline, .text, .link, .ghost]
        XCTAssertEqual(variants.count, 5)
    }

    // MARK: - Shape Tests

    func testButtonShapeCases() {
        let shapes: [MoinUIButtonShape] = [.default, .round, .circle]
        XCTAssertEqual(shapes.count, 3)
    }

    // MARK: - Button Initialization Tests

    func testButtonTextInitializer() {
        var actionCalled = false
        let button = MoinUIButton("Test") {
            actionCalled = true
        }
        XCTAssertNotNil(button)
        XCTAssertFalse(actionCalled)
    }

    func testButtonWithAllParameters() {
        let button = MoinUIButton(
            "Test",
            type: .primary,
            size: .large,
            variant: .outline,
            shape: .round,
            isLoading: false,
            isDisabled: false,
            isBlock: true
        ) {}
        XCTAssertNotNil(button)
    }

    func testButtonIconInitializer() {
        let button = MoinUIButton(
            icon: "plus",
            type: .primary,
            size: .medium
        ) {}
        XCTAssertNotNil(button)
    }

    func testButtonCustomLabelInitializer() {
        let button = MoinUIButton(
            type: .success,
            size: .small,
            variant: .solid,
            shape: .default,
            isLoading: false,
            isDisabled: false,
            isBlock: false,
            action: {}
        ) {
            HStack {
                Image(systemName: "star")
                Text("Custom")
            }
        }
        XCTAssertNotNil(button)
    }

    // MARK: - Constants Tests

    func testButtonConstants() {
        XCTAssertEqual(Constants.Button.heightSm, 24)
        XCTAssertEqual(Constants.Button.heightMd, 32)
        XCTAssertEqual(Constants.Button.heightLg, 40)
        XCTAssertEqual(Constants.Button.paddingHorizontalSm, 8)
        XCTAssertEqual(Constants.Button.paddingHorizontalMd, 16)
        XCTAssertEqual(Constants.Button.paddingHorizontalLg, 20)
        XCTAssertEqual(Constants.Button.fontSizeSm, 12)
        XCTAssertEqual(Constants.Button.fontSizeMd, 14)
        XCTAssertEqual(Constants.Button.fontSizeLg, 16)
        XCTAssertEqual(Constants.Button.iconSizeSm, 14)
        XCTAssertEqual(Constants.Button.iconSizeMd, 16)
        XCTAssertEqual(Constants.Button.iconSizeLg, 18)
        XCTAssertEqual(Constants.Button.iconSpacing, 6)
        XCTAssertEqual(Constants.Button.borderWidth, 1)
    }
}
