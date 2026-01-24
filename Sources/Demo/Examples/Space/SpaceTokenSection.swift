import SwiftUI
import MoinUI

struct SpaceTokenSection: View {
    @Localized var tr

    var body: some View {
        VStack(alignment: .leading, spacing: Moin.Constants.Spacing.lg) {
            // MARK: - Component Token
            Text(tr("api.component_token"))
                .font(.title2)
                .fontWeight(.semibold)
                .id("component_token")

            Text(tr("api.space.token_desc"))
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
                    ("sizeSmall", "CGFloat", "8", tr("api.space.token_small")),
                    ("sizeMedium", "CGFloat", "12", tr("api.space.token_medium")),
                    ("sizeLarge", "CGFloat", "16", tr("api.space.token_large")),
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
                    ("fontSize", "CGFloat", "14", tr("api.global_token.fontSize")),
                    ("margin", "CGFloat", "16", tr("api.global_token.margin")),
                    ("marginLG", "CGFloat", "24", tr("api.global_token.marginLG")),
                    ("marginXS", "CGFloat", "8", tr("api.global_token.marginXS")),
                    ("motionDuration", "Double", "0.2", tr("api.global_token.motionDuration")),
                ]
            )
        }
    }
}

/// Token 页面容器
struct SpaceTokenContent: View {
    @Localized var tr

    private let anchors: [AnchorItem] = [
        AnchorItem(id: "component_token", titleKey: "api.component_token"),
        AnchorItem(id: "global_token", titleKey: "api.global_token_title"),
    ]

    var body: some View {
        ExamplePageWithAnchor(pageName: "Space Token", anchors: anchors) { _ in
            SpaceTokenSection().id("component_token")
        }
    }
}
