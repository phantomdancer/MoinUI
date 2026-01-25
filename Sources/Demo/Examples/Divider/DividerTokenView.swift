import SwiftUI
import MoinUI

// MARK: - DividerTokenView

struct DividerTokenView: View {
    @Localized var tr
    @Environment(\.moinToken) var token
    @ObservedObject var config = Moin.ConfigProvider.shared
    
    // MARK: - Token Sections
    
    private var tokenSections: [DocSidebarSection] {
        [
            // 组件 Token
            DocSidebarSection(
                title: tr("doc.section.component_token"),
                items: [.init(id: "textPadding"), .init(id: "orientationMargin"), .init(id: "dashLength"), .init(id: "dashGap")],
                sectionId: "component"
            ),
            // 全局 Token
            DocSidebarSection(
                title: tr("doc.section.global_token"),
                items: [.init(id: "colorBorder"), .init(id: "colorText"), .init(id: "fontSizeLG"), .init(id: "lineWidth"), .init(id: "marginLG"), .init(id: "marginXS")],
                sectionId: "global"
            )
        ]
    }
    
    // 重置所有 Token 到默认值
    private func resetAll() {
        // 重置 seed tokens
        config.seed = Moin.SeedToken.default
        config.regenerateTokens()
        
        // 重置组件 tokens
        config.components.divider = Moin.DividerToken.generate(from: config.token)
    }
    
    var body: some View {
        ComponentDocBody(
            sections: tokenSections,
            initialItemId: "component"
        ) { sectionId in
            if sectionId == "component" {
                Text(tr("doc.section.component_token")).font(.title3).fontWeight(.semibold)
            } else if sectionId == "global" {
                Text(tr("doc.section.global_token")).font(.title3).fontWeight(.semibold)
            }
        } item: { item in
            cardForItem(item)
                .id(item)
        } footer: {
            HStack(spacing: Moin.Constants.Spacing.sm) {
                Moin.Button(tr("playground.token.reset"), color: .primary, variant: .solid) {
                    resetAll()
                }
                
                Text(tr("token.playground.reset_desc"))
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
                
                Spacer()
            }
            .padding(Moin.Constants.Spacing.md)
        }
    }
    
    @ViewBuilder
    private func cardForItem(_ item: String) -> some View {
        switch item {
        // 组件 Tokens
        case "textPadding": textPaddingCard
        case "orientationMargin": orientationMarginCard
        case "dashLength": dashLengthCard
        case "dashGap": dashGapCard
        // 全局 Tokens
        case "colorBorder": colorBorderCard
        case "colorText": colorTextCard
        case "fontSizeLG": fontSizeLGCard
        case "lineWidth": lineWidthCard
        case "marginLG": marginLGCard
        case "marginXS": marginXSCard
        default: EmptyView()
        }
    }
    
    // MARK: - Component Token Cards
    
    private var textPaddingCard: some View {
        TokenCard(
            name: "textPadding",
            type: "CGFloat",
            defaultValue: "token.padding",
            description: tr("api.divider.token_text_padding"),
            sectionId: "component"
        ) {
            Moin.Divider("Text")
        } editor: {
            TokenValueRow(label: "textPadding", value: Binding(
                get: { config.components.divider.textPadding },
                set: { config.components.divider.textPadding = $0 }
            ))
        } code: {
            "config.components.divider.textPadding = \(Int(config.components.divider.textPadding))"
        }
    }
    
    private var orientationMarginCard: some View {
        TokenCard(
            name: "orientationMargin",
            type: "CGFloat",
            defaultValue: "0.05",
            description: tr("api.divider.token_orientation_margin"),
            sectionId: "component"
        ) {
            Moin.Divider("Left", titlePlacement: .left)
        } editor: {
            TokenValueRow(label: "orientationMargin", value: Binding(
                get: { config.components.divider.orientationMargin },
                set: { config.components.divider.orientationMargin = $0 }
            ), range: 0...1, step: 0.1)
        } code: {
            "config.components.divider.orientationMargin = \(String(format: "%.2f", config.components.divider.orientationMargin))"
        }
    }
    
    private var dashLengthCard: some View {
        TokenCard(
            name: "dashLength",
            type: "CGFloat",
            defaultValue: "4",
            description: tr("api.divider.token_dash_length"),
            sectionId: "component"
        ) {
            Moin.Divider(variant: .dashed)
        } editor: {
            TokenValueRow(label: "dashLength", value: Binding(
                get: { config.components.divider.dashLength },
                set: { config.components.divider.dashLength = $0 }
            ))
        } code: {
            "config.components.divider.dashLength = \(Int(config.components.divider.dashLength))"
        }
    }
    
