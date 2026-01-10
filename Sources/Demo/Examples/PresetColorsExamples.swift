import SwiftUI
import MoinUI

struct PresetColorsExamples: View {
    @Localized var tr

    private let colors: [(name: String, color: Color, hex: String)] = [
        ("blue", Moin.PresetColors.blue, "#1677FF"),
        ("purple", Moin.PresetColors.purple, "#722ED1"),
        ("cyan", Moin.PresetColors.cyan, "#13C2C2"),
        ("green", Moin.PresetColors.green, "#52C41A"),
        ("magenta", Moin.PresetColors.magenta, "#EB2F96"),
        ("pink", Moin.PresetColors.pink, "#EB2F96"),
        ("red", Moin.PresetColors.red, "#F5222D"),
        ("orange", Moin.PresetColors.orange, "#FA8C16"),
        ("yellow", Moin.PresetColors.yellow, "#FADB14"),
        ("volcano", Moin.PresetColors.volcano, "#FA541C"),
        ("geekblue", Moin.PresetColors.geekblue, "#2F54EB"),
        ("gold", Moin.PresetColors.gold, "#FAAD14"),
        ("lime", Moin.PresetColors.lime, "#A0D911"),
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
        .measureRenderTime("PresetColors")
    }

    private var introduction: some View {
        VStack(alignment: .leading, spacing: Moin.Constants.Spacing.md) {
            Text(tr("preset_colors.title"))
                .font(.largeTitle)
                .fontWeight(.bold)

            Text(tr("preset_colors.description"))
                .font(.body)
                .foregroundStyle(.secondary)

            Link(tr("preset_colors.reference_link"), destination: URL(string: "https://ant.design/docs/spec/colors")!)
                .font(.caption)
                .foregroundStyle(.blue)
        }
    }

    private var colorPalette: some View {
        VStack(alignment: .leading, spacing: Moin.Constants.Spacing.md) {
            Text(tr("preset_colors.palette"))
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
            title: tr("preset_colors.usage"),
            description: tr("preset_colors.usage_desc")
        ) {
            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.md) {
                Text(tr("preset_colors.basic_usage"))
                    .font(.caption)
                    .foregroundStyle(.secondary)

                HStack(spacing: Moin.Constants.Spacing.md) {
                    Moin.Button(tr("preset_colors.blue"), color: .custom(Moin.PresetColors.blue)) {}
                    Moin.Button(tr("preset_colors.purple"), color: .custom(Moin.PresetColors.purple)) {}
                    Moin.Button(tr("preset_colors.cyan"), color: .custom(Moin.PresetColors.cyan)) {}
                }
            }
        } code: {
            """
            Moin.Button("\(tr("preset_colors.blue"))", color: .custom(Moin.PresetColors.blue)) {}
            Moin.Button("\(tr("preset_colors.purple"))", color: .custom(Moin.PresetColors.purple)) {}
            Moin.Button("\(tr("preset_colors.cyan"))", color: .custom(Moin.PresetColors.cyan)) {}
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
                    ("blue", "Color", "#1677FF", tr("preset_colors.blue_desc")),
                    ("purple", "Color", "#722ED1", tr("preset_colors.purple_desc")),
                    ("cyan", "Color", "#13C2C2", tr("preset_colors.cyan_desc")),
                    ("green", "Color", "#52C41A", tr("preset_colors.green_desc")),
                    ("magenta", "Color", "#EB2F96", tr("preset_colors.magenta_desc")),
                    ("pink", "Color", "#EB2F96", tr("preset_colors.pink_desc")),
                    ("red", "Color", "#F5222D", tr("preset_colors.red_desc")),
                    ("orange", "Color", "#FA8C16", tr("preset_colors.orange_desc")),
                    ("yellow", "Color", "#FADB14", tr("preset_colors.yellow_desc")),
                    ("volcano", "Color", "#FA541C", tr("preset_colors.volcano_desc")),
                    ("geekblue", "Color", "#2F54EB", tr("preset_colors.geekblue_desc")),
                    ("gold", "Color", "#FAAD14", tr("preset_colors.gold_desc")),
                    ("lime", "Color", "#A0D911", tr("preset_colors.lime_desc")),
                ]
            )
        }
    }
}
