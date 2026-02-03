import SwiftUI
import MoinUI

struct PopoverTokenView: View {
    @Localized var tr
    @ObservedObject var config = Moin.ConfigProvider.shared

    private var tokenSections: [DocSidebarSection] {
        [
            DocSidebarSection(
                title: tr("token.popover.component"),
                items: [
                    .init(id: "titleMinWidth"),
                    .init(id: "zIndexPopup"),
                    .init(id: "innerPadding"),
                    .init(id: "titleMarginBottom")
                ],
                sectionId: "component"
            ),
            DocSidebarSection(
                title: tr("token.popover.global"),
                items: [
                    .init(id: "colorBgElevated"),
                    .init(id: "colorText"),
                    .init(id: "borderRadiusLG"),
                    .init(id: "fontSize"),
                    .init(id: "sizePopupArrow")
                ],
                sectionId: "global"
            )
        ]
    }

    private func resetAll() {
        config.seed = Moin.SeedToken.default
        config.regenerateTokens()
        config.components.popover = .generate(from: config.token)
        NotificationCenter.default.post(name: .popoverDocReset, object: nil)
    }

    var body: some View {
        ComponentDocBody(
            sections: tokenSections,
            initialItemId: "component"
        ) { sectionId in
            switch sectionId {
            case "component":
                Text(tr("token.popover.component"))
                    .font(.title3).fontWeight(.semibold)
            case "global":
                Text(tr("token.popover.global"))
                    .font(.title3).fontWeight(.semibold)
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
                Spacer()
            }
            .padding(Moin.Constants.Spacing.md)
        }
    }

    @ViewBuilder
    private func cardForItem(_ item: String) -> some View {
        switch item {
        case "titleMinWidth": titleMinWidthCard
        case "zIndexPopup": zIndexPopupCard
        case "innerPadding": innerPaddingCard
        case "titleMarginBottom": titleMarginBottomCard
        case "colorBgElevated": colorBgElevatedCard
        case "colorText": colorTextCard
        case "borderRadiusLG": borderRadiusLGCard
        case "fontSize": fontSizeCard
        case "sizePopupArrow": sizePopupArrowCard
        default: EmptyView()
        }
    }

    // MARK: - Preview

    private var previewPopover: some View {
        Moin.Popover("Title", content: {
            Moin.Button("Hover me") {}
        }, popoverContent: {
            VStack(alignment: .leading) {
                Text("Content")
                Text("Content")
            }
        }, placement: .right)
        .environment(\.moinPopoverToken, config.components.popover)
        .environment(\.moinToken, config.token)
    }

    // MARK: - Component Token Cards

    private var titleMinWidthCard: some View {
        TokenCard(
            name: "titleMinWidth",
            type: "CGFloat",
            defaultValue: "177",
            description: tr("popover.token_titleMinWidth_desc"),
            sectionId: "component",
            preview: { previewPopover },
            editor: {
                TokenValueRow(
                    label: "titleMinWidth",
                    value: $config.components.popover.titleMinWidth,
                    range: 100...300,
                    step: 10
                )
            },
            code: {
                "config.components.popover.titleMinWidth = \(Int(config.components.popover.titleMinWidth))"
            }
        )
        .scrollAnchor("popover.titleMinWidth")
    }

    private var zIndexPopupCard: some View {
        TokenCard(
            name: "zIndexPopup",
            type: "Int",
            defaultValue: "1030",
            description: tr("popover.token_zIndexPopup_desc"),
            sectionId: "component",
            preview: { previewPopover },
            editor: {
                TokenValueRow(
                    label: "zIndexPopup",
                    value: Binding(
                        get: { CGFloat(config.components.popover.zIndexPopup) },
                        set: { config.components.popover.zIndexPopup = Int($0) }
                    ),
                    range: 1000...2000,
                    step: 10
                )
            },
            code: {
                "config.components.popover.zIndexPopup = \(config.components.popover.zIndexPopup)"
            }
        )
        .scrollAnchor("popover.zIndexPopup")
    }

