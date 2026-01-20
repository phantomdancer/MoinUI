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
                title: tr("avatar.token.component"),
                items: [
                    "containerBg", "colorText", "colorTextLight", "groupBorderColor",
                    "size", "sizeLG", "sizeSM",
                    "fontSize", "fontSizeLG", "fontSizeSM",
                    "borderRadius", "borderRadiusLG", "borderRadiusSM",
                    "groupSpacing", "groupBorderWidth"
                ],
                sectionId: "token"
            ),
            DocSidebarSection(
                title: tr("avatar.token.global"),
                items: ["colorTextSecondary", "colorFillTertiary", "controlHeight"],
                sectionId: "global"
            )
        ]
    }
    
    // Reset all tokens to default
    private func resetAll() {
        // Reset global seed to defaults (simplified approach)
        config.seed = Moin.SeedToken()
        config.regenerateTokens()
    }
    
    var body: some View {
        ComponentDocBody(
            sections: tokenSections,
            initialItemId: "token"
        ) { sectionId in
            if sectionId == "token" {
                Text(tr("avatar.token.component"))
                    .font(.title3)
                    .fontWeight(.semibold)
            } else if sectionId == "global" {
                Text(tr("avatar.token.global"))
                    .font(.title3)
                    .fontWeight(.semibold)
            }
        } item: { item in
            cardForItem(item)
        } footer: {
             HStack(spacing: Moin.Constants.Spacing.sm) {
                Moin.Button(tr("playground.token.reset"), color: .custom(.primary), variant: .solid) {
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
        case "containerBg": avatarContainerBgCard
        case "colorText": avatarColorTextCard
        case "colorTextLight": avatarColorTextLightCard
        case "groupBorderColor": avatarGroupBorderColorCard
        case "size": avatarSizeCard
        case "sizeLG": avatarSizeLGCard
        case "sizeSM": avatarSizeSMCard
        case "fontSize": avatarFontSizeCard
        case "fontSizeLG": avatarFontSizeLGCard
        case "fontSizeSM": avatarFontSizeSMCard
        case "borderRadius": avatarBorderRadiusCard
        case "borderRadiusLG": avatarBorderRadiusLGCard
        case "borderRadiusSM": avatarBorderRadiusSMCard
        case "groupSpacing": avatarGroupSpacingCard
        case "groupBorderWidth": avatarGroupBorderWidthCard
        case "colorTextSecondary": globalColorTextSecondaryCard
        case "colorFillTertiary": globalColorFillTertiaryCard
        case "controlHeight": globalControlHeightCard
        default: EmptyView()
        }
    }
}
