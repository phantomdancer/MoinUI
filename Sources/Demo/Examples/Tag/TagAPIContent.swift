import SwiftUI
import MoinUI

/// Tag API 文档
struct TagAPIContent: View {
    @Localized var tr

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.xl) {
                // Tag API
                Text("Moin.Tag")
                    .font(.title2)
                    .fontWeight(.semibold)

                Text(tr("tag.api.tag_desc"))
                    .foregroundStyle(.secondary)

                APITable(
                    headers: (
                        tr("api.property"),
                        tr("api.type"),
                        tr("api.default"),
                        tr("api.description")
                    ),
                    rows: [
                        ("text", "String", "-", tr("tag.api.text")),
                        ("color", "Moin.TagColor", ".default", tr("tag.api.color")),
                        ("variant", "Moin.TagVariant", ".filled", tr("tag.api.variant")),
                        ("size", "Moin.TagSize", ".medium", tr("tag.api.size")),
                        ("round", "Bool", "false", tr("tag.api.round")),
                        ("icon", "String?", "nil", tr("tag.api.icon")),
                        ("closable", "Bool", "false", tr("tag.api.closable")),
                        ("onClose", "(() -> Void)?", "nil", tr("tag.api.onClose")),
                    ]
                )

                // CheckableTag API
                Text("Moin.CheckableTag")
                    .font(.title2)
                    .fontWeight(.semibold)

                Text(tr("tag.api.checkable_desc"))
                    .foregroundStyle(.secondary)

                APITable(
                    headers: (
                        tr("api.property"),
                        tr("api.type"),
                        tr("api.default"),
                        tr("api.description")
                    ),
                    rows: [
                        ("text", "String", "-", tr("tag.api.text")),
                        ("isChecked", "Binding<Bool>", "-", tr("tag.api.isChecked")),
                        ("onChange", "((Bool) -> Void)?", "nil", tr("tag.api.onChange")),
                    ]
                )

                // TagColor
                Text("Moin.TagColor")
                    .font(.title2)
                    .fontWeight(.semibold)

                Text(tr("tag.api.tagcolor_desc"))
                    .foregroundStyle(.secondary)

                APITable(
                    headers: (
                        tr("api.value"),
                        tr("api.type"),
                        tr("api.default"),
                        tr("api.description")
                    ),
                    rows: [
                        (".default", "-", "-", tr("tag.api.color_default")),
                        (".success", "-", "-", tr("tag.api.color_success")),
                        (".processing", "-", "-", tr("tag.api.color_processing")),
                        (".warning", "-", "-", tr("tag.api.color_warning")),
                        (".error", "-", "-", tr("tag.api.color_error")),
                        (".custom(Color)", "-", "-", tr("tag.api.color_custom")),
                        (".magenta/.red/...", "-", "-", tr("tag.api.color_preset")),
                    ]
                )

                // TagVariant
                Text("Moin.TagVariant")
                    .font(.title2)
                    .fontWeight(.semibold)

                Text(tr("tag.api.tagvariant_desc"))
                    .foregroundStyle(.secondary)

                APITable(
                    headers: (
                        tr("api.value"),
                        tr("api.type"),
                        tr("api.default"),
                        tr("api.description")
                    ),
                    rows: [
                        (".filled", "-", "-", tr("tag.api.variant_filled")),
                        (".outlined", "-", "-", tr("tag.api.variant_outlined")),
                        (".solid", "-", "-", tr("tag.api.variant_solid")),
                        (".borderless", "-", "-", tr("tag.api.variant_borderless")),
                    ]
                )

                // TagSize
                Text("Moin.TagSize")
                    .font(.title2)
                    .fontWeight(.semibold)

                Text(tr("tag.api.tagsize_desc"))
                    .foregroundStyle(.secondary)

                APITable(
                    headers: (
                        tr("api.value"),
                        tr("api.type"),
                        tr("api.default"),
                        tr("api.description")
                    ),
                    rows: [
                        (".small", "-", "-", tr("tag.api.size_small")),
                        (".medium", "-", "-", tr("tag.api.size_medium")),
                        (".large", "-", "-", tr("tag.api.size_large")),
                    ]
                )
            }
            .padding(Moin.Constants.Spacing.xl)
        }
    }
}
