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
    ]

    var body: some View {
        ZStack {
            examplesContent
                .opacity(selectedTab == .examples ? 1 : 0)
                .allowsHitTesting(selectedTab == .examples)

            playgroundContent
                .opacity(selectedTab == .playground ? 1 : 0)
                .allowsHitTesting(selectedTab == .playground)
        }
    }

    // MARK: - Examples Content

    private var examplesContent: some View {
        ExamplePageWithAnchor(anchors: anchors) { _ in
            VStack(alignment: .leading, spacing: MoinUIConstants.Spacing.xl) {
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
            }
        }
    }

    // MARK: - Playground Content

    private var playgroundContent: some View {
        ButtonPlayground()
            .padding(MoinUIConstants.Spacing.xl)
    }

    // MARK: - Examples

    private var colorVariantExample: some View {
        ExampleSection(
            title: localization.tr("button.color_variant"),
            description: localization.tr("button.color_variant_desc")
        ) {
            VStack(alignment: .leading, spacing: MoinUIConstants.Spacing.md) {
                // Semantic Colors
                HStack(spacing: MoinUIConstants.Spacing.sm) {
                    MoinUIButton(localization.tr("button.label.primary"), color: .primary) {}
                    MoinUIButton(localization.tr("button.label.success"), color: .success) {}
                    MoinUIButton(localization.tr("button.label.warning"), color: .warning) {}
                    MoinUIButton(localization.tr("button.label.danger"), color: .danger) {}
                    MoinUIButton(localization.tr("button.label.info"), color: .info) {}
                }
                // Default
                HStack(spacing: MoinUIConstants.Spacing.sm) {
                    MoinUIButton(localization.tr("button.label.solid"), variant: .solid) {}
                    MoinUIButton(localization.tr("button.label.outlined"), variant: .outlined) {}
                    MoinUIButton(localization.tr("button.label.dashed"), variant: .dashed) {}
                    MoinUIButton(localization.tr("button.label.filled"), variant: .filled) {}
                    MoinUIButton(localization.tr("button.label.text"), variant: .text) {}
                    MoinUIButton(localization.tr("button.label.link"), variant: .link) {}
                }
                // Danger
                HStack(spacing: MoinUIConstants.Spacing.sm) {
                    MoinUIButton(localization.tr("button.label.solid"), color: .danger, variant: .solid) {}
                    MoinUIButton(localization.tr("button.label.outlined"), color: .danger, variant: .outlined) {}
                    MoinUIButton(localization.tr("button.label.dashed"), color: .danger, variant: .dashed) {}
                    MoinUIButton(localization.tr("button.label.filled"), color: .danger, variant: .filled) {}
                    MoinUIButton(localization.tr("button.label.text"), color: .danger, variant: .text) {}
                    MoinUIButton(localization.tr("button.label.link"), color: .danger, variant: .link) {}
                }
                // Custom Color (Cyan)
                HStack(spacing: MoinUIConstants.Spacing.sm) {
                    MoinUIButton(localization.tr("button.label.solid"), color: .custom(MoinUIPresetColors.cyan), variant: .solid) {}
                    MoinUIButton(localization.tr("button.label.outlined"), color: .custom(MoinUIPresetColors.cyan), variant: .outlined) {}
                    MoinUIButton(localization.tr("button.label.dashed"), color: .custom(MoinUIPresetColors.cyan), variant: .dashed) {}
                    MoinUIButton(localization.tr("button.label.filled"), color: .custom(MoinUIPresetColors.cyan), variant: .filled) {}
                    MoinUIButton(localization.tr("button.label.text"), color: .custom(MoinUIPresetColors.cyan), variant: .text) {}
                    MoinUIButton(localization.tr("button.label.link"), color: .custom(MoinUIPresetColors.cyan), variant: .link) {}
                }
                // Custom RGB Color
                HStack(spacing: MoinUIConstants.Spacing.sm) {
                    MoinUIButton(localization.tr("button.label.solid"), color: .custom(Color(red: 0.6, green: 0.2, blue: 0.8)), variant: .solid) {}
                    MoinUIButton(localization.tr("button.label.outlined"), color: .custom(Color(red: 0.6, green: 0.2, blue: 0.8)), variant: .outlined) {}
                    MoinUIButton(localization.tr("button.label.dashed"), color: .custom(Color(red: 0.6, green: 0.2, blue: 0.8)), variant: .dashed) {}
                    MoinUIButton(localization.tr("button.label.filled"), color: .custom(Color(red: 0.6, green: 0.2, blue: 0.8)), variant: .filled) {}
                    MoinUIButton(localization.tr("button.label.text"), color: .custom(Color(red: 0.6, green: 0.2, blue: 0.8)), variant: .text) {}
                    MoinUIButton(localization.tr("button.label.link"), color: .custom(Color(red: 0.6, green: 0.2, blue: 0.8)), variant: .link) {}
                }
            }
        } code: {
            """
            // \(localization.tr("code_comment.semantic_colors"))
            MoinUIButton("\(localization.tr("button.label.primary"))", color: .primary) {}
            MoinUIButton("\(localization.tr("button.label.success"))", color: .success) {}
            MoinUIButton("\(localization.tr("button.label.warning"))", color: .warning) {}
            MoinUIButton("\(localization.tr("button.label.danger"))", color: .danger) {}
            MoinUIButton("\(localization.tr("button.label.info"))", color: .info) {}

            // \(localization.tr("code_comment.variants"))
            MoinUIButton("\(localization.tr("button.label.solid"))", variant: .solid) {}
            MoinUIButton("\(localization.tr("button.label.outlined"))", variant: .outlined) {}
            MoinUIButton("\(localization.tr("button.label.dashed"))", variant: .dashed) {}
            MoinUIButton("\(localization.tr("button.label.filled"))", variant: .filled) {}
            MoinUIButton("\(localization.tr("button.label.text"))", variant: .text) {}
            MoinUIButton("\(localization.tr("button.label.link"))", variant: .link) {}

            // \(localization.tr("code_comment.color_with_variant"))
            MoinUIButton("\(localization.tr("button.label.outlined"))", color: .danger, variant: .outlined) {}

            // \(localization.tr("code_comment.custom_color"))
            MoinUIButton("\(localization.tr("button.label.solid"))", color: .custom(MoinUIPresetColors.cyan)) {}
            MoinUIButton("\(localization.tr("button.label.solid"))", color: .custom(Color(red: 0.6, green: 0.2, blue: 0.8))) {}
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
                    .cornerRadius(MoinUIConstants.Radius.md)
                HStack(spacing: MoinUIConstants.Spacing.md) {
                    MoinUIButton(localization.tr("button.label.primary"), color: .primary, isGhost: true) {}
                    MoinUIButton(localization.tr("button.label.default"), isGhost: true) {}
                    MoinUIButton(localization.tr("button.label.dashed"), variant: .dashed, isGhost: true) {}
                    MoinUIButton(localization.tr("button.label.danger"), color: .danger, isGhost: true) {}
                }
                .padding(MoinUIConstants.Spacing.lg)
            }
        } code: {
            """
            MoinUIButton("\(localization.tr("button.label.primary"))", color: .primary, isGhost: true) {}
            MoinUIButton("\(localization.tr("button.label.default"))", isGhost: true) {}
            MoinUIButton("\(localization.tr("button.label.dashed"))", variant: .dashed, isGhost: true) {}
            MoinUIButton("\(localization.tr("button.label.danger"))", color: .danger, isGhost: true) {}
            """
        }
    }

    private var sizeExample: some View {
        ExampleSection(
            title: localization.tr("button.size"),
            description: localization.tr("button.size_desc")
        ) {
            HStack(alignment: .center, spacing: MoinUIConstants.Spacing.md) {
                MoinUIButton(localization.tr("button.label.small"), color: .primary, size: .small) {}
                MoinUIButton(localization.tr("button.label.medium"), color: .primary, size: .medium) {}
                MoinUIButton(localization.tr("button.label.large"), color: .primary, size: .large) {}
            }
        } code: {
            """
            MoinUIButton("\(localization.tr("button.label.small"))", color: .primary, size: .small) {}
            MoinUIButton("\(localization.tr("button.label.medium"))", color: .primary, size: .medium) {}
            MoinUIButton("\(localization.tr("button.label.large"))", color: .primary, size: .large) {}
            """
        }
    }

    private var shapeExample: some View {
        ExampleSection(
            title: localization.tr("button.shape"),
            description: localization.tr("button.shape_desc")
        ) {
            HStack(spacing: MoinUIConstants.Spacing.md) {
                MoinUIButton(localization.tr("button.label.default"), color: .primary, shape: .default) {}
                MoinUIButton(localization.tr("button.label.round"), color: .primary, shape: .round) {}
                MoinUIButton(icon: "plus", color: .primary, shape: .circle) {}
            }
        } code: {
            """
            MoinUIButton("\(localization.tr("button.label.default"))", color: .primary, shape: .default) {}
            MoinUIButton("\(localization.tr("button.label.round"))", color: .primary, shape: .round) {}
            MoinUIButton(icon: "plus", color: .primary, shape: .circle) {}
            """
        }
    }

    private var loadingExample: some View {
        ExampleSection(
            title: localization.tr("button.loading"),
            description: localization.tr("button.loading_desc")
        ) {
            VStack(alignment: .leading, spacing: MoinUIConstants.Spacing.md) {
                HStack(spacing: MoinUIConstants.Spacing.md) {
                    MoinUIButton(localization.tr("button.label.loading"), color: .primary, loading: true) {}
                    MoinUIButton(localization.tr("button.label.loading"), color: .primary, size: .small, loading: true) {}
                    MoinUIButton(icon: "power", color: .primary, loading: true) {}
                    MoinUIButton(localization.tr("button.label.custom"), color: .primary, loading: MoinUIButtonLoading(true, icon: "face.smiling")) {}
                }
                HStack(spacing: MoinUIConstants.Spacing.md) {
                    MoinUIButton(localization.tr("button.label.click_load"), color: .primary, loading: MoinUIButtonLoading(loadings[0])) {
                        enterLoading(0)
                    }
                    MoinUIButton(localization.tr("button.label.icon_end"), color: .primary, iconPlacement: .end, loading: MoinUIButtonLoading(loadings[1])) {
                        enterLoading(1)
                    }
                    MoinUIButton(localization.tr("button.label.delay"), color: .primary, loading: MoinUIButtonLoading(loadings[2], delay: 0.5)) {
                        enterLoading(2)
                    }
                }
            }
        } code: {
            """
            // \(localization.tr("button.label.loading"))
            MoinUIButton("\(localization.tr("button.label.loading"))", color: .primary, loading: true) {}

            // \(localization.tr("button.label.custom"))
            MoinUIButton("\(localization.tr("button.label.custom"))", color: .primary, loading: MoinUIButtonLoading(true, icon: "face.smiling")) {}

            // \(localization.tr("button.label.delay"))
            MoinUIButton("\(localization.tr("button.label.delay"))", color: .primary, loading: MoinUIButtonLoading(isLoading, delay: 0.5)) {}
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
            HStack(spacing: MoinUIConstants.Spacing.md) {
                MoinUIButton(localization.tr("button.label.primary"), size: .large, icon: "sparkles", gradient: LinearGradient(
                    colors: [Color(hex: "#667eea"), Color(hex: "#764ba2")],
                    startPoint: .leading,
                    endPoint: .trailing
                ), fontColor: .white) {}
                MoinUIButton(localization.tr("button.label.warning"), size: .large, gradient: LinearGradient(
                    colors: [Color(hex: "#f093fb"), Color(hex: "#f5576c")],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ), fontColor: .white) {}
            }
        } code: {
            """
            MoinUIButton(
                "\(localization.tr("button.label.primary"))",
                size: .large,
                icon: "sparkles",
                gradient: LinearGradient(
                    colors: [Color(hex: "#667eea"), Color(hex: "#764ba2")],
                    startPoint: .leading,
                    endPoint: .trailing
                ),
                fontColor: .white
            ) {}

            MoinUIButton(
                "\(localization.tr("button.label.warning"))",
                size: .large,
                gradient: LinearGradient(
                    colors: [Color(hex: "#f093fb"), Color(hex: "#f5576c")],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ),
                fontColor: .white
            ) {}
            """
        }
    }

    private var iconExample: some View {
        ExampleSection(
            title: localization.tr("button.icon"),
            description: localization.tr("button.icon_desc")
        ) {
            HStack(spacing: MoinUIConstants.Spacing.md) {
                MoinUIButton(icon: "plus", color: .primary) {}
                MoinUIButton(icon: "pencil", color: .success) {}
                MoinUIButton(icon: "trash", color: .danger) {}
                MoinUIButton(icon: "magnifyingglass", color: .info) {}
            }
        } code: {
            """
            MoinUIButton(icon: "plus", color: .primary) {}
            MoinUIButton(icon: "pencil", color: .success) {}
            MoinUIButton(icon: "trash", color: .danger) {}
            MoinUIButton(icon: "magnifyingglass", color: .info) {}
            """
        }
    }

    private var iconTextExample: some View {
        ExampleSection(
            title: localization.tr("button.icon_text"),
            description: localization.tr("button.icon_text_desc")
        ) {
            HStack(spacing: MoinUIConstants.Spacing.md) {
                MoinUIButton(localization.tr("button.label.search"), color: .primary, icon: "magnifyingglass") {}
                MoinUIButton(localization.tr("button.label.download"), color: .success, icon: "arrow.down.circle") {}
                MoinUIButton(localization.tr("button.label.go"), color: .info, icon: "arrow.right", iconPlacement: .end) {}
            }
        } code: {
            """
            MoinUIButton("\(localization.tr("button.label.search"))", color: .primary, icon: "magnifyingglass") {}
            MoinUIButton("\(localization.tr("button.label.download"))", color: .success, icon: "arrow.down.circle") {}
            MoinUIButton("\(localization.tr("button.label.go"))", color: .info, icon: "arrow.right", iconPlacement: .end) {}
            """
        }
    }

    private var disabledExample: some View {
        ExampleSection(
            title: localization.tr("button.disabled"),
            description: localization.tr("button.disabled_desc")
        ) {
            VStack(alignment: .leading, spacing: MoinUIConstants.Spacing.md) {
                HStack(spacing: MoinUIConstants.Spacing.md) {
                    MoinUIButton(localization.tr("button.label.primary"), color: .primary, isDisabled: true) {}
                    MoinUIButton(localization.tr("button.label.default"), isDisabled: true) {}
                    MoinUIButton(localization.tr("button.label.dashed"), variant: .dashed, isDisabled: true) {}
                    MoinUIButton(localization.tr("button.label.text"), color: .primary, variant: .text, isDisabled: true) {}
                    MoinUIButton(localization.tr("button.label.link"), color: .primary, variant: .link, isDisabled: true) {}
                }
                HStack(spacing: MoinUIConstants.Spacing.md) {
                    MoinUIButton(localization.tr("button.label.danger"), color: .danger, isDisabled: true) {}
                    MoinUIButton(localization.tr("button.label.success"), color: .success, variant: .outlined, isDisabled: true) {}
                    MoinUIButton(localization.tr("button.label.custom"), color: .custom(MoinUIPresetColors.purple), variant: .solid, isDisabled: true) {}
                    MoinUIButton(icon: "plus", color: .primary, isDisabled: true) {}
                }
            }
        } code: {
            """
            MoinUIButton("\(localization.tr("button.label.primary"))", color: .primary, isDisabled: true) {}
            MoinUIButton("\(localization.tr("button.label.default"))", isDisabled: true) {}
            MoinUIButton("\(localization.tr("button.label.dashed"))", variant: .dashed, isDisabled: true) {}
            MoinUIButton("\(localization.tr("button.label.text"))", color: .primary, variant: .text, isDisabled: true) {}
            MoinUIButton("\(localization.tr("button.label.link"))", color: .primary, variant: .link, isDisabled: true) {}

            MoinUIButton("\(localization.tr("button.label.danger"))", color: .danger, isDisabled: true) {}
            MoinUIButton("\(localization.tr("button.label.success"))", color: .success, variant: .outlined, isDisabled: true) {}
            MoinUIButton("\(localization.tr("button.label.custom"))", color: .custom(MoinUIPresetColors.purple), variant: .solid, isDisabled: true) {}
            MoinUIButton(icon: "plus", color: .primary, isDisabled: true) {}
            """
        }
    }

    private var blockExample: some View {
        ExampleSection(
            title: localization.tr("button.block"),
            description: localization.tr("button.block_desc")
        ) {
            VStack(spacing: MoinUIConstants.Spacing.sm) {
                MoinUIButton(localization.tr("button.label.primary"), color: .primary, isBlock: true) {}
                MoinUIButton(localization.tr("button.label.default"), isBlock: true) {}
                MoinUIButton(localization.tr("button.label.dashed"), variant: .dashed, isBlock: true) {}
                MoinUIButton(localization.tr("button.label.text"), variant: .text, isBlock: true) {}
                MoinUIButton(localization.tr("button.label.link"), variant: .link, isBlock: true) {}
            }
        } code: {
            """
            MoinUIButton("\(localization.tr("button.label.primary"))", color: .primary, isBlock: true) {}
            MoinUIButton("\(localization.tr("button.label.default"))", isBlock: true) {}
            MoinUIButton("\(localization.tr("button.label.dashed"))", variant: .dashed, isBlock: true) {}
            MoinUIButton("\(localization.tr("button.label.text"))", variant: .text, isBlock: true) {}
            MoinUIButton("\(localization.tr("button.label.link"))", variant: .link, isBlock: true) {}
            """
        }
    }
}
