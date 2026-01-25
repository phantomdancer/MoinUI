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
            let globalItemIds = globalSections.flatMap { $0.items.map { $0.id } }
            if globalItemIds.contains(item) {
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
            case "contentFontSize": AnyView(contentFontSizeTokenCard)
            case "contentFontSizeLG": AnyView(contentFontSizeLGTokenCard)
            case "contentFontSizeSM": AnyView(contentFontSizeSMTokenCard)
            case "fontWeight": AnyView(fontWeightTokenCard)
            case "iconGap": AnyView(iconGapTokenCard)
            case "onlyIconSize": AnyView(onlyIconSizeTokenCard)
            case "onlyIconSizeLG": AnyView(onlyIconSizeLGTokenCard)
            case "onlyIconSizeSM": AnyView(onlyIconSizeSMTokenCard)
            case "paddingBlock": AnyView(paddingBlockTokenCard)
            case "paddingBlockLG": AnyView(paddingBlockLGTokenCard)
            case "paddingBlockSM": AnyView(paddingBlockSMTokenCard)
            case "paddingInline": AnyView(paddingInlineTokenCard)
            case "paddingInlineLG": AnyView(paddingInlineLGTokenCard)
            case "paddingInlineSM": AnyView(paddingInlineSMTokenCard)
            case "groupBorderColor": AnyView(groupBorderColorTokenCard)
            case "textTextColor": AnyView(textTextColorTokenCard)
            default: AnyView(EmptyView())
            }
        } else {
            // global
            switch item {
            case "borderRadius": AnyView(borderRadiusGlobalTokenCard)
            case "borderRadiusLG": AnyView(borderRadiusLGGlobalTokenCard)
            case "borderRadiusSM": AnyView(borderRadiusSMGlobalTokenCard)
            case "colorPrimary": AnyView(colorPrimaryGlobalTokenCard)
            case "colorPrimaryActive": AnyView(colorPrimaryActiveGlobalTokenCard)
            case "colorPrimaryHover": AnyView(colorPrimaryHoverGlobalTokenCard)
            case "colorText": AnyView(colorTextGlobalTokenCard)
            case "colorTextDisabled": AnyView(colorTextDisabledGlobalTokenCard)
            case "colorBgContainer": AnyView(colorBgContainerGlobalTokenCard)
            case "colorBorder": AnyView(colorBorderGlobalTokenCard)
            case "controlHeight": AnyView(controlHeightGlobalTokenCard)
            case "controlHeightLG": AnyView(controlHeightLGGlobalTokenCard)
            case "controlHeightSM": AnyView(controlHeightSMGlobalTokenCard)
            default: AnyView(EmptyView())
            }
        }
    }
}
