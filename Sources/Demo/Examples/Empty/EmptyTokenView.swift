import SwiftUI
import MoinUI

// MARK: - EmptyTokenView

struct EmptyTokenView: View {
    @Localized var tr
    @Environment(\.moinToken) var token
    @ObservedObject var config = Moin.ConfigProvider.shared
    
    // MARK: - Token Sections
    
    private var tokenSections: [DocSidebarSection] {
        [
            // 组件 Token
            DocSidebarSection(
                title: tr("doc.section.component_token"),
                items: [.init(id: "imageHeight"), .init(id: "imageHeightSM"), .init(id: "imageOpacity")],
                sectionId: "component"
            ),
            // 全局 Token
            DocSidebarSection(
                title: tr("doc.section.global_token"),
                items: [.init(id: "colorTextQuaternary"), .init(id: "colorTextSecondary"), .init(id: "fontSize"), .init(id: "marginXS"), .init(id: "marginSM")],
                sectionId: "global"
            )
        ]
    }
    
    // 重置所有 Empty Token 到默认值
    private func resetAll() {
        // 重置 seed tokens
        config.seed = Moin.SeedToken.default
        config.regenerateTokens()
        
        // 重置组件 tokens
        config.components.empty = Moin.EmptyToken.generate(from: config.token)
    }
    
    var body: some View {
        ComponentDocBody(
            sections: tokenSections,
            initialItemId: "component"
        ) { sectionId in
            if sectionId == "component" {
                Text(tr("doc.section.component_token"))
                    .font(.title3)
                    .fontWeight(.semibold)
            } else if sectionId == "global" {
                Text(tr("doc.section.global_token"))
                    .font(.title3)
                    .fontWeight(.semibold)
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
        // 组件 Token
        case "imageHeight": imageHeightCard
        case "imageHeightSM": imageHeightSMCard
        case "imageOpacity": imageOpacityCard
        // 全局 Token
        case "colorTextQuaternary": colorTextQuaternaryCard
        case "colorTextSecondary": colorTextSecondaryCard
        case "fontSize": fontSizeCard
        case "marginXS": marginXSCard
        case "marginSM": marginSMCard
        default: EmptyView()
        }
    }
    
    // MARK: - 组件 Token Cards
    
    private var imageHeightCard: some View {
        TokenCard(
            name: "imageHeight",
            type: "CGFloat",
            defaultValue: "100",
            description: tr("empty.token.imageHeight"),
            sectionId: "component"
        ) {
            Moin.Empty(image: .default)
        } editor: {
            TokenValueRow(label: "imageHeight", value: Binding(
                get: { config.components.empty.imageHeight },
                set: { config.components.empty.imageHeight = $0 }
            ))
        } code: {
            "config.components.empty.imageHeight = \(Int(config.components.empty.imageHeight))"
        }
    }
    
    private var imageHeightSMCard: some View {
        TokenCard(
            name: "imageHeightSM",
            type: "CGFloat",
            defaultValue: "40",
            description: tr("empty.token.imageHeightSM"),
            sectionId: "component"
        ) {
            Moin.Empty(image: .simple)
        } editor: {
            TokenValueRow(label: "imageHeightSM", value: Binding(
                get: { config.components.empty.imageHeightSM },
                set: { config.components.empty.imageHeightSM = $0 }
            ))
        } code: {
            "config.components.empty.imageHeightSM = \(Int(config.components.empty.imageHeightSM))"
        }
    }
    
    private var imageOpacityCard: some View {
        TokenCard(
            name: "imageOpacity",
            type: "Double",
            defaultValue: "1.0",
            description: tr("empty.token.imageOpacity"),
            sectionId: "component"
        ) {
            Moin.Empty(image: .simple)
        } editor: {
            TokenValueRow(label: "imageOpacity", value: Binding(
                get: { CGFloat(config.components.empty.imageOpacity) },
                set: { config.components.empty.imageOpacity = Double($0) }
            ), range: 0...1, step: 0.1)
        } code: {
            "config.components.empty.imageOpacity = \(String(format: "%.1f", config.components.empty.imageOpacity))"
        }
    }
    
    // MARK: - 全局 Token Cards
    
    private var colorTextQuaternaryCard: some View {
        TokenCard(
            name: "colorTextQuaternary",
            type: "Color",
            defaultValue: "rgba(0,0,0,0.25)",
            description: tr("empty.token.imageColor"),
            sectionId: "global"
        ) {
            Moin.Empty(image: .simple)
        } code: {
            "// \(tr("api.derived_from")) seed.colorTextBase"
        }
    }
    
    private var colorTextSecondaryCard: some View {
        TokenCard(
            name: "colorTextSecondary",
            type: "Color",
            defaultValue: "rgba(0,0,0,0.45)",
            description: tr("empty.token.descriptionColor"),
            sectionId: "global"
        ) {
            Moin.Empty(description: "Description Text")
        } code: {
            "// \(tr("api.derived_from")) seed.colorTextBase"
        }
    }
    
    private var fontSizeCard: some View {
        TokenCard(
            name: "fontSize",
            type: "CGFloat",
            defaultValue: "14",
            description: tr("empty.token.descriptionFontSize"),
            sectionId: "global"
        ) {
            HStack(spacing: Moin.Constants.Spacing.md) {
                Moin.Empty(description: "Description")
                Text("fontSize: \(Int(config.token.fontSize))px")
                    .font(.system(size: 11, design: .monospaced))
                    .foregroundStyle(.secondary)
            }
        } editor: {
            TokenValueRow(label: "seed.fontSize", value: Binding(
                get: { config.seed.fontSize },
                set: { config.seed.fontSize = $0 }
            ), range: 10...24, onChange: { config.regenerateTokens() })
        } code: {
            "config.seed.fontSize = \(Int(config.seed.fontSize))"
        }
    }
    
    private var marginXSCard: some View {
        TokenCard(
            name: "marginXS",
            type: "CGFloat",
            defaultValue: "8",
            description: tr("empty.token.imageMarginBottom"),
            sectionId: "global"
        ) {
            Moin.Empty(description: "Description")
        } code: {
            "// marginXS = sizeUnit * 2 = \(Int(config.token.marginXS))"
        }
    }
    
    private var marginSMCard: some View {
        TokenCard(
            name: "marginSM",
            type: "CGFloat",
            defaultValue: "12",
            description: tr("empty.token.contentMarginTop"),
            sectionId: "global"
        ) {
            Moin.Empty(description: "Description") {
                Moin.Button("Action") {}
            }
        } code: {
            "// marginSM = sizeUnit * 3 = \(Int(config.token.marginSM))"
        }
    }
}
