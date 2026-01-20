import SwiftUI
import MoinUI

// MARK: - BadgeTokenView

struct BadgeTokenView: View {
    @Localized var tr
    @Environment(\.moinToken) var token
    @ObservedObject var config = Moin.ConfigProvider.shared
    
    // MARK: - Token Sections
    
    private var tokenSections: [DocSidebarSection] {
        [
            DocSidebarSection(
                title: tr("badge.token.component"),
                items: [
                    "indicatorHeight", "indicatorHeightSM",
                    "dotSize", "dotSizeSM",
                    "textFontSize", "textFontSizeSM",
                    "statusSize",
                    "paddingH", "paddingHSM",
                    "shadowRadius"
                ],
                sectionId: "token"
            ),
            DocSidebarSection(
                title: tr("badge.token.global"),
                items: ["colorDanger", "colorSuccess", "colorPrimary", "colorWarning",
                    "colorText", "colorTextSecondary"],
                sectionId: "global"
            )
        ]
    }
    
    var body: some View {
        ComponentDocBody(
            sections: tokenSections,
            initialItemId: "token"
        ) { sectionId in
            if sectionId == "token" {
                Text(tr("badge.token.component"))
                    .font(.title3)
                    .fontWeight(.semibold)
            } else if sectionId == "global" {
                Text(tr("badge.token.global"))
                    .font(.title3)
                    .fontWeight(.semibold)
            }
        } item: { item in
            cardForItem(item)
        }
    }
    
    // MARK: - Item -> Card Mapping
    
    @ViewBuilder
    private func cardForItem(_ item: String) -> some View {
        switch item {
        case "indicatorHeight": badgeIndicatorHeightCard
        case "indicatorHeightSM": badgeIndicatorHeightSMCard
        case "dotSize": badgeDotSizeCard
        case "dotSizeSM": badgeDotSizeSMCard
        case "textFontSize": badgeTextFontSizeCard
        case "textFontSizeSM": badgeTextFontSizeSMCard
        case "statusSize": badgeStatusSizeCard
        case "shadowRadius": badgeShadowRadiusCard
        case "paddingH": badgePaddingHCard
        case "paddingHSM": badgePaddingHSMCard
        
        case "colorDanger": globalColorDangerCard
        case "colorSuccess": globalColorSuccessCard
        case "colorPrimary": globalColorPrimaryCard
        case "colorWarning": globalColorWarningCard
        case "colorText": globalColorTextCard
        case "colorTextSecondary": globalColorTextSecondaryCard
        default: EmptyView()
        }
    }
}
