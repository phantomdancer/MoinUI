import SwiftUI
import MoinUI

struct DividerAPIContent: View {
    @Localized var tr

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.lg) {
                // MARK: - API
                Text(tr("API"))
                    .font(.title2)
                    .fontWeight(.semibold)

                Text("Moin.Divider")
                    .font(.headline)

                APITable(
                    headers: (
                        tr("api.property"),
                        tr("api.type"),
                        tr("api.default"),
                        tr("api.description")
                    ),
                    rows: [
                        ("orientation", "Moin.DividerOrientation", ".horizontal", tr("api.divider.orientation")),
                        ("variant", "Moin.DividerVariant", ".solid", tr("api.divider.variant")),
                        ("titlePlacement", "Moin.DividerTitlePlacement", ".center", tr("api.divider.title_placement")),
                        ("plain", "Bool", "false", tr("api.divider.plain")),
                        ("title", "String?", "nil", tr("api.divider.title")),
                        ("content", "@ViewBuilder () -> View", "nil", tr("api.divider.content")),
                    ]
                )

                Text("Moin.DividerOrientation")
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
                        ("horizontal", "-", "-", tr("api.divider.orientation_h")),
                        ("vertical", "-", "-", tr("api.divider.orientation_v")),
                    ]
                )

                Text("Moin.DividerVariant")
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
                        ("solid", "-", "-", tr("api.divider.variant_solid")),
                        ("dashed", "-", "-", tr("api.divider.variant_dashed")),
                        ("dotted", "-", "-", tr("api.divider.variant_dotted")),
                    ]
                )

                Text("Moin.DividerTitlePlacement")
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
                        ("left", "-", "-", tr("api.divider.placement_left")),
                        ("center", "-", "-", tr("api.divider.placement_center")),
                        ("right", "-", "-", tr("api.divider.placement_right")),
                    ]
                )
            }
            .padding(Moin.Constants.Spacing.xl)
        }
    }
}
