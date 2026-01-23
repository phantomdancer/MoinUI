import SwiftUI
import MoinUI

// MARK: - AvatarTokenView

struct AvatarTokenView: View {
    @Localized var tr
    @Environment(\.moinToken) var token
    @ObservedObject var config = Moin.ConfigProvider.shared
    
    // MARK: - Token Sections
    
    private var tokenSections: [DocSidebarSection] {
        [
            DocSidebarSection(
                title: tr("doc.section.component_token"),
                items: [
                    "size", "sizeLG", "sizeSM",
                    "fontSize", "fontSizeLG", "fontSizeSM",
                    "groupSpacing", "groupBorderColor"
                ],
                sectionId: "component"
            ),
            DocSidebarSection(
                title: tr("doc.section.global_token"),
                items: [
                    "containerBg", "colorText", "colorTextLight",
                    "borderRadius", "borderRadiusLG", "borderRadiusSM",
                    "groupBorderWidth" // Mapped to lineWidth
                ],
                sectionId: "global"
            )
        ]
    }
    
    // Reset all tokens to default
    private func resetAll() {
        // Reset global
        config.seed = Moin.SeedToken.default
        config.regenerateTokens()
        
        // Reset component
        config.components.avatar = .generate(from: config.token)
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
        // Component
        case "size": avatarSizeCard
        case "sizeLG": avatarSizeLGCard
        case "sizeSM": avatarSizeSMCard
        case "fontSize": avatarFontSizeCard
        case "fontSizeLG": avatarFontSizeLGCard
        case "fontSizeSM": avatarFontSizeSMCard
        case "groupSpacing": avatarGroupSpacingCard
        case "groupBorderColor": avatarGroupBorderColorCard
        
        // Global
        case "containerBg": avatarContainerBgCard
        case "colorText": avatarColorTextCard
        case "colorTextLight": avatarColorTextLightCard
        case "borderRadius": avatarBorderRadiusCard
        case "borderRadiusLG": avatarBorderRadiusLGCard
        case "borderRadiusSM": avatarBorderRadiusSMCard
        case "groupBorderWidth": avatarGroupBorderWidthCard
        
        default: EmptyView()
        }
    }
}
