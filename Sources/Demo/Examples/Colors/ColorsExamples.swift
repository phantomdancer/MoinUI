import SwiftUI
import MoinUI

struct ColorsExamples: View {
    @Localized var tr

    /// 所有色板
    private let palettes: [(name: String, palette: Moin.ColorPalette)] = [
        ("Red", Moin.Colors.redPalette),
        ("Volcano", Moin.Colors.volcanoPalette),
        ("Orange", Moin.Colors.orangePalette),
        ("Gold", Moin.Colors.goldPalette),
        ("Yellow", Moin.Colors.yellowPalette),
        ("Lime", Moin.Colors.limePalette),
        ("Green", Moin.Colors.greenPalette),
        ("Cyan", Moin.Colors.cyanPalette),
        ("Blue", Moin.Colors.bluePalette),
        ("Geekblue", Moin.Colors.geekbluePalette),
        ("Purple", Moin.Colors.purplePalette),
        ("Magenta", Moin.Colors.magentaPalette),
    ]

    /// 锚点列表
    private let anchors: [AnchorItem] = [
        AnchorItem(id: "palette", titleKey: "colors.palette"),
        AnchorItem(id: "generator", titleKey: "colors.generator"),
        AnchorItem(id: "semantic", titleKey: "colors.semantic_usage"),
        AnchorItem(id: "preset", titleKey: "colors.preset_usage"),
        AnchorItem(id: "level", titleKey: "colors.palette_usage"),
        AnchorItem(id: "generate", titleKey: "colors.generate_usage"),
        AnchorItem(id: "api", titleKey: "API"),
    ]

    var body: some View {
        ExamplePageWithAnchor(pageName: "Colors", anchors: anchors) { _ in
            introduction

            Moin.Divider()

            colorPalettes.id("palette")

            Moin.Divider()

            paletteGenerator.id("generator")

            Moin.Divider()

            semanticUsageSection.id("semantic")
            presetUsageSection.id("preset")
            paletteUsageSection.id("level")
            generateUsageSection.id("generate")

            Moin.Divider()

            apiReference.id("api")
        }
    }

    // MARK: - 介绍

    private var introduction: some View {
        VStack(alignment: .leading, spacing: Moin.Constants.Spacing.md) {
            Text(tr("colors.title"))
                .font(.largeTitle)
                .fontWeight(.bold)

            Text(tr("colors.description"))
                .font(.body)
                .foregroundStyle(.secondary)
        }
    }

    // MARK: - 色板展示

    private var colorPalettes: some View {
        VStack(alignment: .leading, spacing: Moin.Constants.Spacing.lg) {
            Text(tr("colors.palette"))
                .font(.title2)
                .fontWeight(.semibold)

            Text(tr("colors.palette_desc"))
                .font(.callout)
                .foregroundStyle(.secondary)

            // 响应式布局：最少 4 列
            LazyVGrid(columns: [
                GridItem(.adaptive(minimum: 230, maximum: 280), spacing: Moin.Constants.Spacing.md)
            ], spacing: Moin.Constants.Spacing.md) {
                ForEach(palettes, id: \.name) { item in
                    PaletteCard(name: item.name, palette: item.palette)
                }
            }
        }
    }

    // MARK: - 色板生成器

    @State private var customColor: Color = Moin.Colors.blue
    @State private var generatedPalette: Moin.ColorPalette?

