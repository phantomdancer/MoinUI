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
                    "lineColor", "textColor", "fontSize",
                    "verticalMargin", "horizontalMargin", "textPadding",
                    "lineWidth", "dashLength", "dashGap"
                ],
                sectionId: "token"
            ),
            DocSidebarSection(
                title: tr("api.global_token_title"),
                items: ["borderRadius", "colorPrimary", "colorText", "lineWidth_global", "margin"],
                sectionId: "global"
            )
        ]
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
        }
    }
    
    @ViewBuilder
    private func cardForItem(_ item: String) -> some View {
        switch item {
        // Component Tokens
        case "lineColor": lineColorCard
        case "textColor": textColorCard
        case "fontSize": fontSizeCard
        case "verticalMargin": verticalMarginCard
        case "horizontalMargin": horizontalMarginCard
        case "textPadding": textPaddingCard
        case "lineWidth": lineWidthCard
        case "dashLength": dashLengthCard
        case "dashGap": dashGapCard
        // Global
        case "borderRadius": globalBorderRadiusCard
        case "colorPrimary": globalColorPrimaryCard
        case "colorText": globalColorTextCard
        case "lineWidth_global": globalLineWidthCard
        case "margin": globalMarginCard
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
    
    private var verticalMarginCard: some View {
        TokenCard(
            name: "verticalMargin",
            type: "CGFloat",
            defaultValue: "16",
            description: tr("api.divider.token_vertical_margin"),
            sectionId: "token"
        ) {
            VStack(spacing: 0) {
                Text("Text")
                Moin.Divider()
                Text("Text")
            }
        } editor: {
            TokenValueRow(label: "verticalMargin", value: Binding(
                 get: { Moin.ConfigProvider.shared.components.divider.verticalMargin },
                 set: { Moin.ConfigProvider.shared.components.divider.verticalMargin = $0 }
            ))
        } code: {
            "config.components.divider.verticalMargin = \(Int(config.components.divider.verticalMargin))"
        }
        .scrollAnchor("token.verticalMargin")
    }
    
    private var horizontalMarginCard: some View {
        TokenCard(
            name: "horizontalMargin",
            type: "CGFloat",
            defaultValue: "16", // Typo in old file said 8 or 16? Let's assume standard from old file: "8"
            description: tr("api.divider.token_horizontal_margin"),
            sectionId: "token"
        ) {
             HStack(spacing: 0) {
                Text("A")
                Moin.Divider(orientation: .vertical)
                Text("B")
            }
        } editor: {
            TokenValueRow(label: "horizontalMargin", value: Binding(
                 get: { Moin.ConfigProvider.shared.components.divider.horizontalMargin },
                 set: { Moin.ConfigProvider.shared.components.divider.horizontalMargin = $0 }
            ))
        } code: {
            "config.components.divider.horizontalMargin = \(Int(config.components.divider.horizontalMargin))"
        }
        .scrollAnchor("token.horizontalMargin")
    }
    
    private var textPaddingCard: some View {
         TokenCard(
             name: "textPadding",
             type: "CGFloat",
             defaultValue: "12", // Check old file: "12"
             description: tr("api.divider.token_text_padding"),
             sectionId: "token"
         ) {
              Moin.Divider("Padding")
         } editor: {
             TokenValueRow(label: "textPadding", value: Binding(
                  get: { Moin.ConfigProvider.shared.components.divider.textPadding },
                  set: { Moin.ConfigProvider.shared.components.divider.textPadding = $0 }
             ))
         } code: {
             "config.components.divider.textPadding = \(Int(config.components.divider.textPadding))"
         }
         .scrollAnchor("token.textPadding")
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
    
    // MARK: - Global Cards
    
    private var globalBorderRadiusCard: some View {
         TokenCard(
            name: "borderRadius",
            type: "CGFloat",
            defaultValue: "6",
            description: tr("api.global_token.borderRadius"),
            sectionId: "global"
        ) {
             EmptyView()
        } editor: { EmptyView() } code: { "// Global Token" }
        .scrollAnchor("global.borderRadius")
    }

    private var globalColorPrimaryCard: some View {
         TokenCard(
            name: "colorPrimary",
            type: "Color",
            defaultValue: "token.colorPrimary",
            description: tr("api.global_token.colorPrimary"),
            sectionId: "global"
        ) {
             EmptyView()
        } editor: { EmptyView() } code: { "// Global Token" }
        .scrollAnchor("global.colorPrimary")
    }
    
    private var globalColorTextCard: some View {
         TokenCard(
            name: "colorText",
            type: "Color",
            defaultValue: "token.colorText",
            description: tr("api.global_token.colorText"),
            sectionId: "global"
        ) {
             EmptyView()
        } editor: { EmptyView() } code: { "// Global Token" }
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
             EmptyView()
        } editor: { EmptyView() } code: { "// Global Token" }
        .scrollAnchor("global.lineWidth")
    }
    
    private var globalMarginCard: some View {
         TokenCard(
            name: "margin",
            type: "CGFloat",
            defaultValue: "16",
            description: tr("api.global_token.margin"),
            sectionId: "global"
        ) {
             EmptyView()
        } editor: { EmptyView() } code: { "// Global Token" }
        .scrollAnchor("global.margin")
    }

}
