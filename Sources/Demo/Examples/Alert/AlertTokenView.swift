import SwiftUI
import MoinUI

struct AlertTokenView: View {
    @Localized var tr
    @Environment(\.moinToken) var token
    @ObservedObject var config = Moin.ConfigProvider.shared
    
    // MARK: - Token Sections
    
    private var tokenSections: [DocSidebarSection] {
        [
            DocSidebarSection(
                title: tr("token.preset"),
                items: [
                    "successBg", "successBorder", "successIcon",
                    "infoBg", "infoBorder", "infoIcon",
                    "warningBg", "warningBorder", "warningIcon",
                    "errorBg", "errorBorder", "errorIcon"
                ],
                sectionId: "token"
            ),
            DocSidebarSection(
                title: tr("token.size"),
                items: [
                    "paddingVertical", "paddingHorizontal", "gap", "titleGap",
                    "iconSize", "fontSize", "titleFontSize"
                ],
                sectionId: "token"
            ),
            DocSidebarSection(
                title: tr("token.border"),
                items: ["borderWidth", "cornerRadius"],
                sectionId: "token"
            )
        ]
    }
    
    // 重置所有 Token 到默认值
    private func resetAll() {
        let defaultAlert = Moin.AlertToken.generate(from: config.token)
        config.components.alert = defaultAlert
        
        // 通知重置
        NotificationCenter.default.post(name: .alertDocReset, object: nil)
    }
    
