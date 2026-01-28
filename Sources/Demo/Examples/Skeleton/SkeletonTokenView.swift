import SwiftUI
import MoinUI

// MARK: - SkeletonTokenView

struct SkeletonTokenView: View {
    @Localized var tr
    @Environment(\.moinToken) var token
    @ObservedObject var config = Moin.ConfigProvider.shared

    // MARK: - Token Sections

    private var tokenSections: [DocSidebarSection] {
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

    // 重置所有 Token 到默认值
    private func resetAll() {
        config.seed = Moin.SeedToken.default
        config.regenerateTokens()
        config.components.skeleton = .generate(from: config.token)
    }

    var body: some View {
        ComponentDocBody(
            sections: tokenSections,
            initialItemId: "component"
        ) { sectionId in
            switch sectionId {
            case "component":
                Text(tr("doc.section.component_token")).font(.title3).fontWeight(.semibold)
            default:
                EmptyView()
            }
        } item: { item in
            cardForItem(item)
                .id(item)
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
    private func cardForItem(_ item: String) -> some View {
        switch item {
        case "gradientFromColor": gradientFromColorCard
        case "gradientToColor": gradientToColorCard
        case "titleHeight": titleHeightCard
        case "paragraphLiHeight": paragraphLiHeightCard
        case "paragraphMarginTop": paragraphMarginTopCard
        case "blockRadius": blockRadiusCard
        default: EmptyView()
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
                .frame(width: 280)
        } editor: {
            ColorPresetRow(label: "gradientFromColor", color: Binding(
                get: { config.components.skeleton.gradientFromColor },
                set: { config.components.skeleton.gradientFromColor = $0 }
            ))
        } code: {
            "config.components.skeleton.gradientFromColor = Color(...)"
        }
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
                .frame(width: 280)
        } editor: {
            ColorPresetRow(label: "gradientToColor", color: Binding(
                get: { config.components.skeleton.gradientToColor },
                set: { config.components.skeleton.gradientToColor = $0 }
            ))
        } code: {
            "config.components.skeleton.gradientToColor = Color(...)"
        }
    }

    private var titleHeightCard: some View {
        TokenCard(
            name: "titleHeight",
            type: "CGFloat",
            defaultValue: "token.controlHeight / 2",
            description: tr("skeleton.token.titleHeight.desc"),
            sectionId: "component"
        ) {
            Moin.Skeleton(title: true, paragraph: true)
                .frame(width: 280)
        } editor: {
            TokenValueRow(label: "titleHeight", value: Binding(
                get: { config.components.skeleton.titleHeight },
                set: { config.components.skeleton.titleHeight = $0 }
            ), range: 8...32, step: 2)
        } code: {
            "config.components.skeleton.titleHeight = \(Int(config.components.skeleton.titleHeight))"
        }
    }

    private var paragraphLiHeightCard: some View {
        TokenCard(
            name: "paragraphLiHeight",
            type: "CGFloat",
            defaultValue: "token.controlHeight / 2",
            description: tr("skeleton.token.paragraphLiHeight.desc"),
            sectionId: "component"
        ) {
            Moin.Skeleton(title: true, paragraph: true)
                .frame(width: 280)
        } editor: {
            TokenValueRow(label: "paragraphLiHeight", value: Binding(
                get: { config.components.skeleton.paragraphLiHeight },
                set: { config.components.skeleton.paragraphLiHeight = $0 }
            ), range: 8...32, step: 2)
        } code: {
            "config.components.skeleton.paragraphLiHeight = \(Int(config.components.skeleton.paragraphLiHeight))"
        }
    }

    private var paragraphMarginTopCard: some View {
        TokenCard(
            name: "paragraphMarginTop",
            type: "CGFloat",
            defaultValue: "token.marginLG + token.marginXXS",
            description: tr("skeleton.token.paragraphMarginTop.desc"),
            sectionId: "component"
        ) {
            Moin.Skeleton(avatar: true, title: true, paragraph: true)
                .frame(width: 320)
        } editor: {
            TokenValueRow(label: "paragraphMarginTop", value: Binding(
                get: { config.components.skeleton.paragraphMarginTop },
                set: { config.components.skeleton.paragraphMarginTop = $0 }
            ), range: 0...48, step: 2)
        } code: {
            "config.components.skeleton.paragraphMarginTop = \(Int(config.components.skeleton.paragraphMarginTop))"
        }
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
                .frame(width: 280)
        } editor: {
            TokenValueRow(label: "blockRadius", value: Binding(
                get: { config.components.skeleton.blockRadius },
                set: { config.components.skeleton.blockRadius = $0 }
            ), range: 0...16, step: 1)
        } code: {
            "config.components.skeleton.blockRadius = \(Int(config.components.skeleton.blockRadius))"
        }
    }
}
