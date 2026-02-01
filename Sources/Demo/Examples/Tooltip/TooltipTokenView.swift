import SwiftUI
import MoinUI

// MARK: - TooltipTokenView

/// Tooltip 组件 Token 文档视图
/// 严格按照 Ant Design: 组件 Token + 全局 Token 分开展示
struct TooltipTokenView: View {
    @Localized var tr
    @ObservedObject var config = Moin.ConfigProvider.shared

    // MARK: - Token Sections

    private var tokenSections: [DocSidebarSection] {
        [
            // 组件 Token (仅2个)
            DocSidebarSection(
                title: tr("token.tooltip.component"),
                items: [
                    .init(id: "maxWidth"),
                    .init(id: "zIndexPopup")
                ],
                sectionId: "component"
            ),
            // 全局 Token
            DocSidebarSection(
                title: tr("token.tooltip.global"),
                items: [
                    .init(id: "colorBgSpotlight"),
                    .init(id: "colorTextLightSolid"),
                    .init(id: "borderRadius"),
                    .init(id: "fontSize"),
                    .init(id: "paddingSM"),
                    .init(id: "paddingXS"),
                    .init(id: "sizePopupArrow"),
                    .init(id: "motionDurationMid")
                ],
                sectionId: "global"
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
            switch sectionId {
            case "component":
                Text(tr("token.tooltip.component"))
                    .font(.title3)
                    .fontWeight(.semibold)
            case "global":
                Text(tr("token.tooltip.global"))
                    .font(.title3)
                    .fontWeight(.semibold)
            default:
                EmptyView()
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
        // 组件 Token
        case "maxWidth": maxWidthTokenCard
        case "zIndexPopup": zIndexPopupTokenCard
        // 全局 Token
        case "colorBgSpotlight": colorBgSpotlightTokenCard
        case "colorTextLightSolid": colorTextLightSolidTokenCard
        case "borderRadius": borderRadiusTokenCard
        case "fontSize": fontSizeTokenCard
        case "paddingSM": paddingSMTokenCard
        case "paddingXS": paddingXSTokenCard
        case "sizePopupArrow": sizePopupArrowTokenCard
        case "motionDurationMid": motionDurationMidTokenCard
        default: EmptyView()
        }
    }

    // MARK: - Preview

    private var previewTooltip: some View {
        Moin.Tooltip(tr("tooltip.prompt_text"), placement: .right) {
            Moin.Button("Hover me") {}
        }
    }

    // MARK: - 组件 Token: maxWidth

    private var maxWidthTokenCard: some View {
        TokenCard(
            name: "maxWidth",
            type: "CGFloat",
            defaultValue: "250",
            description: tr("tooltip.token_maxWidth_desc"),
            sectionId: "component",
            preview: { previewTooltip },
            editor: {
                TokenValueRow(
                    label: "maxWidth",
                    value: $config.components.tooltip.maxWidth,
                    range: 100...500,
                    step: 10
                )
            },
            code: {
                "config.components.tooltip.maxWidth = \(Int(config.components.tooltip.maxWidth))"
            }
        )
        .scrollAnchor("tooltip.maxWidth")
    }

    // MARK: - 组件 Token: zIndexPopup

    private var zIndexPopupTokenCard: some View {
        TokenCard(
            name: "zIndexPopup",
            type: "Int",
            defaultValue: "1070",
            description: tr("tooltip.token_zIndexPopup_desc"),
            sectionId: "component",
            preview: { previewTooltip },
            editor: {
                TokenValueRow(
                    label: "zIndexPopup",
                    value: Binding(
                        get: { CGFloat(config.components.tooltip.zIndexPopup) },
                        set: { config.components.tooltip.zIndexPopup = Int($0) }
                    ),
                    range: 1000...2000,
                    step: 10
                )
            },
            code: {
                "config.components.tooltip.zIndexPopup = \(config.components.tooltip.zIndexPopup)"
            }
        )
        .scrollAnchor("tooltip.zIndexPopup")
    }

    // MARK: - 全局 Token: colorBgSpotlight

    private var colorBgSpotlightTokenCard: some View {
        TokenCard(
            name: "colorBgSpotlight",
            type: "Color",
            defaultValue: "rgba(0,0,0,0.85)",
            description: tr("tooltip.token_colorBgSpotlight_desc"),
            sectionId: "global",
            preview: { previewTooltip },
            editor: {
                ColorPresetRow(
                    label: "colorBgSpotlight",
                    color: $config.token.colorBgSpotlight
                )
            },
            code: {
                "config.token.colorBgSpotlight = Color(hex: 0x000000, alpha: 0.85)"
            }
        )
        .scrollAnchor("tooltip.colorBgSpotlight")
    }

    // MARK: - 全局 Token: colorTextLightSolid

    private var colorTextLightSolidTokenCard: some View {
        TokenCard(
            name: "colorTextLightSolid",
            type: "Color",
            defaultValue: "#fff",
            description: tr("tooltip.token_colorTextLightSolid_desc"),
            sectionId: "global",
            preview: { previewTooltip },
            editor: {
                ColorPresetRow(
                    label: "colorTextLightSolid",
                    color: $config.token.colorTextLightSolid
                )
            },
            code: {
                "config.token.colorTextLightSolid = .white"
            }
        )
        .scrollAnchor("tooltip.colorTextLightSolid")
    }

    // MARK: - 全局 Token: borderRadius

    private var borderRadiusTokenCard: some View {
        TokenCard(
            name: "borderRadius",
            type: "CGFloat",
            defaultValue: "6",
            description: tr("tooltip.token_borderRadius_desc"),
            sectionId: "global",
            preview: { previewTooltip },
            editor: {
                TokenValueRow(
                    label: "borderRadius",
                    value: $config.token.borderRadius,
                    range: 0...20,
                    step: 1
                )
            },
            code: {
                "config.token.borderRadius = \(Int(config.token.borderRadius))"
            }
        )
        .scrollAnchor("tooltip.borderRadius")
    }

    // MARK: - 全局 Token: fontSize

    private var fontSizeTokenCard: some View {
        TokenCard(
            name: "fontSize",
            type: "CGFloat",
            defaultValue: "14",
            description: tr("tooltip.token_fontSize_desc"),
            sectionId: "global",
            preview: { previewTooltip },
            editor: {
                TokenValueRow(
                    label: "fontSize",
                    value: $config.token.fontSize,
                    range: 10...20,
                    step: 1
                )
            },
            code: {
                "config.token.fontSize = \(Int(config.token.fontSize))"
            }
        )
        .scrollAnchor("tooltip.fontSize")
    }

    // MARK: - 全局 Token: paddingSM

    private var paddingSMTokenCard: some View {
        TokenCard(
            name: "paddingSM",
            type: "CGFloat",
            defaultValue: "12",
            description: tr("tooltip.token_paddingSM_desc"),
            sectionId: "global",
            preview: { previewTooltip },
            editor: {
                TokenValueRow(
                    label: "paddingSM",
                    value: $config.token.paddingSM,
                    range: 4...24,
                    step: 1
                )
            },
            code: {
                "config.token.paddingSM = \(Int(config.token.paddingSM))"
            }
        )
        .scrollAnchor("tooltip.paddingSM")
    }

    // MARK: - 全局 Token: paddingXS

    private var paddingXSTokenCard: some View {
        TokenCard(
            name: "paddingXS",
            type: "CGFloat",
            defaultValue: "8",
            description: tr("tooltip.token_paddingXS_desc"),
            sectionId: "global",
            preview: { previewTooltip },
            editor: {
                TokenValueRow(
                    label: "paddingXS",
                    value: $config.token.paddingXS,
                    range: 2...16,
                    step: 1
                )
            },
            code: {
                "config.token.paddingXS = \(Int(config.token.paddingXS))"
            }
        )
        .scrollAnchor("tooltip.paddingXS")
    }

    // MARK: - 全局 Token: sizePopupArrow

    private var sizePopupArrowTokenCard: some View {
        TokenCard(
            name: "sizePopupArrow",
            type: "CGFloat",
            defaultValue: "6",
            description: tr("tooltip.token_sizePopupArrow_desc"),
            sectionId: "global",
            preview: { previewTooltip },
            editor: {
                TokenValueRow(
                    label: "sizePopupArrow",
                    value: $config.token.sizePopupArrow,
                    range: 4...16,
                    step: 1
                )
            },
            code: {
                "config.token.sizePopupArrow = \(Int(config.token.sizePopupArrow))"
            }
        )
        .scrollAnchor("tooltip.sizePopupArrow")
    }

    // MARK: - 全局 Token: motionDurationMid

    private var motionDurationMidTokenCard: some View {
        TokenCard(
            name: "motionDurationMid",
            type: "Double",
            defaultValue: "0.2",
            description: tr("tooltip.token_motionDurationMid_desc"),
            sectionId: "global",
            preview: { previewTooltip },
            editor: {
                TokenValueRow(
                    label: "motionDurationMid",
                    value: Binding(
                        get: { CGFloat(config.token.motionDurationMid) },
                        set: { config.token.motionDurationMid = Double($0) }
                    ),
                    range: 0.05...0.5,
                    step: 0.05
                )
            },
            code: {
                "config.token.motionDurationMid = \(config.token.motionDurationMid)"
            }
        )
        .scrollAnchor("tooltip.motionDurationMid")
    }
}

// MARK: - Notification Name Extension

extension Notification.Name {
    static let tooltipDocReset = Notification.Name("tooltipDocReset")
}
