import SwiftUI
import MoinUI

/// 按钮组件文档页面 Tab
enum ButtonExamplesTab: String, CaseIterable {
    case examples
    case playground
    case api
    case token
}

/// Button component examples
struct ButtonExamples: View {
    @Localized var tr
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
        AnchorItem(id: "custom_content", titleKey: "button.custom_content"),
        AnchorItem(id: "disabled", titleKey: "button.disabled"),
        AnchorItem(id: "block", titleKey: "button.block"),
    ]

    var body: some View {
        Group {
            if selectedTab == .examples {
                examplesContent
            } else if selectedTab == .playground {
                playgroundContent
            } else if selectedTab == .api {
                apiContent
            } else {
                tokenContent
            }
        }
    }

    // MARK: - Examples Content

    private var examplesContent: some View {
        ExamplePageWithAnchor(pageName: "Button", anchors: anchors) { _ in
            colorVariantExample.id("color_variant")
            ghostExample.id("ghost")
            sizeExample.id("size")
            shapeExample.id("shape")
            loadingExample.id("loading")
            gradientExample.id("gradient")
            iconExample.id("icon")
            iconTextExample.id("icon_text")
            customContentExample.id("custom_content")
            disabledExample.id("disabled")
            blockExample.id("block")
        }
    }

    // MARK: - Playground Content

    private var playgroundContent: some View {
        ButtonPlayground()
            .padding(Moin.Constants.Spacing.xl)
    }

    // MARK: - API Content

    private var apiContent: some View {
        ButtonAPIContent()
    }

    // MARK: - Token Content

    private var tokenContent: some View {
        ButtonTokenContent()
    }

    // MARK: - Examples

    private var colorVariantExample: some View {
        ExampleSection(
            title: tr("button.color_variant"),
            description: tr("button.color_variant_desc")
        ) {
            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.md) {
                // Semantic Colors
                HStack(spacing: Moin.Constants.Spacing.sm) {
                    Moin.Button(tr("button.label.primary"), color: .primary) {}
                    Moin.Button(tr("button.label.success"), color: .success) {}
                    Moin.Button(tr("button.label.warning"), color: .warning) {}
                    Moin.Button(tr("button.label.danger"), color: .danger) {}
                    Moin.Button(tr("button.label.info"), color: .info) {}
                }
                // Default
                HStack(spacing: Moin.Constants.Spacing.sm) {
                    Moin.Button(tr("button.label.solid"), variant: .solid) {}
                    Moin.Button(tr("button.label.outlined"), variant: .outlined) {}
                    Moin.Button(tr("button.label.dashed"), variant: .dashed) {}
                    Moin.Button(tr("button.label.filled"), variant: .filled) {}
                    Moin.Button(tr("button.label.text"), variant: .text) {}
                    Moin.Button(tr("button.label.link"), variant: .link) {}
                }
                // Danger
                HStack(spacing: Moin.Constants.Spacing.sm) {
                    Moin.Button(tr("button.label.solid"), color: .danger, variant: .solid) {}
                    Moin.Button(tr("button.label.outlined"), color: .danger, variant: .outlined) {}
                    Moin.Button(tr("button.label.dashed"), color: .danger, variant: .dashed) {}
                    Moin.Button(tr("button.label.filled"), color: .danger, variant: .filled) {}
                    Moin.Button(tr("button.label.text"), color: .danger, variant: .text) {}
                    Moin.Button(tr("button.label.link"), color: .danger, variant: .link) {}
                }
                // Custom Color (Cyan)
                HStack(spacing: Moin.Constants.Spacing.sm) {
                    Moin.Button(tr("button.label.solid"), color: .cyan, variant: .solid) {}
                    Moin.Button(tr("button.label.outlined"), color: .cyan, variant: .outlined) {}
                    Moin.Button(tr("button.label.dashed"), color: .cyan, variant: .dashed) {}
                    Moin.Button(tr("button.label.filled"), color: .cyan, variant: .filled) {}
                    Moin.Button(tr("button.label.text"), color: .cyan, variant: .text) {}
                    Moin.Button(tr("button.label.link"), color: .cyan, variant: .link) {}
                }
                // Custom RGB Color
                HStack(spacing: Moin.Constants.Spacing.sm) {
                    Moin.Button(tr("button.label.solid"), color: .custom(Color(red: 0.6, green: 0.2, blue: 0.8)), variant: .solid) {}
                    Moin.Button(tr("button.label.outlined"), color: .custom(Color(red: 0.6, green: 0.2, blue: 0.8)), variant: .outlined) {}
                    Moin.Button(tr("button.label.dashed"), color: .custom(Color(red: 0.6, green: 0.2, blue: 0.8)), variant: .dashed) {}
                    Moin.Button(tr("button.label.filled"), color: .custom(Color(red: 0.6, green: 0.2, blue: 0.8)), variant: .filled) {}
                    Moin.Button(tr("button.label.text"), color: .custom(Color(red: 0.6, green: 0.2, blue: 0.8)), variant: .text) {}
                    Moin.Button(tr("button.label.link"), color: .custom(Color(red: 0.6, green: 0.2, blue: 0.8)), variant: .link) {}
                }
            }
        } code: {
            """
            // \(tr("code_comment.semantic_colors"))
            Moin.Button("\(tr("button.label.primary"))", color: .primary) {}
            Moin.Button("\(tr("button.label.success"))", color: .success) {}
            Moin.Button("\(tr("button.label.warning"))", color: .warning) {}
            Moin.Button("\(tr("button.label.danger"))", color: .danger) {}
            Moin.Button("\(tr("button.label.info"))", color: .info) {}

            // \(tr("code_comment.variants"))
            Moin.Button("\(tr("button.label.solid"))", variant: .solid) {}
            Moin.Button("\(tr("button.label.outlined"))", variant: .outlined) {}
            Moin.Button("\(tr("button.label.dashed"))", variant: .dashed) {}
            Moin.Button("\(tr("button.label.filled"))", variant: .filled) {}
            Moin.Button("\(tr("button.label.text"))", variant: .text) {}
            Moin.Button("\(tr("button.label.link"))", variant: .link) {}

            // \(tr("code_comment.color_with_variant"))
            Moin.Button("\(tr("button.label.outlined"))", color: .danger, variant: .outlined) {}

            // \(tr("code_comment.custom_color"))
            Moin.Button("\(tr("button.label.solid"))", color: .cyan) {}
            Moin.Button("\(tr("button.label.solid"))", color: .custom(Color(red: 0.6, green: 0.2, blue: 0.8))) {}
            """
        }
    }

    private var ghostExample: some View {
        ExampleSection(
            title: tr("button.ghost"),
            description: tr("button.ghost_desc")
        ) {
            ZStack {
                Color.gray.opacity(0.3)
                    .cornerRadius(Moin.Constants.Radius.md)
                HStack(spacing: Moin.Constants.Spacing.md) {
                    Moin.Button(tr("button.label.primary"), color: .primary, isGhost: true) {}
                    Moin.Button(tr("button.label.default"), isGhost: true) {}
                    Moin.Button(tr("button.label.dashed"), variant: .dashed, isGhost: true) {}
                    Moin.Button(tr("button.label.danger"), color: .danger, isGhost: true) {}
                }
                .padding(Moin.Constants.Spacing.lg)
            }
        } code: {
            """
            Moin.Button("\(tr("button.label.primary"))", color: .primary, isGhost: true) {}
            Moin.Button("\(tr("button.label.default"))", isGhost: true) {}
            Moin.Button("\(tr("button.label.dashed"))", variant: .dashed, isGhost: true) {}
            Moin.Button("\(tr("button.label.danger"))", color: .danger, isGhost: true) {}
            """
        }
    }

    private var sizeExample: some View {
        ExampleSection(
            title: tr("button.size"),
            description: tr("button.size_desc")
        ) {
            HStack(alignment: .center, spacing: Moin.Constants.Spacing.md) {
                Moin.Button(tr("button.label.small"), color: .primary, size: .small) {}
                Moin.Button(tr("button.label.medium"), color: .primary, size: .medium) {}
                Moin.Button(tr("button.label.large"), color: .primary, size: .large) {}
            }
        } code: {
            """
            Moin.Button("\(tr("button.label.small"))", color: .primary, size: .small) {}
            Moin.Button("\(tr("button.label.medium"))", color: .primary, size: .medium) {}
            Moin.Button("\(tr("button.label.large"))", color: .primary, size: .large) {}
            """
        }
    }

    private var shapeExample: some View {
        ExampleSection(
            title: tr("button.shape"),
            description: tr("button.shape_desc")
        ) {
            HStack(spacing: Moin.Constants.Spacing.md) {
                Moin.Button(tr("button.label.default"), color: .primary, shape: .default) {}
                Moin.Button(tr("button.label.round"), color: .primary, shape: .round) {}
                Moin.Button(icon: "plus", color: .primary, shape: .circle) {}
            }
        } code: {
            """
            Moin.Button("\(tr("button.label.default"))", color: .primary, shape: .default) {}
            Moin.Button("\(tr("button.label.round"))", color: .primary, shape: .round) {}
            Moin.Button(icon: "plus", color: .primary, shape: .circle) {}
            """
        }
    }

    private var loadingExample: some View {
        ExampleSection(
            title: tr("button.loading"),
            description: tr("button.loading_desc")
        ) {
            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.md) {
                HStack(spacing: Moin.Constants.Spacing.md) {
                    Moin.Button(tr("button.label.loading"), color: .primary, loading: true) {}
                    Moin.Button(tr("button.label.loading"), color: .primary, size: .small, loading: true) {}
                    Moin.Button(icon: "power", color: .primary, loading: true) {}
                    Moin.Button(tr("button.label.custom"), color: .primary, loading: Moin.ButtonLoading(true, icon: "face.smiling")) {}
                }
                HStack(spacing: Moin.Constants.Spacing.md) {
                    Moin.Button(tr("button.label.click_load"), color: .primary, loading: Moin.ButtonLoading(loadings[0])) {
                        enterLoading(0)
                    }
                    Moin.Button(tr("button.label.icon_end"), color: .primary, iconPlacement: .end, loading: Moin.ButtonLoading(loadings[1])) {
                        enterLoading(1)
                    }
                    Moin.Button(tr("button.label.delay"), color: .primary, loading: Moin.ButtonLoading(loadings[2], delay: 0.5)) {
                        enterLoading(2)
                    }
                }
            }
        } code: {
            """
            // \(tr("button.label.loading"))
            Moin.Button("\(tr("button.label.loading"))", color: .primary, loading: true) {}

            // \(tr("button.label.custom"))
            Moin.Button("\(tr("button.label.custom"))", color: .primary, loading: Moin.ButtonLoading(true, icon: "face.smiling")) {}

            // \(tr("button.label.delay"))
            Moin.Button("\(tr("button.label.delay"))", color: .primary, loading: Moin.ButtonLoading(isLoading, delay: 0.5)) {}
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
            title: tr("button.gradient"),
            description: tr("button.gradient_desc")
        ) {
            HStack(spacing: Moin.Constants.Spacing.md) {
                Moin.Button(tr("button.label.primary"), size: .large, icon: "sparkles", gradient: LinearGradient(
                    colors: [Color(hex: "#667eea"), Color(hex: "#764ba2")],
                    startPoint: .leading,
                    endPoint: .trailing
                ), fontColor: .white) {}
                Moin.Button(tr("button.label.warning"), size: .large, gradient: LinearGradient(
                    colors: [Color(hex: "#f093fb"), Color(hex: "#f5576c")],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ), fontColor: .white) {}
            }
        } code: {
            """
            Moin.Button(
                "\(tr("button.label.primary"))",
                size: .large,
                icon: "sparkles",
                gradient: LinearGradient(
                    colors: [Color(hex: "#667eea"), Color(hex: "#764ba2")],
                    startPoint: .leading,
                    endPoint: .trailing
                ),
                fontColor: .white
            ) {}

            Moin.Button(
                "\(tr("button.label.warning"))",
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
            title: tr("button.icon"),
            description: tr("button.icon_desc")
        ) {
            HStack(spacing: Moin.Constants.Spacing.md) {
                Moin.Button(icon: "plus", color: .primary) {}
                Moin.Button(icon: "pencil", color: .success) {}
                Moin.Button(icon: "trash", color: .danger) {}
                Moin.Button(icon: "magnifyingglass", color: .info) {}
            }
        } code: {
            """
            Moin.Button(icon: "plus", color: .primary) {}
            Moin.Button(icon: "pencil", color: .success) {}
            Moin.Button(icon: "trash", color: .danger) {}
            Moin.Button(icon: "magnifyingglass", color: .info) {}
            """
        }
    }

    private var iconTextExample: some View {
        ExampleSection(
            title: tr("button.icon_text"),
            description: tr("button.icon_text_desc")
        ) {
            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.md) {
                HStack(spacing: Moin.Constants.Spacing.md) {
                    Moin.Button(tr("button.label.search"), color: .primary, icon: "magnifyingglass") {}
                    Moin.Button(tr("button.label.download"), color: .success, icon: "arrow.down.circle") {}
                    Moin.Button(tr("button.label.go"), color: .info, icon: "arrow.right", iconPlacement: .end) {}
                }
                HStack(spacing: Moin.Constants.Spacing.md) {
                    Moin.Button(tr("button.label.search"), icon: "magnifyingglass", fontColor: .orange) {}
                    Moin.Button(tr("button.label.download"), icon: "arrow.down.circle", fontColor: .purple) {}
                }
            }
        } code: {
            """
            // 默认颜色
            Moin.Button("\(tr("button.label.search"))", color: .primary, icon: "magnifyingglass") {}
            Moin.Button("\(tr("button.label.download"))", color: .success, icon: "arrow.down.circle") {}
            Moin.Button("\(tr("button.label.go"))", color: .info, icon: "arrow.right", iconPlacement: .end) {}

            // 自定义前景色 (fontColor)
            Moin.Button("\(tr("button.label.search"))", icon: "magnifyingglass", fontColor: .orange) {}
            Moin.Button("\(tr("button.label.download"))", icon: "arrow.down.circle", fontColor: .purple) {}
            """
        }
    }

    private var customContentExample: some View {
        ExampleSection(
            title: tr("button.custom_content"),
            description: tr("button.custom_content_desc")
        ) {
            HStack(spacing: Moin.Constants.Spacing.md) {
                Moin.Button(color: .primary) {
                    HStack(spacing: Moin.Constants.Spacing.xs) {
                        Image(systemName: "star.fill")
                            .foregroundStyle(.yellow)
                        Text(tr("button.label.favorite"))
                    }
                }
                Moin.Button(color: .success, variant: .outlined) {
                    HStack(spacing: Moin.Constants.Spacing.xs) {
                        Circle()
                            .fill(.green)
                            .frame(width: 8, height: 8)
                        Text(tr("button.label.online"))
                    }
                }
            }
        } code: {
            """
            Moin.Button(color: .primary) {
                HStack(spacing: Moin.Constants.Spacing.xs) {
                    Image(systemName: "star.fill")
                        .foregroundStyle(.yellow)
                    Text("\(tr("button.label.favorite"))")
                }
            }

            Moin.Button(color: .success, variant: .outlined) {
                HStack(spacing: Moin.Constants.Spacing.xs) {
                    Circle()
                        .fill(.green)
                        .frame(width: 8, height: 8)
                    Text("\(tr("button.label.online"))")
                }
            }
            """
        }
    }

    private var disabledExample: some View {
        ExampleSection(
            title: tr("button.disabled"),
            description: tr("button.disabled_desc")
        ) {
            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.md) {
                HStack(spacing: Moin.Constants.Spacing.md) {
                    Moin.Button(tr("button.label.primary"), color: .primary, isDisabled: true) {}
                    Moin.Button(tr("button.label.default"), isDisabled: true) {}
                    Moin.Button(tr("button.label.dashed"), variant: .dashed, isDisabled: true) {}
                    Moin.Button(tr("button.label.text"), color: .primary, variant: .text, isDisabled: true) {}
                    Moin.Button(tr("button.label.link"), color: .primary, variant: .link, isDisabled: true) {}
                }
                HStack(spacing: Moin.Constants.Spacing.md) {
                    Moin.Button(tr("button.label.danger"), color: .danger, isDisabled: true) {}
                    Moin.Button(tr("button.label.success"), color: .success, variant: .outlined, isDisabled: true) {}
                    Moin.Button(tr("button.label.custom"), color: .purple, variant: .solid, isDisabled: true) {}
                    Moin.Button(icon: "plus", color: .primary, isDisabled: true) {}
                }
            }
        } code: {
            """
            Moin.Button("\(tr("button.label.primary"))", color: .primary, isDisabled: true) {}
            Moin.Button("\(tr("button.label.default"))", isDisabled: true) {}
            Moin.Button("\(tr("button.label.dashed"))", variant: .dashed, isDisabled: true) {}
            Moin.Button("\(tr("button.label.text"))", color: .primary, variant: .text, isDisabled: true) {}
            Moin.Button("\(tr("button.label.link"))", color: .primary, variant: .link, isDisabled: true) {}

            Moin.Button("\(tr("button.label.danger"))", color: .danger, isDisabled: true) {}
            Moin.Button("\(tr("button.label.success"))", color: .success, variant: .outlined, isDisabled: true) {}
            Moin.Button("\(tr("button.label.custom"))", color: .purple, variant: .solid, isDisabled: true) {}
            Moin.Button(icon: "plus", color: .primary, isDisabled: true) {}
            """
        }
    }

    private var blockExample: some View {
        ExampleSection(
            title: tr("button.block"),
            description: tr("button.block_desc")
        ) {
            VStack(spacing: Moin.Constants.Spacing.sm) {
                Moin.Button(tr("button.label.primary"), color: .primary, isBlock: true) {}
                Moin.Button(tr("button.label.default"), isBlock: true) {}
                Moin.Button(tr("button.label.dashed"), variant: .dashed, isBlock: true) {}
                Moin.Button(tr("button.label.text"), variant: .text, isBlock: true) {}
                Moin.Button(tr("button.label.link"), variant: .link, isBlock: true) {}
            }
        } code: {
            """
            Moin.Button("\(tr("button.label.primary"))", color: .primary, isBlock: true) {}
            Moin.Button("\(tr("button.label.default"))", isBlock: true) {}
            Moin.Button("\(tr("button.label.dashed"))", variant: .dashed, isBlock: true) {}
            Moin.Button("\(tr("button.label.text"))", variant: .text, isBlock: true) {}
            Moin.Button("\(tr("button.label.link"))", variant: .link, isBlock: true) {}
            """
        }
    }
}
