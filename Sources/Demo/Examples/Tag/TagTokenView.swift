import SwiftUI
import MoinUI

// MARK: - TagTokenView

/// Tag 组件 Token 文档视图
struct TagTokenView: View {
    @Localized var tr
    @ObservedObject var config = Moin.ConfigProvider.shared
    
    // MARK: - Sections (与 Ant Design 一致)
    
    private var tokenSections: [DocSidebarSection] {
        [
            // 组件 Token
            DocSidebarSection(
                title: tr("doc.section.component_token"),
                items: [.init(id: "defaultBg"), .init(id: "defaultColor"), .init(id: "solidTextColor"), .init(id: "paddingH"), .init(id: "paddingHSM"), .init(id: "paddingHLG"), .init(id: "paddingV"), .init(id: "paddingVSM"), .init(id: "paddingVLG"), .init(id: "iconSize"), .init(id: "iconSizeSM"), .init(id: "iconSizeLG"), .init(id: "closeIconSize"), .init(id: "iconGap"), .init(id: "iconGapSM"), .init(id: "iconGapLG")],
                sectionId: "component"
            ),
            // 全局 Token
            DocSidebarSection(
                title: tr("doc.section.global_token"),
                items: [.init(id: "fontSize"), .init(id: "fontSizeSM"), .init(id: "lineWidth"), .init(id: "borderRadiusSM"), .init(id: "colorPrimary"), .init(id: "colorSuccess"), .init(id: "colorWarning"), .init(id: "colorError")],
                sectionId: "global"
            )
        ]
    }
    
    // 重置所有 Token 到默认值
    private func resetAll() {
        // 重置 seed tokens
        config.seed = Moin.SeedToken.default
        config.regenerateTokens()
        
        // 重置组件 tokens
        config.components.tag = Moin.TagToken.generate(from: config.token)
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
    
    // MARK: - Item -> Card 映射
    
    @ViewBuilder
    private func cardForItem(_ item: String) -> some View {
        switch item {
        // 组件 Token
        case "defaultBg": tagDefaultBgTokenCard
        case "defaultColor": tagDefaultColorTokenCard
        case "solidTextColor": tagSolidTextColorTokenCard
        case "paddingH": tagPaddingHTokenCard
        case "paddingHSM": tagPaddingHSMTokenCard
        case "paddingHLG": tagPaddingHLGTokenCard
        case "paddingV": tagPaddingVTokenCard
        case "paddingVSM": tagPaddingVSMTokenCard
        case "paddingVLG": tagPaddingVLGTokenCard
        case "iconSize": tagIconSizeTokenCard
        case "iconSizeSM": tagIconSizeSMTokenCard
        case "iconSizeLG": tagIconSizeLGTokenCard
        case "closeIconSize": tagCloseIconSizeTokenCard
        case "iconGap": tagIconGapTokenCard
        case "iconGapSM": tagIconGapSMTokenCard
        case "iconGapLG": tagIconGapLGTokenCard
        
        // 全局 Token
        case "fontSize": tagFontSizeCard
        case "fontSizeSM": tagFontSizeSMCard
        case "lineWidth": tagLineWidthCard
        case "borderRadiusSM": tagBorderRadiusSMCard
        case "colorPrimary": tagColorPrimaryCard
        case "colorSuccess": tagColorSuccessCard
        case "colorWarning": tagColorWarningCard
        case "colorError": tagColorErrorCard
        
        default: EmptyView()
        }
    }
}