    private var paletteGenerator: some View {
        VStack(alignment: .leading, spacing: Moin.Constants.Spacing.md) {
            Text(tr("colors.generator"))
                .font(.title2)
                .fontWeight(.semibold)

            Text(tr("colors.generator_desc"))
                .font(.callout)
                .foregroundStyle(.secondary)

            HStack(spacing: Moin.Constants.Spacing.md) {
                ColorPicker(tr("colors.pick_color"), selection: $customColor)
                    .labelsHidden()

                Text(customColor.toHex())
                    .font(.system(.body, design: .monospaced))
                    .foregroundStyle(.secondary)

                Spacer()

                Moin.Button(tr("colors.generate"), color: .primary) {
                    generatedPalette = Moin.ColorPalette.generate(from: customColor)
                }
            }

            if let palette = generatedPalette {
                HStack(spacing: 0) {
                    ForEach(1...10, id: \.self) { level in
                        Rectangle()
                            .fill(palette[level])
                            .frame(height: 44)
                            .overlay(
                                Text("\(level)")
                                    .font(.caption2)
                                    .foregroundStyle(level <= 5 ? .black.opacity(0.65) : .white)
                            )
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: Moin.Constants.Radius.md))
            }
        }
    }

    // MARK: - 语义颜色章节

    private var semanticUsageSection: some View {
        ExampleSection(
            title: tr("colors.semantic_usage"),
            description: tr("colors.semantic_usage_desc")
        ) {
            HStack(spacing: Moin.Constants.Spacing.md) {
                Moin.Button(tr("colors.primary"), color: .primary) {}
                Moin.Button(tr("colors.success"), color: .success) {}
                Moin.Button(tr("colors.warning"), color: .warning) {}
                Moin.Button(tr("colors.danger"), color: .danger) {}
            }
        } code: {
            """
            // \(tr("colors.code.semantic"))
            Moin.Button("\(tr("colors.primary"))", color: .primary) {}
            Moin.Button("\(tr("colors.success"))", color: .success) {}
            Moin.Button("\(tr("colors.warning"))", color: .warning) {}
            Moin.Button("\(tr("colors.danger"))", color: .danger) {}
            """
        }
    }

    // MARK: - 预设颜色章节

    private var presetUsageSection: some View {
        ExampleSection(
            title: tr("colors.preset_usage"),
            description: tr("colors.preset_usage_desc")
        ) {
            HStack(spacing: Moin.Constants.Spacing.md) {
                Moin.Button(tr("colors.blue"), color: .blue) {}
                Moin.Button(tr("colors.purple"), color: .purple) {}
                Moin.Button(tr("colors.cyan"), color: .cyan) {}
                Moin.Button(tr("colors.gold"), color: .gold) {}
            }
        } code: {
            """
            // \(tr("colors.code.preset"))
            Moin.Button("\(tr("colors.blue"))", color: .blue) {}
            Moin.Button("\(tr("colors.purple"))", color: .purple) {}
            Moin.Button("\(tr("colors.cyan"))", color: .cyan) {}
            Moin.Button("\(tr("colors.gold"))", color: .gold) {}
            """
        }
    }

    // MARK: - 色板级别章节

