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
                    ("action", "(() -> Void)?", "nil", tr("api.button.action")),
                    ("color", "Moin.ButtonColor", ".default", tr("api.button.type")),
                    ("fontColor", "Color?", "nil", tr("api.button.fontColor")),
                    ("gradient", "LinearGradient?", "nil", tr("api.button.gradient")),
                    ("href", "URL?", "nil", tr("api.button.href")),
                    ("icon", "String?", "nil", tr("api.button.icon")),
                    ("iconPlacement", "Moin.ButtonIconPlacement", ".start", tr("api.button.iconPlacement")),
                    ("isBlock", "Bool", "false", tr("api.button.isBlock")),
                    ("isDisabled", "Bool", "false", tr("api.button.isDisabled")),
                    ("isGhost", "Bool", "false", tr("api.button.isGhost")),
                    ("label", "@ViewBuilder () -> View", "-", tr("api.button.label")),
                    ("loading", "Moin.ButtonLoading", "false", tr("api.button.loading")),
                    ("shape", "Moin.ButtonShape", ".default", tr("api.button.shape")),
                    ("size", "Moin.ButtonSize", ".medium", tr("api.button.size")),
                    ("variant", "Moin.ButtonVariant", ".solid", tr("api.button.variant")),
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
                    ("danger", "-", "-", tr("api.type_values.danger")),
                    ("default", "-", "-", tr("api.type_values.default")),
                    ("info", "-", "-", tr("api.type_values.info")),
                    ("primary", "-", "-", tr("api.type_values.primary")),
                    ("success", "-", "-", tr("api.type_values.success")),
                    ("warning", "-", "-", tr("api.type_values.warning")),
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
                    ("dashed", "-", "-", tr("api.variant_values.dashed")),
                    ("filled", "-", "-", tr("api.variant_values.filled")),
                    ("link", "-", "-", tr("api.variant_values.link")),
                    ("outlined", "-", "-", tr("api.variant_values.outlined")),
                    ("solid", "-", "-", tr("api.variant_values.solid")),
                    ("text", "-", "-", tr("api.variant_values.text")),
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
                    ("borderColorDisabled", "Color", "border.opacity(0.5)", tr("api.button_token.borderColorDisabled")),
                    ("contentFontSize", "CGFloat", "14", tr("api.button_token.contentFontSize")),
                    ("contentFontSizeLG", "CGFloat", "16", tr("api.button_token.contentFontSizeLG")),
                    ("contentFontSizeSM", "CGFloat", "12", tr("api.button_token.contentFontSizeSM")),
                    ("dangerColor", "Color", ".white", tr("api.button_token.dangerColor")),
                    ("defaultActiveBg", "Color", "background", tr("api.button_token.defaultActiveBg")),
                    ("defaultActiveBorderColor", "Color", "primaryActive", tr("api.button_token.defaultActiveBorderColor")),
                    ("defaultActiveColor", "Color", "primaryActive", tr("api.button_token.defaultActiveColor")),
                    ("defaultBg", "Color", "background", tr("api.button_token.defaultBg")),
                    ("defaultBgDisabled", "Color", "backgroundDisabled", tr("api.button_token.defaultBgDisabled")),
                    ("defaultBorderColor", "Color", "border", tr("api.button_token.defaultBorderColor")),
                    ("defaultColor", "Color", "textPrimary", tr("api.button_token.defaultColor")),
                    ("defaultGhostBorderColor", "Color", ".white", tr("api.button_token.defaultGhostBorderColor")),
                    ("defaultGhostColor", "Color", ".white", tr("api.button_token.defaultGhostColor")),
                    ("defaultHoverBg", "Color", "background", tr("api.button_token.defaultHoverBg")),
                    ("defaultHoverBorderColor", "Color", "primaryHover", tr("api.button_token.defaultHoverBorderColor")),
                    ("defaultHoverColor", "Color", "primaryHover", tr("api.button_token.defaultHoverColor")),
                    ("fontWeight", "Font.Weight", ".medium", tr("api.button_token.fontWeight")),
                    ("ghostBg", "Color", ".clear", tr("api.button_token.ghostBg")),
                    ("iconGap", "CGFloat", "6", tr("api.button_token.iconGap")),
                    ("linkHoverBg", "Color", ".clear", tr("api.button_token.linkHoverBg")),
                    ("onlyIconSize", "CGFloat", "16", tr("api.button_token.onlyIconSize")),
                    ("onlyIconSizeLG", "CGFloat", "18", tr("api.button_token.onlyIconSizeLG")),
                    ("onlyIconSizeSM", "CGFloat", "14", tr("api.button_token.onlyIconSizeSM")),
                    ("paddingInline", "CGFloat", "15", tr("api.button_token.paddingInline")),
                    ("paddingInlineLG", "CGFloat", "15", tr("api.button_token.paddingInlineLG")),
                    ("paddingInlineSM", "CGFloat", "7", tr("api.button_token.paddingInlineSM")),
                    ("primaryColor", "Color", ".white", tr("api.button_token.primaryColor")),
                    ("solidTextColor", "Color", ".white", tr("api.button_token.solidTextColor")),
                    ("textHoverBg", "Color", "black.opacity(0.04)", tr("api.button_token.textHoverBg")),
                    ("textTextActiveColor", "Color", "textPrimary", tr("api.button_token.textTextActiveColor")),
                    ("textTextColor", "Color", "textPrimary", tr("api.button_token.textTextColor")),
                    ("textTextHoverColor", "Color", "textPrimary", tr("api.button_token.textTextHoverColor")),
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
