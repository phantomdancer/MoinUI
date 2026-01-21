import SwiftUI
import MoinUI

struct StatisticTokenView: View {
    @Localized var tr
    @ObservedObject var config = Moin.ConfigProvider.shared
    
    // MARK: - Token Sections
    
    private var tokenSections: [DocSidebarSection] {
        [
            DocSidebarSection(
                title: tr("api.component_token"),
                items: ["titleFontSize", "contentFontSize", "gap", "contentGap", "titleColor", "contentColor"],
                sectionId: "token"
            )
        ]
    }
    
    // 重置所有 Token 到默认值
    private func resetAll() {
        let defaultToken = Moin.StatisticToken.resolve(token: config.token)
        config.components.statistic = defaultToken
        NotificationCenter.default.post(name: .statisticDocReset, object: nil)
    }
    
    var body: some View {
        ComponentDocBody(
            sections: tokenSections,
            initialItemId: "token"
        ) { sectionId in
            if sectionId == "token" {
                Text(tr("api.component_token")).font(.title3).fontWeight(.semibold)
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
        case "titleFontSize": titleFontSizeCard
        case "contentFontSize": contentFontSizeCard
        case "gap": gapCard
        case "contentGap": contentGapCard
        case "titleColor": titleColorCard
        case "contentColor": contentColorCard
        default: EmptyView()
        }
    }
    
    // MARK: - Cards
    
    private var titleFontSizeCard: some View {
        TokenCard(
            name: "titleFontSize",
            type: "CGFloat",
            defaultValue: "fontSize (14)",
            description: tr("api.statistic.token_title_font_size"),
            sectionId: "token"
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
            defaultValue: "fontSizeHeading3 (24)",
            description: tr("api.statistic.token_content_font_size"),
            sectionId: "token"
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
    
    private var gapCard: some View {
        TokenCard(
            name: "gap",
            type: "CGFloat",
            defaultValue: "marginXXS (4)",
            description: tr("api.statistic.token_gap"),
            sectionId: "token"
        ) {
            Moin.Statistic(title: "Active Users", value: 112893)
                .border(Color.red.opacity(0.3))
        } editor: {
            TokenValueRow(label: "gap", value: Binding(
                 get: { config.components.statistic.gap },
                 set: { config.components.statistic.gap = $0 }
            ))
        } code: {
            "config.components.statistic.gap = \(Int(config.components.statistic.gap))"
        }
    }
    
    private var contentGapCard: some View {
        TokenCard(
            name: "contentGap",
            type: "CGFloat",
            defaultValue: "marginXXS (4)",
            description: tr("api.statistic.token_content_gap"),
            sectionId: "token"
        ) {
             Moin.Statistic(
                title: "Feedback",
                value: 1128,
                prefix: Image(systemName: "hand.thumbsup.fill").foregroundStyle(Color.blue)
            )
            .border(Color.red.opacity(0.3))
        } editor: {
            TokenValueRow(label: "contentGap", value: Binding(
                 get: { config.components.statistic.contentGap },
                 set: { config.components.statistic.contentGap = $0 }
            ))
        } code: {
            "config.components.statistic.contentGap = \(Int(config.components.statistic.contentGap))"
        }
    }

    private var titleColorCard: some View {
        TokenCard(
            name: "titleColor",
            type: "Color",
            defaultValue: "textSecondary",
            description: "Title Text Color",
            sectionId: "token"
        ) {
            Moin.Statistic(title: "Active Users", value: 112893)
        } editor: {
             ColorPresetRow(label: "titleColor", color: Binding(
                 get: { config.components.statistic.titleColor },
                 set: { config.components.statistic.titleColor = $0 }
            ))
        } code: {
            "config.components.statistic.titleColor = .\(config.components.statistic.titleColor.description)"
        }
    }
    
    private var contentColorCard: some View {
        TokenCard(
            name: "contentColor",
            type: "Color",
            defaultValue: "text",
            description: "Content Text Color",
            sectionId: "token"
        ) {
            Moin.Statistic(title: "Active Users", value: 112893)
        } editor: {
             ColorPresetRow(label: "contentColor", color: Binding(
                 get: { config.components.statistic.contentColor },
                 set: { config.components.statistic.contentColor = $0 }
            ))
        } code: {
            "config.components.statistic.contentColor = .\(config.components.statistic.contentColor.description)"
        }
    }
}
