import SwiftUI
import MoinUI

struct AvatarAPIContent: View {
    @Localized var tr

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.xl) {
                // Moin.Avatar
                Text("Moin.Avatar")
                    .font(.title2)
                    .fontWeight(.semibold)

                Text(tr("avatar.basic_desc"))
                    .foregroundStyle(.secondary)

                APITable(
                    headers: (
                        tr("api.property"),
                        tr("api.type"),
                        tr("api.default"),
                        tr("api.description")
                    ),
                    rows: [
                        ("icon", "String?", "-", tr("avatar.api.icon")),
                        ("text", "String?", "-", tr("avatar.api.text")),
                        ("image", "Image?", "-", tr("avatar.api.image")),
                        ("src", "URL? / String", "-", tr("avatar.api.src")),
                        ("fallbackIcon", "String", "\"person.fill\"", tr("avatar.api.fallback_icon")),
                        ("size", "AvatarSize", ".default", tr("avatar.api.size")),
                        ("shape", "AvatarShape", ".circle", tr("avatar.api.shape")),
                        ("backgroundColor", "Color?", "-", tr("avatar.api.background_color")),
                        ("gap", "CGFloat", "4", tr("avatar.api.gap")),
                        ("content", "@ViewBuilder", "-", tr("avatar.api.content")),
                    ]
                )

                // AvatarSize
                Text("AvatarSize")
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
                        (".large", "AvatarSize", "-", tr("avatar.api.size_large")),
                        (".default", "AvatarSize", "✓", tr("avatar.api.size_default")),
                        (".small", "AvatarSize", "-", tr("avatar.api.size_small")),
                        (".custom(CGFloat)", "AvatarSize", "-", tr("avatar.api.size_custom")),
                    ]
                )

                // AvatarShape
                Text("AvatarShape")
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
                        (".circle", "AvatarShape", "✓", tr("avatar.api.shape_circle")),
                        (".square", "AvatarShape", "-", tr("avatar.api.shape_square")),
                    ]
                )

                // Moin.AvatarGroup
                Text("Moin.AvatarGroup")
                    .font(.title2)
                    .fontWeight(.semibold)

                Text(tr("avatar.group_desc"))
                    .foregroundStyle(.secondary)

                APITable(
                    headers: (
                        tr("api.property"),
                        tr("api.type"),
                        tr("api.default"),
                        tr("api.description")
                    ),
                    rows: [
                        ("maxCount", "Int?", "nil", tr("avatar.api.max_count")),
                        ("size", "AvatarSize", ".default", tr("avatar.api.size")),
                        ("shape", "AvatarShape", ".circle", tr("avatar.api.shape")),
                        ("content", "@ViewBuilder", "-", tr("avatar.api.group_content")),
                    ]
                )
            }
            .padding(Moin.Constants.Spacing.xl)
        }
    }
}
