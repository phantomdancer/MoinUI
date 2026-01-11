import SwiftUI
import MoinUI

struct ButtonTokenSection: View {
    @Localized var tr

    var body: some View {
        VStack(alignment: .leading, spacing: Moin.Constants.Spacing.lg) {
            // MARK: - Component Token
            Text(tr("api.component_token"))
                .font(.title2)
                .fontWeight(.semibold)
                .id("component_token")

            Text(tr("api.component_token_desc"))
                .foregroundStyle(.secondary)
                .padding(.bottom, Moin.Constants.Spacing.sm)

            APITable(
                headers: (
                    tr("api.property"),
                    tr("api.type"),
                    tr("api.default"),
                    tr("api.description")
                ),
                rows: [
                    ("borderColorDisabled", "Color", "border.opacity(0.5)", tr("button.api.token.borderColorDisabled")),
                    ("contentFontSize", "CGFloat", "14", tr("button.api.token.contentFontSize")),
                    ("contentFontSizeLG", "CGFloat", "16", tr("button.api.token.contentFontSizeLG")),
                    ("contentFontSizeSM", "CGFloat", "12", tr("button.api.token.contentFontSizeSM")),
                    ("contentLineHeight", "CGFloat", "1.57", tr("button.api.token.contentLineHeight")),
                    ("contentLineHeightLG", "CGFloat", "1.5", tr("button.api.token.contentLineHeightLG")),
                    ("contentLineHeightSM", "CGFloat", "1.67", tr("button.api.token.contentLineHeightSM")),
                    ("dangerColor", "Color", ".white", tr("button.api.token.dangerColor")),
                    ("dangerShadow", "String", "shadow", tr("button.api.token.dangerShadow")),
                    ("dashedBgDisabled", "Color", "bgDisabled", tr("button.api.token.dashedBgDisabled")),
                    ("defaultActiveBg", "Color", "background", tr("button.api.token.defaultActiveBg")),
                    ("defaultActiveBorderColor", "Color", "primaryActive", tr("button.api.token.defaultActiveBorderColor")),
                    ("defaultActiveColor", "Color", "primaryActive", tr("button.api.token.defaultActiveColor")),
                    ("defaultBg", "Color", "background", tr("button.api.token.defaultBg")),
                    ("defaultBgDisabled", "Color", "bgDisabled", tr("button.api.token.defaultBgDisabled")),
                    ("defaultBorderColor", "Color", "border", tr("button.api.token.defaultBorderColor")),
                    ("defaultColor", "Color", "textPrimary", tr("button.api.token.defaultColor")),
                    ("defaultGhostBorderColor", "Color", ".white", tr("button.api.token.defaultGhostBorderColor")),
                    ("defaultGhostColor", "Color", ".white", tr("button.api.token.defaultGhostColor")),
                    ("defaultHoverBg", "Color", "background", tr("button.api.token.defaultHoverBg")),
                    ("defaultHoverBorderColor", "Color", "primaryHover", tr("button.api.token.defaultHoverBorderColor")),
                    ("defaultHoverColor", "Color", "primaryHover", tr("button.api.token.defaultHoverColor")),
                    ("defaultShadow", "String", "shadow", tr("button.api.token.defaultShadow")),
                    ("fontWeight", "Font.Weight", ".medium", tr("button.api.token.fontWeight")),
                    ("ghostBg", "Color", ".clear", tr("button.api.token.ghostBg")),
                    ("groupBorderColor", "Color", "primaryHover", tr("button.api.token.groupBorderColor")),
                    ("iconGap", "CGFloat", "6", tr("button.api.token.iconGap")),
                    ("linkHoverBg", "Color", ".clear", tr("button.api.token.linkHoverBg")),
                    ("onlyIconSize", "CGFloat", "16", tr("button.api.token.onlyIconSize")),
                    ("onlyIconSizeLG", "CGFloat", "18", tr("button.api.token.onlyIconSizeLG")),
                    ("onlyIconSizeSM", "CGFloat", "14", tr("button.api.token.onlyIconSizeSM")),
                    ("paddingBlock", "CGFloat", "0", tr("button.api.token.paddingBlock")),
                    ("paddingBlockLG", "CGFloat", "0", tr("button.api.token.paddingBlockLG")),
                    ("paddingBlockSM", "CGFloat", "0", tr("button.api.token.paddingBlockSM")),
                    ("paddingInline", "CGFloat", "15", tr("button.api.token.paddingInline")),
                    ("paddingInlineLG", "CGFloat", "15", tr("button.api.token.paddingInlineLG")),
                    ("paddingInlineSM", "CGFloat", "7", tr("button.api.token.paddingInlineSM")),
                    ("primaryColor", "Color", ".white", tr("button.api.token.primaryColor")),
                    ("primaryShadow", "String", "shadow", tr("button.api.token.primaryShadow")),
                    ("solidTextColor", "Color", ".white", tr("button.api.token.solidTextColor")),
                    ("textHoverBg", "Color", "black.opacity(0.04)", tr("button.api.token.textHoverBg")),
                    ("textTextActiveColor", "Color", "textPrimary", tr("button.api.token.textTextActiveColor")),
                    ("textTextColor", "Color", "textPrimary", tr("button.api.token.textTextColor")),
                    ("textTextHoverColor", "Color", "textPrimary", tr("button.api.token.textTextHoverColor")),
                ],
                columnWidths: (200, 160, 140, 220)
            )

            // MARK: - Global Token
            Divider()
                .padding(.top, Moin.Constants.Spacing.lg)

            Text(tr("api.global_token_title"))
                .font(.title2)
                .fontWeight(.semibold)
                .id("global_token")

            Text(tr("api.global_token_desc"))
                .foregroundStyle(.secondary)
                .padding(.bottom, Moin.Constants.Spacing.sm)

            APITable(
                headers: (
                    tr("api.property"),
                    tr("api.type"),
                    tr("api.default"),
                    tr("api.description")
                ),
                rows: [
                    ("borderRadius", "CGFloat", "6", tr("api.global_token.borderRadius")),
                    ("borderRadiusLG", "CGFloat", "8", tr("api.global_token.borderRadiusLG")),
                    ("borderRadiusSM", "CGFloat", "4", tr("api.global_token.borderRadiusSM")),
                    ("colorPrimary", "Color", "primary", tr("api.global_token.colorPrimary")),
                    ("colorPrimaryActive", "Color", "primaryActive", tr("api.global_token.colorPrimaryActive")),
                    ("colorPrimaryHover", "Color", "primaryHover", tr("api.global_token.colorPrimaryHover")),
                    ("colorTextDisabled", "Color", "textDisabled", tr("api.global_token.colorTextDisabled")),
                    ("controlHeight", "CGFloat", "32", tr("api.global_token.controlHeight")),
                    ("controlHeightLG", "CGFloat", "40", tr("api.global_token.controlHeightLG")),
                    ("controlHeightSM", "CGFloat", "24", tr("api.global_token.controlHeightSM")),
                    ("motionDuration", "Double", "0.2", tr("api.global_token.motionDuration")),
                ],
                columnWidths: (180, 100, 100, 200)
            )
        }
    }
}

/// Token 页面容器
struct ButtonTokenContent: View {
    @Localized var tr

    private let anchors: [AnchorItem] = [
        AnchorItem(id: "component_token", titleKey: "api.component_token"),
        AnchorItem(id: "global_token", titleKey: "api.global_token_title"),
    ]

    var body: some View {
        ExamplePageWithAnchor(pageName: "Button Token", anchors: anchors) { _ in
            ButtonTokenSection().id("component_token")
        }
    }
}
