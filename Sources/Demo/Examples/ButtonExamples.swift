import SwiftUI
import MoinUI

/// 按钮组件文档页面 Tab
enum ButtonExamplesTab: String, CaseIterable {
    case examples
    case playground
}

/// Button component examples
struct ButtonExamples: View {
    @EnvironmentObject var localization: MoinUILocalization
    @Binding var selectedTab: ButtonExamplesTab
    @State private var isLoading = false
    @State private var loadings: [Bool] = Array(repeating: false, count: 6)

    /// 锚点列表
    private let anchors: [AnchorItem] = [
        AnchorItem(id: "type", titleKey: "button.type"),
        AnchorItem(id: "variant", titleKey: "button.variant"),
        AnchorItem(id: "color_variant", titleKey: "button.color_variant"),
        AnchorItem(id: "ghost", titleKey: "button.ghost"),
        AnchorItem(id: "size", titleKey: "button.size"),
        AnchorItem(id: "shape", titleKey: "button.shape"),
        AnchorItem(id: "loading", titleKey: "button.loading"),
        AnchorItem(id: "gradient", titleKey: "button.gradient"),
        AnchorItem(id: "icon", titleKey: "button.icon"),
        AnchorItem(id: "icon_text", titleKey: "button.icon_text"),
        AnchorItem(id: "disabled", titleKey: "button.disabled"),
        AnchorItem(id: "block", titleKey: "button.block"),
        AnchorItem(id: "api", titleKey: "API"),
        AnchorItem(id: "faq", titleKey: "faq.title"),
    ]

    var body: some View {
        Group {
            switch selectedTab {
            case .examples:
                examplesContent
            case .playground:
                playgroundContent
            }
        }
    }

    // MARK: - Examples Content

    private var examplesContent: some View {
        ExamplePageWithAnchor(anchors: anchors) { _ in
            VStack(alignment: .leading, spacing: Constants.Spacing.xl) {
                typeExample.id("type")
                variantExample.id("variant")
                colorVariantExample.id("color_variant")
                ghostExample.id("ghost")
                sizeExample.id("size")
                shapeExample.id("shape")
                loadingExample.id("loading")
                gradientExample.id("gradient")
                iconExample.id("icon")
                iconTextExample.id("icon_text")
                disabledExample.id("disabled")
                blockExample.id("block")

                Divider()

                ButtonAPISection().id("api")

                Divider()

                ButtonFAQSection().id("faq")
            }
        }
    }

    // MARK: - Playground Content

    private var playgroundContent: some View {
        ButtonPlayground()
            .padding(Constants.Spacing.xl)
    }

    // MARK: - Examples

    private var typeExample: some View {
        ExampleSection(
            title: localization.tr("button.type"),
            description: localization.tr("button.type_desc")
        ) {
            HStack(spacing: Constants.Spacing.md) {
                MoinUIButton(localization.tr("button.label.default")) {}
                MoinUIButton(localization.tr("button.label.primary"), type: .primary) {}
                MoinUIButton(localization.tr("button.label.success"), type: .success) {}
                MoinUIButton(localization.tr("button.label.warning"), type: .warning) {}
                MoinUIButton(localization.tr("button.label.danger"), type: .danger) {}
                MoinUIButton(localization.tr("button.label.info"), type: .info) {}
            }
        } code: {
            """
            MoinUIButton("\(localization.tr("button.label.default"))") {}
            MoinUIButton("\(localization.tr("button.label.primary"))", type: .primary) {}
            MoinUIButton("\(localization.tr("button.label.success"))", type: .success) {}
            MoinUIButton("\(localization.tr("button.label.warning"))", type: .warning) {}
            MoinUIButton("\(localization.tr("button.label.danger"))", type: .danger) {}
            MoinUIButton("\(localization.tr("button.label.info"))", type: .info) {}
            """
        }
    }

