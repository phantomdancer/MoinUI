import SwiftUI
import MoinUI

struct TypographyAPIContent: View {
    @Localized var tr

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.lg) {
                // MARK: - Title API
                Text(tr("API"))
                    .font(.title2)
                    .fontWeight(.semibold)

                Text("Moin.Typography.Title")
                    .font(.headline)

                APITable(
                    headers: (
                        tr("api.property"),
                        tr("api.type"),
                        tr("api.default"),
                        tr("api.description")
                    ),
                    rows: [
                        ("content", "String", "-", tr("api.typography.content")),
                        ("level", "Moin.Typography.TitleLevel", ".h1", tr("api.typography.level")),
                        ("type", "Moin.Typography.TextType", ".default", tr("api.typography.type")),
                        ("disabled", "Bool", "false", tr("api.typography.disabled")),
                        ("mark", "Bool", "false", tr("api.typography.mark")),
                        ("underline", "Bool", "false", tr("api.typography.underline")),
                        ("delete", "Bool", "false", tr("api.typography.delete")),
                        ("code", "Bool", "false", tr("api.typography.code")),
                    ]
                )

                // MARK: - Typography API
                Text("Moin.Typography.Text")
                    .font(.headline)
                    .padding(.top, Moin.Constants.Spacing.md)

                APITable(
                    headers: (
                        tr("api.property"),
                        tr("api.type"),
                        tr("api.default"),
                        tr("api.description")
                    ),
                    rows: [
                        ("content", "String", "-", tr("api.typography.content")),
                        ("type", "Moin.Typography.TextType", ".default", tr("api.typography.type")),
                        ("disabled", "Bool", "false", tr("api.typography.disabled")),
                        ("mark", "Bool", "false", tr("api.typography.mark")),
                        ("underline", "Bool", "false", tr("api.typography.underline")),
                        ("delete", "Bool", "false", tr("api.typography.delete")),
                        ("strong", "Bool", "false", tr("api.typography.strong")),
                        ("italic", "Bool", "false", tr("api.typography.italic")),
                        ("code", "Bool", "false", tr("api.typography.code")),
                        ("keyboard", "Bool", "false", tr("api.typography.keyboard")),
                    ]
                )

                // MARK: - Paragraph API
                Text("Moin.Typography.Paragraph")
                    .font(.headline)
                    .padding(.top, Moin.Constants.Spacing.md)

                APITable(
                    headers: (
                        tr("api.property"),
                        tr("api.type"),
                        tr("api.default"),
                        tr("api.description")
                    ),
                    rows: [
                        ("content", "String", "-", tr("api.typography.content")),
                        ("type", "Moin.Typography.TextType", ".default", tr("api.typography.type")),
                        ("disabled", "Bool", "false", tr("api.typography.disabled")),
                        ("mark", "Bool", "false", tr("api.typography.mark")),
                        ("underline", "Bool", "false", tr("api.typography.underline")),
                        ("delete", "Bool", "false", tr("api.typography.delete")),
                        ("strong", "Bool", "false", tr("api.typography.strong")),
                        ("italic", "Bool", "false", tr("api.typography.italic")),
                    ]
                )

                // MARK: - Link API
                Text("Moin.Typography.Link")
                    .font(.headline)
                    .padding(.top, Moin.Constants.Spacing.md)

                APITable(
                    headers: (
                        tr("api.property"),
                        tr("api.type"),
                        tr("api.default"),
                        tr("api.description")
                    ),
                    rows: [
                        ("content", "String", "-", tr("api.typography.content")),
                        ("disabled", "Bool", "false", tr("api.typography.disabled")),
                        ("action", "() -> Void", "-", tr("api.typography.action")),
                    ]
                )

                // MARK: - TitleLevel
                Text("Moin.Typography.TitleLevel")
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
                        ("h1", "-", "-", tr("api.typography.h1")),
                        ("h2", "-", "-", tr("api.typography.h2")),
                        ("h3", "-", "-", tr("api.typography.h3")),
                        ("h4", "-", "-", tr("api.typography.h4")),
                        ("h5", "-", "-", tr("api.typography.h5")),
                    ]
                )

                // MARK: - TypographyType
                Text("Moin.Typography.TextType")
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
                        ("default", "-", "-", tr("api.typography.type_default")),
                        ("secondary", "-", "-", tr("api.typography.type_secondary")),
                        ("success", "-", "-", tr("api.typography.type_success")),
                        ("warning", "-", "-", tr("api.typography.type_warning")),
                        ("danger", "-", "-", tr("api.typography.type_danger")),
                    ]
                )
            }
            .padding(Moin.Constants.Spacing.xl)
        }
    }
}
