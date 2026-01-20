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
    
    // 重置所有 Badge Token 到默认值
    private func resetAll() {
        // 重置全局 seed token
        config.seed.colorError = Moin.Colors.red
        config.seed.colorSuccess = Moin.Colors.green
        config.seed.colorPrimary = Moin.Colors.blue
        config.seed.colorWarning = Moin.Colors.gold
        config.seed.colorTextBase = Color(white: 0.0)
        config.regenerateTokens()
        
        // 重置组件 token
        let defaultBadge = Moin.BadgeToken.generate(from: config.token)
        config.components.badge = defaultBadge
        
        // 通知重置
        NotificationCenter.default.post(name: .badgeDocReset, object: nil)
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
