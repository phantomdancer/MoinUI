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
        }
    }
}
