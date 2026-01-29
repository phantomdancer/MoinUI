import SwiftUI
import MoinUI

// MARK: - RateTokenView

struct RateTokenView: View {
    @Localized var tr
    @Environment(\.moinToken) var token
    @ObservedObject var config = Moin.ConfigProvider.shared

    @State private var previewValue: Double = 3

    // MARK: - Token Sections

    private var componentSections: [DocSidebarSection] {
        [
            DocSidebarSection(
                title: tr("doc.section.component_token"),
                items: [
                    .init(id: "starColor"),
                    .init(id: "starBg"),
                    .init(id: "starSize"),
                    .init(id: "starSizeSM"),
                    .init(id: "starSizeLG"),
                    .init(id: "starHoverScale")
                ],
                sectionId: "component"
            )
        ]
    }

    private var globalSections: [DocSidebarSection] {
        [
            DocSidebarSection(
                title: tr("doc.section.global_token"),
                items: [
                    .init(id: "yellow6"),
                    .init(id: "colorFillContent"),
                    .init(id: "controlHeight"),
                    .init(id: "controlHeightSM"),
                    .init(id: "controlHeightLG"),
                    .init(id: "marginXS")
                ],
                sectionId: "global"
            )
        ]
    }

    private var allSections: [DocSidebarSection] {
        componentSections + globalSections
    }

    // 重置所有 Token 到默认值
    private func resetAll() {
        config.seed = Moin.SeedToken.default
        config.regenerateTokens()
        config.components.rate = .generate(from: config.token)
    }

