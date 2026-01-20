import SwiftUI
import MoinUI

// MARK: - SpaceTokenView

struct SpaceTokenView: View {
    @Localized var tr
    @Environment(\.moinToken) var token
    @ObservedObject var config = Moin.ConfigProvider.shared
    
    // MARK: - Token Sections
    
    private var tokenSections: [DocSidebarSection] {
        [
            DocSidebarSection(
                title: tr("api.component_token"),
                items: ["sizeSmall", "sizeMedium", "sizeLarge"],
                sectionId: "token"
            ),
             DocSidebarSection(
                title: tr("api.global_token_title"),
                items: ["borderRadius", "fontSize", "margin", "marginLG", "marginXS", "motionDuration"],
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
        case "sizeSmall": sizeSmallCard
        case "sizeMedium": sizeMediumCard
        case "sizeLarge": sizeLargeCard
        
        case "borderRadius": globalBorderRadiusCard
        case "fontSize": globalFontSizeCard
        case "margin": globalMarginCard
        case "marginLG": globalMarginLGCard
        case "marginXS": globalMarginXSCard
        case "motionDuration": globalMotionDurationCard
        default: EmptyView()
        }
    }
    
    // MARK: - Component Cards
    
    private var sizeSmallCard: some View {
        TokenCard(
            name: "sizeSmall",
            type: "CGFloat",
            defaultValue: "8",
            description: tr("api.space.token_small"),
            sectionId: "token"
        ) {
            Moin.Space(size: .small) {
                Text("A")
                Text("B")
            }
        } editor: {
            TokenValueRow(label: "sizeSmall", value: Binding(
                 get: { Moin.ConfigProvider.shared.components.space.sizeSmall },
                 set: { Moin.ConfigProvider.shared.components.space.sizeSmall = $0 }
            ))
        } code: {
            "config.components.space.sizeSmall = \(Int(config.components.space.sizeSmall))"
        }
        .scrollAnchor("token.sizeSmall")
    }
    
    private var sizeMediumCard: some View {
        TokenCard(
            name: "sizeMedium",
            type: "CGFloat",
            defaultValue: "12", // Old file said 12? Assuming yes, based on view_file output
            description: tr("api.space.token_medium"),
            sectionId: "token"
        ) {
            Moin.Space(size: .medium) {
                Text("A")
                Text("B")
            }
        } editor: {
            TokenValueRow(label: "sizeMedium", value: Binding(
                 get: { Moin.ConfigProvider.shared.components.space.sizeMedium },
                 set: { Moin.ConfigProvider.shared.components.space.sizeMedium = $0 }
            ))
        } code: {
            "config.components.space.sizeMedium = \(Int(config.components.space.sizeMedium))"
        }
        .scrollAnchor("token.sizeMedium")
    }
    
    private var sizeLargeCard: some View {
        TokenCard(
            name: "sizeLarge",
            type: "CGFloat",
            defaultValue: "16", // Old file said 16?
            description: tr("api.space.token_large"),
            sectionId: "token"
        ) {
            Moin.Space(size: .large) {
                Text("A")
                Text("B")
            }
        } editor: {
            TokenValueRow(label: "sizeLarge", value: Binding(
                 get: { Moin.ConfigProvider.shared.components.space.sizeLarge },
                 set: { Moin.ConfigProvider.shared.components.space.sizeLarge = $0 }
            ))
        } code: {
            "config.components.space.sizeLarge = \(Int(config.components.space.sizeLarge))"
        }
        .scrollAnchor("token.sizeLarge")
    }
    
    // MARK: - Global
    
    // Just placeholders usually, as seen in other files
    private var globalBorderRadiusCard: some View {
         TokenCard(
            name: "borderRadius",
            type: "CGFloat",
            defaultValue: "6",
            description: tr("api.global_token.borderRadius"),
            sectionId: "global"
        ) { EmptyView() } editor: { EmptyView() } code: { "// Global Token" }
        .scrollAnchor("global.borderRadius")
    }
    
    private var globalFontSizeCard: some View {
         TokenCard(
            name: "fontSize",
            type: "CGFloat",
            defaultValue: "14",
            description: tr("api.global_token.fontSize"),
            sectionId: "global"
        ) { EmptyView() } editor: { EmptyView() } code: { "// Global Token" }
        .scrollAnchor("global.fontSize")
    }
    
    private var globalMarginCard: some View {
         TokenCard(
            name: "margin",
            type: "CGFloat",
            defaultValue: "16",
            description: tr("api.global_token.margin"),
            sectionId: "global"
        ) { EmptyView() } editor: { EmptyView() } code: { "// Global Token" }
        .scrollAnchor("global.margin")
    }
    
    private var globalMarginLGCard: some View {
         TokenCard(
            name: "marginLG",
            type: "CGFloat",
            defaultValue: "24",
            description: tr("api.global_token.marginLG"),
            sectionId: "global"
        ) { EmptyView() } editor: { EmptyView() } code: { "// Global Token" }
        .scrollAnchor("global.marginLG")
    }
    
    private var globalMarginXSCard: some View {
         TokenCard(
            name: "marginXS",
            type: "CGFloat",
            defaultValue: "8",
            description: tr("api.global_token.marginXS"),
            sectionId: "global"
        ) { EmptyView() } editor: { EmptyView() } code: { "// Global Token" }
        .scrollAnchor("global.marginXS")
    }
    
    private var globalMotionDurationCard: some View {
         TokenCard(
            name: "motionDuration",
            type: "Double",
            defaultValue: "0.2",
            description: tr("api.global_token.motionDuration"),
            sectionId: "global"
        ) { EmptyView() } editor: { EmptyView() } code: { "// Global Token" }
        .scrollAnchor("global.motionDuration")
    }
}
