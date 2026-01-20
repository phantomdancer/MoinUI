import SwiftUI
import MoinUI

// MARK: - TagTokenView

/// Tag 组件 Token 文档视图
struct TagTokenView: View {
    @Localized var tr
    @ObservedObject var config = Moin.ConfigProvider.shared
    
    // MARK: - Sections
    
    private var tokenSections: [DocSidebarSection] {
        [
            DocSidebarSection(
                title: tr("api.tag.section.font"),
                items: ["fontSize", "fontSizeSM", "fontSizeLG"],
                sectionId: "token"
            ),
            DocSidebarSection(
                title: tr("api.tag.section.color"),
                items: ["defaultBg", "defaultColor", "solidTextColor"],
                sectionId: "token"
            ),
            DocSidebarSection(
                title: tr("api.tag.section.dimensions"),
                items: ["lineWidth", "paddingH", "paddingHSM", "paddingHLG", "paddingV", "paddingVSM", "paddingVLG"],
                sectionId: "token"
            ),
            DocSidebarSection(
                title: tr("api.tag.section.icon_style"),
                items: ["iconSize", "iconSizeSM", "iconSizeLG", "iconGap", "iconGapSM", "iconGapLG"],
                sectionId: "token"
            )
        ]
    }
    
    private var globalSections: [DocSidebarSection] {
        [
            DocSidebarSection(
                title: tr("doc.section.global_token"),
                items: ["fontSizeSM"],
                sectionId: "global"
            )
        ]
    }
    
    private var allSections: [DocSidebarSection] {
        tokenSections + globalSections
    }
    
    // 重置所有 Token 到默认值
    private func resetAll() {
        // 重置 Component Token
        config.components.tag = Moin.TagToken.generate(from: config.token)
        
        // 重置 Global Token (涉及到的)
        config.seed.fontSize = 14
        
        // 重新生成
        config.regenerateTokens()
    }
    
    var body: some View {
        ComponentDocBody(
            sections: allSections,
            initialItemId: "token"
        ) { sectionId in
            if sectionId == "token" {
                Text(tr("doc.section.component_token"))
                    .font(.title3)
                    .fontWeight(.semibold)
            } else if sectionId == "global" {
                Text(tr("doc.section.global_token"))
                    .font(.title3)
                    .fontWeight(.semibold)
            }
        } item: { item in
            // Determine sectionId
            if globalSections.flatMap({ $0.items }).contains(item) {
                 cardForItem(item, sectionId: "global")
            } else {
                 cardForItem(item, sectionId: "token")
            }
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
    
    // MARK: - Item -> Card 映射
    
    @ViewBuilder
    private func cardForItem(_ item: String, sectionId: String) -> some View {
        if sectionId == "token" {
            switch item {
            case "fontSize": tagFontSizeTokenCard
            case "fontSizeSM": tagFontSizeSMTokenCard
            case "fontSizeLG": tagFontSizeLGTokenCard
            case "defaultBg": tagDefaultBgTokenCard
            case "defaultColor": tagDefaultColorTokenCard
            case "solidTextColor": tagSolidTextColorTokenCard
            case "lineWidth": tagLineWidthTokenCard
            case "paddingH": tagPaddingHTokenCard
            case "paddingHSM": tagPaddingHSMTokenCard
            case "paddingHLG": tagPaddingHLGTokenCard
            case "paddingV": tagPaddingVTokenCard
            case "paddingVSM": tagPaddingVSMTokenCard
            case "paddingVLG": tagPaddingVLGTokenCard
            case "iconSize": tagIconSizeTokenCard
            case "iconSizeSM": tagIconSizeSMTokenCard
            case "iconSizeLG": tagIconSizeLGTokenCard
            case "iconGap": tagIconGapTokenCard
            case "iconGapSM": tagIconGapSMTokenCard
            case "iconGapLG": tagIconGapLGTokenCard
            default: EmptyView()
            }
        } else {
            // global
            switch item {
            case "fontSizeSM": tagGlobalFontSizeCard
            default: EmptyView()
            }
        }
    }
}
