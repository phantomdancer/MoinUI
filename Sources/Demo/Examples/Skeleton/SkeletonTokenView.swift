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
                    .init(id: "paragraphLineMarginTop"),
                    .init(id: "blockRadius"),
                    .init(id: "motionDuration")
                ],
                sectionId: "component"
            ),
            // 头像尺寸 Token
            DocSidebarSection(
                title: "Avatar Sizes",
                items: [
                    .init(id: "avatarSizeSM"),
                    .init(id: "avatarSize"),
                    .init(id: "avatarSizeLG")
                ],
                sectionId: "avatar"
            ),
            // 按钮尺寸 Token
            DocSidebarSection(
                title: "Button Sizes",
                items: [
                    .init(id: "buttonHeightSM"),
                    .init(id: "buttonHeight"),
                    .init(id: "buttonHeightLG")
                ],
                sectionId: "button"
            ),
            // 输入框尺寸 Token
            DocSidebarSection(
                title: "Input Sizes",
                items: [
                    .init(id: "inputHeightSM"),
                    .init(id: "inputHeight"),
                    .init(id: "inputHeightLG")
                ],
                sectionId: "input"
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
            case "avatar":
                Text("Avatar Sizes").font(.title3).fontWeight(.semibold)
            case "button":
                Text("Button Sizes").font(.title3).fontWeight(.semibold)
            case "input":
                Text("Input Sizes").font(.title3).fontWeight(.semibold)
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
        // Component Tokens
        case "color": colorCard
        case "colorGradientEnd": colorGradientEndCard
        case "titleHeight": titleHeightCard
        case "paragraphLineHeight": paragraphLineHeightCard
        case "paragraphLineMarginTop": paragraphLineMarginTopCard
        case "blockRadius": blockRadiusCard
        case "motionDuration": motionDurationCard

        // Avatar Size Tokens
        case "avatarSizeSM": avatarSizeSMCard
        case "avatarSize": avatarSizeCard
        case "avatarSizeLG": avatarSizeLGCard

        // Button Size Tokens
        case "buttonHeightSM": buttonHeightSMCard
        case "buttonHeight": buttonHeightCard
        case "buttonHeightLG": buttonHeightLGCard

        // Input Size Tokens
        case "inputHeightSM": inputHeightSMCard
        case "inputHeight": inputHeightCard
        case "inputHeightLG": inputHeightLGCard

        default: EmptyView()
        }
    }

    // MARK: - Component Token Cards

    private var colorCard: some View {
        TokenCard(
            name: "color",
            type: "Color",
            defaultValue: "token.colorFillSecondary",
            description: "骨架屏主色，用于显示静态骨架效果",
            sectionId: "component"
        ) {
            Moin.Skeleton(active: false)
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
            description: "骨架屏渐变结束色，用于显示动画光效效果",
            sectionId: "component"
        ) {
            Moin.Skeleton(active: true)
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
            description: "标题骨架的高度",
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
    }

    private var paragraphLineHeightCard: some View {
        TokenCard(
            name: "paragraphLineHeight",
            type: "CGFloat",
            defaultValue: "16",
            description: "段落每行骨架的高度",
            sectionId: "component"
        ) {
            Moin.Skeleton(title: false, paragraph: true)
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

    private var paragraphLineMarginTopCard: some View {
        TokenCard(
            name: "paragraphLineMarginTop",
            type: "CGFloat",
            defaultValue: "12",
            description: "段落第一行与标题之间的间距",
            sectionId: "component"
        ) {
            Moin.Skeleton(avatar: true)
                .frame(width: 200)
        } editor: {
            TokenValueRow(label: "paragraphLineMarginTop", value: Binding(
                get: { config.components.skeleton.paragraphLineMarginTop },
                set: { config.components.skeleton.paragraphLineMarginTop = $0 }
            ), range: 0...24, step: 2)
        } code: {
            "config.components.skeleton.paragraphLineMarginTop = \(Int(config.components.skeleton.paragraphLineMarginTop))"
        }
    }

    private var blockRadiusCard: some View {
        TokenCard(
            name: "blockRadius",
            type: "CGFloat",
            defaultValue: "token.borderRadiusSM",
            description: "骨架元素的圆角半径",
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
    }

    private var motionDurationCard: some View {
        TokenCard(
            name: "motionDuration",
            type: "Double",
            defaultValue: "1.5",
            description: "骨架屏动画持续时间（秒）",
            sectionId: "component"
        ) {
            Moin.Skeleton(active: true)
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
            description: "小尺寸头像的尺寸（对应 .small）",
            sectionId: "avatar"
        ) {
            Moin.SkeletonAvatar(size: .small)
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
            description: "默认尺寸头像的尺寸（对应 .default）",
            sectionId: "avatar"
        ) {
            Moin.SkeletonAvatar(size: .default)
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
            description: "大尺寸头像的尺寸（对应 .large）",
            sectionId: "avatar"
        ) {
            Moin.SkeletonAvatar(size: .large)
        } editor: {
            TokenValueRow(label: "avatarSizeLG", value: Binding(
                get: { config.components.skeleton.avatarSizeLG },
                set: { config.components.skeleton.avatarSizeLG = $0 }
            ), range: 32...80, step: 2)
        } code: {
            "config.components.skeleton.avatarSizeLG = \(Int(config.components.skeleton.avatarSizeLG))"
        }
    }

    // MARK: - Button Size Cards

    private var buttonHeightSMCard: some View {
        TokenCard(
            name: "buttonHeightSM",
            type: "CGFloat",
            defaultValue: "token.controlHeightSM",
            description: "小尺寸按钮的高度（对应 .small）",
            sectionId: "button"
        ) {
            Moin.SkeletonButton(size: .small)
        } editor: {
            TokenValueRow(label: "buttonHeightSM", value: Binding(
                get: { config.components.skeleton.buttonHeightSM },
                set: { config.components.skeleton.buttonHeightSM = $0 }
            ), range: 20...40, step: 2)
        } code: {
            "config.components.skeleton.buttonHeightSM = \(Int(config.components.skeleton.buttonHeightSM))"
        }
    }

    private var buttonHeightCard: some View {
        TokenCard(
            name: "buttonHeight",
            type: "CGFloat",
            defaultValue: "token.controlHeight",
            description: "默认尺寸按钮的高度（对应 .default）",
            sectionId: "button"
        ) {
            Moin.SkeletonButton(size: .default)
        } editor: {
            TokenValueRow(label: "buttonHeight", value: Binding(
                get: { config.components.skeleton.buttonHeight },
                set: { config.components.skeleton.buttonHeight = $0 }
            ), range: 24...48, step: 2)
        } code: {
            "config.components.skeleton.buttonHeight = \(Int(config.components.skeleton.buttonHeight))"
        }
    }

    private var buttonHeightLGCard: some View {
        TokenCard(
            name: "buttonHeightLG",
            type: "CGFloat",
            defaultValue: "token.controlHeightLG",
            description: "大尺寸按钮的高度（对应 .large）",
            sectionId: "button"
        ) {
            Moin.SkeletonButton(size: .large)
        } editor: {
            TokenValueRow(label: "buttonHeightLG", value: Binding(
                get: { config.components.skeleton.buttonHeightLG },
                set: { config.components.skeleton.buttonHeightLG = $0 }
            ), range: 32...64, step: 2)
        } code: {
            "config.components.skeleton.buttonHeightLG = \(Int(config.components.skeleton.buttonHeightLG))"
        }
    }

    // MARK: - Input Size Cards

    private var inputHeightSMCard: some View {
        TokenCard(
            name: "inputHeightSM",
            type: "CGFloat",
            defaultValue: "token.controlHeightSM",
            description: "小尺寸输入框的高度（对应 .small）",
            sectionId: "input"
        ) {
            Moin.SkeletonInput(size: .small)
        } editor: {
            TokenValueRow(label: "inputHeightSM", value: Binding(
                get: { config.components.skeleton.inputHeightSM },
                set: { config.components.skeleton.inputHeightSM = $0 }
            ), range: 20...40, step: 2)
        } code: {
            "config.components.skeleton.inputHeightSM = \(Int(config.components.skeleton.inputHeightSM))"
        }
    }

    private var inputHeightCard: some View {
        TokenCard(
            name: "inputHeight",
            type: "CGFloat",
            defaultValue: "token.controlHeight",
            description: "默认尺寸输入框的高度（对应 .default）",
            sectionId: "input"
        ) {
            Moin.SkeletonInput(size: .default)
        } editor: {
            TokenValueRow(label: "inputHeight", value: Binding(
                get: { config.components.skeleton.inputHeight },
                set: { config.components.skeleton.inputHeight = $0 }
            ), range: 24...48, step: 2)
        } code: {
            "config.components.skeleton.inputHeight = \(Int(config.components.skeleton.inputHeight))"
        }
    }

    private var inputHeightLGCard: some View {
        TokenCard(
            name: "inputHeightLG",
            type: "CGFloat",
            defaultValue: "token.controlHeightLG",
            description: "大尺寸输入框的高度（对应 .large）",
            sectionId: "input"
        ) {
            Moin.SkeletonInput(size: .large)
        } editor: {
            TokenValueRow(label: "inputHeightLG", value: Binding(
                get: { config.components.skeleton.inputHeightLG },
                set: { config.components.skeleton.inputHeightLG = $0 }
            ), range: 32...64, step: 2)
        } code: {
            "config.components.skeleton.inputHeightLG = \(Int(config.components.skeleton.inputHeightLG))"
        }
    }
}
