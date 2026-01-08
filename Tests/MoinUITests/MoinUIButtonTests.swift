import XCTest
import SwiftUI
@testable import MoinUI

final class MoinUIButtonTests: XCTestCase {

    // MARK: - Type Tests

    func testButtonTypeCases() {
        let types: [MoinUIButtonType] = [.default, .primary, .success, .warning, .danger, .info]
        XCTAssertEqual(types.count, 6)
    }

    // MARK: - Size Tests

    func testButtonSizeCases() {
        let sizes: [MoinUIButtonSize] = [.small, .medium, .large]
        XCTAssertEqual(sizes.count, 3)
    }

    // MARK: - Variant Tests

    func testButtonVariantCases() {
        let variants: [MoinUIButtonVariant] = [.solid, .outlined, .dashed, .filled, .text, .link]
        XCTAssertEqual(variants.count, 6)
    }

    // MARK: - Shape Tests

    func testButtonShapeCases() {
        let shapes: [MoinUIButtonShape] = [.default, .round, .circle]
        XCTAssertEqual(shapes.count, 3)
    }

    // MARK: - Icon Placement Tests

    func testButtonIconPlacementCases() {
        let placements: [MoinUIButtonIconPlacement] = [.start, .end]
        XCTAssertEqual(placements.count, 2)
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
            variant: .outlined,
            shape: .round,
            loading: false,
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
            loading: false,
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
        XCTAssertEqual(Constants.Button.iconSpacing, 6)
        XCTAssertEqual(Constants.Button.borderWidth, 1)
    }

    // MARK: - Button with Icon Tests

    func testButtonWithIconStart() {
        let button = MoinUIButton(
            "Search",
            type: .primary,
            icon: "magnifyingglass",
            iconPlacement: .start
        ) {}
        XCTAssertNotNil(button)
    }

    func testButtonWithIconEnd() {
        let button = MoinUIButton(
            "Next",
            type: .primary,
            icon: "arrow.right",
            iconPlacement: .end
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
            loading: true
        ) {}
        XCTAssertNotNil(button)
    }

    func testButtonLoadingWithDelay() {
        let button = MoinUIButton(
            "Loading",
            type: .primary,
            loading: MoinUIButtonLoading(true, delay: 0.5)
        ) {}
        XCTAssertNotNil(button)
    }

    func testButtonLoadingWithCustomIcon() {
        let button = MoinUIButton(
            "Loading",
            type: .primary,
            loading: MoinUIButtonLoading(true, icon: "arrow.clockwise")
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

    // MARK: - Ghost Button Tests

    func testButtonGhostMode() {
        let button = MoinUIButton(
            "Ghost",
            type: .primary,
            isGhost: true
        ) {}
        XCTAssertNotNil(button)
    }

    // MARK: - Gradient Button Tests

    func testButtonWithGradient() {
        let gradient = LinearGradient(
            colors: [.purple, .blue],
            startPoint: .leading,
            endPoint: .trailing
        )
        let button = MoinUIButton(
            "Gradient",
            type: .primary,
            gradient: gradient
        ) {}
        XCTAssertNotNil(button)
    }

    // MARK: - Block Button Tests

    func testButtonBlockMode() {
        let button = MoinUIButton(
            "Block",
            type: .primary,
            isBlock: true
        ) {}
        XCTAssertNotNil(button)
    }
}
