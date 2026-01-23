import SwiftUI
import MoinUI

// MARK: - ButtonTokenView

/// Button 组件 Token 文档视图
struct ButtonTokenView: View {
    @Localized var tr
    @ObservedObject var config = Moin.ConfigProvider.shared
    
    // MARK: - Token Sections
    
    // Component Tokens Sections
    private var componentSections: [DocSidebarSection] {
        [
            DocSidebarSection(
                title: tr("api.button.section.font"),
                items: ["contentFontSize", "contentFontSizeSM", "contentFontSizeLG", "fontWeight"],
                sectionId: "component"
            ),
            DocSidebarSection(
                title: tr("api.button.section.dimensions"),
                items: ["paddingBlock", "paddingBlockSM", "paddingBlockLG", "paddingInline", "paddingInlineSM", "paddingInlineLG", "iconGap", "onlyIconSize", "onlyIconSizeSM", "onlyIconSizeLG"],
                sectionId: "component"
            ),
            DocSidebarSection(
                title: tr("api.button.section.style"),
                items: ["groupBorderColor", "textTextColor"], // Shadows skipped for brevity or add if needed
                sectionId: "component"
            )
        ]
    }
    
    // Global Tokens Sections
    private var globalSections: [DocSidebarSection] {
        [
            DocSidebarSection(
                title: tr("doc.section.global_token"),
                items: [
                   "borderRadius", "borderRadiusLG", "borderRadiusSM",
                   "colorPrimary", "colorPrimaryActive", "colorPrimaryHover",
                   "colorText", "colorTextDisabled", "colorBgContainer", "colorBorder",
                   "controlHeight", "controlHeightLG", "controlHeightSM"
                ],
                sectionId: "global"
            )
        ]
    }
    
    private var allSections: [DocSidebarSection] {
        componentSections + globalSections
    }
    
    // 重置所有 Token 到默认值
    private func resetAll() {
        // 重置全局token
        config.seed = Moin.SeedToken.default
        config.regenerateTokens()
        
        // 重置组件 Token
        config.components.button = .generate(from: config.token)
        
        // 通知重置
        NotificationCenter.default.post(name: .buttonDocReset, object: nil)
    }
    
    var body: some View {
        ComponentDocBody(
            sections: allSections,
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
            if globalSections.flatMap({ $0.items }).contains(item) {
                 cardForItem(item, sectionId: "global")
            } else {
                 cardForItem(item, sectionId: "component")
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
        if sectionId == "component" {
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
            case "groupBorderColor": groupBorderColorTokenCard
            case "textTextColor": textTextColorTokenCard
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
            case "colorText": colorTextGlobalTokenCard
            case "colorTextDisabled": colorTextDisabledGlobalTokenCard
            case "colorBgContainer": colorBgContainerGlobalTokenCard
            case "colorBorder": colorBorderGlobalTokenCard
            case "controlHeight": controlHeightGlobalTokenCard
            case "controlHeightLG": controlHeightLGGlobalTokenCard
            case "controlHeightSM": controlHeightSMGlobalTokenCard
            default: EmptyView()
            }
        }
    }
}
