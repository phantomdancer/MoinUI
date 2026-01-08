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
                    ("label", "@ViewBuilder () -> View", "-", localization.tr("api.button.label")),
                    ("color", "MoinUIButtonColor", ".default", localization.tr("api.button.type")),
                    ("size", "MoinUIButtonSize", ".medium", localization.tr("api.button.size")),
                    ("variant", "MoinUIButtonVariant", ".solid", localization.tr("api.button.variant")),
                    ("shape", "MoinUIButtonShape", ".default", localization.tr("api.button.shape")),
                    ("gradient", "LinearGradient?", "nil", localization.tr("api.button.gradient")),
                    ("fontColor", "Color?", "nil", localization.tr("api.button.fontColor")),
                    ("icon", "String?", "nil", localization.tr("api.button.icon")),
                    ("iconPlacement", "MoinUIButtonIconPlacement", ".start", localization.tr("api.button.iconPlacement")),
                    ("loading", "MoinUIButtonLoading", "false", localization.tr("api.button.loading")),
                    ("isDisabled", "Bool", "false", localization.tr("api.button.isDisabled")),
                    ("isBlock", "Bool", "false", localization.tr("api.button.isBlock")),
                    ("isGhost", "Bool", "false", localization.tr("api.button.isGhost")),
                    ("href", "URL?", "nil", localization.tr("api.button.href")),
                    ("action", "(() -> Void)?", "nil", localization.tr("api.button.action")),
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
                    ("default", "-", "-", localization.tr("api.type_values.default")),
                    ("primary", "-", "-", localization.tr("api.type_values.primary")),
                    ("success", "-", "-", localization.tr("api.type_values.success")),
                    ("warning", "-", "-", localization.tr("api.type_values.warning")),
                    ("danger", "-", "-", localization.tr("api.type_values.danger")),
                    ("info", "-", "-", localization.tr("api.type_values.info")),
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
                    ("solid", "-", "-", localization.tr("api.variant_values.solid")),
                    ("outlined", "-", "-", localization.tr("api.variant_values.outlined")),
                    ("dashed", "-", "-", localization.tr("api.variant_values.dashed")),
                    ("filled", "-", "-", localization.tr("api.variant_values.filled")),
                    ("text", "-", "-", localization.tr("api.variant_values.text")),
                    ("link", "-", "-", localization.tr("api.variant_values.link")),
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
                    ("fontWeight", "Font.Weight", ".medium", localization.tr("api.button_token.fontWeight")),
                    ("iconGap", "CGFloat", "6", localization.tr("api.button_token.iconGap")),
                    ("defaultColor", "Color", "textPrimary", localization.tr("api.button_token.defaultColor")),
                    ("defaultBg", "Color", "background", localization.tr("api.button_token.defaultBg")),
                    ("defaultBorderColor", "Color", "border", localization.tr("api.button_token.defaultBorderColor")),
                    ("defaultHoverBg", "Color", "background", localization.tr("api.button_token.defaultHoverBg")),
                    ("defaultHoverColor", "Color", "primaryHover", localization.tr("api.button_token.defaultHoverColor")),
                    ("defaultHoverBorderColor", "Color", "primaryHover", localization.tr("api.button_token.defaultHoverBorderColor")),
                    ("defaultActiveBg", "Color", "background", localization.tr("api.button_token.defaultActiveBg")),
                    ("defaultActiveColor", "Color", "primaryActive", localization.tr("api.button_token.defaultActiveColor")),
                    ("defaultActiveBorderColor", "Color", "primaryActive", localization.tr("api.button_token.defaultActiveBorderColor")),
                    ("primaryColor", "Color", ".white", localization.tr("api.button_token.primaryColor")),
                    ("dangerColor", "Color", ".white", localization.tr("api.button_token.dangerColor")),
                    ("ghostBg", "Color", ".clear", localization.tr("api.button_token.ghostBg")),
                    ("defaultGhostColor", "Color", ".white", localization.tr("api.button_token.defaultGhostColor")),
                    ("defaultGhostBorderColor", "Color", ".white", localization.tr("api.button_token.defaultGhostBorderColor")),
                    ("solidTextColor", "Color", ".white", localization.tr("api.button_token.solidTextColor")),
                    ("textTextColor", "Color", "textPrimary", localization.tr("api.button_token.textTextColor")),
                    ("textHoverBg", "Color", "black.opacity(0.04)", localization.tr("api.button_token.textHoverBg")),
                    ("linkHoverBg", "Color", ".clear", localization.tr("api.button_token.linkHoverBg")),
                    ("paddingInline", "CGFloat", "15", localization.tr("api.button_token.paddingInline")),
                    ("paddingInlineLG", "CGFloat", "15", localization.tr("api.button_token.paddingInlineLG")),
                    ("paddingInlineSM", "CGFloat", "7", localization.tr("api.button_token.paddingInlineSM")),
                    ("onlyIconSize", "CGFloat", "16", localization.tr("api.button_token.onlyIconSize")),
                    ("onlyIconSizeLG", "CGFloat", "18", localization.tr("api.button_token.onlyIconSizeLG")),
                    ("onlyIconSizeSM", "CGFloat", "14", localization.tr("api.button_token.onlyIconSizeSM")),
                    ("contentFontSize", "CGFloat", "14", localization.tr("api.button_token.contentFontSize")),
                    ("contentFontSizeLG", "CGFloat", "16", localization.tr("api.button_token.contentFontSizeLG")),
                    ("contentFontSizeSM", "CGFloat", "12", localization.tr("api.button_token.contentFontSizeSM")),
                    ("borderColorDisabled", "Color", "border.opacity(0.5)", localization.tr("api.button_token.borderColorDisabled")),
                    ("defaultBgDisabled", "Color", "backgroundDisabled", localization.tr("api.button_token.defaultBgDisabled")),
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
                    ("colorPrimary", "Color", "primary", localization.tr("api.global_token.colorPrimary")),
                    ("colorPrimaryHover", "Color", "primaryHover", localization.tr("api.global_token.colorPrimaryHover")),
                    ("colorPrimaryActive", "Color", "primaryActive", localization.tr("api.global_token.colorPrimaryActive")),
                    ("borderRadius", "CGFloat", "6", localization.tr("api.global_token.borderRadius")),
                    ("borderRadiusLG", "CGFloat", "8", localization.tr("api.global_token.borderRadiusLG")),
                    ("borderRadiusSM", "CGFloat", "4", localization.tr("api.global_token.borderRadiusSM")),
                    ("controlHeight", "CGFloat", "32", localization.tr("api.global_token.controlHeight")),
                    ("controlHeightLG", "CGFloat", "40", localization.tr("api.global_token.controlHeightLG")),
                    ("controlHeightSM", "CGFloat", "24", localization.tr("api.global_token.controlHeightSM")),
                    ("colorTextDisabled", "Color", "textDisabled", localization.tr("api.global_token.colorTextDisabled")),
                    ("motionDuration", "Double", "0.2", localization.tr("api.global_token.motionDuration")),
                ],
                columnWidths: (180, 100, 100, 200)
            )
        }
    }
}
