import SwiftUI
import MoinUI

struct ButtonAPISection: View {
    @ObservedObject private var localization = MoinUILocalization.shared

    var body: some View {
        VStack(alignment: .leading, spacing: Constants.Spacing.lg) {
            Text("API")
                .font(.title2)
                .fontWeight(.semibold)

            APITable(
                headers: (
                    localization.tr("api.property"),
                    localization.tr("api.type"),
                    localization.tr("api.default"),
                    localization.tr("api.description")
                ),
                rows: [
                    ("type", "MoinUIButtonColor", ".default", localization.tr("api.button.type")),
                    ("size", "MoinUIButtonSize", ".medium", localization.tr("api.button.size")),
                    ("variant", "MoinUIButtonVariant", ".solid", localization.tr("api.button.variant")),
                    ("shape", "MoinUIButtonShape", ".default", localization.tr("api.button.shape")),
                    ("color", "Color?", "nil", localization.tr("api.button.color")),
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
                .padding(.top, Constants.Spacing.md)

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
                .padding(.top, Constants.Spacing.md)

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
        }
    }
}
