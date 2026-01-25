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
            // 组件 Token
            DocSidebarSection(
                title: tr("doc.section.component_token"),
                items: [
                    .init(id: "color"),
                    .init(id: "colorGradientEnd"),
                    .init(id: "titleHeight"),
                    .init(id: "paragraphLineHeight"),
                    .init(id: "blockRadius"),
                    .init(id: "motionDuration")
                ],
                sectionId: "component"
            ),
            // 尺寸 Token
            DocSidebarSection(
                title: tr("skeleton.token_avatar_sizes"),
                items: [
                    .init(id: "avatarSizeSM"),
                    .init(id: "avatarSize"),
                    .init(id: "avatarSizeLG")
                ],
                sectionId: "avatar"
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
            if sectionId == "component" {
                Text(tr("doc.section.component_token")).font(.title3).fontWeight(.semibold)
            } else if sectionId == "avatar" {
                Text(tr("skeleton.token_avatar_sizes")).font(.title3).fontWeight(.semibold)
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
        case "color": colorCard
        case "colorGradientEnd": colorGradientEndCard
        case "titleHeight": titleHeightCard
        case "paragraphLineHeight": paragraphLineHeightCard
        case "blockRadius": blockRadiusCard
        case "motionDuration": motionDurationCard
        case "avatarSizeSM": avatarSizeSMCard
        case "avatarSize": avatarSizeCard
        case "avatarSizeLG": avatarSizeLGCard
        default: EmptyView()
        }
    }

    // MARK: - Component Token Cards

    private var colorCard: some View {
        TokenCard(
            name: "color",
            type: "Color",
            defaultValue: "token.colorFillSecondary",
            description: tr("skeleton.token_color"),
            sectionId: "component"
        ) {
            Skeleton(active: false)
                .frame(width: 200)
        } code: {
            "config.components.skeleton.color"
        }
    }

    private var colorGradientEndCard: some View {
        TokenCard(
            name: "colorGradientEnd",
            type: "Color",
            defaultValue: "token.colorFill",
            description: tr("skeleton.token_color_gradient"),
            sectionId: "component"
        ) {
            Skeleton(active: true)
                .frame(width: 200)
        } code: {
            "config.components.skeleton.colorGradientEnd"
        }
    }

    private var titleHeightCard: some View {
        TokenCard(
            name: "titleHeight",
            type: "CGFloat",
            defaultValue: "16",
            description: tr("skeleton.token_title_height"),
            sectionId: "component"
        ) {
            Skeleton(active: true, title: true, paragraph: false)
                .frame(width: 200)
        } editor: {
            TokenValueRow(label: "titleHeight", value: Binding(
                get: { config.components.skeleton.titleHeight },
                set: { config.components.skeleton.titleHeight = $0 }
            ), range: 8...32, step: 2)
        } code: {
            "config.components.skeleton.titleHeight = \(Int(config.components.skeleton.titleHeight))"
        }
    }

    private var paragraphLineHeightCard: some View {
        TokenCard(
            name: "paragraphLineHeight",
            type: "CGFloat",
            defaultValue: "16",
            description: tr("skeleton.token_paragraph_height"),
            sectionId: "component"
        ) {
            Skeleton(active: true, title: false, paragraph: true)
                .frame(width: 200)
        } editor: {
            TokenValueRow(label: "paragraphLineHeight", value: Binding(
                get: { config.components.skeleton.paragraphLineHeight },
                set: { config.components.skeleton.paragraphLineHeight = $0 }
            ), range: 8...32, step: 2)
        } code: {
            "config.components.skeleton.paragraphLineHeight = \(Int(config.components.skeleton.paragraphLineHeight))"
        }
    }

    private var blockRadiusCard: some View {
        TokenCard(
            name: "blockRadius",
            type: "CGFloat",
            defaultValue: "token.borderRadiusSM",
            description: tr("skeleton.token_block_radius"),
            sectionId: "component"
        ) {
            Skeleton(active: true)
                .frame(width: 200)
        } editor: {
            TokenValueRow(label: "blockRadius", value: Binding(
                get: { config.components.skeleton.blockRadius },
                set: { config.components.skeleton.blockRadius = $0 }
            ), range: 0...16, step: 1)
        } code: {
            "config.components.skeleton.blockRadius = \(Int(config.components.skeleton.blockRadius))"
        }
    }

    private var motionDurationCard: some View {
        TokenCard(
            name: "motionDuration",
            type: "Double",
            defaultValue: "1.5",
            description: tr("skeleton.token_motion_duration"),
            sectionId: "component"
        ) {
            Skeleton(active: true)
                .frame(width: 200)
        } editor: {
            TokenValueRow(label: "motionDuration", value: Binding(
                get: { CGFloat(config.components.skeleton.motionDuration) },
                set: { config.components.skeleton.motionDuration = Double($0) }
            ), range: 0.5...3, step: 0.1)
        } code: {
            "config.components.skeleton.motionDuration = \(config.components.skeleton.motionDuration)"
        }
    }

    // MARK: - Avatar Size Cards

    private var avatarSizeSMCard: some View {
        TokenCard(
            name: "avatarSizeSM",
            type: "CGFloat",
            defaultValue: "token.controlHeightSM",
            description: tr("skeleton.token_avatar_sm"),
            sectionId: "avatar"
        ) {
            SkeletonElement.avatar(size: .small, active: true)
        } editor: {
            TokenValueRow(label: "avatarSizeSM", value: Binding(
                get: { config.components.skeleton.avatarSizeSM },
                set: { config.components.skeleton.avatarSizeSM = $0 }
            ), range: 16...48, step: 2)
        } code: {
            "config.components.skeleton.avatarSizeSM = \(Int(config.components.skeleton.avatarSizeSM))"
        }
    }

    private var avatarSizeCard: some View {
        TokenCard(
            name: "avatarSize",
            type: "CGFloat",
            defaultValue: "token.controlHeight",
            description: tr("skeleton.token_avatar_default"),
            sectionId: "avatar"
        ) {
            SkeletonElement.avatar(size: .default, active: true)
        } editor: {
            TokenValueRow(label: "avatarSize", value: Binding(
                get: { config.components.skeleton.avatarSize },
                set: { config.components.skeleton.avatarSize = $0 }
            ), range: 24...64, step: 2)
        } code: {
            "config.components.skeleton.avatarSize = \(Int(config.components.skeleton.avatarSize))"
        }
    }

    private var avatarSizeLGCard: some View {
        TokenCard(
            name: "avatarSizeLG",
            type: "CGFloat",
            defaultValue: "token.controlHeightLG",
            description: tr("skeleton.token_avatar_lg"),
            sectionId: "avatar"
        ) {
            SkeletonElement.avatar(size: .large, active: true)
        } editor: {
            TokenValueRow(label: "avatarSizeLG", value: Binding(
                get: { config.components.skeleton.avatarSizeLG },
                set: { config.components.skeleton.avatarSizeLG = $0 }
            ), range: 32...80, step: 2)
        } code: {
            "config.components.skeleton.avatarSizeLG = \(Int(config.components.skeleton.avatarSizeLG))"
        }
    }
}
