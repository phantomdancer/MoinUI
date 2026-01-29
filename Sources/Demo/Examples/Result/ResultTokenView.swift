import SwiftUI
import MoinUI

struct ResultTokenView: View {
    @Localized var tr
    @Environment(\.moinToken) var token
    @ObservedObject var config = Moin.ConfigProvider.shared

    private var tokenSections: [DocSidebarSection] {
        [
            DocSidebarSection(
                title: tr("doc.section.component_token"),
                items: [
                    .init(id: "titleFontSize"),
                    .init(id: "subtitleFontSize"),
                    .init(id: "iconFontSize"),
                    .init(id: "extraMargin"),
                    .init(id: "padding")
                ],
                sectionId: "component"
            ),
            DocSidebarSection(
                title: tr("doc.section.global_token"),
                items: [
                    .init(id: "colorSuccess"),
                    .init(id: "colorError"),
                    .init(id: "colorInfo"),
                    .init(id: "colorWarning"),
                    .init(id: "colorText"),
                    .init(id: "colorTextSecondary")
                ],
                sectionId: "global"
            )
        ]
    }

    private func resetAll() {
        config.seed = Moin.SeedToken.default
        config.regenerateTokens()

        let defaultResult = Moin.ResultToken.generate(from: config.token)
        config.components.result = defaultResult
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
        case "titleFontSize": titleFontSizeCard
        case "subtitleFontSize": subtitleFontSizeCard
        case "iconFontSize": iconFontSizeCard
        case "extraMargin": extraMarginCard
        case "padding": paddingCard

        // Global Token
        case "colorSuccess": colorSuccessCard
        case "colorError": colorErrorCard
        case "colorInfo": colorInfoCard
        case "colorWarning": colorWarningCard
        case "colorText": colorTextCard
        case "colorTextSecondary": colorTextSecondaryCard

        default: EmptyView()
        }
    }

    // MARK: - Component Token Cards

    private var titleFontSizeCard: some View {
        TokenCard(
            name: "titleFontSize",
            type: "CGFloat",
            defaultValue: "\(Int(Moin.ResultToken.default.titleFontSize))",
            description: tr("token.result.titleFontSize"),
            sectionId: "component"
        ) {
            Moin.Result(tr("token.result.demo.title"), status: .success)
                .frame(maxWidth: 300)
        } editor: {
            TokenValueRow(
                label: "titleFontSize",
                value: $config.components.result.titleFontSize,
                range: 14...36
            )
        }
    }

    private var subtitleFontSizeCard: some View {
        TokenCard(
            name: "subtitleFontSize",
            type: "CGFloat",
            defaultValue: "\(Int(Moin.ResultToken.default.subtitleFontSize))",
            description: tr("token.result.subtitleFontSize"),
            sectionId: "component"
        ) {
            Moin.Result(
                tr("token.result.demo.title"),
                subTitle: tr("token.result.demo.subtitle"),
                status: .info
            )
            .frame(maxWidth: 300)
        } editor: {
            TokenValueRow(
                label: "subtitleFontSize",
                value: $config.components.result.subtitleFontSize,
                range: 12...24
            )
        }
    }

    private var iconFontSizeCard: some View {
        TokenCard(
            name: "iconFontSize",
            type: "CGFloat",
            defaultValue: "\(Int(Moin.ResultToken.default.iconFontSize))",
            description: tr("token.result.iconFontSize"),
            sectionId: "component"
        ) {
            Moin.Result(tr("token.result.demo.title"), status: .success)
                .frame(maxWidth: 300)
        } editor: {
            TokenValueRow(
                label: "iconFontSize",
                value: $config.components.result.iconFontSize,
                range: 32...120
            )
        }
    }

    private var extraMarginCard: some View {
        TokenCard(
            name: "extraMargin",
            type: "CGFloat",
            defaultValue: "\(Int(Moin.ResultToken.default.extraMargin))",
            description: tr("token.result.extraMargin"),
            sectionId: "component"
        ) {
            Moin.Result(
                tr("token.result.demo.title"),
                status: .success
            ) {
                Moin.Button(tr("token.result.demo.action"), variant: .solid) {}
            }
            .frame(maxWidth: 300)
        } editor: {
            TokenValueRow(
                label: "extraMargin",
                value: $config.components.result.extraMargin,
                range: 8...48
            )
        }
    }

    private var paddingCard: some View {
        TokenCard(
            name: "padding",
            type: "CGFloat",
            defaultValue: "\(Int(Moin.ResultToken.default.padding))",
            description: tr("token.result.padding"),
            sectionId: "component"
        ) {
            Moin.Result(tr("token.result.demo.title"), status: .info)
                .frame(maxWidth: 300)
                .background(token.colorBgLayout)
        } editor: {
            TokenValueRow(
                label: "padding",
                value: $config.components.result.padding,
                range: 16...80
            )
        }
    }

    // MARK: - Global Token Cards

    private var colorSuccessCard: some View {
        TokenCard(
            name: "colorSuccess",
            type: "Color",
            defaultValue: "#52c41a",
            description: tr("token.result.colorSuccess"),
            sectionId: "global"
        ) {
            Moin.Result(tr("token.result.demo.success"), status: .success)
                .frame(maxWidth: 300)
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

    private var colorErrorCard: some View {
        TokenCard(
            name: "colorError",
            type: "Color",
            defaultValue: "#ff4d4f",
            description: tr("token.result.colorError"),
            sectionId: "global"
        ) {
            Moin.Result(tr("token.result.demo.error"), status: .error)
                .frame(maxWidth: 300)
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

    private var colorInfoCard: some View {
        TokenCard(
            name: "colorInfo",
            type: "Color",
            defaultValue: "#1677ff",
            description: tr("token.result.colorInfo"),
            sectionId: "global"
        ) {
            Moin.Result(tr("token.result.demo.info"), status: .info)
                .frame(maxWidth: 300)
        } editor: {
            ColorPresetRow(
                label: "colorInfo",
                color: Binding(
                    get: { config.seed.colorInfo },
                    set: {
                        config.seed.colorInfo = $0
                        config.regenerateTokens()
                    }
                )
            )
        }
    }

    private var colorWarningCard: some View {
        TokenCard(
            name: "colorWarning",
            type: "Color",
            defaultValue: "#faad14",
            description: tr("token.result.colorWarning"),
            sectionId: "global"
        ) {
            Moin.Result(tr("token.result.demo.warning"), status: .warning)
                .frame(maxWidth: 300)
        } editor: {
            ColorPresetRow(
                label: "colorWarning",
                color: Binding(
                    get: { config.seed.colorWarning },
                    set: {
                        config.seed.colorWarning = $0
                        config.regenerateTokens()
                    }
                )
            )
        }
    }

    private var colorTextCard: some View {
        TokenCard(
            name: "colorText",
            type: "Color",
            defaultValue: "rgba(0,0,0,0.88)",
            description: tr("token.result.colorText"),
            sectionId: "global"
        ) {
            Moin.Result(tr("token.result.demo.title"), status: .info)
                .frame(maxWidth: 300)
        } editor: {
            Text(tr("token.global.colorText.hint"))
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }

    private var colorTextSecondaryCard: some View {
        TokenCard(
            name: "colorTextSecondary",
            type: "Color",
            defaultValue: "rgba(0,0,0,0.65)",
            description: tr("token.result.colorTextSecondary"),
            sectionId: "global"
        ) {
            Moin.Result(
                tr("token.result.demo.title"),
                subTitle: tr("token.result.demo.subtitle"),
                status: .info
            )
            .frame(maxWidth: 300)
        } editor: {
            Text(tr("token.global.colorTextSecondary.hint"))
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}
