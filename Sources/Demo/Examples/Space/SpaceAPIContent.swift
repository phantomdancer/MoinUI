import SwiftUI
import MoinUI

struct SpaceAPIContent: View {
    @Localized var tr

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.lg) {
                // MARK: - API
                Text(tr("API"))
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
                        ("size", "Moin.Space.Size", ".medium", tr("api.space.size")),
                        ("direction", "Moin.Space.Direction", ".horizontal", tr("api.space.direction")),
                        ("alignment", "Moin.Space.Alignment", ".center", tr("api.space.alignment")),
                        ("wrap", "Bool", "false", tr("api.space.wrap")),
                        ("content", "@ViewBuilder () -> View", "-", tr("api.space.content")),
                    ]
                )

                Text("Moin.Space.Size")
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

                Text("Moin.Space.Direction")
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

                Text("Moin.Space.Alignment")
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
            }
            .padding(Moin.Constants.Spacing.xl)
        }
    }
}
