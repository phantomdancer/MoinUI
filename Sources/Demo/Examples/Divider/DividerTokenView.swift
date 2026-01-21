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
            DocSidebarSection(
                title: tr("api.component_token"),
                items: [
                    "textPaddingInline", "orientationMargin", "verticalMarginInline",
                    "lineColor", "textColor", "fontSize",
                    "horizontalMarginBlock", "lineWidth", "dashLength", "dashGap"
                ],
                sectionId: "token"
            ),
            DocSidebarSection(
                title: tr("api.global_token_title"),
                items: ["colorText", "globalLineWidth|lineWidth"],
                sectionId: "global"
            )
        ]
    }
    
    // 重置所有 Token 到默认值
    private func resetAll() {
        // 重置全局 seed token
        config.seed.colorPrimary = Moin.Colors.blue
        config.seed.colorTextBase = Color(white: 0.0)
        config.seed.lineWidth = 1
        config.seed.borderRadius = 6
        config.regenerateTokens()
        
        // 重置组件 token
        let defaultDivider = Moin.DividerToken.generate(from: config.token)
        config.components.divider = defaultDivider
        
        // 通知重置
        NotificationCenter.default.post(name: .dividerDocReset, object: nil)
    }
    
    var body: some View {
        ComponentDocBody(
            sections: tokenSections,
            initialItemId: "token"
        ) { sectionId in
            if sectionId == "token" {
                Text(tr("api.component_token")).font(.title3).fontWeight(.semibold)
            } else if sectionId == "global" {
                Text(tr("api.global_token_title")).font(.title3).fontWeight(.semibold)
            }
        } item: { item in
            cardForItem(item)
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
        // Component Tokens (Antd 对齐)
        case "textPaddingInline": textPaddingInlineCard
        case "orientationMargin": orientationMarginCard
        case "verticalMarginInline": verticalMarginInlineCard
        // Extended Tokens
        case "lineColor": lineColorCard
        case "textColor": textColorCard
        case "fontSize": fontSizeCard
        case "horizontalMarginBlock": horizontalMarginBlockCard
        case "lineWidth": lineWidthCard
        case "dashLength": dashLengthCard
        case "dashGap": dashGapCard
        // Global
        case "colorText": globalColorTextCard
        case "globalLineWidth": globalLineWidthCard
        default: EmptyView()
        }
    }
    
    // MARK: - Component Cards
    
    private var lineColorCard: some View {
        TokenCard(
            name: "lineColor",
            type: "Color",
            defaultValue: "token.colorBorder",
            description: tr("api.divider.token_line_color"),
            sectionId: "token"
        ) {
            Moin.Divider()
        } editor: {
            ColorPresetRow(label: "lineColor", color: Binding(
                 get: { Moin.ConfigProvider.shared.components.divider.lineColor },
                 set: { Moin.ConfigProvider.shared.components.divider.lineColor = $0 }
            ))
        } code: {
            "config.components.divider.lineColor = Color(...)"
        }
        .scrollAnchor("token.lineColor")
    }
    
    private var textColorCard: some View {
        TokenCard(
            name: "textColor",
            type: "Color",
            defaultValue: "token.colorText",
            description: tr("api.divider.token_text_color"),
            sectionId: "token"
        ) {
            Moin.Divider("Text")
        } editor: {
             ColorPresetRow(label: "textColor", color: Binding(
                  get: { Moin.ConfigProvider.shared.components.divider.textColor },
                  set: { Moin.ConfigProvider.shared.components.divider.textColor = $0 }
             ))
        } code: {
            "config.components.divider.textColor = Color(...)"
        }
        .scrollAnchor("token.textColor")
    }
    
    private var fontSizeCard: some View {
        TokenCard(
            name: "fontSize",
            type: "CGFloat",
            defaultValue: "14",
            description: tr("api.divider.token_font_size"),
            sectionId: "token"
        ) {
            Moin.Divider("Size")
        } editor: {
            TokenValueRow(label: "fontSize", value: Binding(
                 get: { Moin.ConfigProvider.shared.components.divider.fontSize },
                 set: { Moin.ConfigProvider.shared.components.divider.fontSize = $0 }
            ))
        } code: {
            "config.components.divider.fontSize = \(Int(config.components.divider.fontSize))"
        }
        .scrollAnchor("token.fontSize")
    }
    
    // MARK: - Antd 对齐 Token Cards
    
    private var textPaddingInlineCard: some View {
         TokenCard(
             name: "textPaddingInline",
             type: "CGFloat",
             defaultValue: "token.padding",
             description: tr("api.divider.token_text_padding_inline"),
             sectionId: "token"
         ) {
              Moin.Divider("Text")
         } editor: {
             TokenValueRow(label: "textPaddingInline", value: Binding(
                  get: { Moin.ConfigProvider.shared.components.divider.textPaddingInline },
                  set: { Moin.ConfigProvider.shared.components.divider.textPaddingInline = $0 }
             ))
         } code: {
             "config.components.divider.textPaddingInline = \(Int(config.components.divider.textPaddingInline))"
         }
         .scrollAnchor("token.textPaddingInline")
     }
    
    private var orientationMarginCard: some View {
         TokenCard(
             name: "orientationMargin",
             type: "CGFloat",
             defaultValue: "0.05",
             description: tr("api.divider.token_orientation_margin"),
             sectionId: "token"
         ) {
              Moin.Divider("Left", titlePlacement: .left)
         } editor: {
             TokenValueRow(label: "orientationMargin", value: Binding(
                  get: { Moin.ConfigProvider.shared.components.divider.orientationMargin },
                  set: { Moin.ConfigProvider.shared.components.divider.orientationMargin = $0 }
             ), range: 0...1, step: 0.1)
         } code: {
             "config.components.divider.orientationMargin = \(String(format: "%.2f", config.components.divider.orientationMargin))"
         }
         .scrollAnchor("token.orientationMargin")
     }
    
    private var verticalMarginInlineCard: some View {
        TokenCard(
            name: "verticalMarginInline",
            type: "CGFloat",
            defaultValue: "token.marginXS",
            description: tr("api.divider.token_vertical_margin_inline"),
            sectionId: "token"
        ) {
             HStack(spacing: 0) {
                Text("A")
                Moin.Divider(orientation: .vertical)
                Text("B")
            }
        } editor: {
            TokenValueRow(label: "verticalMarginInline", value: Binding(
                 get: { Moin.ConfigProvider.shared.components.divider.verticalMarginInline },
                 set: { Moin.ConfigProvider.shared.components.divider.verticalMarginInline = $0 }
            ))
        } code: {
            "config.components.divider.verticalMarginInline = \(Int(config.components.divider.verticalMarginInline))"
        }
        .scrollAnchor("token.verticalMarginInline")
    }
    
    private var horizontalMarginBlockCard: some View {
        TokenCard(
            name: "horizontalMarginBlock",
            type: "CGFloat",
            defaultValue: "token.marginLG",
            description: tr("api.divider.token_horizontal_margin_block"),
            sectionId: "token"
        ) {
            VStack(spacing: 0) {
                Text("Text")
                Moin.Divider()
                Text("Text")
            }
        } editor: {
            TokenValueRow(label: "horizontalMarginBlock", value: Binding(
                 get: { Moin.ConfigProvider.shared.components.divider.horizontalMarginBlock },
                 set: { Moin.ConfigProvider.shared.components.divider.horizontalMarginBlock = $0 }
            ))
        } code: {
            "config.components.divider.horizontalMarginBlock = \(Int(config.components.divider.horizontalMarginBlock))"
        }
        .scrollAnchor("token.horizontalMarginBlock")
    }
    
    private var lineWidthCard: some View {
        TokenCard(
            name: "lineWidth",
            type: "CGFloat",
            defaultValue: "1",
            description: tr("api.divider.token_line_width"),
            sectionId: "token"
        ) {
             Moin.Divider()
        } editor: {
            TokenValueRow(label: "lineWidth", value: Binding(
                 get: { Moin.ConfigProvider.shared.components.divider.lineWidth },
                 set: { Moin.ConfigProvider.shared.components.divider.lineWidth = $0 }
            ))
        } code: {
            "config.components.divider.lineWidth = \(Int(config.components.divider.lineWidth))"
        }
        .scrollAnchor("token.lineWidth")
    }
    
    private var dashLengthCard: some View {
        TokenCard(
            name: "dashLength",
            type: "CGFloat",
            defaultValue: "4",
            description: tr("api.divider.token_dash_length"),
            sectionId: "token"
        ) {
             Moin.Divider(variant: .dashed)
        } editor: {
            TokenValueRow(label: "dashLength", value: Binding(
                 get: { Moin.ConfigProvider.shared.components.divider.dashLength },
                 set: { Moin.ConfigProvider.shared.components.divider.dashLength = $0 }
            ))
        } code: {
            "config.components.divider.dashLength = \(Int(config.components.divider.dashLength))"
        }
        .scrollAnchor("token.dashLength")
    }
    
    private var dashGapCard: some View {
         TokenCard(
             name: "dashGap",
             type: "CGFloat",
             defaultValue: "4",
             description: tr("api.divider.token_dash_gap"),
             sectionId: "token"
         ) {
              Moin.Divider(variant: .dashed)
         } editor: {
             TokenValueRow(label: "dashGap", value: Binding(
                  get: { Moin.ConfigProvider.shared.components.divider.dashGap },
                  set: { Moin.ConfigProvider.shared.components.divider.dashGap = $0 }
             ))
         } code: {
             "config.components.divider.dashGap = \(Int(config.components.divider.dashGap))"
         }
         .scrollAnchor("token.dashGap")
     }
    
    private var globalColorTextCard: some View {
         TokenCard(
            name: "colorText",
            type: "Color",
            defaultValue: "token.colorText",
            description: tr("api.global_token.colorText"),
            sectionId: "global"
        ) {
             Moin.Divider("Text")
        } editor: {
            ColorPresetRow(label: "colorText", color: Binding(
                 get: { Moin.ConfigProvider.shared.seed.colorTextBase },
                 set: {
                     Moin.ConfigProvider.shared.seed.colorTextBase = $0
                     Moin.ConfigProvider.shared.regenerateTokens()
                     Moin.ConfigProvider.shared.components.divider = Moin.DividerToken.generate(from: Moin.ConfigProvider.shared.token)
                 }
            ))
        } code: {
            "config.seed.colorTextBase = Color(...)"
        }
        .scrollAnchor("global.colorText")
    }

    private var globalLineWidthCard: some View {
         TokenCard(
            name: "lineWidth",
            type: "CGFloat",
            defaultValue: "1",
            description: tr("api.global_token.lineWidth"),
            sectionId: "global"
        ) {
             Moin.Divider()
        } editor: {
            TokenValueRow(label: "lineWidth", value: Binding(
                 get: { Moin.ConfigProvider.shared.seed.lineWidth },
                 set: {
                     Moin.ConfigProvider.shared.seed.lineWidth = $0
                     Moin.ConfigProvider.shared.regenerateTokens()
                     Moin.ConfigProvider.shared.components.divider = Moin.DividerToken.generate(from: Moin.ConfigProvider.shared.token)
                 }
            ))
        } code: {
            "config.seed.lineWidth = \(Int(config.seed.lineWidth))"
        }
        .scrollAnchor("global.globalLineWidth")
    }
}