    private var colorExample: some View {
        ExampleSection(
            title: localization.tr("button.color"),
            description: localization.tr("button.color_desc")
        ) {
            VStack(alignment: .leading, spacing: Constants.Spacing.md) {
                // Pink
                HStack(spacing: Constants.Spacing.sm) {
                    MoinUIButton(localization.tr("button.label.solid"), variant: .solid, color: Color.pink) {}
                    MoinUIButton(localization.tr("button.label.outlined"), variant: .outlined, color: Color.pink) {}
                    MoinUIButton(localization.tr("button.label.text"), variant: .text, color: Color.pink) {}
                    MoinUIButton(localization.tr("button.label.link"), variant: .link, color: Color.pink) {}
                }
                // Purple
                HStack(spacing: Constants.Spacing.sm) {
                    MoinUIButton(localization.tr("button.label.solid"), variant: .solid, color: Color.purple) {}
                    MoinUIButton(localization.tr("button.label.outlined"), variant: .outlined, color: Color.purple) {}
                    MoinUIButton(localization.tr("button.label.text"), variant: .text, color: Color.purple) {}
                    MoinUIButton(localization.tr("button.label.link"), variant: .link, color: Color.purple) {}
                }
                // Cyan
                HStack(spacing: Constants.Spacing.sm) {
                    MoinUIButton(localization.tr("button.label.solid"), variant: .solid, color: Color.cyan) {}
                    MoinUIButton(localization.tr("button.label.outlined"), variant: .outlined, color: Color.cyan) {}
                    MoinUIButton(localization.tr("button.label.text"), variant: .text, color: Color.cyan) {}
                    MoinUIButton(localization.tr("button.label.link"), variant: .link, color: Color.cyan) {}
                }
                // Orange
                HStack(spacing: Constants.Spacing.sm) {
                    MoinUIButton(localization.tr("button.label.solid"), variant: .solid, color: Color.orange) {}
                    MoinUIButton(localization.tr("button.label.outlined"), variant: .outlined, color: Color.orange) {}
                    MoinUIButton(localization.tr("button.label.text"), variant: .text, color: Color.orange) {}
                    MoinUIButton(localization.tr("button.label.link"), variant: .link, color: Color.orange) {}
                }
            }
        } code: {
            """
            // Pink
            MoinUIButton("\(localization.tr("button.label.solid"))", variant: .solid, color: Color.pink) {}
            MoinUIButton("\(localization.tr("button.label.outlined"))", variant: .outlined, color: Color.pink) {}

            // Purple
            MoinUIButton("\(localization.tr("button.label.solid"))", variant: .solid, color: Color.purple) {}

            // Cyan
            MoinUIButton("\(localization.tr("button.label.solid"))", variant: .solid, color: Color.cyan) {}
            """
        }
    }

    private var variantExample: some View {
        ExampleSection(
            title: localization.tr("button.variant"),
            description: localization.tr("button.variant_desc")
        ) {
            HStack(spacing: Constants.Spacing.md) {
                MoinUIButton(localization.tr("button.label.solid"), type: .primary, variant: .solid) {}
                MoinUIButton(localization.tr("button.label.outlined"), type: .primary, variant: .outlined) {}
                MoinUIButton(localization.tr("button.label.dashed"), type: .primary, variant: .dashed) {}
                MoinUIButton(localization.tr("button.label.filled"), type: .primary, variant: .filled) {}
                MoinUIButton(localization.tr("button.label.text"), type: .primary, variant: .text) {}
                MoinUIButton(localization.tr("button.label.link"), type: .primary, variant: .link) {}
            }
        } code: {
            """
            MoinUIButton("\(localization.tr("button.label.solid"))", type: .primary, variant: .solid) {}
            MoinUIButton("\(localization.tr("button.label.outlined"))", type: .primary, variant: .outlined) {}
            MoinUIButton("\(localization.tr("button.label.dashed"))", type: .primary, variant: .dashed) {}
            MoinUIButton("\(localization.tr("button.label.filled"))", type: .primary, variant: .filled) {}
            MoinUIButton("\(localization.tr("button.label.text"))", type: .primary, variant: .text) {}
            MoinUIButton("\(localization.tr("button.label.link"))", type: .primary, variant: .link) {}
            """
        }
    }

