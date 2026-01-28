import SwiftUI
import MoinUI

// MARK: - SkeletonTokenView

struct SkeletonTokenView: View {
    @Localized var tr
    @Environment(\.moinToken) var token
    @ObservedObject var config = Moin.ConfigProvider.shared

    // MARK: - Token Sections

    private var componentSections: [DocSidebarSection] {
        [
            DocSidebarSection(
                title: tr("doc.section.component_token"),
                items: [
                    .init(id: "gradientFromColor"),
                    .init(id: "gradientToColor"),
                    .init(id: "titleHeight"),
                    .init(id: "paragraphLiHeight"),
                    .init(id: "paragraphMarginTop"),
                    .init(id: "blockRadius")
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
                    .init(id: "colorFillSecondary"),
                    .init(id: "colorFill"),
                    .init(id: "controlHeight"),
                    .init(id: "controlHeightSM"),
                    .init(id: "controlHeightLG"),
                    .init(id: "borderRadiusSM"),
                    .init(id: "marginLG"),
                    .init(id: "marginXXS")
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
        config.components.skeleton = .generate(from: config.token)
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
            case "gradientFromColor": AnyView(gradientFromColorCard)
            case "gradientToColor": AnyView(gradientToColorCard)
            case "titleHeight": AnyView(titleHeightCard)
            case "paragraphLiHeight": AnyView(paragraphLiHeightCard)
            case "paragraphMarginTop": AnyView(paragraphMarginTopCard)
            case "blockRadius": AnyView(blockRadiusCard)
            default: AnyView(EmptyView())
            }
        } else {
            switch item {
            case "colorFill": AnyView(colorFillGlobalCard)
            case "colorFillSecondary": AnyView(colorFillSecondaryGlobalCard)
            case "controlHeight": AnyView(controlHeightGlobalCard)
            case "controlHeightSM": AnyView(controlHeightSMGlobalCard)
            case "controlHeightLG": AnyView(controlHeightLGGlobalCard)
            case "borderRadiusSM": AnyView(borderRadiusSMGlobalCard)
            case "marginLG": AnyView(marginLGGlobalCard)
            case "marginXXS": AnyView(marginXXSGlobalCard)
            default: AnyView(EmptyView())
            }
        }
    }

    // MARK: - Component Token Cards

    private var gradientFromColorCard: some View {
        TokenCard(
            name: "gradientFromColor",
            type: "Color",
            defaultValue: "token.colorFillSecondary",
            description: tr("skeleton.token.gradientFromColor.desc"),
            sectionId: "component"
        ) {
            Moin.Skeleton(active: false)
                .frame(width: 200)
        } editor: {
            ColorPresetRow(label: "gradientFromColor", color: Binding(
                get: { config.components.skeleton.gradientFromColor },
                set: { config.components.skeleton.gradientFromColor = $0 }
            ))
        } code: {
            "config.components.skeleton.gradientFromColor = Color(...)"
        }
        .scrollAnchor("component.gradientFromColor")
    }

    private var gradientToColorCard: some View {
        TokenCard(
            name: "gradientToColor",
            type: "Color",
            defaultValue: "token.colorFill",
            description: tr("skeleton.token.gradientToColor.desc"),
            sectionId: "component"
        ) {
            Moin.Skeleton(active: true)
                .frame(width: 200)
        } editor: {
            ColorPresetRow(label: "gradientToColor", color: Binding(
                get: { config.components.skeleton.gradientToColor },
                set: { config.components.skeleton.gradientToColor = $0 }
            ))
        } code: {
            "config.components.skeleton.gradientToColor = Color(...)"
        }
        .scrollAnchor("component.gradientToColor")
    }

    private var titleHeightCard: some View {
        TokenCard(
            name: "titleHeight",
            type: "CGFloat",
            defaultValue: "token.controlHeight / 2",
            description: tr("skeleton.token.titleHeight.desc"),
            sectionId: "component"
        ) {
            Moin.Skeleton(title: true, paragraph: false)
                .frame(width: 200)
        } editor: {
            TokenValueRow(label: "titleHeight", value: Binding(
                get: { config.components.skeleton.titleHeight },
                set: { config.components.skeleton.titleHeight = $0 }
            ), range: 8...32, step: 2)
        } code: {
            "config.components.skeleton.titleHeight = \(Int(config.components.skeleton.titleHeight))"
        }
        .scrollAnchor("component.titleHeight")
    }

    private var paragraphLiHeightCard: some View {
        TokenCard(
            name: "paragraphLiHeight",
            type: "CGFloat",
            defaultValue: "token.controlHeight / 2",
            description: tr("skeleton.token.paragraphLiHeight.desc"),
            sectionId: "component"
        ) {
            Moin.Skeleton(title: false, paragraph: true)
                .frame(width: 200)
        } editor: {
            TokenValueRow(label: "paragraphLiHeight", value: Binding(
                get: { config.components.skeleton.paragraphLiHeight },
                set: { config.components.skeleton.paragraphLiHeight = $0 }
            ), range: 8...32, step: 2)
        } code: {
            "config.components.skeleton.paragraphLiHeight = \(Int(config.components.skeleton.paragraphLiHeight))"
        }
        .scrollAnchor("component.paragraphLiHeight")
    }

    private var paragraphMarginTopCard: some View {
        TokenCard(
            name: "paragraphMarginTop",
            type: "CGFloat",
            defaultValue: "token.marginLG + token.marginXXS",
            description: tr("skeleton.token.paragraphMarginTop.desc"),
            sectionId: "component"
        ) {
            Moin.Skeleton(avatar: true)
                .padding(.leading, 16)
                .frame(width: 220)
        } editor: {
            TokenValueRow(label: "paragraphMarginTop", value: Binding(
                get: { config.components.skeleton.paragraphMarginTop },
                set: { config.components.skeleton.paragraphMarginTop = $0 }
            ), range: 0...48, step: 2)
        } code: {
            "config.components.skeleton.paragraphMarginTop = \(Int(config.components.skeleton.paragraphMarginTop))"
        }
        .scrollAnchor("component.paragraphMarginTop")
    }

    private var blockRadiusCard: some View {
        TokenCard(
            name: "blockRadius",
            type: "CGFloat",
            defaultValue: "token.borderRadiusSM",
            description: tr("skeleton.token.blockRadius.desc"),
            sectionId: "component"
        ) {
            Moin.Skeleton()
                .frame(width: 200)
        } editor: {
            TokenValueRow(label: "blockRadius", value: Binding(
                get: { config.components.skeleton.blockRadius },
                set: { config.components.skeleton.blockRadius = $0 }
            ), range: 0...16, step: 1)
        } code: {
            "config.components.skeleton.blockRadius = \(Int(config.components.skeleton.blockRadius))"
        }
        .scrollAnchor("component.blockRadius")
    }

    // MARK: - Global Token Cards

    private var colorFillSecondaryGlobalCard: some View {
        TokenCard(
            name: "colorFillSecondary",
            type: "Color",
            defaultValue: "#000000 6%",
            description: tr("skeleton.token.global.colorFillSecondary.desc"),
            sectionId: "global"
        ) {
            Moin.Skeleton(active: false)
                .frame(width: 200)
        } editor: {
            HStack {
                Text("Theme")
                Spacer()
                Picker("", selection: Binding(
                    get: { config.theme },
                    set: {
                        config.theme = $0
                        config.components.skeleton = .generate(from: config.token)
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
            // colorFillSecondary \(tr("skeleton.token.global.derived_from")) theme
            // Light: #000000 6%, Dark: #FFFFFF 12%
            config.theme = .light // or .dark
            config.components.skeleton = .generate(from: config.token)
            """
        }
        .scrollAnchor("global.colorFillSecondary")
    }

    private var colorFillGlobalCard: some View {
        TokenCard(
            name: "colorFill",
            type: "Color",
            defaultValue: "#000000 15%",
            description: tr("skeleton.token.global.colorFill.desc"),
            sectionId: "global"
        ) {
            Moin.Skeleton(active: true)
                .frame(width: 200)
        } editor: {
            HStack {
                Text("Theme")
                Spacer()
                Picker("", selection: Binding(
                    get: { config.theme },
                    set: {
                        config.theme = $0
                        config.components.skeleton = .generate(from: config.token)
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
            // colorFill \(tr("skeleton.token.global.derived_from")) theme
            // Light: #000000 15%, Dark: #FFFFFF 18%
            config.theme = .light // or .dark
            config.components.skeleton = .generate(from: config.token)
            """
        }
        .scrollAnchor("global.colorFill")
    }

    private var controlHeightGlobalCard: some View {
        TokenCard(
            name: "controlHeight",
            type: "CGFloat",
            defaultValue: "32",
            description: tr("skeleton.token.global.controlHeight.desc"),
            sectionId: "global"
        ) {
            HStack(spacing: Moin.Constants.Spacing.md) {
                Moin.SkeletonAvatar(size: .small)
                Moin.SkeletonAvatar(size: .default)
                Moin.SkeletonAvatar(size: .large)
            }
            .padding(.horizontal, 8)
        } editor: {
            TokenValueRow(label: "controlHeight", value: $config.seed.controlHeight, range: 24...48, onChange: { config.regenerateTokens() })
        } code: {
            "config.seed.controlHeight = \(Int(config.seed.controlHeight))"
        }
        .scrollAnchor("global.controlHeight")
    }

    private var controlHeightSMGlobalCard: some View {
        TokenCard(
            name: "controlHeightSM",
            type: "CGFloat",
            defaultValue: "24",
            description: tr("skeleton.token.global.controlHeightSM.desc"),
            sectionId: "global"
        ) {
            HStack(spacing: Moin.Constants.Spacing.md) {
                Moin.SkeletonAvatar(size: .small)
                Moin.SkeletonButton(size: .small)
                Moin.SkeletonInput(size: .small)
            }
            .padding(.horizontal, 8)
        } editor: {
            TokenValueRow(label: "controlHeight", value: $config.seed.controlHeight, range: 24...48, onChange: { config.regenerateTokens() })
        } code: {
            """
            // controlHeightSM = controlHeight × 0.75
            config.seed.controlHeight = \(Int(config.seed.controlHeight))
            config.regenerateTokens()
            """
        }
        .scrollAnchor("global.controlHeightSM")
    }

    private var controlHeightLGGlobalCard: some View {
        TokenCard(
            name: "controlHeightLG",
            type: "CGFloat",
            defaultValue: "40",
            description: tr("skeleton.token.global.controlHeightLG.desc"),
            sectionId: "global"
        ) {
            HStack(spacing: Moin.Constants.Spacing.md) {
                Moin.SkeletonAvatar(size: .large)
                Moin.SkeletonButton(size: .large)
                Moin.SkeletonInput(size: .large)
            }
            .padding(.horizontal, 8)
        } editor: {
            TokenValueRow(label: "controlHeight", value: $config.seed.controlHeight, range: 24...48, onChange: { config.regenerateTokens() })
        } code: {
            """
            // controlHeightLG = controlHeight × 1.25
            config.seed.controlHeight = \(Int(config.seed.controlHeight))
            config.regenerateTokens()
            """
        }
        .scrollAnchor("global.controlHeightLG")
    }

    private var borderRadiusSMGlobalCard: some View {
        TokenCard(
            name: "borderRadiusSM",
            type: "CGFloat",
            defaultValue: "4",
            description: tr("skeleton.token.global.borderRadiusSM.desc"),
            sectionId: "global"
        ) {
            Moin.Skeleton()
                .frame(width: 200)
        } editor: {
            TokenValueRow(label: "borderRadius", value: $config.seed.borderRadius, range: 0...20, onChange: { config.regenerateTokens() })
        } code: {
            "config.seed.borderRadius = \(Int(config.seed.borderRadius))"
        }
        .scrollAnchor("global.borderRadiusSM")
    }

    private var marginLGGlobalCard: some View {
        TokenCard(
            name: "marginLG",
            type: "CGFloat",
            defaultValue: "24",
            description: tr("skeleton.token.global.marginLG.desc"),
            sectionId: "global"
        ) {
            Moin.Skeleton(avatar: true)
                .padding(.leading, 16)
                .frame(width: 220)
        } editor: {
            TokenValueRow(label: "sizeUnit", value: $config.seed.sizeUnit, range: 2...8, onChange: { config.regenerateTokens() })
        } code: {
            """
            // marginLG = sizeUnit × 6
            config.seed.sizeUnit = \(Int(config.seed.sizeUnit))
            config.regenerateTokens()
            // marginLG = \(Int(config.seed.sizeUnit)) × 6 = \(Int(config.seed.sizeUnit * 6))
            """
        }
        .scrollAnchor("global.marginLG")
    }

    private var marginXXSGlobalCard: some View {
        TokenCard(
            name: "marginXXS",
            type: "CGFloat",
            defaultValue: "4",
            description: tr("skeleton.token.global.marginXXS.desc"),
            sectionId: "global"
        ) {
            Moin.Skeleton(avatar: true)
                .padding(.leading, 16)
                .frame(width: 220)
        } editor: {
            TokenValueRow(label: "sizeUnit", value: $config.seed.sizeUnit, range: 2...8, onChange: { config.regenerateTokens() })
        } code: {
            """
            // marginXXS = sizeUnit
            config.seed.sizeUnit = \(Int(config.seed.sizeUnit))
            config.regenerateTokens()
            // marginXXS = \(Int(config.seed.sizeUnit))
            """
        }
        .scrollAnchor("global.marginXXS")
    }
}