    private var innerPaddingCard: some View {
        TokenCard(
            name: "innerPadding",
            type: "CGFloat",
            defaultValue: "12",
            description: tr("popover.token_innerPadding_desc"),
            sectionId: "component",
            preview: { previewPopover },
            editor: {
                TokenValueRow(
                    label: "innerPadding",
                    value: $config.components.popover.innerPadding,
                    range: 4...24,
                    step: 2
                )
            },
            code: {
                "config.components.popover.innerPadding = \(Int(config.components.popover.innerPadding))"
            }
        )
        .scrollAnchor("popover.innerPadding")
    }

    private var titleMarginBottomCard: some View {
        TokenCard(
            name: "titleMarginBottom",
            type: "CGFloat",
            defaultValue: "8",
            description: tr("popover.token_titleMarginBottom_desc"),
            sectionId: "component",
            preview: { previewPopover },
            editor: {
                TokenValueRow(
                    label: "titleMarginBottom",
                    value: $config.components.popover.titleMarginBottom,
                    range: 0...16,
                    step: 2
                )
            },
            code: {
                "config.components.popover.titleMarginBottom = \(Int(config.components.popover.titleMarginBottom))"
            }
        )
        .scrollAnchor("popover.titleMarginBottom")
    }

    // MARK: - Global Token Cards

    private var colorBgElevatedCard: some View {
        TokenCard(
            name: "colorBgElevated",
            type: "Color",
            defaultValue: "#fff",
            description: tr("popover.token_colorBgElevated_desc"),
            sectionId: "global",
            preview: { previewPopover },
            editor: {
                ColorPresetRow(
                    label: "colorBgElevated",
                    color: $config.token.colorBgElevated
                )
            },
            code: {
                "config.token.colorBgElevated = .white"
            }
        )
        .scrollAnchor("popover.colorBgElevated")
    }

    private var colorTextCard: some View {
        TokenCard(
            name: "colorText",
            type: "Color",
            defaultValue: "rgba(0,0,0,0.88)",
            description: tr("popover.token_colorText_desc"),
            sectionId: "global",
            preview: { previewPopover },
            editor: {
                ColorPresetRow(
                    label: "colorText",
                    color: $config.token.colorText
                )
            },
            code: {
                "config.token.colorText = Color(hex: 0x000000, alpha: 0.88)"
            }
        )
        .scrollAnchor("popover.colorText")
    }

    private var borderRadiusLGCard: some View {
        TokenCard(
            name: "borderRadiusLG",
            type: "CGFloat",
            defaultValue: "8",
            description: tr("popover.token_borderRadiusLG_desc"),
            sectionId: "global",
            preview: { previewPopover },
            editor: {
                TokenValueRow(
                    label: "borderRadiusLG",
                    value: $config.token.borderRadiusLG,
                    range: 0...24,
                    step: 1
                )
            },
            code: {
                "config.token.borderRadiusLG = \(Int(config.token.borderRadiusLG))"
            }
        )
        .scrollAnchor("popover.borderRadiusLG")
    }

    private var fontSizeCard: some View {
        TokenCard(
            name: "fontSize",
            type: "CGFloat",
            defaultValue: "14",
            description: tr("popover.token_fontSize_desc"),
            sectionId: "global",
            preview: { previewPopover },
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
        .scrollAnchor("popover.fontSize")
    }

    private var sizePopupArrowCard: some View {
        TokenCard(
            name: "sizePopupArrow",
            type: "CGFloat",
            defaultValue: "6",
            description: tr("popover.token_sizePopupArrow_desc"),
            sectionId: "global",
            preview: { previewPopover },
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
        .scrollAnchor("popover.sizePopupArrow")
    }
}

extension Notification.Name {
    static let popoverDocReset = Notification.Name("popoverDocReset")
}
