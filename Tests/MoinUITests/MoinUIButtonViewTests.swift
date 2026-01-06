import XCTest
import SwiftUI
import ViewInspector
@testable import MoinUI

final class MoinUIButtonViewTests: XCTestCase {

    override func setUp() {
        super.setUp()
        MoinUIConfigProvider.shared.reset()
    }

    // MARK: - Basic Rendering Tests

    func testButtonRendersText() throws {
        let button = MoinUIButton("Click Me") {}
        let text = try button.inspect().find(text: "Click Me")
        XCTAssertNotNil(text)
    }

    func testButtonRendersWithDifferentTypes() throws {
        let types: [MoinUIButtonType] = [.default, .primary, .success, .warning, .danger, .info]

        for type in types {
            let button = MoinUIButton("Test", type: type) {}
            let text = try button.inspect().find(text: "Test")
            XCTAssertNotNil(text, "Button with type \(type) should render text")
        }
    }

    func testButtonRendersWithDifferentSizes() throws {
        let sizes: [MoinUIButtonSize] = [.small, .medium, .large]

        for size in sizes {
            let button = MoinUIButton("Test", size: size) {}
            let text = try button.inspect().find(text: "Test")
            XCTAssertNotNil(text, "Button with size \(size) should render text")
        }
    }

    func testButtonRendersWithDifferentVariants() throws {
        let variants: [MoinUIButtonVariant] = [.solid, .outline, .text, .link, .ghost]

        for variant in variants {
            let button = MoinUIButton("Test", variant: variant) {}
            let text = try button.inspect().find(text: "Test")
            XCTAssertNotNil(text, "Button with variant \(variant) should render text")
        }
    }

    func testButtonRendersWithDifferentShapes() throws {
        let shapes: [MoinUIButtonShape] = [.default, .round, .circle]

        for shape in shapes {
            let button = MoinUIButton("T", shape: shape) {}
            let text = try button.inspect().find(text: "T")
            XCTAssertNotNil(text, "Button with shape \(shape) should render text")
        }
    }

    // MARK: - Icon Button Tests

    func testIconButtonRendersImage() throws {
        let button = MoinUIButton(icon: "plus", type: .primary) {}
        let image = try button.inspect().find(ViewType.Image.self)
        XCTAssertNotNil(image)
    }

    // MARK: - Loading State Tests

    func testLoadingButtonShowsProgressView() throws {
        let button = MoinUIButton("Loading", isLoading: true) {}
        let progress = try button.inspect().find(ViewType.ProgressView.self)
        XCTAssertNotNil(progress)
    }

    func testNonLoadingButtonHidesProgressView() throws {
        let button = MoinUIButton("Normal", isLoading: false) {}
        XCTAssertThrowsError(try button.inspect().find(ViewType.ProgressView.self))
    }

    // MARK: - Disabled State Tests

    func testDisabledButton() throws {
        let button = MoinUIButton("Disabled", isDisabled: true) {}
        let swiftUIButton = try button.inspect().find(ViewType.Button.self)
        XCTAssertNotNil(swiftUIButton)
    }

    // MARK: - Block Button Tests

    func testBlockButton() throws {
        let button = MoinUIButton("Block", isBlock: true) {}
        let text = try button.inspect().find(text: "Block")
        XCTAssertNotNil(text)
    }

    // MARK: - Custom Label Tests

    func testCustomLabelButton() throws {
        let button = MoinUIButton(action: {}) {
            HStack {
                Image(systemName: "star")
                Text("Custom")
            }
        }

        let text = try button.inspect().find(text: "Custom")
        XCTAssertNotNil(text)

        let image = try button.inspect().find(ViewType.Image.self)
        XCTAssertNotNil(image)
    }

    // MARK: - Token Integration Tests

    func testButtonUsesGlobalToken() throws {
        let provider = MoinUIConfigProvider.shared
        provider.token.colorPrimary = .purple

        let button = MoinUIButton("Token Test", type: .primary) {}
        let text = try button.inspect().find(text: "Token Test")
        XCTAssertNotNil(text)
    }

    func testButtonUpdatesWithTokenChange() throws {
        let provider = MoinUIConfigProvider.shared

        // Create button
        let button = MoinUIButton("Dynamic", type: .primary) {}

        // Change token
        provider.token.borderRadius = 16

        // Button should still render
        let text = try button.inspect().find(text: "Dynamic")
        XCTAssertNotNil(text)
    }

    // MARK: - Combination Tests

    func testButtonWithAllOptions() throws {
        let button = MoinUIButton(
            "Full Options",
            type: .success,
            size: .large,
            variant: .outline,
            shape: .round,
            isLoading: false,
            isDisabled: false,
            isBlock: true
        ) {}

        let text = try button.inspect().find(text: "Full Options")
        XCTAssertNotNil(text)
    }

    func testLoadingDisabledButton() throws {
        let button = MoinUIButton("Both", isLoading: true, isDisabled: true) {}

        let progress = try button.inspect().find(ViewType.ProgressView.self)
        XCTAssertNotNil(progress)

        let text = try button.inspect().find(text: "Both")
        XCTAssertNotNil(text)
    }

    // MARK: - Icon + Text Button Tests

    func testButtonWithIconAndText() throws {
        let button = MoinUIButton("Search", type: .primary, icon: "magnifyingglass") {}
        let text = try button.inspect().find(text: "Search")
        XCTAssertNotNil(text)
        let image = try button.inspect().find(ViewType.Image.self)
        XCTAssertNotNil(image)
    }

    func testButtonWithIconTrailing() throws {
        let button = MoinUIButton("Next", type: .primary, icon: "arrow.right", iconPosition: .trailing) {}
        let text = try button.inspect().find(text: "Next")
        XCTAssertNotNil(text)
    }

    // MARK: - Link Button Tests

    func testButtonWithHref() throws {
        let button = MoinUIButton(
            "GitHub",
            type: .primary,
            href: URL(string: "https://github.com")
        )
        // Link button renders as Link, not Button
        let link = try button.inspect().find(ViewType.Link.self)
        XCTAssertNotNil(link)
    }

    func testButtonWithHrefAndIcon() throws {
        let button = MoinUIButton(
            "Link",
            type: .primary,
            icon: "link",
            href: URL(string: "https://example.com")
        )
        let link = try button.inspect().find(ViewType.Link.self)
        XCTAssertNotNil(link)
    }

    // MARK: - Button Group Tests

    func testButtonGroupRenders() throws {
        let group = MoinUIButtonGroup {
            MoinUIButton("A", type: .primary) {}
            MoinUIButton("B", type: .primary) {}
        }
        let textA = try group.inspect().find(text: "A")
        let textB = try group.inspect().find(text: "B")
        XCTAssertNotNil(textA)
        XCTAssertNotNil(textB)
    }

    func testButtonGroupWithSize() throws {
        let group = MoinUIButtonGroup(size: .large) {
            MoinUIButton("Large", type: .primary) {}
        }
        let text = try group.inspect().find(text: "Large")
        XCTAssertNotNil(text)
    }
}
