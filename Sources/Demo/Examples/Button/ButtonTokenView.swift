import SwiftUI
import MoinUI

// MARK: - ButtonTokenView

/// Button 组件 Token 文档视图
struct ButtonTokenView: View {
    @Localized var tr
    @ObservedObject var config = Moin.ConfigProvider.shared
    
    @State var selectedItemId: String? = "token"
    @State var scrollPosition: String?
    @State private var targetScrollId: String?

    
    // MARK: - 共享 Sections 数据（sidebar 和主内容区共用）
    
    private var tokenSections: [DocSidebarSection] {
        [
            DocSidebarSection(
                title: tr("api.button.section.font"),
                items: ["contentFontSize", "contentFontSizeSM", "contentFontSizeLG", "fontWeight"],
                sectionId: "token"
            ),
            DocSidebarSection(
                title: tr("api.button.section.dimensions"),
                items: ["paddingBlock", "paddingBlockSM", "paddingBlockLG", "paddingInline", "paddingInlineSM", "paddingInlineLG", "iconGap", "onlyIconSize", "onlyIconSizeSM", "onlyIconSizeLG"],
                sectionId: "token"
            ),
            DocSidebarSection(
                title: tr("api.button.section.color_primary"),
                items: ["primaryColor", "solidTextColor", "dangerColor"],
                sectionId: "token"
            ),
            DocSidebarSection(
                title: tr("api.button.section.color_default"),
                items: ["defaultColor", "defaultBg", "defaultBorderColor", "defaultHoverColor", "defaultHoverBg", "defaultHoverBorderColor", "defaultActiveColor", "defaultActiveBg", "defaultActiveBorderColor", "defaultBgDisabled", "borderColorDisabled"],
                sectionId: "token"
            ),
            DocSidebarSection(
                title: tr("api.button.section.color_other"),
                items: ["defaultGhostColor", "defaultGhostBorderColor", "ghostBg", "textTextColor", "textHoverBg", "textTextHoverColor", "textTextActiveColor", "linkHoverBg"],
                sectionId: "token"
            )
        ]
    }
    
    private var globalSections: [DocSidebarSection] {
        [
            DocSidebarSection(
                title: tr("doc.section.global_token"),
                items: ["borderRadius", "borderRadiusLG", "borderRadiusSM", "colorPrimary", "colorPrimaryActive", "colorPrimaryHover", "colorTextDisabled", "controlHeight", "controlHeightLG", "controlHeightSM", "motionDurationMid", "motionDurationSlow", "motionEase"],
                sectionId: "global"
            )
        ]
    }
    
    private var allSections: [DocSidebarSection] {
        tokenSections + globalSections
    }
    
    // 重置所有 Token 到默认值
    private func resetAll() {
        // 重置全局token
        config.seed.colorPrimary = Moin.Colors.blue
        config.seed.borderRadius = 6
        config.seed.controlHeight = 32
        config.seed.motionUnit = 0.1 // 重置动画 Unit
        config.seed.motionBase = 2   // 重置动画 Base
        config.regenerateTokens()
        // 通知重置
        NotificationCenter.default.post(name: .buttonDocReset, object: nil)
    }
    
    var body: some View {
        HStack(spacing: 0) {
            // 左栏：Token 卡片列表
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
        VStack(spacing: 0) {
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

                    Divider().padding(.vertical, Moin.Constants.Spacing.md)

                    // 全局 Token 分组
                    Text(tr("doc.section.global_token"))
                        .font(.title3)
                        .fontWeight(.semibold)
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
    }
    
    // MARK: - Item -> Card 映射
    
    @ViewBuilder
    private func cardForItem(_ item: String, sectionId: String) -> some View {
        if sectionId == "token" {
            switch item {
            case "contentFontSize": contentFontSizeTokenCard
            case "contentFontSizeLG": contentFontSizeLGTokenCard
            case "contentFontSizeSM": contentFontSizeSMTokenCard
            case "fontWeight": fontWeightTokenCard
            case "iconGap": iconGapTokenCard
            case "onlyIconSize": onlyIconSizeTokenCard
            case "onlyIconSizeLG": onlyIconSizeLGTokenCard
            case "onlyIconSizeSM": onlyIconSizeSMTokenCard
            case "paddingBlock": paddingBlockTokenCard
            case "paddingBlockLG": paddingBlockLGTokenCard
            case "paddingBlockSM": paddingBlockSMTokenCard
            case "paddingInline": paddingInlineTokenCard
            case "paddingInlineLG": paddingInlineLGTokenCard
            case "paddingInlineSM": paddingInlineSMTokenCard
            case "dangerColor": dangerColorTokenCard
            case "primaryColor": primaryColorTokenCard
            case "solidTextColor": solidTextColorTokenCard
            case "borderColorDisabled": borderColorDisabledTokenCard
            case "defaultActiveBg": defaultActiveBgTokenCard
            case "defaultActiveBorderColor": defaultActiveBorderColorTokenCard
            case "defaultActiveColor": defaultActiveColorTokenCard
            case "defaultBg": defaultBgTokenCard
            case "defaultBgDisabled": defaultBgDisabledTokenCard
            case "defaultBorderColor": defaultBorderColorTokenCard
            case "defaultColor": defaultColorTokenCard
            case "defaultHoverBg": defaultHoverBgTokenCard
            case "defaultHoverBorderColor": defaultHoverBorderColorTokenCard
            case "defaultHoverColor": defaultHoverColorTokenCard
            case "defaultGhostBorderColor": defaultGhostBorderColorTokenCard
            case "defaultGhostColor": defaultGhostColorTokenCard
            case "ghostBg": ghostBgTokenCard
            case "linkHoverBg": linkHoverBgTokenCard
            case "textHoverBg": textHoverBgTokenCard
            case "textTextActiveColor": textTextActiveColorTokenCard
            case "textTextColor": textTextColorTokenCard
            case "textTextHoverColor": textTextHoverColorTokenCard
            default: EmptyView()
            }
        } else {
            // global
            switch item {
            case "borderRadius": borderRadiusGlobalTokenCard
            case "borderRadiusLG": borderRadiusLGGlobalTokenCard
            case "borderRadiusSM": borderRadiusSMGlobalTokenCard
            case "colorPrimary": colorPrimaryGlobalTokenCard
            case "colorPrimaryActive": colorPrimaryActiveGlobalTokenCard
            case "colorPrimaryHover": colorPrimaryHoverGlobalTokenCard
            case "colorTextDisabled": colorTextDisabledGlobalTokenCard
            case "controlHeight": controlHeightGlobalTokenCard
            case "controlHeightLG": controlHeightLGGlobalTokenCard
            case "controlHeightSM": controlHeightSMGlobalTokenCard
            case "motionDurationMid": motionDurationMidGlobalTokenCard
            case "motionDurationSlow": motionDurationSlowGlobalTokenCard
            case "motionEase": motionEaseGlobalTokenCard
            default: EmptyView()
            }
        }
    }
}
