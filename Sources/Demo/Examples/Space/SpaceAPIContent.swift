import SwiftUI
import MoinUI

struct SpaceAPIContent: View {
    @Localized var tr

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.lg) {
                // MARK: - API
                Text("API")
                    .font(.title2)
                    .fontWeight(.semibold)

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
                        ("size", "Moin.SpaceSize", ".middle", tr("api.space.size")),
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
                        ("middle", "-", "-", tr("api.space.size_middle")),
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
                        ("sizeMiddle", "CGFloat", "12", tr("api.space.token_middle")),
                        ("sizeLarge", "CGFloat", "16", tr("api.space.token_large")),
                    ]
                )
            }
            .padding(Moin.Constants.Spacing.xl)
        }
    }
}
