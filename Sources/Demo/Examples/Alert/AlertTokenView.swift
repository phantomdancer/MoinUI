import SwiftUI
import MoinUI

struct AlertTokenView: View {
    @Localized var tr
    @Environment(\.moinToken) var token
    @ObservedObject var config = Moin.ConfigProvider.shared
    
    // MARK: - Token Sections (与 Ant Design 一致)
    
    private var tokenSections: [DocSidebarSection] {
        [
            // 组件 Token（仅3项）
            DocSidebarSection(
                title: tr("doc.section.component_token"),
                items: [
                    "defaultPadding", "withDescriptionIconSize", "withDescriptionPadding"
                ],
                sectionId: "component"
            ),
            // 全局 Token（其余全部）
            DocSidebarSection(
                title: tr("doc.section.global_token"),
                items: [
                    "colorError", "colorErrorBg", "colorErrorBorder",
                    "colorIcon", "colorIconHover",
                    "colorInfo", "colorInfoBg", "colorInfoBorder",
                    "colorSuccess", "colorSuccessBg", "colorSuccessBorder",
                    "colorText", "colorTextHeading",
                    "colorWarning", "colorWarningBg", "colorWarningBorder",
                    "borderRadiusLG", "fontSize", "fontSizeIcon", "fontSizeLG",
                    "lineHeight", "lineWidth",
                    "marginSM", "marginXS"
                ],
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
        let defaultAlert = Moin.AlertToken.generate(from: config.token)
        config.components.alert = defaultAlert
        
        NotificationCenter.default.post(name: .alertDocReset, object: nil)
    }
    
    var body: some View {
        ComponentDocBody(
            sections: tokenSections,
            initialItemId: "component"
        ) { sectionId in
            if sectionId == "component" {
                Text(tr("doc.section.component_token")).font(.title3).fontWeight(.semibold)
            } else if sectionId == "global" {
                Text(tr("doc.section.global_token")).font(.title3).fontWeight(.semibold)
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
        // Component Token
        case "defaultPadding": defaultPaddingCard
        case "withDescriptionIconSize": withDescriptionIconSizeCard
        case "withDescriptionPadding": withDescriptionPaddingCard
        
        // Global Token - Colors
        case "colorError": colorErrorCard
        case "colorErrorBg": colorErrorBgCard
        case "colorErrorBorder": colorErrorBorderCard
        case "colorIcon": colorIconCard
        case "colorIconHover": colorIconHoverCard
        case "colorInfo": colorInfoCard
        case "colorInfoBg": colorInfoBgCard
        case "colorInfoBorder": colorInfoBorderCard
        case "colorSuccess": colorSuccessCard
        case "colorSuccessBg": colorSuccessBgCard
        case "colorSuccessBorder": colorSuccessBorderCard
        case "colorText": colorTextCard
        case "colorTextHeading": colorTextHeadingCard
        case "colorWarning": colorWarningCard
        case "colorWarningBg": colorWarningBgCard
        case "colorWarningBorder": colorWarningBorderCard
        
        // Global Token - Size
        case "borderRadiusLG": borderRadiusLGCard
        case "fontSize": fontSizeCard
        case "fontSizeIcon": fontSizeIconCard
        case "fontSizeLG": fontSizeLGCard
        case "lineHeight": lineHeightCard
        case "lineWidth": lineWidthCard
        case "marginSM": marginSMCard
        case "marginXS": marginXSCard
        
        default: EmptyView()
        }
    }
    
    // MARK: - Component Token Cards
    
    private var defaultPaddingCard: some View {
        TokenCard(name: "defaultPadding", type: "EdgeInsets", defaultValue: "8px 12px", description: tr("token.alert.defaultPadding"), sectionId: "component") {
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
    
    private var withDescriptionIconSizeCard: some View {
        TokenCard(name: "withDescriptionIconSize", type: "number", defaultValue: "24", description: tr("token.alert.withDescriptionIconSize"), sectionId: "component") {
             Moin.Alert(type: .info, title: tr("alert.demo.token_demo.title"), description: tr("alert.demo.token_demo.description"), showIcon: true)
        } editor: {
            TokenValueRow(label: "Size", value: Binding(get: { config.components.alert.withDescriptionIconSize }, set: { config.components.alert.withDescriptionIconSize = $0 }), range: 12...48)
        } code: { "config.components.alert.withDescriptionIconSize = \(Int(config.components.alert.withDescriptionIconSize))" }
    }
    
    private var withDescriptionPaddingCard: some View {
        TokenCard(name: "withDescriptionPadding", type: "EdgeInsets", defaultValue: "20px 24px", description: tr("token.alert.withDescriptionPadding"), sectionId: "component") {
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
    
    // MARK: - Global Token Cards - Status Colors (可编辑 seed Token)
    
    private var colorSuccessCard: some View {
        TokenCard(name: "colorSuccess", type: "string", defaultValue: "#52c41a", description: tr("token.alert.colorSuccess"), sectionId: "global") {
            Moin.Alert(type: .success, title: tr("alert.demo.token_demo.success"), showIcon: true)
        } editor: {
            ColorPresetRow(label: "seed.colorSuccess", color: $config.seed.colorSuccess, onChange: { config.regenerateTokens() })
        } code: { "config.seed.colorSuccess = Color(...)" }
    }
    
    private var colorSuccessBgCard: some View {
        TokenCard(name: "colorSuccessBg", type: "string", defaultValue: "#f6ffed", description: tr("token.alert.colorSuccessBg"), sectionId: "global") {
            Moin.Alert(type: .success, title: tr("alert.demo.token_demo.success"))
        } editor: {
            ColorPresetRow(label: "seed.colorSuccess", color: $config.seed.colorSuccess, onChange: { config.regenerateTokens() })
        } code: { "// \(tr("api.derived_from")) seed.colorSuccess" }
    }
    
    private var colorSuccessBorderCard: some View {
        TokenCard(name: "colorSuccessBorder", type: "string", defaultValue: "#b7eb8f", description: tr("token.alert.colorSuccessBorder"), sectionId: "global") {
            Moin.Alert(type: .success, title: tr("alert.demo.token_demo.success"))
        } editor: {
            ColorPresetRow(label: "seed.colorSuccess", color: $config.seed.colorSuccess, onChange: { config.regenerateTokens() })
        } code: { "// \(tr("api.derived_from")) seed.colorSuccess" }
    }
    
    private var colorInfoCard: some View {
        TokenCard(name: "colorInfo", type: "string", defaultValue: "#1677ff", description: tr("token.alert.colorInfo"), sectionId: "global") {
            Moin.Alert(type: .info, title: tr("alert.demo.token_demo.info"), showIcon: true)
        } editor: {
            ColorPresetRow(label: "seed.colorInfo", color: $config.seed.colorInfo, onChange: { config.regenerateTokens() })
        } code: { "config.seed.colorInfo = Color(...)" }
    }
    
    private var colorInfoBgCard: some View {
        TokenCard(name: "colorInfoBg", type: "string", defaultValue: "#e6f4ff", description: tr("token.alert.colorInfoBg"), sectionId: "global") {
            Moin.Alert(type: .info, title: tr("alert.demo.token_demo.info"))
        } editor: {
            ColorPresetRow(label: "seed.colorInfo", color: $config.seed.colorInfo, onChange: { config.regenerateTokens() })
        } code: { "// \(tr("api.derived_from")) seed.colorInfo" }
    }
    
    private var colorInfoBorderCard: some View {
        TokenCard(name: "colorInfoBorder", type: "string", defaultValue: "#91caff", description: tr("token.alert.colorInfoBorder"), sectionId: "global") {
            Moin.Alert(type: .info, title: tr("alert.demo.token_demo.info"))
        } editor: {
            ColorPresetRow(label: "seed.colorInfo", color: $config.seed.colorInfo, onChange: { config.regenerateTokens() })
        } code: { "// \(tr("api.derived_from")) seed.colorInfo" }
    }
    
    private var colorWarningCard: some View {
        TokenCard(name: "colorWarning", type: "string", defaultValue: "#faad14", description: tr("token.alert.colorWarning"), sectionId: "global") {
            Moin.Alert(type: .warning, title: tr("alert.demo.token_demo.warning"), showIcon: true)
        } editor: {
            ColorPresetRow(label: "seed.colorWarning", color: $config.seed.colorWarning, onChange: { config.regenerateTokens() })
        } code: { "config.seed.colorWarning = Color(...)" }
    }
    
    private var colorWarningBgCard: some View {
        TokenCard(name: "colorWarningBg", type: "string", defaultValue: "#fffbe6", description: tr("token.alert.colorWarningBg"), sectionId: "global") {
            Moin.Alert(type: .warning, title: tr("alert.demo.token_demo.warning"))
        } editor: {
            ColorPresetRow(label: "seed.colorWarning", color: $config.seed.colorWarning, onChange: { config.regenerateTokens() })
        } code: { "// \(tr("api.derived_from")) seed.colorWarning" }
    }
    
    private var colorWarningBorderCard: some View {
        TokenCard(name: "colorWarningBorder", type: "string", defaultValue: "#ffe58f", description: tr("token.alert.colorWarningBorder"), sectionId: "global") {
            Moin.Alert(type: .warning, title: tr("alert.demo.token_demo.warning"))
        } editor: {
            ColorPresetRow(label: "seed.colorWarning", color: $config.seed.colorWarning, onChange: { config.regenerateTokens() })
        } code: { "// \(tr("api.derived_from")) seed.colorWarning" }
    }
    
    private var colorErrorCard: some View {
        TokenCard(name: "colorError", type: "string", defaultValue: "#ff4d4f", description: tr("token.alert.colorError"), sectionId: "global") {
            Moin.Alert(type: .error, title: tr("alert.demo.token_demo.error"), showIcon: true)
        } editor: {
            ColorPresetRow(label: "seed.colorError", color: $config.seed.colorError, onChange: { config.regenerateTokens() })
        } code: { "config.seed.colorError = Color(...)" }
    }
    
    private var colorErrorBgCard: some View {
        TokenCard(name: "colorErrorBg", type: "string", defaultValue: "#fff2f0", description: tr("token.alert.colorErrorBg"), sectionId: "global") {
            Moin.Alert(type: .error, title: tr("alert.demo.token_demo.error"))
        } editor: {
            ColorPresetRow(label: "seed.colorError", color: $config.seed.colorError, onChange: { config.regenerateTokens() })
        } code: { "// \(tr("api.derived_from")) seed.colorError" }
    }
    
    private var colorErrorBorderCard: some View {
        TokenCard(name: "colorErrorBorder", type: "string", defaultValue: "#ffccc7", description: tr("token.alert.colorErrorBorder"), sectionId: "global") {
            Moin.Alert(type: .error, title: tr("alert.demo.token_demo.error"))
        } editor: {
            ColorPresetRow(label: "seed.colorError", color: $config.seed.colorError, onChange: { config.regenerateTokens() })
        } code: { "// \(tr("api.derived_from")) seed.colorError" }
    }
    
    // MARK: - Global Token Cards - Text Colors
    
    private var colorTextCard: some View {
        TokenCard(name: "colorText", type: "string", defaultValue: "rgba(0,0,0,0.88)", description: tr("token.alert.colorText"), sectionId: "global") {
            Moin.Alert(type: .info, title: tr("alert.demo.token_demo.title"), description: tr("alert.demo.token_demo.description"))
        } code: { "// \(tr("api.derived_from")) seed.colorTextBase" }
    }
    
    private var colorTextHeadingCard: some View {
        TokenCard(name: "colorTextHeading", type: "string", defaultValue: "rgba(0,0,0,0.88)", description: tr("token.alert.colorTextHeading"), sectionId: "global") {
            Moin.Alert(type: .info, title: tr("alert.demo.token_demo.title"))
        } code: { "// \(tr("api.derived_from")) colorText" }
    }
    
    private var colorIconCard: some View {
        TokenCard(name: "colorIcon", type: "string", defaultValue: "rgba(0,0,0,0.45)", description: tr("token.alert.colorIcon"), sectionId: "global") {
            Moin.Alert(type: .info, title: tr("alert.demo.token_demo.closable"), showIcon: true, closable: true)
        } code: { "// \(tr("api.derived_from")) colorTextTertiary" }
    }
    
    private var colorIconHoverCard: some View {
        TokenCard(name: "colorIconHover", type: "string", defaultValue: "rgba(0,0,0,0.88)", description: tr("token.alert.colorIconHover"), sectionId: "global") {
            Moin.Alert(type: .info, title: tr("alert.demo.token_demo.closable"), showIcon: true, closable: true)
        } code: { "// \(tr("api.derived_from")) colorText" }
    }
    
    // MARK: - Global Token Cards - Size (可编辑 seed Token)
    
    private var borderRadiusLGCard: some View {
        TokenCard(name: "borderRadiusLG", type: "number", defaultValue: "8", description: tr("token.alert.borderRadiusLG"), sectionId: "global") {
            HStack(spacing: Moin.Constants.Spacing.md) {
                Moin.Alert(type: .info, title: tr("alert.demo.token_demo.corner_radius"))
                Text("borderRadiusLG: \(Int(config.token.borderRadiusLG))px")
                    .font(.system(size: 11, design: .monospaced))
                    .foregroundStyle(.secondary)
            }
        } editor: {
            TokenValueRow(label: "seed.borderRadius", value: $config.seed.borderRadius, range: 0...20, onChange: { config.regenerateTokens() })
        } code: { "// \(tr("api.derived_from")) seed.borderRadius + 2" }
    }
    
    private var fontSizeCard: some View {
        TokenCard(name: "fontSize", type: "number", defaultValue: "14", description: tr("token.alert.fontSize"), sectionId: "global") {
            HStack(spacing: Moin.Constants.Spacing.md) {
                Moin.Alert(type: .info, title: tr("alert.demo.token_demo.title"), description: tr("alert.demo.token_demo.font_size"))
                Text("fontSize: \(Int(config.token.fontSize))px")
                    .font(.system(size: 11, design: .monospaced))
                    .foregroundStyle(.secondary)
            }
        } editor: {
            TokenValueRow(label: "seed.fontSize", value: $config.seed.fontSize, range: 10...24, onChange: { config.regenerateTokens() })
        } code: { "config.seed.fontSize = \(Int(config.seed.fontSize))" }
    }
    
    private var fontSizeIconCard: some View {
        TokenCard(name: "fontSizeIcon", type: "number", defaultValue: "12", description: tr("token.alert.fontSizeIcon"), sectionId: "global") {
            HStack(spacing: Moin.Constants.Spacing.md) {
                Moin.Alert(type: .info, title: tr("alert.demo.token_demo.closable"), closable: true)
                Text("fontSizeIcon: \(Int(config.token.fontSizeSM))px")
                    .font(.system(size: 11, design: .monospaced))
                    .foregroundStyle(.secondary)
            }
        } editor: {
            TokenValueRow(label: "seed.fontSize", value: $config.seed.fontSize, range: 10...24, onChange: { config.regenerateTokens() })
        } code: { "// \(tr("api.derived_from")) fontSizeSM (seed.fontSize - 2)" }
    }
    
    private var fontSizeLGCard: some View {
        TokenCard(name: "fontSizeLG", type: "number", defaultValue: "16", description: tr("token.alert.fontSizeLG"), sectionId: "global") {
            HStack(spacing: Moin.Constants.Spacing.md) {
                Moin.Alert(type: .info, title: tr("alert.demo.token_demo.title_font_size"), description: tr("alert.demo.token_demo.description"))
                Text("fontSizeLG: \(Int(config.token.fontSizeLG))px")
                    .font(.system(size: 11, design: .monospaced))
                    .foregroundStyle(.secondary)
            }
        } editor: {
            TokenValueRow(label: "seed.fontSize", value: $config.seed.fontSize, range: 10...24, onChange: { config.regenerateTokens() })
        } code: { "// \(tr("api.derived_from")) seed.fontSize + 2" }
    }
    
    private var lineHeightCard: some View {
        TokenCard(name: "lineHeight", type: "number", defaultValue: "1.5714", description: tr("token.alert.lineHeight"), sectionId: "global") {
            Moin.Alert(type: .info, title: tr("alert.demo.token_demo.title"), description: tr("alert.demo.token_demo.description"))
        } code: { "// \(tr("api.derived_from")) fontSize * 1.5714" }
    }
    
    private var lineWidthCard: some View {
        TokenCard(name: "lineWidth", type: "number", defaultValue: "1", description: tr("token.alert.lineWidth"), sectionId: "global") {
            HStack(spacing: Moin.Constants.Spacing.md) {
                Moin.Alert(type: .info, title: tr("alert.demo.token_demo.border_width"))
                Text("lineWidth: \(Int(config.token.lineWidth))px")
                    .font(.system(size: 11, design: .monospaced))
                    .foregroundStyle(.secondary)
            }
        } editor: {
            TokenValueRow(label: "seed.lineWidth", value: $config.seed.lineWidth, range: 0...10, onChange: { config.regenerateTokens() })
        } code: { "config.seed.lineWidth = \(Int(config.seed.lineWidth))" }
    }
    
    private var marginSMCard: some View {
        TokenCard(name: "marginSM", type: "number", defaultValue: "12", description: tr("token.alert.marginSM"), sectionId: "global") {
            HStack(spacing: Moin.Constants.Spacing.md) {
                Moin.Alert(type: .info, title: tr("alert.demo.token_demo.title"), description: tr("alert.demo.token_demo.description"), showIcon: true)
                Text("marginSM: \(Int(config.token.marginSM))px")
                    .font(.system(size: 11, design: .monospaced))
                    .foregroundStyle(.secondary)
            }
        } editor: {
            TokenValueRow(label: "seed.sizeUnit", value: $config.seed.sizeUnit, range: 2...8, onChange: { config.regenerateTokens() })
        } code: { "// \(tr("api.derived_from")) seed.sizeUnit * 3" }
    }
    
    private var marginXSCard: some View {
        TokenCard(name: "marginXS", type: "number", defaultValue: "8", description: tr("token.alert.marginXS"), sectionId: "global") {
            HStack(spacing: Moin.Constants.Spacing.md) {
                Moin.Alert(type: .info, title: tr("alert.demo.token_demo.gap"), showIcon: true)
                Text("marginXS: \(Int(config.token.marginXS))px")
                    .font(.system(size: 11, design: .monospaced))
                    .foregroundStyle(.secondary)
            }
        } editor: {
            TokenValueRow(label: "seed.sizeUnit", value: $config.seed.sizeUnit, range: 2...8, onChange: { config.regenerateTokens() })
        } code: { "// \(tr("api.derived_from")) seed.sizeUnit * 2" }
    }
}
