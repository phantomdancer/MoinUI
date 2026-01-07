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
        XCTAssertEqual(MoinUIButtonType.warning.borderColor, Color.clear)
        XCTAssertEqual(MoinUIButtonType.danger.borderColor, Color.clear)
        XCTAssertEqual(MoinUIButtonType.info.borderColor, Color.clear)
    }

    func testButtonTypeHoverBorderColors() {
        XCTAssertEqual(MoinUIButtonType.default.hoverBorderColor, Constants.Colors.borderHover)
        XCTAssertEqual(MoinUIButtonType.primary.hoverBorderColor, Color.clear)
        XCTAssertEqual(MoinUIButtonType.success.hoverBorderColor, Color.clear)
        XCTAssertEqual(MoinUIButtonType.warning.hoverBorderColor, Color.clear)
        XCTAssertEqual(MoinUIButtonType.danger.hoverBorderColor, Color.clear)
        XCTAssertEqual(MoinUIButtonType.info.hoverBorderColor, Color.clear)
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

    // MARK: - Icon Position Tests

    func testButtonIconPositionCases() {
        let positions: [MoinUIButtonIconPosition] = [.leading, .trailing]
        XCTAssertEqual(positions.count, 2)
    }

    // MARK: - Button with Icon Tests

    func testButtonWithIconLeading() {
        let button = MoinUIButton(
            "Search",
            type: .primary,
            icon: "magnifyingglass",
            iconPosition: .leading
        ) {}
        XCTAssertNotNil(button)
    }

    func testButtonWithIconTrailing() {
        let button = MoinUIButton(
            "Next",
            type: .primary,
            icon: "arrow.right",
            iconPosition: .trailing
        ) {}
        XCTAssertNotNil(button)
    }

    // MARK: - Button with Href Tests

    func testButtonWithHref() {
        let button = MoinUIButton(
            "GitHub",
            type: .primary,
            href: URL(string: "https://github.com")
        )
        XCTAssertNotNil(button)
    }

    func testButtonWithHrefAndIcon() {
        let button = MoinUIButton(
            "Link",
            type: .primary,
            icon: "link",
            href: URL(string: "https://example.com")
        )
        XCTAssertNotNil(button)
    }

    // MARK: - Icon Only Button Tests

    func testIconOnlyButtonWithHref() {
        let button = MoinUIButton(
            icon: "link",
            type: .primary,
            href: URL(string: "https://example.com")
        )
        XCTAssertNotNil(button)
    }

    func testIconOnlyButtonAllVariants() {
        let variants: [MoinUIButtonVariant] = [.solid, .outlined, .dashed, .filled, .text, .link]
        for variant in variants {
            let button = MoinUIButton(
                icon: "star",
                type: .primary,
                variant: variant
            ) {}
            XCTAssertNotNil(button)
        }
    }

    // MARK: - Button Disabled State Tests

    func testButtonDisabledState() {
        let button = MoinUIButton(
            "Disabled",
            type: .primary,
            isDisabled: true
        ) {}
        XCTAssertNotNil(button)
    }

    func testButtonLoadingState() {
        let button = MoinUIButton(
            "Loading",
            type: .primary,
            isLoading: true
        ) {}
        XCTAssertNotNil(button)
    }

    // MARK: - Button All Types Tests

    func testButtonAllTypes() {
        let types: [MoinUIButtonType] = [.default, .primary, .success, .warning, .danger, .info]
        for buttonType in types {
            let button = MoinUIButton(
                "Button",
                type: buttonType
            ) {}
            XCTAssertNotNil(button)
        }
    }

    // MARK: - Button All Variants Tests

    func testButtonAllVariants() {
        let variants: [MoinUIButtonVariant] = [.solid, .outlined, .dashed, .filled, .text, .link]
        for variant in variants {
            let button = MoinUIButton(
                "Button",
                type: .primary,
                variant: variant
            ) {}
            XCTAssertNotNil(button)
        }
    }

    // MARK: - Button All Shapes Tests

    func testButtonAllShapes() {
        let shapes: [MoinUIButtonShape] = [.default, .round, .circle]
        for shape in shapes {
            let button = MoinUIButton(
                "B",
                type: .primary,
                shape: shape
            ) {}
            XCTAssertNotNil(button)
        }
    }

    // MARK: - Custom Color Tests

    func testButtonWithCustomColor() {
        let customColor = Color(red: 0.6, green: 0.2, blue: 0.8)
        let button = MoinUIButton(
            "Custom",
            color: customColor
        ) {}
        XCTAssertNotNil(button)
    }

    func testButtonWithCustomColorAndVariants() {
        let customColor = Color(red: 1.0, green: 0.4, blue: 0.6)
        let variants: [MoinUIButtonVariant] = [.solid, .outlined, .text, .link]
        for variant in variants {
            let button = MoinUIButton(
                "Custom",
                variant: variant,
                color: customColor
            ) {}
            XCTAssertNotNil(button)
        }
    }

    func testIconButtonWithCustomColor() {
        let customColor = Color(red: 0.0, green: 0.8, blue: 0.6)
        let button = MoinUIButton(
            icon: "star",
            color: customColor
        ) {}
        XCTAssertNotNil(button)
    }

    func testButtonCustomColorOverridesType() {
        let customColor = Color.purple
        let button = MoinUIButton(
            "Test",
            type: .primary,
            color: customColor
        ) {}
        XCTAssertNotNil(button)
    }
}
