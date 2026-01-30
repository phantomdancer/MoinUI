import SwiftUI
import MoinUI

// MARK: - TooltipTokenView

/// Tooltip 组件 Token 文档视图
struct TooltipTokenView: View {
    @Localized var tr
    @ObservedObject var config = Moin.ConfigProvider.shared

    // MARK: - Token Sections

    private var tokenSections: [DocSidebarSection] {
        [
            DocSidebarSection(
                title: tr("token.tooltip.component"),
                items: [
                    .init(id: "borderRadius"),
                    .init(id: "paddingVertical"),
                    .init(id: "paddingHorizontal"),
                    .init(id: "arrowSize"),
                    .init(id: "colorBg"),
                    .init(id: "colorText"),
                    .init(id: "fontSize")
                ],
                sectionId: "component"
            )
        ]
    }

    // 重置所有 Token 到默认值
    private func resetAll() {
        config.seed = Moin.SeedToken.default
        config.regenerateTokens()
        config.components.tooltip = .generate(from: config.token)
        NotificationCenter.default.post(name: .tooltipDocReset, object: nil)
    }

    var body: some View {
        ComponentDocBody(
            sections: tokenSections,
            initialItemId: "component"
        ) { sectionId in
            if sectionId == "component" {
                Text(tr("token.tooltip.component"))
                    .font(.title3)
                    .fontWeight(.semibold)
            }
        } item: { item in
            cardForItem(item)
        } footer: {
            HStack(spacing: Moin.Constants.Spacing.sm) {
                Moin.Button(tr("playground.token.reset"), color: .primary, variant: .solid) {
                    resetAll()
                }

                Text(tr("token.playground.reset_desc"))
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)

                Spacer()
            }
            .padding(Moin.Constants.Spacing.md)
        }
    }

    // MARK: - Item -> Card 映射

    @ViewBuilder
    private func cardForItem(_ item: String) -> some View {
        switch item {
        case "borderRadius": borderRadiusTokenCard
        case "paddingVertical": paddingVerticalTokenCard
        case "paddingHorizontal": paddingHorizontalTokenCard
        case "arrowSize": arrowSizeTokenCard
        case "colorBg": colorBgTokenCard
        case "colorText": colorTextTokenCard
        case "fontSize": fontSizeTokenCard
        default: EmptyView()
        }
    }

    // MARK: - Preview

    private var previewTooltip: some View {
        Moin.Tooltip(tr("tooltip.prompt_text"), placement: .right) {
            Moin.Button("Hover me") {}
        }
    }

    // MARK: - borderRadius

    private var borderRadiusTokenCard: some View {
        TokenCard(
            name: "borderRadius",
            type: "CGFloat",
            defaultValue: "6",
            description: tr("tooltip.token_borderRadius_desc"),
            sectionId: "component",
            preview: { previewTooltip },
            editor: {
                TokenValueRow(
                    label: "borderRadius",
                    value: $config.components.tooltip.borderRadius,
                    range: 0...20,
                    step: 1
                )
            },
            code: {
                "config.components.tooltip.borderRadius = \(Int(config.components.tooltip.borderRadius))"
            }
        )
        .scrollAnchor("tooltip.borderRadius")
    }

    // MARK: - paddingVertical

    private var paddingVerticalTokenCard: some View {
        TokenCard(
            name: "paddingVertical",
            type: "CGFloat",
            defaultValue: "6",
            description: tr("tooltip.token_paddingVertical_desc"),
            sectionId: "component",
            preview: { previewTooltip },
            editor: {
                TokenValueRow(
                    label: "paddingVertical",
                    value: $config.components.tooltip.paddingVertical,
                    range: 0...20,
                    step: 1
                )
            },
            code: {
                "config.components.tooltip.paddingVertical = \(Int(config.components.tooltip.paddingVertical))"
            }
        )
        .scrollAnchor("tooltip.paddingVertical")
    }

    // MARK: - paddingHorizontal

    private var paddingHorizontalTokenCard: some View {
        TokenCard(
            name: "paddingHorizontal",
            type: "CGFloat",
            defaultValue: "8",
            description: tr("tooltip.token_paddingHorizontal_desc"),
            sectionId: "component",
            preview: { previewTooltip },
            editor: {
                TokenValueRow(
                    label: "paddingHorizontal",
                    value: $config.components.tooltip.paddingHorizontal,
                    range: 0...30,
                    step: 1
                )
            },
            code: {
                "config.components.tooltip.paddingHorizontal = \(Int(config.components.tooltip.paddingHorizontal))"
            }
        )
        .scrollAnchor("tooltip.paddingHorizontal")
    }

    // MARK: - arrowSize

    private var arrowSizeTokenCard: some View {
        TokenCard(
            name: "arrowSize",
            type: "CGFloat",
            defaultValue: "8",
            description: tr("tooltip.token_arrowSize_desc"),
            sectionId: "component",
            preview: { previewTooltip },
            editor: {
                TokenValueRow(
                    label: "arrowSize",
                    value: $config.components.tooltip.arrowSize,
                    range: 4...16,
                    step: 1
                )
            },
            code: {
                "config.components.tooltip.arrowSize = \(Int(config.components.tooltip.arrowSize))"
            }
        )
        .scrollAnchor("tooltip.arrowSize")
    }

    // MARK: - colorBg

    private var colorBgTokenCard: some View {
        TokenCard(
            name: "colorBg",
            type: "Color",
            defaultValue: "rgba(0,0,0,0.85)",
            description: tr("tooltip.token_colorBg_desc"),
            sectionId: "component",
            preview: { previewTooltip },
            editor: {
                ColorPresetRow(
                    label: "colorBg",
                    color: $config.components.tooltip.colorBg
                )
            },
            code: {
                "config.components.tooltip.colorBg = Color(hex: 0x000000, alpha: 0.85)"
            }
        )
        .scrollAnchor("tooltip.colorBg")
    }

    // MARK: - colorText

    private var colorTextTokenCard: some View {
        TokenCard(
            name: "colorText",
            type: "Color",
            defaultValue: ".white",
            description: tr("tooltip.token_colorText_desc"),
            sectionId: "component",
            preview: { previewTooltip },
            editor: {
                ColorPresetRow(
                    label: "colorText",
                    color: $config.components.tooltip.colorText
                )
            },
            code: {
                "config.components.tooltip.colorText = .white"
            }
        )
        .scrollAnchor("tooltip.colorText")
    }

    // MARK: - fontSize

    private var fontSizeTokenCard: some View {
        TokenCard(
            name: "fontSize",
            type: "CGFloat",
            defaultValue: "14",
            description: tr("tooltip.token_fontSize_desc"),
            sectionId: "component",
            preview: { previewTooltip },
            editor: {
                TokenValueRow(
                    label: "fontSize",
                    value: $config.components.tooltip.fontSize,
                    range: 10...20,
                    step: 1
                )
            },
            code: {
                "config.components.tooltip.fontSize = \(Int(config.components.tooltip.fontSize))"
            }
        )
        .scrollAnchor("tooltip.fontSize")
    }
}

// MARK: - Notification Name Extension

extension Notification.Name {
    static let tooltipDocReset = Notification.Name("tooltipDocReset")
}
