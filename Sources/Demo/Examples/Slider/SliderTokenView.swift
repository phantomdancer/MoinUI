import SwiftUI
import MoinUI

// MARK: - SliderTokenView

struct SliderTokenView: View {
    @Localized var tr
    @Environment(\.moinToken) var token
    @ObservedObject var config = Moin.ConfigProvider.shared

    @State private var value: Double = 30
    @State private var rangeValue: ClosedRange<Double> = 20...50

    private let marks: [Double: String] = [
        0: "0", 50: "50", 100: "100"
    ]

    // MARK: - Token Sections

    private var componentSections: [DocSidebarSection] {
        [
            DocSidebarSection(
                title: tr("doc.section.component_token"),
                items: [
                    .init(id: "controlSize"),
                    .init(id: "railSize"),
                    .init(id: "handleSize"),
                    .init(id: "handleSizeHover"),
                    .init(id: "handleLineWidth"),
                    .init(id: "handleLineWidthHover"),
                    .init(id: "dotSize"),
                    .init(id: "railBg"),
                    .init(id: "railHoverBg"),
                    .init(id: "trackBg"),
                    .init(id: "trackHoverBg"),
                    .init(id: "trackBgDisabled"),
                    .init(id: "handleColor"),
                    .init(id: "handleActiveColor"),
                    .init(id: "handleColorDisabled"),
                    .init(id: "dotBorderColor"),
                    .init(id: "dotActiveBorderColor")
                ],
                sectionId: "component"
            )
        ]
    }

    private var globalSections: [DocSidebarSection] {
        [
            DocSidebarSection(
                title: tr("doc.section.global_token"),
                items: [
                    .init(id: "controlHeightLG"),
                    .init(id: "lineWidth"),
                    .init(id: "colorPrimaryBorder"),
                    .init(id: "colorPrimary"),
                    .init(id: "colorFillTertiary"),
                    .init(id: "colorFillSecondary")
                ],
                sectionId: "global"
            )
        ]
    }

    private var allSections: [DocSidebarSection] {
        componentSections + globalSections
    }

    private func resetAll() {
        config.seed = Moin.SeedToken.default
        config.regenerateTokens()
        config.components.slider = .generate(from: config.token)
    }

