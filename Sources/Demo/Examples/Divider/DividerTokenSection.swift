import SwiftUI
import MoinUI

struct DividerTokenSection: View {
    @Localized var tr

    var body: some View {
        VStack(alignment: .leading, spacing: Moin.Constants.Spacing.lg) {
            // MARK: - Component Token
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
            Moin.Divider()
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
    }
}

/// Token 页面容器
struct DividerTokenContent: View {
    @Localized var tr

    private let anchors: [AnchorItem] = [
        AnchorItem(id: "component_token", titleKey: "api.component_token"),
        AnchorItem(id: "global_token", titleKey: "api.global_token_title"),
    ]

    var body: some View {
        ExamplePageWithAnchor(pageName: "Divider Token", anchors: anchors) { _ in
            DividerTokenSection().id("component_token")
        }
    }
}
