import SwiftUI
import MoinUI

struct TimelineTokenView: View {
    @Localized var tr
    @Environment(\.moinToken) var token
    @ObservedObject var config = Moin.ConfigProvider.shared

    private var tokenSections: [DocSidebarSection] {
        [
            DocSidebarSection(
                title: tr("doc.section.component_token"),
                items: [
                    .init(id: "tailColor"),
                    .init(id: "tailWidth"),
                    .init(id: "dotSize"),
                    .init(id: "dotBorderWidth"),
                    .init(id: "dotBg"),
                    .init(id: "itemPaddingBottom"),
                    .init(id: "contentInsetStart")
                ],
                sectionId: "component"
            ),
            DocSidebarSection(
                title: tr("doc.section.global_token"),
                items: [
                    .init(id: "colorPrimary"),
                    .init(id: "colorSuccess"),
                    .init(id: "colorDanger")
                ],
                sectionId: "global"
            )
        ]
    }

    private func resetAll() {
        config.seed = Moin.SeedToken.default
        config.regenerateTokens()

        let defaultTimeline = Moin.TimelineToken.generate(from: config.token)
        config.components.timeline = defaultTimeline
    }

    var body: some View {
        ComponentDocBody(
            sections: tokenSections,
            initialItemId: "component"
        ) { sectionId in
            if sectionId == "component" {
                Text(tr("doc.section.component_token")).font(.title3).fontWeight(.semibold)
            } else if sectionId == "global" {
                Text(tr("doc.section.global_token")).font(.title3).fontWeight(.semibold)
            }
        } item: { item in
            cardForItem(item)
                .id(item)
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

    @ViewBuilder
    private func cardForItem(_ item: String) -> some View {
        switch item {
        // Component Token
        case "tailColor": tailColorCard
        case "tailWidth": tailWidthCard
        case "dotSize": dotSizeCard
        case "dotBorderWidth": dotBorderWidthCard
        case "dotBg": dotBgCard
        case "itemPaddingBottom": itemPaddingBottomCard
        case "contentInsetStart": contentInsetStartCard

        // Global Token
        case "colorPrimary": colorPrimaryCard
        case "colorSuccess": colorSuccessCard
        case "colorDanger": colorDangerCard

        default: EmptyView()
        }
    }

    // MARK: - Component Token Cards

    private var tailColorCard: some View {
        TokenCard(
            name: "tailColor",
            type: "Color",
            defaultValue: "colorBorderSecondary",
            description: tr("token.timeline.tailColor"),
            sectionId: "component"
        ) {
            InteractiveTimeline()
                .id(config.components.timeline.tailColor)
        } editor: {
            ColorPresetRow(
                label: "tailColor",
                color: $config.components.timeline.tailColor
            )
        }
    }

    private var tailWidthCard: some View {
        TokenCard(
            name: "tailWidth",
            type: "CGFloat",
            defaultValue: "\(Int(Moin.TimelineToken.default.tailWidth))",
            description: tr("token.timeline.tailWidth"),
            sectionId: "component"
        ) {
            InteractiveTimeline()
                .id(config.components.timeline.tailWidth)
        } editor: {
            TokenValueRow(
                label: "tailWidth",
                value: $config.components.timeline.tailWidth,
                range: 1...6
            )
        }
    }

    private var dotSizeCard: some View {
        TokenCard(
            name: "dotSize",
            type: "CGFloat",
            defaultValue: "\(Int(Moin.TimelineToken.default.dotSize))",
            description: tr("token.timeline.dotSize"),
            sectionId: "component"
        ) {
            InteractiveTimeline()
                .id(config.components.timeline.dotSize)
        } editor: {
            TokenValueRow(
                label: "dotSize",
                value: $config.components.timeline.dotSize,
                range: 6...24
            )
        }
    }

    private var dotBorderWidthCard: some View {
        TokenCard(
            name: "dotBorderWidth",
            type: "CGFloat",
            defaultValue: "\(Int(Moin.TimelineToken.default.dotBorderWidth))",
            description: tr("token.timeline.dotBorderWidth"),
            sectionId: "component"
        ) {
            InteractiveTimeline()
                .id(config.components.timeline.dotBorderWidth)
        } editor: {
            TokenValueRow(
                label: "dotBorderWidth",
                value: $config.components.timeline.dotBorderWidth,
                range: 1...6
            )
        }
    }

    private var dotBgCard: some View {
        TokenCard(
            name: "dotBg",
            type: "Color",
            defaultValue: "colorBgContainer",
            description: tr("token.timeline.dotBg"),
            sectionId: "component"
        ) {
            InteractiveTimeline()
                .id(config.components.timeline.dotBg)
        } editor: {
            ColorPresetRow(
                label: "dotBg",
                color: $config.components.timeline.dotBg
            )
        }
    }

    private var itemPaddingBottomCard: some View {
        TokenCard(
            name: "itemPaddingBottom",
            type: "CGFloat",
            defaultValue: "\(Int(Moin.TimelineToken.default.itemPaddingBottom))",
            description: tr("token.timeline.itemPaddingBottom"),
            sectionId: "component"
        ) {
            InteractiveTimeline()
                .id(config.components.timeline.itemPaddingBottom)
        } editor: {
            TokenValueRow(
                label: "itemPaddingBottom",
                value: $config.components.timeline.itemPaddingBottom,
                range: 8...48
            )
        }
    }

    private var contentInsetStartCard: some View {
        TokenCard(
            name: "contentInsetStart",
            type: "CGFloat",
            defaultValue: "\(Int(Moin.TimelineToken.default.contentInsetStart))",
            description: tr("token.timeline.contentInsetStart"),
            sectionId: "component"
        ) {
            InteractiveTimeline()
                .id(config.components.timeline.contentInsetStart)
        } editor: {
            TokenValueRow(
                label: "contentInsetStart",
                value: $config.components.timeline.contentInsetStart,
                range: 4...32
            )
        }
    }

    // MARK: - Global Token Cards

    private var colorPrimaryCard: some View {
        TokenCard(
            name: "colorPrimary",
            type: "Color",
            defaultValue: "#1677ff",
            description: tr("token.global.colorPrimary.hint"),
            sectionId: "global"
        ) {
            Moin.Timeline {
                Moin.Timeline.Item(tr("token.timeline.demo.step1"), color: .blue)
                Moin.Timeline.Item(tr("token.timeline.demo.step2"), color: .blue)
            }
        } editor: {
            ColorPresetRow(
                label: "colorPrimary",
                color: Binding(
                    get: { config.seed.colorPrimary },
                    set: {
                        config.seed.colorPrimary = $0
                        config.regenerateTokens()
                    }
                )
            )
        }
    }

    private var colorSuccessCard: some View {
        TokenCard(
            name: "colorSuccess",
            type: "Color",
            defaultValue: "#52c41a",
            description: tr("token.global.colorSuccess.hint"),
            sectionId: "global"
        ) {
            Moin.Timeline {
                Moin.Timeline.Item(tr("token.timeline.demo.step1"), color: .green)
                Moin.Timeline.Item(tr("token.timeline.demo.step2"), color: .green)
            }
        } editor: {
            ColorPresetRow(
                label: "colorSuccess",
                color: Binding(
                    get: { config.seed.colorSuccess },
                    set: {
                        config.seed.colorSuccess = $0
                        config.regenerateTokens()
                    }
                )
            )
        }
    }

    private var colorDangerCard: some View {
        TokenCard(
            name: "colorDanger",
            type: "Color",
            defaultValue: "#ff4d4f",
            description: tr("token.global.colorDanger.hint"),
            sectionId: "global"
        ) {
            Moin.Timeline {
                Moin.Timeline.Item(tr("token.timeline.demo.step1"), color: .red)
                Moin.Timeline.Item(tr("token.timeline.demo.step2"), color: .red)
            }
        } editor: {
            ColorPresetRow(
                label: "colorError",
                color: Binding(
                    get: { config.seed.colorError },
                    set: {
                        config.seed.colorError = $0
                        config.regenerateTokens()
                    }
                )
            )
        }
    }
}

// MARK: - Interactive Timeline

private struct InteractiveTimeline: View {
    @Localized var tr

    var body: some View {
        Moin.Timeline {
            Moin.Timeline.Item(tr("token.timeline.demo.step1"))
            Moin.Timeline.Item(tr("token.timeline.demo.step2"), color: .green)
            Moin.Timeline.Item(tr("token.timeline.demo.step3"), color: .gray)
        }
    }
}
