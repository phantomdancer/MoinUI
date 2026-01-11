import SwiftUI
import MoinUI

struct SpaceAPIContent: View {
    @Localized var tr

    private let anchors: [AnchorItem] = [
        AnchorItem(id: "api", titleKey: "API"),
        AnchorItem(id: "component_token", titleKey: "api.component_token"),
        AnchorItem(id: "global_token", titleKey: "api.global_token_title"),
    ]

    var body: some View {
        ExamplePageWithAnchor(pageName: "Space API", anchors: anchors) { _ in
            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.lg) {
                // MARK: - API
                Text(tr("API"))
                    .font(.title2)
                    .fontWeight(.semibold)
                    .id("api")

                Text("Moin.Space")
                    .font(.headline)

                APITable(
                    headers: (
                        tr("api.property"),
                        tr("api.type"),
                        tr("api.default"),
                        tr("api.description")
                    ),
                    rows: [
                        ("size", "Moin.SpaceSize", ".medium", tr("api.space.size")),
                        ("direction", "Moin.SpaceDirection", ".horizontal", tr("api.space.direction")),
                        ("alignment", "Moin.SpaceAlignment", ".center", tr("api.space.alignment")),
                        ("wrap", "Bool", "false", tr("api.space.wrap")),
                        ("content", "@ViewBuilder () -> View", "-", tr("api.space.content")),
                    ]
                )

                Text("Moin.SpaceSize")
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
                        ("small", "-", "-", tr("api.space.size_small")),
                        ("medium", "-", "-", tr("api.space.size_medium")),
                        ("large", "-", "-", tr("api.space.size_large")),
                        ("custom(CGFloat)", "-", "-", tr("api.space.size_custom")),
                    ]
                )

                Text("Moin.SpaceDirection")
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
                        ("horizontal", "-", "-", tr("api.space.direction_h")),
                        ("vertical", "-", "-", tr("api.space.direction_v")),
                    ]
                )

                Text("Moin.SpaceAlignment")
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
                        ("start", "-", "-", tr("api.space.align_start")),
                        ("center", "-", "-", tr("api.space.align_center")),
                        ("end", "-", "-", tr("api.space.align_end")),
                    ]
                )

                // MARK: - Component Token
                Divider()
                    .padding(.top, Moin.Constants.Spacing.lg)

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
                        ("fontSize", "CGFloat", "14", tr("api.global_token.fontSize")),
                        ("margin", "CGFloat", "16", tr("api.global_token.margin")),
                        ("marginLG", "CGFloat", "24", tr("api.global_token.marginLG")),
                        ("marginXS", "CGFloat", "8", tr("api.global_token.marginXS")),
                        ("motionDuration", "Double", "0.2", tr("api.global_token.motionDuration")),
                    ]
                )
            }
            .padding(Moin.Constants.Spacing.xl)
        }
    }
}