    private var colorVariantExample: some View {
        ExampleSection(
            title: localization.tr("button.color_variant"),
            description: localization.tr("button.color_variant_desc")
        ) {
            VStack(alignment: .leading, spacing: Constants.Spacing.md) {
                // Default
                HStack(spacing: Constants.Spacing.sm) {
                    MoinUIButton(localization.tr("button.label.solid"), variant: .solid) {}
                    MoinUIButton(localization.tr("button.label.outlined"), variant: .outlined) {}
                    MoinUIButton(localization.tr("button.label.dashed"), variant: .dashed) {}
                    MoinUIButton(localization.tr("button.label.filled"), variant: .filled) {}
                    MoinUIButton(localization.tr("button.label.text"), variant: .text) {}
                    MoinUIButton(localization.tr("button.label.link"), variant: .link) {}
                }
                // Primary
                HStack(spacing: Constants.Spacing.sm) {
                    MoinUIButton(localization.tr("button.label.solid"), type: .primary, variant: .solid) {}
                    MoinUIButton(localization.tr("button.label.outlined"), type: .primary, variant: .outlined) {}
                    MoinUIButton(localization.tr("button.label.dashed"), type: .primary, variant: .dashed) {}
                    MoinUIButton(localization.tr("button.label.filled"), type: .primary, variant: .filled) {}
                    MoinUIButton(localization.tr("button.label.text"), type: .primary, variant: .text) {}
                    MoinUIButton(localization.tr("button.label.link"), type: .primary, variant: .link) {}
                }
                // Danger
                HStack(spacing: Constants.Spacing.sm) {
                    MoinUIButton(localization.tr("button.label.solid"), type: .danger, variant: .solid) {}
                    MoinUIButton(localization.tr("button.label.outlined"), type: .danger, variant: .outlined) {}
                    MoinUIButton(localization.tr("button.label.dashed"), type: .danger, variant: .dashed) {}
                    MoinUIButton(localization.tr("button.label.filled"), type: .danger, variant: .filled) {}
                    MoinUIButton(localization.tr("button.label.text"), type: .danger, variant: .text) {}
                    MoinUIButton(localization.tr("button.label.link"), type: .danger, variant: .link) {}
                }
                // Custom Color (Pink)
                HStack(spacing: Constants.Spacing.sm) {
                    MoinUIButton(localization.tr("button.label.solid"), variant: .solid, color: .pink) {}
                    MoinUIButton(localization.tr("button.label.outlined"), variant: .outlined, color: .pink) {}
                    MoinUIButton(localization.tr("button.label.dashed"), variant: .dashed, color: .pink) {}
                    MoinUIButton(localization.tr("button.label.filled"), variant: .filled, color: .pink) {}
                    MoinUIButton(localization.tr("button.label.text"), variant: .text, color: .pink) {}
                    MoinUIButton(localization.tr("button.label.link"), variant: .link, color: .pink) {}
                }
                // Custom Color (Purple)
                HStack(spacing: Constants.Spacing.sm) {
                    MoinUIButton(localization.tr("button.label.solid"), variant: .solid, color: .purple) {}
                    MoinUIButton(localization.tr("button.label.outlined"), variant: .outlined, color: .purple) {}
                    MoinUIButton(localization.tr("button.label.dashed"), variant: .dashed, color: .purple) {}
                    MoinUIButton(localization.tr("button.label.filled"), variant: .filled, color: .purple) {}
                    MoinUIButton(localization.tr("button.label.text"), variant: .text, color: .purple) {}
                    MoinUIButton(localization.tr("button.label.link"), variant: .link, color: .purple) {}
                }
            }
        } code: {
            """
            // Default
            MoinUIButton("\(localization.tr("button.label.solid"))", variant: .solid) {}
            MoinUIButton("\(localization.tr("button.label.outlined"))", variant: .outlined) {}
            MoinUIButton("\(localization.tr("button.label.dashed"))", variant: .dashed) {}
            MoinUIButton("\(localization.tr("button.label.filled"))", variant: .filled) {}

            // Primary
            MoinUIButton("\(localization.tr("button.label.solid"))", type: .primary, variant: .solid) {}

            // Danger
            MoinUIButton("\(localization.tr("button.label.solid"))", type: .danger, variant: .solid) {}

            // Custom Color
            MoinUIButton("\(localization.tr("button.label.solid"))", variant: .solid, color: .pink) {}
            MoinUIButton("\(localization.tr("button.label.solid"))", variant: .solid, color: .purple) {}
            """
        }
    }

    private var ghostExample: some View {
        ExampleSection(
            title: localization.tr("button.ghost"),
            description: localization.tr("button.ghost_desc")
        ) {
            ZStack {
                Color.gray.opacity(0.3)
                    .cornerRadius(Constants.Radius.md)
                HStack(spacing: Constants.Spacing.md) {
                    MoinUIButton(localization.tr("button.label.primary"), type: .primary, isGhost: true) {}
                    MoinUIButton(localization.tr("button.label.default"), isGhost: true) {}
                    MoinUIButton(localization.tr("button.label.dashed"), variant: .dashed, isGhost: true) {}
                    MoinUIButton(localization.tr("button.label.danger"), type: .danger, isGhost: true) {}
                }
                .padding(Constants.Spacing.lg)
            }
        } code: {
            """
            MoinUIButton("\(localization.tr("button.label.primary"))", type: .primary, isGhost: true) {}
            MoinUIButton("\(localization.tr("button.label.default"))", isGhost: true) {}
            MoinUIButton("\(localization.tr("button.label.dashed"))", variant: .dashed, isGhost: true) {}
            MoinUIButton("\(localization.tr("button.label.danger"))", type: .danger, isGhost: true) {}
            """
        }
    }

