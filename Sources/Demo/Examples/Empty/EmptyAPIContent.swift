import SwiftUI
import MoinUI

struct EmptyAPIContent: View {
    @Localized var tr

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.xl) {
                // Moin.Empty
                Text("Moin.Empty")
                    .font(.title2)
                    .fontWeight(.semibold)

                Text(tr("empty.basic_desc"))
                    .foregroundStyle(.secondary)

                APITable(
                    headers: (
                        tr("api.property"),
                        tr("api.type"),
                        tr("api.default"),
                        tr("api.description")
                    ),
                    rows: [
                        ("image", "ImageType", ".default", tr("empty.api.image")),
                        ("description", "String?", "nil", tr("empty.api.description")),
                        ("content", "@ViewBuilder", "-", tr("empty.api.content")),
                    ]
                )

                // ImageType
                Text("ImageType")
                    .font(.title2)
                    .fontWeight(.semibold)

                APITable(
                    headers: (
                        tr("api.value"),
                        tr("api.type"),
                        tr("api.default"),
                        tr("api.description")
                    ),
                    rows: [
                        (".default", "ImageType", "✓", tr("empty.api.image_default")),
                        (".simple", "ImageType", "-", tr("empty.api.image_simple")),
                        (".custom(Image)", "ImageType", "-", tr("empty.api.image_custom")),
                        (".systemIcon(String)", "ImageType", "-", tr("empty.api.image_system")),
                        (".url(String)", "ImageType", "-", tr("empty.api.image_url")),
                        (".none", "ImageType", "-", tr("empty.api.image_none")),
                    ]
                )
            }
            .padding(Moin.Constants.Spacing.xl)
        }
    }
}
