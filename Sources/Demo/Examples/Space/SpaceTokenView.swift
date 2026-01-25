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
                title: tr("doc.section.global_token"),
                items: [.init(id: "paddingXS"), .init(id: "padding"), .init(id: "paddingLG")],
                sectionId: "global"
            )
        ]
    }
    
    // 重置所有 Token 到默认值
    private func resetAll() {
        // 重置全局 seed token
        config.seed = Moin.SeedToken.default
        config.regenerateTokens()
        
        // 通知重置
        NotificationCenter.default.post(name: .spaceDocReset, object: nil)
    }
    
    var body: some View {
        ComponentDocBody(
            sections: tokenSections,
            initialItemId: "global"
        ) { sectionId in
            if sectionId == "global" {
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
        case "paddingXS": globalPaddingXSCard
        case "padding": globalPaddingCard
        case "paddingLG": globalPaddingLGCard
        default: EmptyView()
        }
    }
    
    // MARK: - Global Cards
    
    // Space 组件直接使用 Global Token，因此这里允许直接修改 Global Token，
    // 以演示如何覆盖特定的全局样式。
    // 注意：如果随后修改了 Seed Token，Regenerate 过程可能会重置这些手动修改的值。
    
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
             .border(Color.red.opacity(0.2), width: 1)
        } editor: {
             TokenValueRow(label: "paddingXS", value: Binding(
                  get: { Moin.ConfigProvider.shared.token.paddingXS },
                  set: { Moin.ConfigProvider.shared.token.paddingXS = $0 }
             ))
        } code: {
            "config.token.paddingXS = \(Int(config.token.paddingXS))"
        }
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
            .border(Color.red.opacity(0.2), width: 1)
        } editor: {
             TokenValueRow(label: "padding", value: Binding(
                  get: { Moin.ConfigProvider.shared.token.padding },
                  set: { Moin.ConfigProvider.shared.token.padding = $0 }
             ))
        } code: {
            "config.token.padding = \(Int(config.token.padding))"
        }
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
            .border(Color.red.opacity(0.2), width: 1)
        } editor: {
             TokenValueRow(label: "paddingLG", value: Binding(
                  get: { Moin.ConfigProvider.shared.token.paddingLG },
                  set: { Moin.ConfigProvider.shared.token.paddingLG = $0 }
             ))
        } code: {
            "config.token.paddingLG = \(Int(config.token.paddingLG))"
        }
    }
}