    var body: some View {
        ComponentDocBody(
            sections: allSections,
            initialItemId: "component"
        ) { sectionId in
            switch sectionId {
            case "component":
                Text(tr("doc.section.component_token")).font(.title3).fontWeight(.semibold)
            case "global":
                Text(tr("doc.section.global_token")).font(.title3).fontWeight(.semibold)
            default:
                EmptyView()
            }
        } item: { item in
            let globalItemIds = globalSections.flatMap { $0.items.map { $0.id } }
            if globalItemIds.contains(item) {
                cardForItem(item, sectionId: "global")
            } else {
                cardForItem(item, sectionId: "component")
            }
        } footer: {
            HStack(spacing: Moin.Constants.Spacing.sm) {
                Moin.Button(tr("playground.token.reset"), color: .primary, variant: .solid) {
                    resetAll()
                }

                Text(tr("playground.token.reset_desc"))
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)

                Spacer()
            }
            .padding(Moin.Constants.Spacing.md)
        }
    }

    @ViewBuilder
    private func cardForItem(_ item: String, sectionId: String) -> some View {
        if sectionId == "component" {
            switch item {
            case "controlSize": AnyView(controlSizeCard)
            case "railSize": AnyView(railSizeCard)
            case "handleSize": AnyView(handleSizeCard)
            case "handleSizeHover": AnyView(handleSizeHoverCard)
            case "handleLineWidth": AnyView(handleLineWidthCard)
            case "handleLineWidthHover": AnyView(handleLineWidthHoverCard)
            case "dotSize": AnyView(dotSizeCard)
            case "railBg": AnyView(railBgCard)
            case "railHoverBg": AnyView(railHoverBgCard)
            case "trackBg": AnyView(trackBgCard)
            case "trackHoverBg": AnyView(trackHoverBgCard)
            case "trackBgDisabled": AnyView(trackBgDisabledCard)
            case "handleColor": AnyView(handleColorCard)
            case "handleActiveColor": AnyView(handleActiveColorCard)
            case "handleColorDisabled": AnyView(handleColorDisabledCard)
            case "dotBorderColor": AnyView(dotBorderColorCard)
            case "dotActiveBorderColor": AnyView(dotActiveBorderColorCard)
            default: AnyView(EmptyView())
            }
        } else {
            switch item {
            case "controlHeightLG": AnyView(controlHeightLGCard)
            case "lineWidth": AnyView(lineWidthCard)
            case "colorPrimaryBorder": AnyView(colorPrimaryBorderCard)
            case "colorPrimary": AnyView(colorPrimaryCard)
            case "colorFillTertiary": AnyView(colorFillTertiaryCard)
            case "colorFillSecondary": AnyView(colorFillSecondaryCard)
            default: AnyView(EmptyView())
            }
        }
    }

    // MARK: - Component Token Cards (Size)

    private var controlSizeCard: some View {
        TokenCard(
            name: "controlSize",
            type: "CGFloat",
            defaultValue: "controlHeightLG / 4",
            description: tr("slider.token.controlSize_desc"),
            sectionId: "component"
        ) {
            Moin.Slider(value: $value)
        } editor: {
            TokenValueRow(label: "controlSize", value: Binding(
                get: { config.components.slider.controlSize },
                set: { config.components.slider.controlSize = $0 }
            ), range: 8...24, step: 1)
        } code: {
            "config.components.slider.controlSize = \(Int(config.components.slider.controlSize))"
        }
        .scrollAnchor("component.controlSize")
    }

    private var railSizeCard: some View {
        TokenCard(
            name: "railSize",
            type: "CGFloat",
            defaultValue: "4",
            description: tr("slider.token.railSize_desc"),
            sectionId: "component"
        ) {
            Moin.Slider(value: $value)
        } editor: {
            TokenValueRow(label: "railSize", value: Binding(
                get: { config.components.slider.railSize },
                set: { config.components.slider.railSize = $0 }
            ), range: 2...10, step: 1)
        } code: {
            "config.components.slider.railSize = \(Int(config.components.slider.railSize))"
        }
        .scrollAnchor("component.railSize")
    }

    private var handleSizeCard: some View {
        TokenCard(
            name: "handleSize",
            type: "CGFloat",
            defaultValue: "controlSize",
            description: tr("slider.token.handleSize_desc"),
            sectionId: "component"
        ) {
            Moin.Slider(value: $value)
        } editor: {
            TokenValueRow(label: "handleSize", value: Binding(
                get: { config.components.slider.handleSize },
                set: { config.components.slider.handleSize = $0 }
            ), range: 8...24, step: 1)
        } code: {
            "config.components.slider.handleSize = \(Int(config.components.slider.handleSize))"
        }
        .scrollAnchor("component.handleSize")
    }

    private var handleSizeHoverCard: some View {
        TokenCard(
            name: "handleSizeHover",
            type: "CGFloat",
            defaultValue: "controlHeightSM / 2",
            description: tr("slider.token.handleSizeHover_desc"),
            sectionId: "component"
        ) {
            VStack(alignment: .leading, spacing: 8) {
                Moin.Slider(value: $value)
                Text(tr("slider.hover_to_see"))
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        } editor: {
            TokenValueRow(label: "handleSizeHover", value: Binding(
                get: { config.components.slider.handleSizeHover },
                set: { config.components.slider.handleSizeHover = $0 }
            ), range: 10...28, step: 1)
        } code: {
            "config.components.slider.handleSizeHover = \(Int(config.components.slider.handleSizeHover))"
        }
        .scrollAnchor("component.handleSizeHover")
    }

    private var handleLineWidthCard: some View {
        TokenCard(
            name: "handleLineWidth",
            type: "CGFloat",
            defaultValue: "lineWidth + 1",
            description: tr("slider.token.handleLineWidth_desc"),
            sectionId: "component"
        ) {
            Moin.Slider(value: $value)
        } editor: {
            TokenValueRow(label: "handleLineWidth", value: Binding(
                get: { config.components.slider.handleLineWidth },
                set: { config.components.slider.handleLineWidth = $0 }
            ), range: 1...4, step: 0.5)
        } code: {
            "config.components.slider.handleLineWidth = \(String(format: "%.1f", config.components.slider.handleLineWidth))"
        }
        .scrollAnchor("component.handleLineWidth")
    }

    private var handleLineWidthHoverCard: some View {
        TokenCard(
            name: "handleLineWidthHover",
            type: "CGFloat",
            defaultValue: "handleLineWidth + 0.5",
            description: tr("slider.token.handleLineWidthHover_desc"),
            sectionId: "component"
        ) {
            VStack(alignment: .leading, spacing: 8) {
                Moin.Slider(value: $value)
                Text(tr("slider.hover_to_see"))
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        } editor: {
            TokenValueRow(label: "handleLineWidthHover", value: Binding(
                get: { config.components.slider.handleLineWidthHover },
                set: { config.components.slider.handleLineWidthHover = $0 }
            ), range: 1...5, step: 0.5)
        } code: {
            "config.components.slider.handleLineWidthHover = \(String(format: "%.1f", config.components.slider.handleLineWidthHover))"
        }
        .scrollAnchor("component.handleLineWidthHover")
    }

    private var dotSizeCard: some View {
        TokenCard(
            name: "dotSize",
            type: "CGFloat",
            defaultValue: "8",
            description: tr("slider.token.dotSize_desc"),
            sectionId: "component"
        ) {
            Moin.Slider(value: $value, marks: marks)
                .frame(height: 60)
        } editor: {
            TokenValueRow(label: "dotSize", value: Binding(
                get: { config.components.slider.dotSize },
                set: { config.components.slider.dotSize = $0 }
            ), range: 4...16, step: 1)
        } code: {
            "config.components.slider.dotSize = \(Int(config.components.slider.dotSize))"
        }
        .scrollAnchor("component.dotSize")
    }

    // MARK: - Component Token Cards (Color)

    private var railBgCard: some View {
        TokenCard(
            name: "railBg",
            type: "Color",
            defaultValue: "colorFillTertiary",
            description: tr("slider.token.railBg_desc"),
            sectionId: "component"
        ) {
            Moin.Slider(value: $value)
        } editor: {
            ColorPresetRow(label: "railBg", color: Binding(
                get: { config.components.slider.railBg },
                set: { config.components.slider.railBg = $0 }
            ))
        } code: {
            "config.components.slider.railBg = Color(...)"
        }
        .scrollAnchor("component.railBg")
    }

    private var railHoverBgCard: some View {
        TokenCard(
            name: "railHoverBg",
            type: "Color",
            defaultValue: "colorFillSecondary",
            description: tr("slider.token.railHoverBg_desc"),
            sectionId: "component"
        ) {
            VStack(alignment: .leading, spacing: 8) {
                Moin.Slider(value: $value)
                Text(tr("slider.hover_to_see"))
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        } editor: {
            ColorPresetRow(label: "railHoverBg", color: Binding(
                get: { config.components.slider.railHoverBg },
                set: { config.components.slider.railHoverBg = $0 }
            ))
        } code: {
            "config.components.slider.railHoverBg = Color(...)"
        }
        .scrollAnchor("component.railHoverBg")
    }

    private var trackBgCard: some View {
        TokenCard(
            name: "trackBg",
            type: "Color",
            defaultValue: "colorPrimaryBorder",
            description: tr("slider.token.trackBg_desc"),
            sectionId: "component"
        ) {
            Moin.Slider(value: $value)
        } editor: {
            ColorPresetRow(label: "trackBg", color: Binding(
                get: { config.components.slider.trackBg },
                set: { config.components.slider.trackBg = $0 }
            ))
        } code: {
            "config.components.slider.trackBg = Color(...)"
        }
        .scrollAnchor("component.trackBg")
    }

    private var trackHoverBgCard: some View {
        TokenCard(
            name: "trackHoverBg",
            type: "Color",
            defaultValue: "colorPrimaryBorderHover",
            description: tr("slider.token.trackHoverBg_desc"),
            sectionId: "component"
        ) {
            VStack(alignment: .leading, spacing: 8) {
                Moin.Slider(value: $value)
                Text(tr("slider.hover_to_see"))
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        } editor: {
            ColorPresetRow(label: "trackHoverBg", color: Binding(
                get: { config.components.slider.trackHoverBg },
                set: { config.components.slider.trackHoverBg = $0 }
            ))
        } code: {
            "config.components.slider.trackHoverBg = Color(...)"
        }
        .scrollAnchor("component.trackHoverBg")
    }

    private var trackBgDisabledCard: some View {
        TokenCard(
            name: "trackBgDisabled",
            type: "Color",
            defaultValue: "colorBgDisabled",
            description: tr("slider.token.trackBgDisabled_desc"),
            sectionId: "component"
        ) {
            Moin.Slider(value: .constant(30), disabled: true)
        } editor: {
            ColorPresetRow(label: "trackBgDisabled", color: Binding(
                get: { config.components.slider.trackBgDisabled },
                set: { config.components.slider.trackBgDisabled = $0 }
            ))
        } code: {
            "config.components.slider.trackBgDisabled = Color(...)"
        }
        .scrollAnchor("component.trackBgDisabled")
    }

    private var handleColorCard: some View {
        TokenCard(
            name: "handleColor",
            type: "Color",
            defaultValue: "colorPrimaryBorder",
            description: tr("slider.token.handleColor_desc"),
            sectionId: "component"
        ) {
            Moin.Slider(value: $value)
        } editor: {
            ColorPresetRow(label: "handleColor", color: Binding(
                get: { config.components.slider.handleColor },
                set: { config.components.slider.handleColor = $0 }
            ))
        } code: {
            "config.components.slider.handleColor = Color(...)"
        }
        .scrollAnchor("component.handleColor")
    }

    private var handleActiveColorCard: some View {
        TokenCard(
            name: "handleActiveColor",
            type: "Color",
            defaultValue: "colorPrimary",
            description: tr("slider.token.handleActiveColor_desc"),
            sectionId: "component"
        ) {
            VStack(alignment: .leading, spacing: 8) {
                Moin.Slider(value: $value)
                Text(tr("slider.hover_to_see"))
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        } editor: {
            ColorPresetRow(label: "handleActiveColor", color: Binding(
                get: { config.components.slider.handleActiveColor },
                set: { config.components.slider.handleActiveColor = $0 }
            ))
        } code: {
            "config.components.slider.handleActiveColor = Color(...)"
        }
        .scrollAnchor("component.handleActiveColor")
    }

    private var handleColorDisabledCard: some View {
        TokenCard(
            name: "handleColorDisabled",
            type: "Color",
            defaultValue: "colorTextDisabled",
            description: tr("slider.token.handleColorDisabled_desc"),
            sectionId: "component"
        ) {
            Moin.Slider(value: .constant(30), disabled: true)
        } editor: {
            ColorPresetRow(label: "handleColorDisabled", color: Binding(
                get: { config.components.slider.handleColorDisabled },
                set: { config.components.slider.handleColorDisabled = $0 }
            ))
        } code: {
            "config.components.slider.handleColorDisabled = Color(...)"
        }
        .scrollAnchor("component.handleColorDisabled")
    }

    private var dotBorderColorCard: some View {
        TokenCard(
            name: "dotBorderColor",
            type: "Color",
            defaultValue: "colorBorderSecondary",
            description: tr("slider.token.dotBorderColor_desc"),
            sectionId: "component"
        ) {
            Moin.Slider(value: $value, marks: marks)
                .frame(height: 60)
        } editor: {
            ColorPresetRow(label: "dotBorderColor", color: Binding(
                get: { config.components.slider.dotBorderColor },
                set: { config.components.slider.dotBorderColor = $0 }
            ))
        } code: {
            "config.components.slider.dotBorderColor = Color(...)"
        }
        .scrollAnchor("component.dotBorderColor")
    }

    private var dotActiveBorderColorCard: some View {
        TokenCard(
            name: "dotActiveBorderColor",
            type: "Color",
            defaultValue: "colorPrimaryBorder",
            description: tr("slider.token.dotActiveBorderColor_desc"),
            sectionId: "component"
        ) {
            Moin.Slider(value: $value, marks: marks)
                .frame(height: 60)
        } editor: {
            ColorPresetRow(label: "dotActiveBorderColor", color: Binding(
                get: { config.components.slider.dotActiveBorderColor },
                set: { config.components.slider.dotActiveBorderColor = $0 }
            ))
        } code: {
            "config.components.slider.dotActiveBorderColor = Color(...)"
        }
        .scrollAnchor("component.dotActiveBorderColor")
    }

    // MARK: - Global Token Cards

    private var controlHeightLGCard: some View {
        TokenCard(
            name: "controlHeightLG",
            type: "CGFloat",
            defaultValue: "40",
            description: tr("slider.token.global.controlHeightLG"),
            sectionId: "global"
        ) {
            Moin.Slider(value: $value)
        } editor: {
            TokenValueRow(label: "controlHeight", value: $config.seed.controlHeight, range: 24...48, onChange: {
                config.regenerateTokens()
                config.components.slider = .generate(from: config.token)
            })
        } code: {
            """
            config.seed.controlHeight = \(Int(config.seed.controlHeight))
            // controlSize = controlHeightLG / 4 = \(Int(config.token.controlHeightLG / 4))
            """
        }
        .scrollAnchor("global.controlHeightLG")
    }

    private var lineWidthCard: some View {
        TokenCard(
            name: "lineWidth",
            type: "CGFloat",
            defaultValue: "1",
            description: tr("slider.token.global.lineWidth"),
            sectionId: "global"
        ) {
            Moin.Slider(value: $value)
        } editor: {
            TokenValueRow(label: "lineWidth", value: $config.seed.lineWidth, range: 1...4, onChange: {
                config.regenerateTokens()
                config.components.slider = .generate(from: config.token)
            })
        } code: {
            """
            config.seed.lineWidth = \(Int(config.seed.lineWidth))
            // handleLineWidth = lineWidth + 1
            """
        }
        .scrollAnchor("global.lineWidth")
    }

    private var colorPrimaryBorderCard: some View {
        TokenCard(
            name: "colorPrimaryBorder",
            type: "Color",
            defaultValue: "colorPrimary 60%",
            description: tr("slider.token.global.colorPrimaryBorder"),
            sectionId: "global"
        ) {
            Moin.Slider(value: $value)
        } editor: {
            HStack {
                Text(tr("slider.token.global.theme"))
                Spacer()
                Picker("", selection: Binding(
                    get: { config.theme },
                    set: {
                        config.theme = $0
                        config.components.slider = .generate(from: config.token)
                    }
                )) {
                    Text("Light").tag(Moin.Theme.light)
                    Text("Dark").tag(Moin.Theme.dark)
                }
                .pickerStyle(.segmented)
                .frame(width: 140)
            }
        } code: {
            """
            config.theme = .light // or .dark
            config.components.slider = .generate(from: config.token)
            """
        }
        .scrollAnchor("global.colorPrimaryBorder")
    }

    private var colorPrimaryCard: some View {
        TokenCard(
            name: "colorPrimary",
            type: "Color",
            defaultValue: "blue6",
            description: tr("slider.token.global.colorPrimary"),
            sectionId: "global"
        ) {
            VStack(alignment: .leading, spacing: 8) {
                Moin.Slider(value: $value)
                Text(tr("slider.hover_to_see"))
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        } editor: {
            HStack {
                Text(tr("slider.token.global.theme"))
                Spacer()
                Picker("", selection: Binding(
                    get: { config.theme },
                    set: {
                        config.theme = $0
                        config.components.slider = .generate(from: config.token)
                    }
                )) {
                    Text("Light").tag(Moin.Theme.light)
                    Text("Dark").tag(Moin.Theme.dark)
                }
                .pickerStyle(.segmented)
                .frame(width: 140)
            }
        } code: {
            """
            config.theme = .light // or .dark
            config.components.slider = .generate(from: config.token)
            """
        }
        .scrollAnchor("global.colorPrimary")
    }

    private var colorFillTertiaryCard: some View {
        TokenCard(
            name: "colorFillTertiary",
            type: "Color",
            defaultValue: "rgba(0,0,0,0.04)",
            description: tr("slider.token.global.colorFillTertiary"),
            sectionId: "global"
        ) {
            Moin.Slider(value: $value)
        } editor: {
            HStack {
                Text(tr("slider.token.global.theme"))
                Spacer()
                Picker("", selection: Binding(
                    get: { config.theme },
                    set: {
                        config.theme = $0
                        config.components.slider = .generate(from: config.token)
                    }
                )) {
                    Text("Light").tag(Moin.Theme.light)
                    Text("Dark").tag(Moin.Theme.dark)
                }
                .pickerStyle(.segmented)
                .frame(width: 140)
            }
        } code: {
            """
            config.theme = .light // or .dark
            config.components.slider = .generate(from: config.token)
            """
        }
        .scrollAnchor("global.colorFillTertiary")
    }

    private var colorFillSecondaryCard: some View {
        TokenCard(
            name: "colorFillSecondary",
            type: "Color",
            defaultValue: "rgba(0,0,0,0.06)",
            description: tr("slider.token.global.colorFillSecondary"),
            sectionId: "global"
        ) {
            VStack(alignment: .leading, spacing: 8) {
                Moin.Slider(value: $value)
                Text(tr("slider.hover_to_see"))
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        } editor: {
            HStack {
                Text(tr("slider.token.global.theme"))
                Spacer()
                Picker("", selection: Binding(
                    get: { config.theme },
                    set: {
                        config.theme = $0
                        config.components.slider = .generate(from: config.token)
                    }
                )) {
                    Text("Light").tag(Moin.Theme.light)
                    Text("Dark").tag(Moin.Theme.dark)
                }
                .pickerStyle(.segmented)
                .frame(width: 140)
            }
        } code: {
            """
            config.theme = .light // or .dark
            config.components.slider = .generate(from: config.token)
            """
        }
        .scrollAnchor("global.colorFillSecondary")
    }
}