    var body: some View {
        ComponentDocBody(
            sections: tokenSections,
            initialItemId: "token"
        ) { sectionId in
            if sectionId == "token" {
                Text(tr("doc.section.component_token")).font(.title3).fontWeight(.semibold)
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
    
    @ViewBuilder
    private func cardForItem(_ item: String) -> some View {
        switch item {
        // Colors
        case "successBg": successBgCard
        case "successBorder": successBorderCard
        case "successIcon": successIconCard
        case "infoBg": infoBgCard
        case "infoBorder": infoBorderCard
        case "infoIcon": infoIconCard
        case "warningBg": warningBgCard
        case "warningBorder": warningBorderCard
        case "warningIcon": warningIconCard
        case "errorBg": errorBgCard
        case "errorBorder": errorBorderCard
        case "errorIcon": errorIconCard
        
        // Sizes
        case "paddingVertical": paddingVerticalCard
        case "paddingHorizontal": paddingHorizontalCard
        case "gap": gapCard
        case "titleGap": titleGapCard
        case "iconSize": iconSizeCard
        case "fontSize": fontSizeCard
        case "titleFontSize": titleFontSizeCard
        
        // Border
        case "borderWidth": borderWidthCard
        case "cornerRadius": cornerRadiusCard
        
        default: EmptyView()
        }
    }
    
    // MARK: - Cards
    
    private var successBgCard: some View {
        TokenCard(name: "successBg", type: "Color", defaultValue: "token.colorSuccessBg", description: tr("token.alert.successBg"), sectionId: "token") {
            Moin.Alert(type: .success, title: "Success")
        } editor: {
            ColorPresetRow(label: "successBg", color: Binding(get: { config.components.alert.successBg }, set: { config.components.alert.successBg = $0 }))
        } code: { "config.components.alert.successBg = Color(hex: \"\(config.components.alert.successBg.toHex())\")" }
    }
    
    private var successBorderCard: some View {
        TokenCard(name: "successBorder", type: "Color", defaultValue: "token.colorSuccessBorder", description: tr("token.alert.successBorder"), sectionId: "token") {
            Moin.Alert(type: .success, title: "Success")
        } editor: {
            ColorPresetRow(label: "successBorder", color: Binding(get: { config.components.alert.successBorder }, set: { config.components.alert.successBorder = $0 }))
        } code: { "config.components.alert.successBorder = Color(hex: \"\(config.components.alert.successBorder.toHex())\")" }
    }
    
    private var successIconCard: some View {
        TokenCard(name: "successIcon", type: "Color", defaultValue: "token.colorSuccess", description: tr("token.alert.successIcon"), sectionId: "token") {
            Moin.Alert(type: .success, title: "Success", showIcon: true)
        } editor: {
            ColorPresetRow(label: "successIcon", color: Binding(get: { config.components.alert.successIcon }, set: { config.components.alert.successIcon = $0 }))
        } code: { "config.components.alert.successIcon = Color(hex: \"\(config.components.alert.successIcon.toHex())\")" }
    }
    
    private var infoBgCard: some View {
        TokenCard(name: "infoBg", type: "Color", defaultValue: "token.colorInfoBg", description: tr("token.alert.infoBg"), sectionId: "token") {
            Moin.Alert(type: .info, title: "Info")
        } editor: {
             ColorPresetRow(label: "infoBg", color: Binding(get: { config.components.alert.infoBg }, set: { config.components.alert.infoBg = $0 }))
        } code: { "config.components.alert.infoBg = Color(hex: \"\(config.components.alert.infoBg.toHex())\")" }
    }
    
    private var infoBorderCard: some View {
        TokenCard(name: "infoBorder", type: "Color", defaultValue: "token.colorInfoBorder", description: tr("token.alert.infoBorder"), sectionId: "token") {
            Moin.Alert(type: .info, title: "Info")
        } editor: {
             ColorPresetRow(label: "infoBorder", color: Binding(get: { config.components.alert.infoBorder }, set: { config.components.alert.infoBorder = $0 }))
        } code: { "config.components.alert.infoBorder = Color(hex: \"\(config.components.alert.infoBorder.toHex())\")" }
    }
    
    private var infoIconCard: some View {
        TokenCard(name: "infoIcon", type: "Color", defaultValue: "token.colorInfo", description: tr("token.alert.infoIcon"), sectionId: "token") {
            Moin.Alert(type: .info, title: "Info", showIcon: true)
        } editor: {
             ColorPresetRow(label: "infoIcon", color: Binding(get: { config.components.alert.infoIcon }, set: { config.components.alert.infoIcon = $0 }))
        } code: { "config.components.alert.infoIcon = Color(hex: \"\(config.components.alert.infoIcon.toHex())\")" }
    }
    
    private var warningBgCard: some View {
        TokenCard(name: "warningBg", type: "Color", defaultValue: "token.colorWarningBg", description: tr("token.alert.warningBg"), sectionId: "token") {
            Moin.Alert(type: .warning, title: "Warning")
        } editor: {
             ColorPresetRow(label: "warningBg", color: Binding(get: { config.components.alert.warningBg }, set: { config.components.alert.warningBg = $0 }))
        } code: { "config.components.alert.warningBg = Color(hex: \"\(config.components.alert.warningBg.toHex())\")" }
    }
    
    private var warningBorderCard: some View {
        TokenCard(name: "warningBorder", type: "Color", defaultValue: "token.colorWarningBorder", description: tr("token.alert.warningBorder"), sectionId: "token") {
            Moin.Alert(type: .warning, title: "Warning")
        } editor: {
             ColorPresetRow(label: "warningBorder", color: Binding(get: { config.components.alert.warningBorder }, set: { config.components.alert.warningBorder = $0 }))
        } code: { "config.components.alert.warningBorder = Color(hex: \"\(config.components.alert.warningBorder.toHex())\")" }
    }
    
    private var warningIconCard: some View {
        TokenCard(name: "warningIcon", type: "Color", defaultValue: "token.colorWarning", description: tr("token.alert.warningIcon"), sectionId: "token") {
            Moin.Alert(type: .warning, title: "Warning", showIcon: true)
        } editor: {
             ColorPresetRow(label: "warningIcon", color: Binding(get: { config.components.alert.warningIcon }, set: { config.components.alert.warningIcon = $0 }))
        } code: { "config.components.alert.warningIcon = Color(hex: \"\(config.components.alert.warningIcon.toHex())\")" }
    }
    
    private var errorBgCard: some View {
        TokenCard(name: "errorBg", type: "Color", defaultValue: "token.colorDangerBg", description: tr("token.alert.errorBg"), sectionId: "token") {
            Moin.Alert(type: .error, title: "Error")
        } editor: {
             ColorPresetRow(label: "errorBg", color: Binding(get: { config.components.alert.errorBg }, set: { config.components.alert.errorBg = $0 }))
        } code: { "config.components.alert.errorBg = Color(hex: \"\(config.components.alert.errorBg.toHex())\")" }
    }
    
    private var errorBorderCard: some View {
        TokenCard(name: "errorBorder", type: "Color", defaultValue: "token.colorDangerBorder", description: tr("token.alert.errorBorder"), sectionId: "token") {
            Moin.Alert(type: .error, title: "Error")
        } editor: {
             ColorPresetRow(label: "errorBorder", color: Binding(get: { config.components.alert.errorBorder }, set: { config.components.alert.errorBorder = $0 }))
        } code: { "config.components.alert.errorBorder = Color(hex: \"\(config.components.alert.errorBorder.toHex())\")" }
    }
    
    private var errorIconCard: some View {
        TokenCard(name: "errorIcon", type: "Color", defaultValue: "token.colorDanger", description: tr("token.alert.errorIcon"), sectionId: "token") {
            Moin.Alert(type: .error, title: "Error", showIcon: true)
        } editor: {
             ColorPresetRow(label: "errorIcon", color: Binding(get: { config.components.alert.errorIcon }, set: { config.components.alert.errorIcon = $0 }))
        } code: { "config.components.alert.errorIcon = Color(hex: \"\(config.components.alert.errorIcon.toHex())\")" }
    }
    
    private var paddingVerticalCard: some View {
        TokenCard(name: "paddingVertical", type: "CGFloat", defaultValue: "token.paddingXS", description: tr("token.alert.paddingVertical"), sectionId: "token") {
             Moin.Alert(type: .info, title: "Padding V")
        } editor: {
            TokenValueRow(label: "paddingVertical", value: Binding(get: { config.components.alert.paddingVertical }, set: { config.components.alert.paddingVertical = $0 }), range: 0...48)
        } code: { "config.components.alert.paddingVertical = \(Int(config.components.alert.paddingVertical))" }
    }
    
    private var paddingHorizontalCard: some View {
        TokenCard(name: "paddingHorizontal", type: "CGFloat", defaultValue: "token.padding", description: tr("token.alert.paddingHorizontal"), sectionId: "token") {
             Moin.Alert(type: .info, title: "Padding H")
        } editor: {
            TokenValueRow(label: "paddingHorizontal", value: Binding(get: { config.components.alert.paddingHorizontal }, set: { config.components.alert.paddingHorizontal = $0 }), range: 0...48)
        } code: { "config.components.alert.paddingHorizontal = \(Int(config.components.alert.paddingHorizontal))" }
    }
    
    private var gapCard: some View {
        TokenCard(name: "gap", type: "CGFloat", defaultValue: "token.marginXS", description: tr("token.alert.gap"), sectionId: "token") {
             Moin.Alert(type: .info, title: "Gap Example", showIcon: true)
        } editor: {
            TokenValueRow(label: "gap", value: Binding(get: { config.components.alert.gap }, set: { config.components.alert.gap = $0 }), range: 0...32)
        } code: { "config.components.alert.gap = \(Int(config.components.alert.gap))" }
    }
    
    private var titleGapCard: some View {
        TokenCard(name: "titleGap", type: "CGFloat", defaultValue: "token.marginXXS", description: tr("token.alert.titleGap"), sectionId: "token") {
             Moin.Alert(type: .info, title: "Title", description: "Description")
        } editor: {
            TokenValueRow(label: "titleGap", value: Binding(get: { config.components.alert.titleGap }, set: { config.components.alert.titleGap = $0 }), range: 0...32)
        } code: { "config.components.alert.titleGap = \(Int(config.components.alert.titleGap))" }
    }
    
    private var iconSizeCard: some View {
        TokenCard(name: "iconSize", type: "CGFloat", defaultValue: "16", description: tr("token.alert.iconSize"), sectionId: "token") {
             Moin.Alert(type: .info, title: "Icon Size", showIcon: true)
        } editor: {
            TokenValueRow(label: "iconSize", value: Binding(get: { config.components.alert.iconSize }, set: { config.components.alert.iconSize = $0 }), range: 12...48)
        } code: { "config.components.alert.iconSize = \(Int(config.components.alert.iconSize))" }
    }
    
    private var fontSizeCard: some View {
        TokenCard(name: "fontSize", type: "CGFloat", defaultValue: "token.fontSize", description: tr("token.alert.fontSize"), sectionId: "token") {
             Moin.Alert(type: .info, title: "Title", description: "Description Font Size")
        } editor: {
            TokenValueRow(label: "fontSize", value: Binding(get: { config.components.alert.fontSize }, set: { config.components.alert.fontSize = $0 }), range: 10...24)
        } code: { "config.components.alert.fontSize = \(Int(config.components.alert.fontSize))" }
    }
    
    private var titleFontSizeCard: some View {
        TokenCard(name: "titleFontSize", type: "CGFloat", defaultValue: "token.fontSizeLG", description: tr("token.alert.titleFontSize"), sectionId: "token") {
             Moin.Alert(type: .info, title: "Title Font Size")
        } editor: {
            TokenValueRow(label: "titleFontSize", value: Binding(get: { config.components.alert.titleFontSize }, set: { config.components.alert.titleFontSize = $0 }), range: 12...32)
        } code: { "config.components.alert.titleFontSize = \(Int(config.components.alert.titleFontSize))" }
    }
    
    private var borderWidthCard: some View {
        TokenCard(name: "borderWidth", type: "CGFloat", defaultValue: "1", description: tr("token.alert.borderWidth"), sectionId: "token") {
             Moin.Alert(type: .info, title: "Border Width")
        } editor: {
            TokenValueRow(label: "borderWidth", value: Binding(get: { config.components.alert.borderWidth }, set: { config.components.alert.borderWidth = $0 }), range: 0...10)
        } code: { "config.components.alert.borderWidth = \(Int(config.components.alert.borderWidth))" }
    }
    
    private var cornerRadiusCard: some View {
        TokenCard(name: "cornerRadius", type: "CGFloat", defaultValue: "token.borderRadius", description: tr("token.alert.cornerRadius"), sectionId: "token") {
             Moin.Alert(type: .info, title: "Corner Radius")
        } editor: {
            TokenValueRow(label: "cornerRadius", value: Binding(get: { config.components.alert.cornerRadius }, set: { config.components.alert.cornerRadius = $0 }), range: 0...32)
        } code: { "config.components.alert.cornerRadius = \(Int(config.components.alert.cornerRadius))" }
    }
}
