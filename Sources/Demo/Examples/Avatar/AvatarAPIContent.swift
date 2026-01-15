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
                        ("icon", "String?", "-", tr("avatar.type_desc")),
                        ("size", "AvatarSize", ".default", tr("avatar.size_desc")),
                        ("shape", "AvatarShape", ".circle", tr("avatar.shape_desc")),
                        ("text", "String?", "-", tr("avatar.type_desc")),
                        ("backgroundColor", "Color?", "-", tr("avatar.color_desc")),
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
                        ("maxCount", "Int?", "nil", tr("avatar.group_desc")),
                        ("size", "AvatarSize", ".default", tr("avatar.size_desc")),
                        ("shape", "AvatarShape", ".circle", tr("avatar.shape_desc")),
                    ]
                )
            }
            .padding(Moin.Constants.Spacing.xl)
        }
    }
}
