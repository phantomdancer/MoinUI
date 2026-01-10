import SwiftUI
import MoinUI

struct ColorsExamples: View {
    @Localized var tr

    private let colors: [(name: String, color: Color, hex: String)] = [
        ("blue", Moin.Colors.blue, "#1677FF"),
        ("purple", Moin.Colors.purple, "#722ED1"),
        ("cyan", Moin.Colors.cyan, "#13C2C2"),
        ("green", Moin.Colors.green, "#52C41A"),
        ("magenta", Moin.Colors.magenta, "#EB2F96"),
        ("pink", Moin.Colors.pink, "#EB2F96"),
        ("red", Moin.Colors.red, "#F5222D"),
        ("orange", Moin.Colors.orange, "#FA8C16"),
        ("yellow", Moin.Colors.yellow, "#FADB14"),
        ("volcano", Moin.Colors.volcano, "#FA541C"),
        ("geekblue", Moin.Colors.geekblue, "#2F54EB"),
        ("gold", Moin.Colors.gold, "#FAAD14"),
        ("lime", Moin.Colors.lime, "#A0D911"),
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.xl) {
                introduction

                Divider()

                colorPalette

                Divider()

                usageExamples

                Divider()

                apiReference
            }
            .padding(Moin.Constants.Spacing.xl)
        }
        .measureRenderTime("Colors")
    }

    private var introduction: some View {
        VStack(alignment: .leading, spacing: Moin.Constants.Spacing.md) {
            Text(tr("colors.title"))
                .font(.largeTitle)
                .fontWeight(.bold)

            Text(tr("colors.description"))
                .font(.body)
                .foregroundStyle(.secondary)

            Link(tr("colors.reference_link"), destination: URL(string: "https://ant.design/docs/spec/colors")!)
                .font(.caption)
                .foregroundStyle(.blue)
        }
    }

    private var colorPalette: some View {
        VStack(alignment: .leading, spacing: Moin.Constants.Spacing.md) {
            Text(tr("colors.palette"))
                .font(.title2)
                .fontWeight(.semibold)

            LazyVGrid(columns: [
                GridItem(.adaptive(minimum: 120, maximum: 180), spacing: Moin.Constants.Spacing.md)
            ], spacing: Moin.Constants.Spacing.md) {
                ForEach(colors, id: \.name) { colorInfo in
                    VStack(spacing: Moin.Constants.Spacing.sm) {
                        RoundedRectangle(cornerRadius: Moin.Constants.Radius.md)
                            .fill(colorInfo.color)
                            .frame(height: 80)
                            .overlay(
                                RoundedRectangle(cornerRadius: Moin.Constants.Radius.md)
                                    .strokeBorder(.quaternary, lineWidth: 1)
                            )

                        VStack(spacing: Moin.Constants.Spacing.xs) {
                            Text(colorInfo.name)
                                .font(.caption)
                                .foregroundStyle(.secondary)

                            Text(colorInfo.hex)
                                .font(.caption2)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }
        }
    }

    private var usageExamples: some View {
        ExampleSection(
            title: tr("colors.usage"),
            description: tr("colors.usage_desc")
        ) {
            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.md) {
                Text(tr("colors.basic_usage"))
                    .font(.caption)
                    .foregroundStyle(.secondary)

                HStack(spacing: Moin.Constants.Spacing.md) {
                    Moin.Button(tr("colors.blue"), color: .custom(Moin.Colors.blue)) {}
                    Moin.Button(tr("colors.purple"), color: .custom(Moin.Colors.purple)) {}
                    Moin.Button(tr("colors.cyan"), color: .custom(Moin.Colors.cyan)) {}
                }
            }
        } code: {
            """
            Moin.Button("\(tr("colors.blue"))", color: .custom(Moin.Colors.blue)) {}
            Moin.Button("\(tr("colors.purple"))", color: .custom(Moin.Colors.purple)) {}
            Moin.Button("\(tr("colors.cyan"))", color: .custom(Moin.Colors.cyan)) {}
            """
        }
    }

    private var apiReference: some View {
        VStack(alignment: .leading, spacing: Moin.Constants.Spacing.md) {
            Text(tr("API"))
                .font(.title2)
                .fontWeight(.semibold)

            APITable(
                headers: (
                    tr("api.property"),
                    tr("api.type"),
                    tr("api.default"),
                    tr("api.description")
                ),
                rows: [
                    ("blue", "Color", "#1677FF", tr("colors.blue_desc")),
                    ("purple", "Color", "#722ED1", tr("colors.purple_desc")),
                    ("cyan", "Color", "#13C2C2", tr("colors.cyan_desc")),
                    ("green", "Color", "#52C41A", tr("colors.green_desc")),
                    ("magenta", "Color", "#EB2F96", tr("colors.magenta_desc")),
                    ("pink", "Color", "#EB2F96", tr("colors.pink_desc")),
                    ("red", "Color", "#F5222D", tr("colors.red_desc")),
                    ("orange", "Color", "#FA8C16", tr("colors.orange_desc")),
                    ("yellow", "Color", "#FADB14", tr("colors.yellow_desc")),
                    ("volcano", "Color", "#FA541C", tr("colors.volcano_desc")),
                    ("geekblue", "Color", "#2F54EB", tr("colors.geekblue_desc")),
                    ("gold", "Color", "#FAAD14", tr("colors.gold_desc")),
                    ("lime", "Color", "#A0D911", tr("colors.lime_desc")),
                ]
            )
        }
    }
}
