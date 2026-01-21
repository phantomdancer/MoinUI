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
                items: ["paddingXS", "padding", "paddingLG"],
                sectionId: "global"
            )
        ]
    }
    
    // 重置所有 Token 到默认值
    private func resetAll() {
        // 重置全局 seed token
        config.seed = .default
        config.regenerateTokens()
        
        // 重置组件 token
        let defaultSpace = Moin.SpaceToken.generate(from: config.token)
        config.components.space = defaultSpace
        
        // 通知重置
        NotificationCenter.default.post(name: .spaceDocReset, object: nil)
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
        case "sizeSmall": sizeSmallCard
        case "sizeMedium": sizeMediumCard
        case "sizeLarge": sizeLargeCard
        
        case "paddingXS": globalPaddingXSCard
        case "padding": globalPaddingCard
        case "paddingLG": globalPaddingLGCard
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
            defaultValue: "12",
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
            defaultValue: "16",
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
    
    private var globalPaddingXSCard: some View {
         TokenCard(
            name: "paddingXS",
            type: "CGFloat",
            defaultValue: "8",
            description: tr("api.global_token.paddingXS"),
            sectionId: "global"
        ) {
             Moin.Space(size: .small) {
                 Color.blue.frame(width: 20, height: 20)
                 Color.blue.frame(width: 20, height: 20)
             }
             .border(Color.red, width: 1)
        } editor: {
             TokenValueRow(label: "paddingXS", value: Binding(
                  get: { Moin.ConfigProvider.shared.token.paddingXS },
                  set: {
                      Moin.ConfigProvider.shared.token.paddingXS = $0
                      Moin.ConfigProvider.shared.components.space = Moin.SpaceToken.generate(from: Moin.ConfigProvider.shared.token)
                  }
             ))
        } code: {
            "config.token.paddingXS = \(Int(config.token.paddingXS))"
        }
        .scrollAnchor("global.paddingXS")
    }
    
    private var globalPaddingCard: some View {
         TokenCard(
            name: "padding",
            type: "CGFloat",
            defaultValue: "16",
            description: tr("api.global_token.padding"),
            sectionId: "global"
        ) {
            Moin.Space(size: .medium) {
                Color.blue.frame(width: 20, height: 20)
                Color.blue.frame(width: 20, height: 20)
            }
            .border(Color.red, width: 1)
        } editor: {
             TokenValueRow(label: "padding", value: Binding(
                  get: { Moin.ConfigProvider.shared.token.padding },
                  set: {
                      Moin.ConfigProvider.shared.token.padding = $0
                      Moin.ConfigProvider.shared.components.space = Moin.SpaceToken.generate(from: Moin.ConfigProvider.shared.token)
                  }
             ))
        } code: {
            "config.token.padding = \(Int(config.token.padding))"
        }
        .scrollAnchor("global.padding")
    }
    
    private var globalPaddingLGCard: some View {
         TokenCard(
            name: "paddingLG",
            type: "CGFloat",
            defaultValue: "24",
            description: tr("api.global_token.paddingLG"),
            sectionId: "global"
        ) {
            Moin.Space(size: .large) {
                Color.blue.frame(width: 20, height: 20)
                Color.blue.frame(width: 20, height: 20)
            }
            .border(Color.red, width: 1)
        } editor: {
             TokenValueRow(label: "paddingLG", value: Binding(
                  get: { Moin.ConfigProvider.shared.token.paddingLG },
                  set: {
                      Moin.ConfigProvider.shared.token.paddingLG = $0
                      Moin.ConfigProvider.shared.components.space = Moin.SpaceToken.generate(from: Moin.ConfigProvider.shared.token)
                  }
             ))
        } code: {
            "config.token.paddingLG = \(Int(config.token.paddingLG))"
        }
        .scrollAnchor("global.paddingLG")
    }
}
