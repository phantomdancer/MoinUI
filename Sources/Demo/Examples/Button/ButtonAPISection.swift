import SwiftUI
import MoinUI

struct ButtonAPISection: View {
    @ObservedObject private var localization = MoinUILocalization.shared

    var body: some View {
        VStack(alignment: .leading, spacing: MoinUIConstants.Spacing.lg) {
            Text("API")
                .font(.title2)
                .fontWeight(.semibold)

            Text("MoinUIButton")
                .font(.headline)

            APITable(
                headers: (
                    localization.tr("api.property"),
                    localization.tr("api.type"),
                    localization.tr("api.default"),
                    localization.tr("api.description")
                ),
                rows: [
                    ("action", "(() -> Void)?", "nil", localization.tr("api.button.action")),
                    ("color", "MoinUIButtonColor", ".default", localization.tr("api.button.type")),
                    ("fontColor", "Color?", "nil", localization.tr("api.button.fontColor")),
                    ("gradient", "LinearGradient?", "nil", localization.tr("api.button.gradient")),
                    ("href", "URL?", "nil", localization.tr("api.button.href")),
                    ("icon", "String?", "nil", localization.tr("api.button.icon")),
                    ("iconPlacement", "MoinUIButtonIconPlacement", ".start", localization.tr("api.button.iconPlacement")),
                    ("isBlock", "Bool", "false", localization.tr("api.button.isBlock")),
                    ("isDisabled", "Bool", "false", localization.tr("api.button.isDisabled")),
                    ("isGhost", "Bool", "false", localization.tr("api.button.isGhost")),
                    ("label", "@ViewBuilder () -> View", "-", localization.tr("api.button.label")),
                    ("loading", "MoinUIButtonLoading", "false", localization.tr("api.button.loading")),
                    ("shape", "MoinUIButtonShape", ".default", localization.tr("api.button.shape")),
                    ("size", "MoinUIButtonSize", ".medium", localization.tr("api.button.size")),
                    ("variant", "MoinUIButtonVariant", ".solid", localization.tr("api.button.variant")),
                ]
            )

            Text("MoinUIButtonColor")
                .font(.headline)
                .padding(.top, MoinUIConstants.Spacing.md)

            APITable(
                headers: (
                    localization.tr("api.value"),
                    localization.tr("api.type"),
                    localization.tr("api.default"),
                    localization.tr("api.description")
                ),
                rows: [
                    ("danger", "-", "-", localization.tr("api.type_values.danger")),
                    ("default", "-", "-", localization.tr("api.type_values.default")),
                    ("info", "-", "-", localization.tr("api.type_values.info")),
                    ("primary", "-", "-", localization.tr("api.type_values.primary")),
                    ("success", "-", "-", localization.tr("api.type_values.success")),
                    ("warning", "-", "-", localization.tr("api.type_values.warning")),
                ]
            )

            Text("MoinUIButtonVariant")
                .font(.headline)
                .padding(.top, MoinUIConstants.Spacing.md)

            APITable(
                headers: (
                    localization.tr("api.value"),
                    localization.tr("api.type"),
                    localization.tr("api.default"),
                    localization.tr("api.description")
                ),
                rows: [
                    ("dashed", "-", "-", localization.tr("api.variant_values.dashed")),
                    ("filled", "-", "-", localization.tr("api.variant_values.filled")),
                    ("link", "-", "-", localization.tr("api.variant_values.link")),
                    ("outlined", "-", "-", localization.tr("api.variant_values.outlined")),
                    ("solid", "-", "-", localization.tr("api.variant_values.solid")),
                    ("text", "-", "-", localization.tr("api.variant_values.text")),
                ]
            )

            // MARK: - Component Token
            Divider()
                .padding(.top, MoinUIConstants.Spacing.lg)

            Text(localization.tr("api.component_token"))
                .font(.title2)
                .fontWeight(.semibold)
                .id("component_token")

            Text(localization.tr("api.component_token_desc"))
                .foregroundStyle(.secondary)
                .padding(.bottom, MoinUIConstants.Spacing.sm)

            APITable(
                headers: (
                    localization.tr("api.property"),
                    localization.tr("api.type"),
                    localization.tr("api.default"),
                    localization.tr("api.description")
                ),
                rows: [
                    ("borderColorDisabled", "Color", "border.opacity(0.5)", localization.tr("api.button_token.borderColorDisabled")),
                    ("contentFontSize", "CGFloat", "14", localization.tr("api.button_token.contentFontSize")),
                    ("contentFontSizeLG", "CGFloat", "16", localization.tr("api.button_token.contentFontSizeLG")),
                    ("contentFontSizeSM", "CGFloat", "12", localization.tr("api.button_token.contentFontSizeSM")),
                    ("dangerColor", "Color", ".white", localization.tr("api.button_token.dangerColor")),
                    ("defaultActiveBg", "Color", "background", localization.tr("api.button_token.defaultActiveBg")),
                    ("defaultActiveBorderColor", "Color", "primaryActive", localization.tr("api.button_token.defaultActiveBorderColor")),
                    ("defaultActiveColor", "Color", "primaryActive", localization.tr("api.button_token.defaultActiveColor")),
                    ("defaultBg", "Color", "background", localization.tr("api.button_token.defaultBg")),
                    ("defaultBgDisabled", "Color", "backgroundDisabled", localization.tr("api.button_token.defaultBgDisabled")),
                    ("defaultBorderColor", "Color", "border", localization.tr("api.button_token.defaultBorderColor")),
                    ("defaultColor", "Color", "textPrimary", localization.tr("api.button_token.defaultColor")),
                    ("defaultGhostBorderColor", "Color", ".white", localization.tr("api.button_token.defaultGhostBorderColor")),
                    ("defaultGhostColor", "Color", ".white", localization.tr("api.button_token.defaultGhostColor")),
                    ("defaultHoverBg", "Color", "background", localization.tr("api.button_token.defaultHoverBg")),
                    ("defaultHoverBorderColor", "Color", "primaryHover", localization.tr("api.button_token.defaultHoverBorderColor")),
                    ("defaultHoverColor", "Color", "primaryHover", localization.tr("api.button_token.defaultHoverColor")),
                    ("fontWeight", "Font.Weight", ".medium", localization.tr("api.button_token.fontWeight")),
                    ("ghostBg", "Color", ".clear", localization.tr("api.button_token.ghostBg")),
                    ("iconGap", "CGFloat", "6", localization.tr("api.button_token.iconGap")),
                    ("linkHoverBg", "Color", ".clear", localization.tr("api.button_token.linkHoverBg")),
                    ("onlyIconSize", "CGFloat", "16", localization.tr("api.button_token.onlyIconSize")),
                    ("onlyIconSizeLG", "CGFloat", "18", localization.tr("api.button_token.onlyIconSizeLG")),
                    ("onlyIconSizeSM", "CGFloat", "14", localization.tr("api.button_token.onlyIconSizeSM")),
                    ("paddingInline", "CGFloat", "15", localization.tr("api.button_token.paddingInline")),
                    ("paddingInlineLG", "CGFloat", "15", localization.tr("api.button_token.paddingInlineLG")),
                    ("paddingInlineSM", "CGFloat", "7", localization.tr("api.button_token.paddingInlineSM")),
                    ("primaryColor", "Color", ".white", localization.tr("api.button_token.primaryColor")),
                    ("solidTextColor", "Color", ".white", localization.tr("api.button_token.solidTextColor")),
                    ("textHoverBg", "Color", "black.opacity(0.04)", localization.tr("api.button_token.textHoverBg")),
                    ("textTextActiveColor", "Color", "textPrimary", localization.tr("api.button_token.textTextActiveColor")),
                    ("textTextColor", "Color", "textPrimary", localization.tr("api.button_token.textTextColor")),
                    ("textTextHoverColor", "Color", "textPrimary", localization.tr("api.button_token.textTextHoverColor")),
                ],
                columnWidths: (200, 160, 140, 220)
            )

            // MARK: - Global Token
            Divider()
                .padding(.top, MoinUIConstants.Spacing.lg)

            Text(localization.tr("api.global_token_title"))
                .font(.title2)
                .fontWeight(.semibold)
                .id("global_token")

            Text(localization.tr("api.global_token_desc"))
                .foregroundStyle(.secondary)
                .padding(.bottom, MoinUIConstants.Spacing.sm)

            APITable(
                headers: (
                    localization.tr("api.property"),
                    localization.tr("api.type"),
                    localization.tr("api.default"),
                    localization.tr("api.description")
                ),
                rows: [
                    ("borderRadius", "CGFloat", "6", localization.tr("api.global_token.borderRadius")),
                    ("borderRadiusLG", "CGFloat", "8", localization.tr("api.global_token.borderRadiusLG")),
                    ("borderRadiusSM", "CGFloat", "4", localization.tr("api.global_token.borderRadiusSM")),
                    ("colorPrimary", "Color", "primary", localization.tr("api.global_token.colorPrimary")),
                    ("colorPrimaryActive", "Color", "primaryActive", localization.tr("api.global_token.colorPrimaryActive")),
                    ("colorPrimaryHover", "Color", "primaryHover", localization.tr("api.global_token.colorPrimaryHover")),
                    ("colorTextDisabled", "Color", "textDisabled", localization.tr("api.global_token.colorTextDisabled")),
                    ("controlHeight", "CGFloat", "32", localization.tr("api.global_token.controlHeight")),
                    ("controlHeightLG", "CGFloat", "40", localization.tr("api.global_token.controlHeightLG")),
                    ("controlHeightSM", "CGFloat", "24", localization.tr("api.global_token.controlHeightSM")),
                    ("motionDuration", "Double", "0.2", localization.tr("api.global_token.motionDuration")),
                ],
                columnWidths: (180, 100, 100, 200)
            )
        }
    }
}