    private var dashGapCard: some View {
        TokenCard(
            name: "dashGap",
            type: "CGFloat",
            defaultValue: "4",
            description: tr("api.divider.token_dash_gap"),
            sectionId: "component"
        ) {
            Moin.Divider(variant: .dashed)
        } editor: {
            TokenValueRow(label: "dashGap", value: Binding(
                get: { config.components.divider.dashGap },
                set: { config.components.divider.dashGap = $0 }
            ))
        } code: {
            "config.components.divider.dashGap = \(Int(config.components.divider.dashGap))"
        }
    }
    
    // MARK: - Global Token Cards
    
    private var colorBorderCard: some View {
        TokenCard(
            name: "colorBorder",
            type: "Color",
            defaultValue: "#d9d9d9",
            description: tr("api.divider.token_line_color"),
            sectionId: "global"
        ) {
            HStack(spacing: Moin.Constants.Spacing.md) {
                Moin.Divider()
            }
        } code: {
            "// \(tr("api.derived_from")) seed.colorBgBase"
        }
    }
    
    private var colorTextCard: some View {
        TokenCard(
            name: "colorText",
            type: "Color",
            defaultValue: "rgba(0,0,0,0.88)",
            description: tr("api.divider.token_text_color"),
            sectionId: "global"
        ) {
            Moin.Divider("Text")
        } code: {
            "// \(tr("api.derived_from")) seed.colorTextBase"
        }
    }
    
    private var fontSizeLGCard: some View {
        TokenCard(
            name: "fontSizeLG",
            type: "CGFloat",
            defaultValue: "16",
            description: tr("api.divider.token_font_size"),
            sectionId: "global"
        ) {
            HStack(spacing: Moin.Constants.Spacing.md) {
                Moin.Divider("Text")
                Text("fontSizeLG: \(Int(config.token.fontSizeLG))px")
                    .font(.system(size: 11, design: .monospaced))
                    .foregroundStyle(.secondary)
            }
        } editor: {
            TokenValueRow(label: "seed.fontSize", value: Binding(
                get: { config.seed.fontSize },
                set: { config.seed.fontSize = $0 }
            ), range: 10...24, onChange: { config.regenerateTokens() })
        } code: {
            "// fontSizeLG = seed.fontSize + 2"
        }
    }
    
    private var lineWidthCard: some View {
        TokenCard(
            name: "lineWidth",
            type: "CGFloat",
            defaultValue: "1",
            description: tr("api.divider.token_line_width"),
            sectionId: "global"
        ) {
            HStack(spacing: Moin.Constants.Spacing.md) {
                Moin.Divider()
                Text("lineWidth: \(Int(config.token.lineWidth))px")
                    .font(.system(size: 11, design: .monospaced))
                    .foregroundStyle(.secondary)
            }
        } editor: {
            TokenValueRow(label: "seed.lineWidth", value: Binding(
                get: { config.seed.lineWidth },
                set: { config.seed.lineWidth = $0 }
            ), range: 0...5, onChange: { config.regenerateTokens() })
        } code: {
            "config.seed.lineWidth = \(Int(config.seed.lineWidth))"
        }
    }
    
    private var marginLGCard: some View {
        TokenCard(
            name: "marginLG",
            type: "CGFloat",
            defaultValue: "24",
            description: tr("api.divider.token_vertical_margin"),
            sectionId: "global"
        ) {
            VStack(spacing: 0) {
                Text("Text")
                Moin.Divider()
                Text("Text")
            }
        } editor: {
            TokenValueRow(label: "seed.sizeUnit", value: Binding(
                get: { config.seed.sizeUnit },
                set: { config.seed.sizeUnit = $0 }
            ), range: 2...8, onChange: { config.regenerateTokens() })
        } code: {
            "// marginLG = sizeUnit * 6 = \(Int(config.token.marginLG))"
        }
    }
    
    private var marginXSCard: some View {
        TokenCard(
            name: "marginXS",
            type: "CGFloat",
            defaultValue: "8",
            description: tr("api.divider.token_horizontal_margin"),
            sectionId: "global"
        ) {
            HStack(spacing: 0) {
                Text("A")
                Moin.Divider(orientation: .vertical)
                Text("B")
            }
        } code: {
            "// marginXS = sizeUnit * 2 = \(Int(config.token.marginXS))"
        }
    }
}