    private var paletteUsageSection: some View {
        ExampleSection(
            title: tr("colors.palette_usage"),
            description: tr("colors.palette_usage_desc")
        ) {
            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.md) {
                HStack(spacing: Moin.Constants.Spacing.md) {
                    Moin.Button(tr("colors.level4"), color: .blue4) {}
                    Moin.Button(tr("colors.level6"), color: .blue6) {}
                    Moin.Button(tr("colors.level8"), color: .blue8) {}
                }
            }
        } code: {
            """
            // \(tr("colors.code.palette_level"))
            Moin.Colors.blue4  // \(tr("colors.code.light"))
            Moin.Colors.blue6  // \(tr("colors.code.primary"))
            Moin.Colors.blue8  // \(tr("colors.code.dark"))

            // \(tr("colors.code.button_color_shorthand"))
            Moin.Button("...", color: .blue4) {}
            Moin.Button("...", color: .custom(Moin.Colors.cyanPalette[8])) {}
            """
        }
    }

    // MARK: - 动态生成章节

    private var generateUsageSection: some View {
        ExampleSection(
            title: tr("colors.generate_usage"),
            description: tr("colors.generate_usage_desc")
        ) {
            let palette = Moin.ColorPalette.generate(from: .orange)
            HStack(spacing: 0) {
                ForEach(1...10, id: \.self) { level in
                    Rectangle()
                        .fill(palette[level])
                        .frame(width: 32, height: 32)
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: Moin.Constants.Radius.sm))
        } code: {
            """
            // \(tr("colors.code.custom_palette"))
            let palette = Moin.ColorPalette.generate(from: myColor)
            palette[1]  // \(tr("colors.code.lightest"))
            palette[6]  // \(tr("colors.code.primary"))
            palette[10] // \(tr("colors.code.darkest"))

            // \(tr("colors.code.extract_level"))
            let myColor5 = palette[5]
            let myColor10 = palette[10]
            """
        }
    }

    // MARK: - API

    private var apiReference: some View {
        VStack(alignment: .leading, spacing: Moin.Constants.Spacing.md) {
            Text(tr("API"))
                .font(.title2)
                .fontWeight(.semibold)

            Text("Moin.Colors")
                .font(.headline)
                .padding(.top, Moin.Constants.Spacing.sm)

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
                    ("red", "Color", "#F5222D", tr("colors.red_desc")),
                    ("orange", "Color", "#FA8C16", tr("colors.orange_desc")),
                    ("yellow", "Color", "#FADB14", tr("colors.yellow_desc")),
                    ("volcano", "Color", "#FA541C", tr("colors.volcano_desc")),
                    ("geekblue", "Color", "#2F54EB", tr("colors.geekblue_desc")),
                    ("gold", "Color", "#FAAD14", tr("colors.gold_desc")),
                    ("lime", "Color", "#A0D911", tr("colors.lime_desc")),
                ]
            )

            Text("Moin.ColorPalette")
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
                    ("colors", "[Color]", "-", tr("colors.api.colors")),
                    ("primary", "Color", "-", tr("colors.api.primary")),
                    ("subscript(level:)", "Color", "-", tr("colors.api.subscript")),
                    ("generate(from:theme:)", "ColorPalette", "-", tr("colors.api.generate")),
                ]
            )
        }
    }
}

// MARK: - PaletteCard

/// 单个色板卡片
private struct PaletteCard: View {
    let name: String
    let palette: Moin.ColorPalette

    @State private var hoveredLevel: Int?

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // 色板名称
            HStack {
                Text(name)
                    .font(.headline)
                Spacer()
                Text(palette.primary.toHex())
                    .font(.system(.caption, design: .monospaced))
                    .foregroundStyle(.secondary)
            }
            .padding(.horizontal, Moin.Constants.Spacing.md)
            .padding(.vertical, Moin.Constants.Spacing.sm)

            // 10 级颜色
            VStack(spacing: 0) {
                ForEach(1...10, id: \.self) { level in
                    let color = palette[level]
                    let isHovered = hoveredLevel == level
                    let isPrimary = level == 6

                    HStack {
                        Text(".\(name.lowercased())\(level)")
                            .font(.system(.caption, design: .monospaced))

                        if isPrimary {
                            Text("/ .\(name.lowercased())")
                                .font(.system(.caption, design: .monospaced))
                                .opacity(0.7)
                        }

                        Spacer()

                        Text(color.toHex())
                            .font(.system(.caption2, design: .monospaced))
                            .opacity(isHovered ? 1 : 0)
                    }
                    .padding(.horizontal, Moin.Constants.Spacing.md)
                    .padding(.vertical, Moin.Constants.Spacing.xs)
                    .frame(maxWidth: .infinity)
                    .background(color)
                    .foregroundStyle(level <= 5 ? .black.opacity(0.85) : .white)
                    .fontWeight(isPrimary ? .semibold : .regular)
                    .onHover { hovering in
                        hoveredLevel = hovering ? level : nil
                    }
                }
            }
        }
        .background(Color(nsColor: .controlBackgroundColor))
        .clipShape(RoundedRectangle(cornerRadius: Moin.Constants.Radius.lg))
        .overlay(
            RoundedRectangle(cornerRadius: Moin.Constants.Radius.lg)
                .strokeBorder(.quaternary, lineWidth: 1)
        )
    }
}
