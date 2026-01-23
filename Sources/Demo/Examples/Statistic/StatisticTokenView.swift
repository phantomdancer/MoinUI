import SwiftUI
import MoinUI

struct StatisticTokenView: View {
    @Localized var tr
    @Environment(\.moinToken) var token
    @ObservedObject var config = Moin.ConfigProvider.shared
    
    // MARK: - Token Sections
    
    private var tokenSections: [DocSidebarSection] {
        [
            DocSidebarSection(
                title: tr("doc.section.component_token"),
                items: ["titleFontSize", "contentFontSize"],
                sectionId: "component"
            ),
            DocSidebarSection(
                title: tr("doc.section.global_token"),
                items: ["colorTextDescription", "colorTextHeading", "marginXXS"],
                sectionId: "global"
            )
        ]
    }
    
    // 重置所有 Token 到默认值
    private func resetAll() {
        // Reset Global
        config.seed = Moin.SeedToken.default
        config.regenerateTokens()
        
        // Reset Component
        config.components.statistic = .generate(from: config.token)
        NotificationCenter.default.post(name: .statisticDocReset, object: nil)
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
        // Component
        case "titleFontSize": titleFontSizeCard
        case "contentFontSize": contentFontSizeCard
        // Global
        case "colorTextDescription": colorTextDescriptionCard
        case "colorTextHeading": colorTextHeadingCard
        case "marginXXS": marginXXSCard
        default: EmptyView()
        }
    }
    
    // MARK: - Component Cards
    
    private var titleFontSizeCard: some View {
        TokenCard(
            name: "titleFontSize",
            type: "CGFloat",
            defaultValue: "token.fontSize (14)",
            description: tr("api.statistic.token_title_font_size"),
            sectionId: "component"
        ) {
            Moin.Statistic(title: "Active Users", value: 112893)
        } editor: {
            TokenValueRow(label: "titleFontSize", value: Binding(
                 get: { config.components.statistic.titleFontSize },
                 set: { config.components.statistic.titleFontSize = $0 }
            ))
        } code: {
            "config.components.statistic.titleFontSize = \(Int(config.components.statistic.titleFontSize))"
        }
    }
    
    private var contentFontSizeCard: some View {
        TokenCard(
            name: "contentFontSize",
            type: "CGFloat",
            defaultValue: "token.fontSizeHeading3 (24)",
            description: tr("api.statistic.token_content_font_size"),
            sectionId: "component"
        ) {
            Moin.Statistic(title: "Active Users", value: 112893)
        } editor: {
            TokenValueRow(label: "contentFontSize", value: Binding(
                 get: { config.components.statistic.contentFontSize },
                 set: { config.components.statistic.contentFontSize = $0 }
            ))
        } code: {
            "config.components.statistic.contentFontSize = \(Int(config.components.statistic.contentFontSize))"
        }
    }
    
    // MARK: - Global Cards
    
    private var colorTextDescriptionCard: some View {
        TokenCard(
            name: "colorTextDescription",
            type: "Color",
            defaultValue: "token.colorTextDescription",
            description: "Title Text Color",
            sectionId: "global"
        ) {
            Moin.Statistic(title: "Active Users", value: 112893)
        } code: {
            "// \(tr("api.derived_from")) seed.colorTextBase"
        }
    }
    
    private var colorTextHeadingCard: some View {
         TokenCard(
            name: "colorTextHeading",
            type: "Color",
            defaultValue: "token.colorTextHeading",
            description: "Content Text Color",
            sectionId: "global"
        ) {
            Moin.Statistic(title: "Active Users", value: 112893)
        } code: {
            "// \(tr("api.derived_from")) seed.colorTextBase"
        }
    }
    
    private var marginXXSCard: some View {
        TokenCard(
            name: "marginXXS",
            type: "CGFloat",
            defaultValue: "4",
            description: tr("api.statistic.token_gap"),
            sectionId: "global"
        ) {
            Moin.Statistic(title: "Active Users", value: 112893)
                .border(Color.red.opacity(0.3))
        } editor: {
             TokenValueRow(label: "seed.sizeUnit", value: Binding(
                  get: { Moin.ConfigProvider.shared.seed.sizeUnit },
                  set: {
                      Moin.ConfigProvider.shared.seed.sizeUnit = $0
                      Moin.ConfigProvider.shared.regenerateTokens()
                  }
             ), range: 2...8, step: 1)
        } code: {
            "// marginXXS = sizeUnit"
        }
    }
}