    private var sizeExample: some View {
        ExampleSection(
            title: localization.tr("button.size"),
            description: localization.tr("button.size_desc")
        ) {
            HStack(alignment: .center, spacing: Constants.Spacing.md) {
                MoinUIButton(localization.tr("button.label.small"), type: .primary, size: .small) {}
                MoinUIButton(localization.tr("button.label.medium"), type: .primary, size: .medium) {}
                MoinUIButton(localization.tr("button.label.large"), type: .primary, size: .large) {}
            }
        } code: {
            """
            MoinUIButton("\(localization.tr("button.label.small"))", type: .primary, size: .small) {}
            MoinUIButton("\(localization.tr("button.label.medium"))", type: .primary, size: .medium) {}
            MoinUIButton("\(localization.tr("button.label.large"))", type: .primary, size: .large) {}
            """
        }
    }

    private var shapeExample: some View {
        ExampleSection(
            title: localization.tr("button.shape"),
            description: localization.tr("button.shape_desc")
        ) {
            HStack(spacing: Constants.Spacing.md) {
                MoinUIButton(localization.tr("button.label.default"), type: .primary, shape: .default) {}
                MoinUIButton(localization.tr("button.label.round"), type: .primary, shape: .round) {}
                MoinUIButton(icon: "plus", type: .primary, shape: .circle) {}
            }
        } code: {
            """
            MoinUIButton("\(localization.tr("button.label.default"))", type: .primary, shape: .default) {}
            MoinUIButton("\(localization.tr("button.label.round"))", type: .primary, shape: .round) {}
            MoinUIButton(icon: "plus", type: .primary, shape: .circle) {}
            """
        }
    }

    private var loadingExample: some View {
        ExampleSection(
            title: localization.tr("button.loading"),
            description: localization.tr("button.loading_desc")
        ) {
            VStack(alignment: .leading, spacing: Constants.Spacing.md) {
                HStack(spacing: Constants.Spacing.md) {
                    MoinUIButton(localization.tr("button.label.loading"), type: .primary, loading: true) {}
                    MoinUIButton(localization.tr("button.label.loading"), type: .primary, size: .small, loading: true) {}
                    MoinUIButton(icon: "power", type: .primary, loading: true) {}
                    MoinUIButton(localization.tr("button.label.custom"), type: .primary, loading: MoinUIButtonLoading(true, icon: "arrow.clockwise")) {}
                }
                HStack(spacing: Constants.Spacing.md) {
                    MoinUIButton(localization.tr("button.label.button"), type: .primary, loading: MoinUIButtonLoading(loadings[0])) {
                        enterLoading(0)
                    }
                    MoinUIButton(localization.tr("button.label.button"), type: .primary, iconPlacement: .end, loading: MoinUIButtonLoading(loadings[1])) {
                        enterLoading(1)
                    }
                    MoinUIButton(localization.tr("button.label.button"), type: .primary, loading: MoinUIButtonLoading(loadings[2], delay: 0.5)) {
                        enterLoading(2)
                    }
                }
            }
        } code: {
            """
            // \(localization.tr("button.label.loading"))
            MoinUIButton("\(localization.tr("button.label.loading"))", type: .primary, loading: true) {}

            // \(localization.tr("button.label.custom"))
            MoinUIButton("\(localization.tr("button.label.custom"))", type: .primary, loading: MoinUIButtonLoading(true, icon: "arrow.clockwise")) {}

            // Loading delay 0.5s
            MoinUIButton("\(localization.tr("button.label.button"))", type: .primary, loading: MoinUIButtonLoading(isLoading, delay: 0.5)) {}
            """
        }
    }

