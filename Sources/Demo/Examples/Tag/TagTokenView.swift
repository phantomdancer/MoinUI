import SwiftUI
import MoinUI

// MARK: - TagTokenView

/// Tag 组件 Token 文档视图
struct TagTokenView: View {
    @Localized var tr
    @ObservedObject var config = Moin.ConfigProvider.shared
    
    @State var selectedItemId: String? = "token"
    @State var scrollPosition: String?
    @State private var targetScrollId: String?

    // MARK: - 共享 Sections 数据（sidebar 和主内容区共用）
    
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
        HStack(spacing: 0) {
            // 左栏：主内容
            mainContent
            
            Divider()
            
            // 右栏：导航树
            docSidebar
                .frame(width: 280)
        }
        .background(Color(nsColor: .controlBackgroundColor))
    }
    
    // MARK: - Doc Sidebar

    private var docSidebar: some View {
        DocSidebar(
            sections: allSections,
            selectedItemId: $selectedItemId,
            targetScrollId: $targetScrollId
        ) {
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
    
    // MARK: - 主内容区
    
    private var mainContent: some View {
        // 可滚动内容
        AnchorScrollView(targetScrollId: $targetScrollId, currentScrollId: $selectedItemId) {
            LazyVStack(alignment: .leading, spacing: Moin.Constants.Spacing.xl) {
                // Token 分组
                Text(tr("doc.section.component_token"))
                    .font(.title3)
                    .fontWeight(.semibold)
                    .scrollAnchor("token")

                // 按 tokenSections 顺序渲染
                ForEach(tokenSections) { section in
                    ForEach(section.sortedItems, id: \.self) { item in
                        cardForItem(item, sectionId: "token")
                    }
                }

                // Global Token 分组
                Text(tr("doc.section.global_token"))
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding(.top, Moin.Constants.Spacing.xl)
                    .scrollAnchor("global")
                
                // 按 globalSections 顺序渲染
                ForEach(globalSections) { section in
                    ForEach(section.sortedItems, id: \.self) { item in
                        cardForItem(item, sectionId: "global")
                    }
                }
            }
            .padding(Moin.Constants.Spacing.lg)
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
