import SwiftUI
import MoinUI

struct DividerAPIContent: View {
    @Localized var tr

    private let anchors: [AnchorItem] = [
        AnchorItem(id: "api", titleKey: "API"),
        AnchorItem(id: "component_token", titleKey: "api.component_token"),
        AnchorItem(id: "global_token", titleKey: "api.global_token_title"),
    ]

    var body: some View {
        ExamplePageWithAnchor(pageName: "Divider API", anchors: anchors) { _ in
            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.lg) {
                // MARK: - API
                Text(tr("API"))
                    .font(.title2)
                    .fontWeight(.semibold)
                    .id("api")

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

                // MARK: - Component Token
                Divider()
                    .padding(.top, Moin.Constants.Spacing.lg)

                Text(tr("api.component_token"))
                    .font(.title2)
                    .fontWeight(.semibold)
                    .id("component_token")

                Text(tr("api.divider.token_desc"))
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
                        ("lineColor", "Color", "border", tr("api.divider.token_line_color")),
                        ("textColor", "Color", "textPrimary", tr("api.divider.token_text_color")),
                        ("fontSize", "CGFloat", "14", tr("api.divider.token_font_size")),
                        ("verticalMargin", "CGFloat", "16", tr("api.divider.token_vertical_margin")),
                        ("horizontalMargin", "CGFloat", "8", tr("api.divider.token_horizontal_margin")),
                        ("textPadding", "CGFloat", "12", tr("api.divider.token_text_padding")),
                        ("lineWidth", "CGFloat", "1", tr("api.divider.token_line_width")),
                        ("dashLength", "CGFloat", "4", tr("api.divider.token_dash_length")),
                        ("dashGap", "CGFloat", "4", tr("api.divider.token_dash_gap")),
                    ]
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
                        ("colorPrimary", "Color", "primary", tr("api.global_token.colorPrimary")),
                        ("colorText", "Color", "textPrimary", tr("api.global_token.colorText")),
                        ("lineWidth", "CGFloat", "1", tr("api.global_token.lineWidth")),
                        ("margin", "CGFloat", "16", tr("api.global_token.margin")),
                    ]
                )
            }
            .padding(Moin.Constants.Spacing.xl)
        }
    }
}