    private func enterLoading(_ index: Int) {
        loadings[index] = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            loadings[index] = false
        }
    }

    private var gradientExample: some View {
        ExampleSection(
            title: localization.tr("button.gradient"),
            description: localization.tr("button.gradient_desc")
        ) {
            HStack(spacing: Constants.Spacing.md) {
                MoinUIButton(localization.tr("button.label.primary"), type: .primary, size: .large, icon: "sparkles", gradient: LinearGradient(
                    colors: [Color(red: 0.38, green: 0.33, blue: 0.88), Color(red: 0.02, green: 0.75, blue: 1.0)],
                    startPoint: .leading,
                    endPoint: .trailing
                )) {}
                MoinUIButton(localization.tr("button.label.warning"), size: .large, gradient: LinearGradient(
                    colors: [.orange, .pink],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )) {}
                MoinUIButton(localization.tr("button.label.success"), size: .large, gradient: LinearGradient(
                    colors: [.green, .teal],
                    startPoint: .top,
                    endPoint: .bottom
                )) {}
            }
        } code: {
            """
            MoinUIButton(
                "\(localization.tr("button.label.primary"))",
                size: .large,
                icon: "sparkles",
                gradient: LinearGradient(
                    colors: [.purple, .blue],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            ) {}
            """
        }
    }

    private var iconExample: some View {
        ExampleSection(
            title: localization.tr("button.icon"),
            description: localization.tr("button.icon_desc")
        ) {
            HStack(spacing: Constants.Spacing.md) {
                MoinUIButton(icon: "plus", type: .primary) {}
                MoinUIButton(icon: "pencil", type: .success) {}
                MoinUIButton(icon: "trash", type: .danger) {}
                MoinUIButton(icon: "magnifyingglass", type: .info) {}
            }
        } code: {
            """
            MoinUIButton(icon: "plus", type: .primary) {}
            MoinUIButton(icon: "pencil", type: .success) {}
            MoinUIButton(icon: "trash", type: .danger) {}
            MoinUIButton(icon: "magnifyingglass", type: .info) {}
            """
        }
    }

    private var iconTextExample: some View {
        ExampleSection(
            title: localization.tr("button.icon_text"),
            description: localization.tr("button.icon_text_desc")
        ) {
            HStack(spacing: Constants.Spacing.md) {
                MoinUIButton(localization.tr("button.label.search"), type: .primary, icon: "magnifyingglass") {}
                MoinUIButton(localization.tr("button.label.download"), type: .success, icon: "arrow.down.circle") {}
                MoinUIButton(localization.tr("button.label.go"), type: .info, icon: "arrow.right", iconPlacement: .end) {}
            }
        } code: {
            """
            MoinUIButton("\(localization.tr("button.label.search"))", type: .primary, icon: "magnifyingglass") {}
            MoinUIButton("\(localization.tr("button.label.download"))", type: .success, icon: "arrow.down.circle") {}
            MoinUIButton("\(localization.tr("button.label.go"))", type: .info, icon: "arrow.right", iconPlacement: .end) {}
            """
        }
    }

    private var disabledExample: some View {
        ExampleSection(
            title: localization.tr("button.disabled"),
            description: localization.tr("button.disabled_desc")
        ) {
            VStack(alignment: .leading, spacing: Constants.Spacing.md) {
                HStack(spacing: Constants.Spacing.md) {
                    MoinUIButton(localization.tr("button.label.primary"), type: .primary, isDisabled: true) {}
                    MoinUIButton(localization.tr("button.label.default"), isDisabled: true) {}
                    MoinUIButton(localization.tr("button.label.dashed"), variant: .dashed, isDisabled: true) {}
                    MoinUIButton(localization.tr("button.label.text"), type: .primary, variant: .text, isDisabled: true) {}
                    MoinUIButton(localization.tr("button.label.link"), type: .primary, variant: .link, isDisabled: true) {}
                }
                HStack(spacing: Constants.Spacing.md) {
                    MoinUIButton(localization.tr("button.label.danger"), type: .danger, isDisabled: true) {}
                    MoinUIButton(localization.tr("button.label.success"), type: .success, variant: .outlined, isDisabled: true) {}
                    MoinUIButton(localization.tr("button.label.custom"), variant: .solid, isDisabled: true, color: .purple) {}
                    MoinUIButton(icon: "plus", type: .primary, isDisabled: true) {}
                }
            }
        } code: {
            """
            MoinUIButton("\(localization.tr("button.label.primary"))", type: .primary, isDisabled: true) {}
            MoinUIButton("\(localization.tr("button.label.default"))", isDisabled: true) {}
            MoinUIButton("\(localization.tr("button.label.dashed"))", variant: .dashed, isDisabled: true) {}
            MoinUIButton("\(localization.tr("button.label.custom"))", variant: .solid, isDisabled: true, color: .purple) {}
            """
        }
    }

    private var blockExample: some View {
        ExampleSection(
            title: localization.tr("button.block"),
            description: localization.tr("button.block_desc")
        ) {
            MoinUIButton(localization.tr("button.label.block_button"), type: .primary, isBlock: true) {}
        } code: {
            """
            MoinUIButton("\(localization.tr("button.label.block_button"))", type: .primary, isBlock: true) {}
            """
        }
    }
}
