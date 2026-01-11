import SwiftUI
import MoinUI

struct ButtonAPISection: View {
    @Localized var tr

    var body: some View {
        VStack(alignment: .leading, spacing: Moin.Constants.Spacing.lg) {
            Text("API")
                .font(.title2)
                .fontWeight(.semibold)

            Text("Moin.Button")
                .font(.headline)

            APITable(
                headers: (
                    tr("api.property"),
                    tr("api.type"),
                    tr("api.default"),
                    tr("api.description")
                ),
                rows: [
                    ("action", "(() -> Void)?", "nil", tr("button.api.action")),
                    ("color", "Moin.ButtonColor", ".default", tr("button.api.type")),
                    ("fontColor", "Color?", "nil", tr("button.api.fontColor")),
                    ("gradient", "LinearGradient?", "nil", tr("button.api.gradient")),
                    ("href", "URL?", "nil", tr("button.api.href")),
                    ("icon", "String?", "nil", tr("button.api.icon")),
                    ("iconPlacement", "Moin.ButtonIconPlacement", ".start", tr("button.api.iconPlacement")),
                    ("isBlock", "Bool", "false", tr("button.api.isBlock")),
                    ("isDisabled", "Bool", "false", tr("button.api.isDisabled")),
                    ("isGhost", "Bool", "false", tr("button.api.isGhost")),
                    ("label", "@ViewBuilder () -> View", "-", tr("button.api.label")),
                    ("loading", "Moin.ButtonLoading", "false", tr("button.api.loading")),
                    ("shape", "Moin.ButtonShape", ".default", tr("button.api.shape")),
                    ("size", "Moin.ButtonSize", ".medium", tr("button.api.size")),
                    ("variant", "Moin.ButtonVariant", ".solid", tr("button.api.variant")),
                ]
            )

            Text("Moin.ButtonColor")
                .font(.headline)
                .padding(.top, Moin.Constants.Spacing.md)

            APITable(
                headers: (
                    tr("api.value"),
                    tr("api.type"),
                    tr("api.default"),
                    tr("api.description")
                ),
                rows: [
                    ("danger", "-", "-", tr("button.api.type_values.danger")),
                    ("default", "-", "-", tr("button.api.type_values.default")),
                    ("info", "-", "-", tr("button.api.type_values.info")),
                    ("primary", "-", "-", tr("button.api.type_values.primary")),
                    ("success", "-", "-", tr("button.api.type_values.success")),
                    ("warning", "-", "-", tr("button.api.type_values.warning")),
                ]
            )

            Text("Moin.ButtonVariant")
                .font(.headline)
                .padding(.top, Moin.Constants.Spacing.md)

            APITable(
                headers: (
                    tr("api.value"),
                    tr("api.type"),
                    tr("api.default"),
                    tr("api.description")
                ),
                rows: [
                    ("dashed", "-", "-", tr("button.api.variant_values.dashed")),
                    ("filled", "-", "-", tr("button.api.variant_values.filled")),
                    ("link", "-", "-", tr("button.api.variant_values.link")),
                    ("outlined", "-", "-", tr("button.api.variant_values.outlined")),
                    ("solid", "-", "-", tr("button.api.variant_values.solid")),
                    ("text", "-", "-", tr("button.api.variant_values.text")),
                ]
            )

            // MARK: - Component Token
            Divider()
                .padding(.top, Moin.Constants.Spacing.lg)

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
                    ("dangerColor", "Color", ".white", tr("button.api.token.dangerColor")),
                    ("defaultActiveBg", "Color", "background", tr("button.api.token.defaultActiveBg")),
                    ("defaultActiveBorderColor", "Color", "primaryActive", tr("button.api.token.defaultActiveBorderColor")),
                    ("defaultActiveColor", "Color", "primaryActive", tr("button.api.token.defaultActiveColor")),
                    ("defaultBg", "Color", "background", tr("button.api.token.defaultBg")),
                    ("defaultBgDisabled", "Color", "backgroundDisabled", tr("button.api.token.defaultBgDisabled")),
                    ("defaultBorderColor", "Color", "border", tr("button.api.token.defaultBorderColor")),
                    ("defaultColor", "Color", "textPrimary", tr("button.api.token.defaultColor")),
                    ("defaultGhostBorderColor", "Color", ".white", tr("button.api.token.defaultGhostBorderColor")),
                    ("defaultGhostColor", "Color", ".white", tr("button.api.token.defaultGhostColor")),
                    ("defaultHoverBg", "Color", "background", tr("button.api.token.defaultHoverBg")),
                    ("defaultHoverBorderColor", "Color", "primaryHover", tr("button.api.token.defaultHoverBorderColor")),
                    ("defaultHoverColor", "Color", "primaryHover", tr("button.api.token.defaultHoverColor")),
                    ("fontWeight", "Font.Weight", ".medium", tr("button.api.token.fontWeight")),
                    ("ghostBg", "Color", ".clear", tr("button.api.token.ghostBg")),
                    ("iconGap", "CGFloat", "6", tr("button.api.token.iconGap")),
                    ("linkHoverBg", "Color", ".clear", tr("button.api.token.linkHoverBg")),
                    ("onlyIconSize", "CGFloat", "16", tr("button.api.token.onlyIconSize")),
                    ("onlyIconSizeLG", "CGFloat", "18", tr("button.api.token.onlyIconSizeLG")),
                    ("onlyIconSizeSM", "CGFloat", "14", tr("button.api.token.onlyIconSizeSM")),
                    ("paddingInline", "CGFloat", "15", tr("button.api.token.paddingInline")),
                    ("paddingInlineLG", "CGFloat", "15", tr("button.api.token.paddingInlineLG")),
                    ("paddingInlineSM", "CGFloat", "7", tr("button.api.token.paddingInlineSM")),
                    ("primaryColor", "Color", ".white", tr("button.api.token.primaryColor")),
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
