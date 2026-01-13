import SwiftUI
import MoinUI

struct TypographyTokenSection: View {
    @Localized var tr

    var body: some View {
        VStack(alignment: .leading, spacing: Moin.Constants.Spacing.lg) {
            // MARK: - Font Size Token
            Text(tr("token.font_size"))
                .font(.title2)
                .fontWeight(.semibold)
                .id("font_size")

            Text(tr("typography.token_desc"))
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
                    ("fontSizeHeading1", "CGFloat", "38", tr("api.typography.h1")),
                    ("fontSizeHeading2", "CGFloat", "30", tr("api.typography.h2")),
                    ("fontSizeHeading3", "CGFloat", "24", tr("api.typography.h3")),
                    ("fontSizeHeading4", "CGFloat", "20", tr("api.typography.h4")),
                    ("fontSizeHeading5", "CGFloat", "16", tr("api.typography.h5")),
                    ("fontSize", "CGFloat", "14", tr("token.default_font_size")),
                    ("fontSizeSM", "CGFloat", "12", tr("token.small_font_size")),
                    ("fontSizeLG", "CGFloat", "16", tr("token.large_font_size")),
                ]
            )

            // MARK: - Line Height Token
            Divider()
                .padding(.top, Moin.Constants.Spacing.lg)

            Text(tr("token.line_height"))
                .font(.title2)
                .fontWeight(.semibold)
                .id("line_height")

            APITable(
                headers: (
                    tr("api.property"),
                    tr("api.type"),
                    tr("api.default"),
                    tr("api.description")
                ),
                rows: [
                    ("lineHeightHeading1", "CGFloat", "46", tr("token.h1_line_height")),
                    ("lineHeightHeading2", "CGFloat", "38", tr("token.h2_line_height")),
                    ("lineHeightHeading3", "CGFloat", "32", tr("token.h3_line_height")),
                    ("lineHeightHeading4", "CGFloat", "28", tr("token.h4_line_height")),
                    ("lineHeightHeading5", "CGFloat", "24", tr("token.h5_line_height")),
                    ("lineHeight", "CGFloat", "22", tr("token.default_line_height")),
                ]
            )

            // MARK: - Color Token
            Divider()
                .padding(.top, Moin.Constants.Spacing.lg)

            Text(tr("token.text_color"))
                .font(.title2)
                .fontWeight(.semibold)
                .id("text_color")

            APITable(
                headers: (
                    tr("api.property"),
                    tr("api.type"),
                    tr("api.default"),
                    tr("api.description")
                ),
                rows: [
                    ("colorText", "Color", "-", tr("token.primary_text")),
                    ("colorTextSecondary", "Color", "-", tr("token.secondary_text")),
                    ("colorTextTertiary", "Color", "-", tr("token.tertiary_text")),
                    ("colorTextDisabled", "Color", "-", tr("token.disabled_text")),
                    ("colorSuccess", "Color", "-", tr("token.success_color")),
                    ("colorWarning", "Color", "-", tr("token.warning_color")),
                    ("colorDanger", "Color", "-", tr("token.danger_color")),
                    ("colorLink", "Color", "-", tr("token.link_color")),
                ]
            )
        }
    }
}

/// Token 页面容器
struct TypographyTokenContent: View {
    @Localized var tr

    private let anchors: [AnchorItem] = [
        AnchorItem(id: "font_size", titleKey: "token.font_size"),
        AnchorItem(id: "line_height", titleKey: "token.line_height"),
        AnchorItem(id: "text_color", titleKey: "token.text_color"),
    ]

    var body: some View {
        ExamplePageWithAnchor(pageName: "Typography Token", anchors: anchors) { _ in
            TypographyTokenSection().id("font_size")
        }
    }
}