    var body: some View {
        ComponentDocBody(
            sections: allSections,
            initialItemId: "component"
        ) { sectionId in
            switch sectionId {
            case "component":
                Text(tr("doc.section.component_token")).font(.title3).fontWeight(.semibold)
            case "global":
                Text(tr("doc.section.global_token")).font(.title3).fontWeight(.semibold)
            default:
                EmptyView()
            }
        } item: { item in
            let globalItemIds = globalSections.flatMap { $0.items.map { $0.id } }
            if globalItemIds.contains(item) {
                cardForItem(item, sectionId: "global")
            } else {
                cardForItem(item, sectionId: "component")
            }
        } footer: {
            HStack(spacing: Moin.Constants.Spacing.sm) {
                Moin.Button(tr("playground.token.reset"), color: .primary, variant: .solid) {
                    resetAll()
                }

                Text(tr("playground.token.reset_desc"))
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)

                Spacer()
            }
            .padding(Moin.Constants.Spacing.md)
        }
    }

    @ViewBuilder
    private func cardForItem(_ item: String, sectionId: String) -> some View {
        if sectionId == "component" {
            switch item {
            case "starColor": AnyView(starColorCard)
            case "starBg": AnyView(starBgCard)
            case "starSize": AnyView(starSizeCard)
            case "starSizeSM": AnyView(starSizeSMCard)
            case "starSizeLG": AnyView(starSizeLGCard)
            case "starHoverScale": AnyView(starHoverScaleCard)
            default: AnyView(EmptyView())
            }
        } else {
            switch item {
            case "yellow6": AnyView(yellow6GlobalCard)
            case "colorFillContent": AnyView(colorFillContentGlobalCard)
            case "controlHeight": AnyView(controlHeightGlobalCard)
            case "controlHeightSM": AnyView(controlHeightSMGlobalCard)
            case "controlHeightLG": AnyView(controlHeightLGGlobalCard)
            case "marginXS": AnyView(marginXSGlobalCard)
            default: AnyView(EmptyView())
            }
        }
    }

    // MARK: - Component Token Cards

    private var starColorCard: some View {
        TokenCard(
            name: "starColor",
            type: "Color",
            defaultValue: "token.yellow6",
            description: tr("rate.token.starColor.desc"),
            sectionId: "component"
        ) {
            Moin.Rate(value: $previewValue)
        } editor: {
            ColorPresetRow(label: "starColor", color: Binding(
                get: { config.components.rate.starColor },
                set: { config.components.rate.starColor = $0 }
            ))
        } code: {
            "config.components.rate.starColor = Color(...)"
        }
        .scrollAnchor("component.starColor")
    }

    private var starBgCard: some View {
        TokenCard(
            name: "starBg",
            type: "Color",
            defaultValue: "token.colorFillContent",
            description: tr("rate.token.starBg.desc"),
            sectionId: "component"
        ) {
            Moin.Rate(value: .constant(2))
        } editor: {
            ColorPresetRow(label: "starBg", color: Binding(
                get: { config.components.rate.starBg },
                set: { config.components.rate.starBg = $0 }
            ))
        } code: {
            "config.components.rate.starBg = Color(...)"
        }
        .scrollAnchor("component.starBg")
    }

    private var starSizeCard: some View {
        TokenCard(
            name: "starSize",
            type: "CGFloat",
            defaultValue: "token.controlHeight × 0.625",
            description: tr("rate.token.starSize.desc"),
            sectionId: "component"
        ) {
            Moin.Rate(value: $previewValue, size: .medium)
        } editor: {
            TokenValueRow(label: "starSize", value: Binding(
                get: { config.components.rate.starSize },
                set: { config.components.rate.starSize = $0 }
            ), range: 12...40, step: 2)
        } code: {
            "config.components.rate.starSize = \(Int(config.components.rate.starSize))"
        }
        .scrollAnchor("component.starSize")
    }

    private var starSizeSMCard: some View {
        TokenCard(
            name: "starSizeSM",
            type: "CGFloat",
            defaultValue: "token.controlHeightSM × 0.625",
            description: tr("rate.token.starSizeSM.desc"),
            sectionId: "component"
        ) {
            Moin.Rate(value: $previewValue, size: .small)
        } editor: {
            TokenValueRow(label: "starSizeSM", value: Binding(
                get: { config.components.rate.starSizeSM },
                set: { config.components.rate.starSizeSM = $0 }
            ), range: 8...30, step: 1)
        } code: {
            "config.components.rate.starSizeSM = \(Int(config.components.rate.starSizeSM))"
        }
        .scrollAnchor("component.starSizeSM")
    }

    private var starSizeLGCard: some View {
        TokenCard(
            name: "starSizeLG",
            type: "CGFloat",
            defaultValue: "token.controlHeightLG × 0.625",
            description: tr("rate.token.starSizeLG.desc"),
            sectionId: "component"
        ) {
            Moin.Rate(value: $previewValue, size: .large)
        } editor: {
            TokenValueRow(label: "starSizeLG", value: Binding(
                get: { config.components.rate.starSizeLG },
                set: { config.components.rate.starSizeLG = $0 }
            ), range: 16...50, step: 2)
        } code: {
            "config.components.rate.starSizeLG = \(Int(config.components.rate.starSizeLG))"
        }
        .scrollAnchor("component.starSizeLG")
    }

    private var starHoverScaleCard: some View {
        TokenCard(
            name: "starHoverScale",
            type: "CGFloat",
            defaultValue: "1.1",
            description: tr("rate.token.starHoverScale.desc"),
            sectionId: "component"
        ) {
            VStack(alignment: .leading, spacing: 8) {
                Moin.Rate(value: $previewValue)
                Text(tr("rate.hover_to_see_effect"))
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        } editor: {
            TokenValueRow(label: "starHoverScale", value: Binding(
                get: { config.components.rate.starHoverScale },
                set: { config.components.rate.starHoverScale = $0 }
            ), range: 1.0...1.5, step: 0.05)
        } code: {
            "config.components.rate.starHoverScale = \(String(format: "%.2f", config.components.rate.starHoverScale))"
        }
        .scrollAnchor("component.starHoverScale")
    }



    // MARK: - Global Token Cards

    private var yellow6GlobalCard: some View {
        TokenCard(
            name: "yellow6",
            type: "Color",
            defaultValue: "#FADB14",
            description: tr("rate.token.global.yellow6.desc"),
            sectionId: "global"
        ) {
            Moin.Rate(value: $previewValue)
        } editor: {
            HStack {
                Text("Theme")
                Spacer()
                Picker("", selection: Binding(
                    get: { config.theme },
                    set: {
                        config.theme = $0
                        config.components.rate = .generate(from: config.token)
                    }
                )) {
                    Text("Light").tag(Moin.Theme.light)
                    Text("Dark").tag(Moin.Theme.dark)
                }
                .pickerStyle(.segmented)
                .frame(width: 140)
            }
        } code: {
            """
            // yellow6 \(tr("rate.token.global.derived_from")) theme
            config.theme = .light // or .dark
            config.components.rate = .generate(from: config.token)
            """
        }
        .scrollAnchor("global.yellow6")
    }

    private var colorFillContentGlobalCard: some View {
        TokenCard(
            name: "colorFillContent",
            type: "Color",
            defaultValue: "#000000 12%",
            description: tr("rate.token.global.colorFillContent.desc"),
            sectionId: "global"
        ) {
            Moin.Rate(value: .constant(2))
        } editor: {
            HStack {
                Text("Theme")
                Spacer()
                Picker("", selection: Binding(
                    get: { config.theme },
                    set: {
                        config.theme = $0
                        config.components.rate = .generate(from: config.token)
                    }
                )) {
                    Text("Light").tag(Moin.Theme.light)
                    Text("Dark").tag(Moin.Theme.dark)
                }
                .pickerStyle(.segmented)
                .frame(width: 140)
            }
        } code: {
            """
            // colorFillContent \(tr("rate.token.global.derived_from")) theme
            config.theme = .light // or .dark
            config.components.rate = .generate(from: config.token)
            """
        }
        .scrollAnchor("global.colorFillContent")
    }

    private var controlHeightGlobalCard: some View {
        TokenCard(
            name: "controlHeight",
            type: "CGFloat",
            defaultValue: "32",
            description: tr("rate.token.global.controlHeight.desc"),
            sectionId: "global"
        ) {
            Moin.Rate(value: $previewValue, size: .medium)
        } editor: {
            TokenValueRow(label: "controlHeight", value: $config.seed.controlHeight, range: 24...48, onChange: {
                config.regenerateTokens()
                config.components.rate = .generate(from: config.token)
            })
        } code: {
            """
            config.seed.controlHeight = \(Int(config.seed.controlHeight))
            config.regenerateTokens()
            // starSize = controlHeight × 0.625 = \(Int(config.seed.controlHeight * 0.625))
            """
        }
        .scrollAnchor("global.controlHeight")
    }

    private var controlHeightSMGlobalCard: some View {
        TokenCard(
            name: "controlHeightSM",
            type: "CGFloat",
            defaultValue: "24",
            description: tr("rate.token.global.controlHeightSM.desc"),
            sectionId: "global"
        ) {
            Moin.Rate(value: $previewValue, size: .small)
        } editor: {
            TokenValueRow(label: "controlHeight", value: $config.seed.controlHeight, range: 24...48, onChange: {
                config.regenerateTokens()
                config.components.rate = .generate(from: config.token)
            })
        } code: {
            """
            // controlHeightSM = controlHeight × 0.75
            config.seed.controlHeight = \(Int(config.seed.controlHeight))
            // starSizeSM = controlHeightSM × 0.625
            """
        }
        .scrollAnchor("global.controlHeightSM")
    }

    private var controlHeightLGGlobalCard: some View {
        TokenCard(
            name: "controlHeightLG",
            type: "CGFloat",
            defaultValue: "40",
            description: tr("rate.token.global.controlHeightLG.desc"),
            sectionId: "global"
        ) {
            Moin.Rate(value: $previewValue, size: .large)
        } editor: {
            TokenValueRow(label: "controlHeight", value: $config.seed.controlHeight, range: 24...48, onChange: {
                config.regenerateTokens()
                config.components.rate = .generate(from: config.token)
            })
        } code: {
            """
            // controlHeightLG = controlHeight × 1.25
            config.seed.controlHeight = \(Int(config.seed.controlHeight))
            // starSizeLG = controlHeightLG × 0.625
            """
        }
        .scrollAnchor("global.controlHeightLG")
    }

    private var marginXSGlobalCard: some View {
        TokenCard(
            name: "marginXS",
            type: "CGFloat",
            defaultValue: "8",
            description: tr("rate.token.global.marginXS.desc"),
            sectionId: "global"
        ) {
            Moin.Rate(value: $previewValue)
        } editor: {
            TokenValueRow(label: "sizeUnit", value: $config.seed.sizeUnit, range: 2...8, onChange: {
                config.regenerateTokens()
                config.components.rate = .generate(from: config.token)
            })
        } code: {
            """
            // marginXS = sizeUnit × 2
            config.seed.sizeUnit = \(Int(config.seed.sizeUnit))
            // star gap = marginXS = \(Int(config.seed.sizeUnit * 2))
            """
        }
        .scrollAnchor("global.marginXS")
    }
}
