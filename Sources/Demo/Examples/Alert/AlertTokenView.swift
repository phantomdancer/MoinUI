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
                    "defaultPadding", "withDescriptionPadding", "withDescriptionIconSize",
                    "gap", "titleGap",
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
        case "colorSuccessBg": successBgCard
        case "colorSuccessBorder": successBorderCard
        case "colorSuccess": successIconCard
        case "colorInfoBg": infoBgCard
        case "colorInfoBorder": infoBorderCard
        case "colorInfo": infoIconCard
        case "colorWarningBg": warningBgCard
        case "colorWarningBorder": warningBorderCard
        case "colorWarning": warningIconCard
        case "colorErrorBg": errorBgCard
        case "colorErrorBorder": errorBorderCard
        case "colorError": errorIconCard
        
        // Sizes
        case "defaultPadding": defaultPaddingCard
        case "withDescriptionPadding": withDescriptionPaddingCard
        case "withDescriptionIconSize": withDescriptionIconSizeCard
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
        TokenCard(name: "colorSuccessBg", type: "Color", defaultValue: "token.colorSuccessBg", description: tr("token.alert.colorSuccessBg"), sectionId: "token") {
            Moin.Alert(type: .success, title: tr("alert.demo.token_demo.success"))
        } editor: {
            ColorPresetRow(label: "colorSuccessBg", color: Binding(get: { config.components.alert.colorSuccessBg }, set: { config.components.alert.colorSuccessBg = $0 }))
        } code: { "config.components.alert.colorSuccessBg = Color(hex: \"\(config.components.alert.colorSuccessBg.toHex())\")" }
    }
    
    private var successBorderCard: some View {
        TokenCard(name: "colorSuccessBorder", type: "Color", defaultValue: "token.colorSuccessBorder", description: tr("token.alert.colorSuccessBorder"), sectionId: "token") {
            Moin.Alert(type: .success, title: tr("alert.demo.token_demo.success"))
        } editor: {
            ColorPresetRow(label: "colorSuccessBorder", color: Binding(get: { config.components.alert.colorSuccessBorder }, set: { config.components.alert.colorSuccessBorder = $0 }))
        } code: { "config.components.alert.colorSuccessBorder = Color(hex: \"\(config.components.alert.colorSuccessBorder.toHex())\")" }
    }
    
    private var successIconCard: some View {
        TokenCard(name: "colorSuccess", type: "Color", defaultValue: "token.colorSuccess", description: tr("token.alert.colorSuccess"), sectionId: "token") {
            Moin.Alert(type: .success, title: tr("alert.demo.token_demo.success"), showIcon: true)
        } editor: {
            ColorPresetRow(label: "colorSuccess", color: Binding(get: { config.components.alert.colorSuccess }, set: { config.components.alert.colorSuccess = $0 }))
        } code: { "config.components.alert.colorSuccess = Color(hex: \"\(config.components.alert.colorSuccess.toHex())\")" }
    }
    
    private var infoBgCard: some View {
        TokenCard(name: "colorInfoBg", type: "Color", defaultValue: "token.colorInfoBg", description: tr("token.alert.colorInfoBg"), sectionId: "token") {
            Moin.Alert(type: .info, title: tr("alert.demo.token_demo.info"))
        } editor: {
             ColorPresetRow(label: "colorInfoBg", color: Binding(get: { config.components.alert.colorInfoBg }, set: { config.components.alert.colorInfoBg = $0 }))
        } code: { "config.components.alert.colorInfoBg = Color(hex: \"\(config.components.alert.colorInfoBg.toHex())\")" }
    }
    
    private var infoBorderCard: some View {
        TokenCard(name: "colorInfoBorder", type: "Color", defaultValue: "token.colorInfoBorder", description: tr("token.alert.colorInfoBorder"), sectionId: "token") {
            Moin.Alert(type: .info, title: tr("alert.demo.token_demo.info"))
        } editor: {
             ColorPresetRow(label: "colorInfoBorder", color: Binding(get: { config.components.alert.colorInfoBorder }, set: { config.components.alert.colorInfoBorder = $0 }))
        } code: { "config.components.alert.colorInfoBorder = Color(hex: \"\(config.components.alert.colorInfoBorder.toHex())\")" }
    }
    
    private var infoIconCard: some View {
        TokenCard(name: "colorInfo", type: "Color", defaultValue: "token.colorInfo", description: tr("token.alert.colorInfo"), sectionId: "token") {
            Moin.Alert(type: .info, title: tr("alert.demo.token_demo.info"), showIcon: true)
        } editor: {
             ColorPresetRow(label: "colorInfo", color: Binding(get: { config.components.alert.colorInfo }, set: { config.components.alert.colorInfo = $0 }))
        } code: { "config.components.alert.colorInfo = Color(hex: \"\(config.components.alert.colorInfo.toHex())\")" }
    }
    
    private var warningBgCard: some View {
        TokenCard(name: "colorWarningBg", type: "Color", defaultValue: "token.colorWarningBg", description: tr("token.alert.colorWarningBg"), sectionId: "token") {
            Moin.Alert(type: .warning, title: tr("alert.demo.token_demo.warning"))
        } editor: {
             ColorPresetRow(label: "colorWarningBg", color: Binding(get: { config.components.alert.colorWarningBg }, set: { config.components.alert.colorWarningBg = $0 }))
        } code: { "config.components.alert.colorWarningBg = Color(hex: \"\(config.components.alert.colorWarningBg.toHex())\")" }
    }
    
    private var warningBorderCard: some View {
        TokenCard(name: "colorWarningBorder", type: "Color", defaultValue: "token.colorWarningBorder", description: tr("token.alert.colorWarningBorder"), sectionId: "token") {
            Moin.Alert(type: .warning, title: tr("alert.demo.token_demo.warning"))
        } editor: {
             ColorPresetRow(label: "colorWarningBorder", color: Binding(get: { config.components.alert.colorWarningBorder }, set: { config.components.alert.colorWarningBorder = $0 }))
        } code: { "config.components.alert.colorWarningBorder = Color(hex: \"\(config.components.alert.colorWarningBorder.toHex())\")" }
    }
    
    private var warningIconCard: some View {
        TokenCard(name: "colorWarning", type: "Color", defaultValue: "token.colorWarning", description: tr("token.alert.colorWarning"), sectionId: "token") {
            Moin.Alert(type: .warning, title: tr("alert.demo.token_demo.warning"), showIcon: true)
        } editor: {
             ColorPresetRow(label: "colorWarning", color: Binding(get: { config.components.alert.colorWarning }, set: { config.components.alert.colorWarning = $0 }))
        } code: { "config.components.alert.colorWarning = Color(hex: \"\(config.components.alert.colorWarning.toHex())\")" }
    }
    
    private var errorBgCard: some View {
        TokenCard(name: "colorErrorBg", type: "Color", defaultValue: "token.colorDangerBg", description: tr("token.alert.colorErrorBg"), sectionId: "token") {
            Moin.Alert(type: .error, title: tr("alert.demo.token_demo.error"))
        } editor: {
             ColorPresetRow(label: "colorErrorBg", color: Binding(get: { config.components.alert.colorErrorBg }, set: { config.components.alert.colorErrorBg = $0 }))
        } code: { "config.components.alert.colorErrorBg = Color(hex: \"\(config.components.alert.colorErrorBg.toHex())\")" }
    }
    
    private var errorBorderCard: some View {
        TokenCard(name: "colorErrorBorder", type: "Color", defaultValue: "token.colorDangerBorder", description: tr("token.alert.colorErrorBorder"), sectionId: "token") {
            Moin.Alert(type: .error, title: tr("alert.demo.token_demo.error"))
        } editor: {
             ColorPresetRow(label: "colorErrorBorder", color: Binding(get: { config.components.alert.colorErrorBorder }, set: { config.components.alert.colorErrorBorder = $0 }))
        } code: { "config.components.alert.colorErrorBorder = Color(hex: \"\(config.components.alert.colorErrorBorder.toHex())\")" }
    }
    
    private var errorIconCard: some View {
        TokenCard(name: "colorError", type: "Color", defaultValue: "token.colorDanger", description: tr("token.alert.colorError"), sectionId: "token") {
            Moin.Alert(type: .error, title: tr("alert.demo.token_demo.error"), showIcon: true)
        } editor: {
             ColorPresetRow(label: "colorError", color: Binding(get: { config.components.alert.colorError }, set: { config.components.alert.colorError = $0 }))
        } code: { "config.components.alert.colorError = Color(hex: \"\(config.components.alert.colorError.toHex())\")" }
    }
    
    private var defaultPaddingCard: some View {
        TokenCard(name: "defaultPadding", type: "EdgeInsets", defaultValue: "8px 12px", description: tr("token.alert.defaultPadding"), sectionId: "token") {
             Moin.Alert(type: .info, title: tr("alert.demo.token_demo.defaultPadding"))
        } editor: {
            VStack {
                TokenValueRow(label: "Vertical", value: Binding(get: { config.components.alert.defaultPadding.top }, set: { 
                    var p = config.components.alert.defaultPadding
                    p.top = $0; p.bottom = $0
                    config.components.alert.defaultPadding = p
                }), range: 0...48)
                TokenValueRow(label: "Horizontal", value: Binding(get: { config.components.alert.defaultPadding.leading }, set: { 
                    var p = config.components.alert.defaultPadding
                    p.leading = $0; p.trailing = $0
                    config.components.alert.defaultPadding = p
                }), range: 0...48)
            }
        } code: { "config.components.alert.defaultPadding = EdgeInsets(...)" }
    }
    
    private var withDescriptionPaddingCard: some View {
        TokenCard(name: "withDescriptionPadding", type: "EdgeInsets", defaultValue: "20px 24px", description: tr("token.alert.withDescriptionPadding"), sectionId: "token") {
             Moin.Alert(type: .info, title: tr("alert.demo.token_demo.title"), description: tr("alert.demo.token_demo.description"))
        } editor: {
            VStack {
                TokenValueRow(label: "Vertical", value: Binding(get: { config.components.alert.withDescriptionPadding.top }, set: { 
                    var p = config.components.alert.withDescriptionPadding
                    p.top = $0; p.bottom = $0
                    config.components.alert.withDescriptionPadding = p
                }), range: 0...48)
                TokenValueRow(label: "Horizontal", value: Binding(get: { config.components.alert.withDescriptionPadding.leading }, set: { 
                    var p = config.components.alert.withDescriptionPadding
                    p.leading = $0; p.trailing = $0
                    config.components.alert.withDescriptionPadding = p
                }), range: 0...48)
            }
        } code: { "config.components.alert.withDescriptionPadding = EdgeInsets(...)" }
    }
    private var withDescriptionIconSizeCard: some View {
        TokenCard(name: "withDescriptionIconSize", type: "CGFloat", defaultValue: "24", description: tr("token.alert.withDescriptionIconSize"), sectionId: "token") {
             Moin.Alert(type: .info, title: tr("alert.demo.token_demo.title"), description: tr("alert.demo.token_demo.description"), showIcon: true)
        } editor: {
            TokenValueRow(label: "Icon Size", value: Binding(get: { config.components.alert.withDescriptionIconSize }, set: { config.components.alert.withDescriptionIconSize = $0 }), range: 12...48)
        } code: { "config.components.alert.withDescriptionIconSize = \(Int(config.components.alert.withDescriptionIconSize))" }
    }
    private var gapCard: some View {
        TokenCard(name: "gap", type: "CGFloat", defaultValue: "token.marginXS", description: tr("token.alert.gap"), sectionId: "token") {
             Moin.Alert(type: .info, title: tr("alert.demo.token_demo.gap"), showIcon: true)
        } editor: {
            TokenValueRow(label: "gap", value: Binding(get: { config.components.alert.gap }, set: { config.components.alert.gap = $0 }), range: 0...32)
        } code: { "config.components.alert.gap = \(Int(config.components.alert.gap))" }
    }
    
    private var titleGapCard: some View {
        TokenCard(name: "titleGap", type: "CGFloat", defaultValue: "token.marginXXS", description: tr("token.alert.titleGap"), sectionId: "token") {
             Moin.Alert(type: .info, title: tr("alert.demo.token_demo.title"), description: tr("alert.demo.token_demo.description"))
        } editor: {
            TokenValueRow(label: "titleGap", value: Binding(get: { config.components.alert.titleGap }, set: { config.components.alert.titleGap = $0 }), range: 0...32)
        } code: { "config.components.alert.titleGap = \(Int(config.components.alert.titleGap))" }
    }
    
    private var iconSizeCard: some View {
        TokenCard(name: "iconSize", type: "CGFloat", defaultValue: "16", description: tr("token.alert.iconSize"), sectionId: "token") {
             Moin.Alert(type: .info, title: tr("alert.demo.token_demo.icon_size"), showIcon: true)
        } editor: {
            TokenValueRow(label: "iconSize", value: Binding(get: { config.components.alert.iconSize }, set: { config.components.alert.iconSize = $0 }), range: 12...48)
        } code: { "config.components.alert.iconSize = \(Int(config.components.alert.iconSize))" }
    }
    
    private var fontSizeCard: some View {
        TokenCard(name: "fontSize", type: "CGFloat", defaultValue: "token.fontSize", description: tr("token.alert.fontSize"), sectionId: "token") {
             Moin.Alert(type: .info, title: tr("alert.demo.token_demo.title"), description: tr("alert.demo.token_demo.font_size"))
        } editor: {
            TokenValueRow(label: "fontSize", value: Binding(get: { config.components.alert.fontSize }, set: { config.components.alert.fontSize = $0 }), range: 10...24)
        } code: { "config.components.alert.fontSize = \(Int(config.components.alert.fontSize))" }
    }
    
    private var titleFontSizeCard: some View {
        TokenCard(name: "titleFontSize", type: "CGFloat", defaultValue: "token.fontSizeLG", description: tr("token.alert.titleFontSize"), sectionId: "token") {
             Moin.Alert(type: .info, title: tr("alert.demo.token_demo.title_font_size"))
        } editor: {
            TokenValueRow(label: "titleFontSize", value: Binding(get: { config.components.alert.titleFontSize }, set: { config.components.alert.titleFontSize = $0 }), range: 12...32)
        } code: { "config.components.alert.titleFontSize = \(Int(config.components.alert.titleFontSize))" }
    }
    
    private var borderWidthCard: some View {
        TokenCard(name: "borderWidth", type: "CGFloat", defaultValue: "1", description: tr("token.alert.borderWidth"), sectionId: "token") {
             Moin.Alert(type: .info, title: tr("alert.demo.token_demo.border_width"))
        } editor: {
            TokenValueRow(label: "borderWidth", value: Binding(get: { config.components.alert.borderWidth }, set: { config.components.alert.borderWidth = $0 }), range: 0...10)
        } code: { "config.components.alert.borderWidth = \(Int(config.components.alert.borderWidth))" }
    }
    
    private var cornerRadiusCard: some View {
        TokenCard(name: "cornerRadius", type: "CGFloat", defaultValue: "token.borderRadius", description: tr("token.alert.cornerRadius"), sectionId: "token") {
             Moin.Alert(type: .info, title: tr("alert.demo.token_demo.corner_radius"))
        } editor: {
            TokenValueRow(label: "cornerRadius", value: Binding(get: { config.components.alert.cornerRadius }, set: { config.components.alert.cornerRadius = $0 }), range: 0...32)
        } code: { "config.components.alert.cornerRadius = \(Int(config.components.alert.cornerRadius))" }
    }
}
