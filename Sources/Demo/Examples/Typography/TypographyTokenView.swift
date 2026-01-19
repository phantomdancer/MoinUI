import SwiftUI
import MoinUI

// MARK: - TypographyTokenView

/// Typography 组件 Token 文档视图
struct TypographyTokenView: View {
    @Localized var tr
    @ObservedObject var config = Moin.ConfigProvider.shared
    
    @State var selectedItemId: String? = "token"
    @State private var targetScrollId: String?
    @State var searchText: String = ""
    
    // 重置所有 Token 到默认值
    private func resetAll() {
        config.regenerateTokens()
    }
    
    var body: some View {
        HStack(spacing: 0) {
            // 左栏：主内容
            mainContent
            
            Divider()
            
            // 右栏：导航树
            navigationSidebar
                .frame(width: 280)
        }
        .background(Color(nsColor: .controlBackgroundColor))
    }
    
    // MARK: - 右栏导航

    private var navigationSidebar: some View {
        VStack(spacing: 0) {
            // 搜索框
            HStack(spacing: Moin.Constants.Spacing.xs) {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.secondary)
                    .font(.system(size: 12))
                TextField(tr("search.placeholder"), text: $searchText)
                    .textFieldStyle(.plain)
                    .font(.system(size: 12))
                if !searchText.isEmpty {
                    Button {
                        searchText = ""
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(.secondary)
                            .font(.system(size: 12))
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(Moin.Constants.Spacing.sm)
            .background(Color(nsColor: .textBackgroundColor))
            .cornerRadius(Moin.Constants.Radius.sm)
            .padding(Moin.Constants.Spacing.md)

            Divider()

            // 导航列表
            ScrollView {
                VStack(alignment: .leading, spacing: Moin.Constants.Spacing.sm) {
                    navSection(title: tr("token.font_size"), items: [
                        "fontSizeHeading1", "fontSizeHeading2", "fontSizeHeading3", "fontSizeHeading4", "fontSizeHeading5",
                        "fontSize", "fontSizeSM", "fontSizeLG", "fontSizeXL"
                    ], sectionId: "token")
                    
                    navSection(title: tr("token.line_height"), items: [
                        "lineHeightHeading1", "lineHeightHeading2", "lineHeightHeading3", "lineHeightHeading4", "lineHeightHeading5",
                        "lineHeight", "lineHeightSM", "lineHeightLG"
                    ], sectionId: "token")
                    
                    navSection(title: "Dimensions", items: [
                        "lineWidth", "borderRadiusXS", "borderRadiusSM", 
                        "paddingXXS", "paddingXS", "marginXS"
                    ], sectionId: "token")
                    
                    navSection(title: tr("token.text_color"), items: [
                        "colorText", "colorTextSecondary", "colorTextTertiary", "colorTextDisabled",
                        "colorSuccess", "colorWarning", "colorDanger", "colorLink",
                        "colorFillTertiary", "colorFillSecondary", "colorBorder"
                    ], sectionId: "token")
                }
                .padding(Moin.Constants.Spacing.md)
            }
            
            Divider()
            
            // 底部重置按钮
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

    private func navSection(title: String, items: [String], sectionId: String) -> some View {
        let filteredItems = searchText.isEmpty ? items : items.filter { $0.localizedCaseInsensitiveContains(searchText) }

        return Group {
            if !filteredItems.isEmpty {
                VStack(alignment: .leading, spacing: 0) {
                    Text(title)
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundStyle(.secondary)
                        .padding(.vertical, Moin.Constants.Spacing.xs)

                    ForEach(filteredItems, id: \.self) { item in
                        navItem(name: item, sectionId: sectionId)
                    }
                }
                .padding(.bottom, Moin.Constants.Spacing.md)
            }
        }
    }
    
    private func navItem(name: String, sectionId: String) -> some View {
        let itemId = "\(sectionId).\(name)"
        return Button {
            selectedItemId = itemId
            targetScrollId = itemId
        } label: {
            HStack(spacing: Moin.Constants.Spacing.xs) {
                Circle()
                    .fill(selectedItemId == itemId ? config.token.colorPrimary : Color.secondary.opacity(0.3))
                    .frame(width: 6, height: 6)
                Text(name)
                    .font(.system(size: 12, design: .monospaced))
                    .foregroundStyle(selectedItemId == itemId ? config.token.colorPrimary : .primary)
                Spacer()
            }
            .padding(.vertical, 4)
            .padding(.horizontal, Moin.Constants.Spacing.sm)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .background(selectedItemId == itemId ? config.token.colorPrimary.opacity(0.1) : .clear)
        .cornerRadius(Moin.Constants.Radius.sm)
    }
    
    // MARK: - 主内容区
    
    private var mainContent: some View {
        // 可滚动内容
        AnchorScrollView(targetScrollId: $targetScrollId, currentScrollId: $selectedItemId) {
            LazyVStack(alignment: .leading, spacing: Moin.Constants.Spacing.xl) {
                // Token 分组
                Text(tr("doc.section.global_token"))
                    .font(.title3)
                    .fontWeight(.semibold)
                    .scrollAnchor("token")

                // Font Size
                Text(tr("token.font_size")).font(.headline).padding(.top)
                fontSizeHeading1Card
                fontSizeHeading2Card
                fontSizeHeading3Card
                fontSizeHeading4Card
                fontSizeHeading5Card
                fontSizeCard
                fontSizeSMCard
                fontSizeLGCard
                fontSizeXLCard
                
                // Line Height
                Text(tr("token.line_height")).font(.headline).padding(.top)
                lineHeightHeading1Card
                lineHeightHeading2Card
                lineHeightHeading3Card
                lineHeightHeading4Card
                lineHeightHeading5Card
                lineHeightCard
                lineHeightSMCard
                lineHeightLGCard
                
                // Dimensions
                Text("Dimensions").font(.headline).padding(.top)
                lineWidthCard
                borderRadiusXSCard
                borderRadiusSMCard
                paddingXXSCard
                paddingXSCard
                marginXSCard

                // Color
                Text(tr("token.text_color")).font(.headline).padding(.top)
                colorTextCard
                colorTextSecondaryCard
                colorTextTertiaryCard
                colorTextDisabledCard
                colorSuccessCard
                colorWarningCard
                colorDangerCard
                colorLinkCard
                colorFillTertiaryCard
                colorFillSecondaryCard
                colorBorderCard
            }
            .padding(Moin.Constants.Spacing.lg)
        }
    }
    
    // MARK: - Font Size Cards
    
    var fontSizeHeading1Card: some View {
        TokenCard(
            name: "fontSizeHeading1",
            type: "CGFloat",
            defaultValue: "38",
            description: tr("api.typography.h1"),
            sectionId: "token"
        ) {
            Moin.Typography.Title(tr("typography.example.h1"), level: .h1)
        } editor: {
            TokenValueRow(label: "fontSizeHeading1", value: $config.token.fontSizeHeading1)
        } code: { "config.token.fontSizeHeading1 = \(Int(config.token.fontSizeHeading1))" }
        .scrollAnchor("token.fontSizeHeading1")
    }

    var fontSizeHeading2Card: some View {
        TokenCard(
            name: "fontSizeHeading2",
            type: "CGFloat",
            defaultValue: "30",
            description: tr("api.typography.h2"),
            sectionId: "token"
        ) {
            Moin.Typography.Title(tr("typography.example.h2"), level: .h2)
        } editor: {
            TokenValueRow(label: "fontSizeHeading2", value: $config.token.fontSizeHeading2)
        } code: { "config.token.fontSizeHeading2 = \(Int(config.token.fontSizeHeading2))" }
        .scrollAnchor("token.fontSizeHeading2")
    }
    
    var fontSizeHeading3Card: some View {
        TokenCard(
            name: "fontSizeHeading3",
            type: "CGFloat",
            defaultValue: "24",
            description: tr("api.typography.h3"),
            sectionId: "token"
        ) {
            Moin.Typography.Title(tr("typography.example.h3"), level: .h3)
        } editor: {
            TokenValueRow(label: "fontSizeHeading3", value: $config.token.fontSizeHeading3)
        } code: { "config.token.fontSizeHeading3 = \(Int(config.token.fontSizeHeading3))" }
        .scrollAnchor("token.fontSizeHeading3")
    }

    var fontSizeHeading4Card: some View {
        TokenCard(
            name: "fontSizeHeading4",
            type: "CGFloat",
            defaultValue: "20",
            description: tr("api.typography.h4"),
            sectionId: "token"
        ) {
            Moin.Typography.Title(tr("typography.example.h4"), level: .h4)
        } editor: {
            TokenValueRow(label: "fontSizeHeading4", value: $config.token.fontSizeHeading4)
        } code: { "config.token.fontSizeHeading4 = \(Int(config.token.fontSizeHeading4))" }
        .scrollAnchor("token.fontSizeHeading4")
    }
    
    var fontSizeHeading5Card: some View {
        TokenCard(
            name: "fontSizeHeading5",
            type: "CGFloat",
            defaultValue: "16",
            description: tr("api.typography.h5"),
            sectionId: "token"
        ) {
            Moin.Typography.Title(tr("typography.example.h5"), level: .h5)
        } editor: {
            TokenValueRow(label: "fontSizeHeading5", value: $config.token.fontSizeHeading5)
        } code: { "config.token.fontSizeHeading5 = \(Int(config.token.fontSizeHeading5))" }
        .scrollAnchor("token.fontSizeHeading5")
    }

    var fontSizeCard: some View {
        TokenCard(
            name: "fontSize",
            type: "CGFloat",
            defaultValue: "14",
            description: tr("token.default_font_size"),
            sectionId: "token"
        ) {
            Moin.Typography.Text(tr("typography.example.default"))
        } editor: {
            TokenValueRow(label: "fontSize", value: $config.token.fontSize)
        } code: { "config.token.fontSize = \(Int(config.token.fontSize))" }
        .scrollAnchor("token.fontSize")
    }
    
    var fontSizeSMCard: some View {
        TokenCard(
            name: "fontSizeSM",
            type: "CGFloat",
            defaultValue: "12",
            description: tr("token.small_font_size"),
            sectionId: "token"
        ) {
            Moin.Typography.Text(tr("typography.example.keyboard"), keyboard: true)
        } editor: {
            TokenValueRow(label: "fontSizeSM", value: $config.token.fontSizeSM)
        } code: { "config.token.fontSizeSM = \(Int(config.token.fontSizeSM))" }
        .scrollAnchor("token.fontSizeSM")
    }
    
    var fontSizeLGCard: some View {
        TokenCard(
            name: "fontSizeLG",
            type: "CGFloat",
            defaultValue: "16",
            description: tr("token.large_font_size"),
            sectionId: "token"
        ) {
            Text(tr("typography.example.default")).font(.system(size: config.token.fontSizeLG))
        } editor: {
            TokenValueRow(label: "fontSizeLG", value: $config.token.fontSizeLG)
        } code: { "config.token.fontSizeLG = \(Int(config.token.fontSizeLG))" }
        .scrollAnchor("token.fontSizeLG")
    }
    
    var fontSizeXLCard: some View {
        TokenCard(
            name: "fontSizeXL",
            type: "CGFloat",
            defaultValue: "20",
            description: "Extra Large Font Size",
            sectionId: "token"
        ) {
            Text(tr("typography.example.default")).font(.system(size: config.token.fontSizeXL))
        } editor: {
            TokenValueRow(label: "fontSizeXL", value: $config.token.fontSizeXL)
        } code: { "config.token.fontSizeXL = \(Int(config.token.fontSizeXL))" }
        .scrollAnchor("token.fontSizeXL")
    }
    
    // MARK: - Line Height Cards
    
    var lineHeightHeading1Card: some View {
        TokenCard(
            name: "lineHeightHeading1",
            type: "CGFloat",
            defaultValue: String(format: "%.4f", Moin.MapToken.generate(from: .default, theme: .light).lineHeightHeading1),
            description: tr("token.h1_line_height"),
            sectionId: "token"
        ) {
            Moin.Typography.Title("Line Height H1", level: .h1)
                .border(Color.red.opacity(0.2))
        } editor: {
            TokenValueRow(label: "lineHeightHeading1", value: $config.token.lineHeightHeading1)
        } code: { "config.token.lineHeightHeading1 = \(Int(config.token.lineHeightHeading1))" }
        .scrollAnchor("token.lineHeightHeading1")
    }
    
    var lineHeightHeading2Card: some View {
        TokenCard(
            name: "lineHeightHeading2",
            type: "CGFloat",
            defaultValue: String(format: "%.4f", Moin.MapToken.generate(from: .default, theme: .light).lineHeightHeading2),
            description: tr("token.h2_line_height"),
            sectionId: "token"
        ) {
            Moin.Typography.Title("Line Height H2", level: .h2)
                .border(Color.red.opacity(0.2))
        } editor: {
            TokenValueRow(label: "lineHeightHeading2", value: $config.token.lineHeightHeading2)
        } code: { "config.token.lineHeightHeading2 = \(Int(config.token.lineHeightHeading2))" }
        .scrollAnchor("token.lineHeightHeading2")
    }
    
    var lineHeightHeading3Card: some View {
        TokenCard(
            name: "lineHeightHeading3",
            type: "CGFloat",
            defaultValue: String(format: "%.4f", Moin.MapToken.generate(from: .default, theme: .light).lineHeightHeading3),
            description: tr("token.h3_line_height"),
            sectionId: "token"
        ) {
            Moin.Typography.Title("Line Height H3", level: .h3)
                .border(Color.red.opacity(0.2))
        } editor: {
            TokenValueRow(label: "lineHeightHeading3", value: $config.token.lineHeightHeading3)
        } code: { "config.token.lineHeightHeading3 = \(Int(config.token.lineHeightHeading3))" }
        .scrollAnchor("token.lineHeightHeading3")
    }
    
    var lineHeightHeading4Card: some View {
        TokenCard(
            name: "lineHeightHeading4",
            type: "CGFloat",
            defaultValue: String(format: "%.4f", Moin.MapToken.generate(from: .default, theme: .light).lineHeightHeading4),
            description: tr("token.h4_line_height"),
            sectionId: "token"
        ) {
            Moin.Typography.Title("Line Height H4", level: .h4)
                .border(Color.red.opacity(0.2))
        } editor: {
            TokenValueRow(label: "lineHeightHeading4", value: $config.token.lineHeightHeading4)
        } code: { "config.token.lineHeightHeading4 = \(Int(config.token.lineHeightHeading4))" }
        .scrollAnchor("token.lineHeightHeading4")
    }
    
    var lineHeightHeading5Card: some View {
        TokenCard(
            name: "lineHeightHeading5",
            type: "CGFloat",
            defaultValue: String(format: "%.4f", Moin.MapToken.generate(from: .default, theme: .light).lineHeightHeading5),
            description: tr("token.h5_line_height"),
            sectionId: "token"
        ) {
            Moin.Typography.Title("Line Height H5", level: .h5)
                .border(Color.red.opacity(0.2))
        } editor: {
            TokenValueRow(label: "lineHeightHeading5", value: $config.token.lineHeightHeading5)
        } code: { "config.token.lineHeightHeading5 = \(Int(config.token.lineHeightHeading5))" }
        .scrollAnchor("token.lineHeightHeading5")
    }
    
    var lineHeightCard: some View {
        TokenCard(
            name: "lineHeight",
            type: "CGFloat",
            defaultValue: String(format: "%.4f", Moin.MapToken.generate(from: .default, theme: .light).lineHeight),
            description: tr("token.default_line_height"),
            sectionId: "token"
        ) {
            Moin.Typography.Text(tr("token.default_line_height"))
                .border(Color.red.opacity(0.2))
        } editor: {
            TokenValueRow(label: "lineHeight", value: $config.token.lineHeight)
        } code: { "config.token.lineHeight = \(Int(config.token.lineHeight))" }
        .scrollAnchor("token.lineHeight")
    }
    
    var lineHeightSMCard: some View {
        TokenCard(
            name: "lineHeightSM",
            type: "CGFloat",
            defaultValue: String(format: "%.4f", Moin.MapToken.generate(from: .default, theme: .light).lineHeightSM),
            description: "Small Line Height",
            sectionId: "token"
        ) {
            Text("Small Line Height").font(.system(size: 12))
                .lineSpacing(config.token.lineHeightSM - 12)
                .border(Color.red.opacity(0.2))
        } editor: {
            TokenValueRow(label: "lineHeightSM", value: $config.token.lineHeightSM)
        } code: { "config.token.lineHeightSM = \(Int(config.token.lineHeightSM))" }
        .scrollAnchor("token.lineHeightSM")
    }
    
    var lineHeightLGCard: some View {
        TokenCard(
            name: "lineHeightLG",
            type: "CGFloat",
            defaultValue: String(format: "%.4f", Moin.MapToken.generate(from: .default, theme: .light).lineHeightLG),
            description: "Large Line Height",
            sectionId: "token"
        ) {
            Text("Large Line Height").font(.system(size: 16))
                .lineSpacing(config.token.lineHeightLG - 16)
                .border(Color.red.opacity(0.2))
        } editor: {
            TokenValueRow(label: "lineHeightLG", value: $config.token.lineHeightLG)
        } code: { "config.token.lineHeightLG = \(Int(config.token.lineHeightLG))" }
        .scrollAnchor("token.lineHeightLG")
    }
    
    // MARK: - Dimensions Cards
    
    var lineWidthCard: some View {
        TokenCard(
            name: "lineWidth",
            type: "CGFloat",
            defaultValue: "1",
            description: "Line Width (Used in Keyboard)",
            sectionId: "token"
        ) {
            Moin.Typography.Text("Cmd+C", keyboard: true)
        } editor: {
            TokenValueRow(label: "lineWidth", value: $config.token.lineWidth)
        } code: { "config.token.lineWidth = \(Int(config.token.lineWidth))" }
        .scrollAnchor("token.lineWidth")
    }
    
    var borderRadiusXSCard: some View {
        TokenCard(
            name: "borderRadiusXS",
            type: "CGFloat",
            defaultValue: "2",
            description: "XS Border Radius (Used in Code)",
            sectionId: "token"
        ) {
            Moin.Typography.Text(tr("typography.example.code"), code: true)
        } editor: {
            TokenValueRow(label: "borderRadiusXS", value: $config.token.borderRadiusXS)
        } code: { "config.token.borderRadiusXS = \(Int(config.token.borderRadiusXS))" }
        .scrollAnchor("token.borderRadiusXS")
    }
    
    var borderRadiusSMCard: some View {
        TokenCard(
            name: "borderRadiusSM",
            type: "CGFloat",
            defaultValue: "4",
            description: "SM Border Radius (Used in Keyboard)",
            sectionId: "token"
        ) {
            Moin.Typography.Text("Cmd+V", keyboard: true)
        } editor: {
            TokenValueRow(label: "borderRadiusSM", value: $config.token.borderRadiusSM)
        } code: { "config.token.borderRadiusSM = \(Int(config.token.borderRadiusSM))" }
        .scrollAnchor("token.borderRadiusSM")
    }
    
    var paddingXXSCard: some View {
        TokenCard(
            name: "paddingXXS",
            type: "CGFloat",
            defaultValue: "4",
            description: "XXS Padding (Used in Code/Keyboard)",
            sectionId: "token"
        ) {
            HStack {
                Moin.Typography.Text(tr("typography.example.code"), code: true)
                Moin.Typography.Text("Cmd", keyboard: true)
            }
        } editor: {
            TokenValueRow(label: "paddingXXS", value: $config.token.paddingXXS)
        } code: { "config.token.paddingXXS = \(Int(config.token.paddingXXS))" }
        .scrollAnchor("token.paddingXXS")
    }
    
    var paddingXSCard: some View {
        TokenCard(
            name: "paddingXS",
            type: "CGFloat",
            defaultValue: "8",
            description: "XS Padding (Used in Keyboard horizontal)",
            sectionId: "token"
        ) {
             Moin.Typography.Text("Cmd+S", keyboard: true)
        } editor: {
            TokenValueRow(label: "paddingXS", value: $config.token.paddingXS)
        } code: { "config.token.paddingXS = \(Int(config.token.paddingXS))" }
        .scrollAnchor("token.paddingXS")
    }
    
    var marginXSCard: some View {
        TokenCard(
            name: "marginXS",
            type: "CGFloat",
            defaultValue: "8",
            description: "XS Margin (Paragraph Bottom Margin)",
            sectionId: "token"
        ) {
             VStack(alignment: .leading, spacing: 0) {
                 Moin.Typography.Paragraph(tr("typography.paragraph"))
                     .background(Color.blue.opacity(0.1))
                 Moin.Typography.Paragraph(tr("typography.paragraph"))
                     .background(Color.green.opacity(0.1))
             }
        } editor: {
            TokenValueRow(label: "marginXS", value: $config.token.marginXS)
        } code: { "config.token.marginXS = \(Int(config.token.marginXS))" }
        .scrollAnchor("token.marginXS")
    }

    // MARK: - Color Cards

    var colorTextCard: some View {
        TokenCard(
            name: "colorText",
            type: "Color",
            defaultValue: "-",
            description: tr("token.primary_text"),
            sectionId: "token"
        ) {
            Moin.Typography.Text(tr("typography.example.type_default"))
        } editor: {
            ColorPresetRow(label: "colorText", color: $config.token.colorText)
        } code: { "config.token.colorText = Color(...)" }
        .scrollAnchor("token.colorText")
    }
    
    var colorTextSecondaryCard: some View {
        TokenCard(
            name: "colorTextSecondary",
            type: "Color",
            defaultValue: "-",
            description: tr("token.secondary_text"),
            sectionId: "token"
        ) {
            Moin.Typography.Text(tr("typography.example.type_secondary"), type: .secondary)
        } editor: {
            ColorPresetRow(label: "colorTextSecondary", color: $config.token.colorTextSecondary)
        } code: { "config.token.colorTextSecondary = Color(...)" }
        .scrollAnchor("token.colorTextSecondary")
    }
    
    var colorTextTertiaryCard: some View {
        TokenCard(
            name: "colorTextTertiary",
            type: "Color",
            defaultValue: "-",
            description: tr("token.tertiary_text"),
            sectionId: "token"
        ) {
            Text("Tertiary Text").foregroundStyle(config.token.colorTextTertiary)
        } editor: {
            ColorPresetRow(label: "colorTextTertiary", color: $config.token.colorTextTertiary)
        } code: { "config.token.colorTextTertiary = Color(...)" }
        .scrollAnchor("token.colorTextTertiary")
    }
    
    var colorTextDisabledCard: some View {
        TokenCard(
            name: "colorTextDisabled",
            type: "Color",
            defaultValue: "-",
            description: tr("token.disabled_text"),
            sectionId: "token"
        ) {
            Moin.Typography.Text(tr("typography.example.type_disabled"), disabled: true)
        } editor: {
            ColorPresetRow(label: "colorTextDisabled", color: $config.token.colorTextDisabled)
        } code: { "config.token.colorTextDisabled = Color(...)" }
        .scrollAnchor("token.colorTextDisabled")
    }
    
    var colorSuccessCard: some View {
        TokenCard(
            name: "colorSuccess",
            type: "Color",
            defaultValue: "-",
            description: tr("token.success_color"),
            sectionId: "token"
        ) {
            Moin.Typography.Text(tr("typography.example.type_success"), type: .success)
        } editor: {
            ColorPresetRow(label: "colorSuccess", color: $config.token.colorSuccess)
        } code: { "config.token.colorSuccess = Color(...)" }
        .scrollAnchor("token.colorSuccess")
    }
    
    var colorWarningCard: some View {
        TokenCard(
            name: "colorWarning",
            type: "Color",
            defaultValue: "-",
            description: tr("token.warning_color"),
            sectionId: "token"
        ) {
            Moin.Typography.Text(tr("typography.example.type_warning"), type: .warning)
        } editor: {
            ColorPresetRow(label: "colorWarning", color: $config.token.colorWarning)
        } code: { "config.token.colorWarning = Color(...)" }
        .scrollAnchor("token.colorWarning")
    }
    
    var colorDangerCard: some View {
        TokenCard(
            name: "colorDanger",
            type: "Color",
            defaultValue: "-",
            description: tr("token.danger_color"),
            sectionId: "token"
        ) {
            Moin.Typography.Text(tr("typography.example.type_danger"), type: .danger)
        } editor: {
            ColorPresetRow(label: "colorDanger", color: $config.token.colorDanger)
        } code: { "config.token.colorDanger = Color(...)" }
        .scrollAnchor("token.colorDanger")
    }
    
    var colorLinkCard: some View {
        TokenCard(
            name: "colorLink",
            type: "Color",
            defaultValue: "-",
            description: tr("token.link_color"),
            sectionId: "token"
        ) {
            Moin.Typography.Link(tr("typography.example.link"), href: nil)
        } editor: {
            ColorPresetRow(label: "colorLink", color: $config.token.colorLink)
        } code: { "config.token.colorLink = Color(...)" }
        .scrollAnchor("token.colorLink")
    }
    
    var colorFillTertiaryCard: some View {
        TokenCard(
            name: "colorFillTertiary",
            type: "Color",
            defaultValue: "-",
            description: "Tertiary Fill Color (Code Background)",
            sectionId: "token"
        ) {
            Moin.Typography.Text(tr("typography.example.code"), code: true)
        } editor: {
            ColorPresetRow(label: "colorFillTertiary", color: $config.token.colorFillTertiary)
        } code: { "config.token.colorFillTertiary = Color(...)" }
        .scrollAnchor("token.colorFillTertiary")
    }
    
    var colorFillSecondaryCard: some View {
        TokenCard(
            name: "colorFillSecondary",
            type: "Color",
            defaultValue: "-",
            description: "Secondary Fill Color (Keyboard Background)",
            sectionId: "token"
        ) {
            Moin.Typography.Text(tr("typography.example.keyboard"), keyboard: true)
        } editor: {
            ColorPresetRow(label: "colorFillSecondary", color: $config.token.colorFillSecondary)
        } code: { "config.token.colorFillSecondary = Color(...)" }
        .scrollAnchor("token.colorFillSecondary")
    }
    
    var colorBorderCard: some View {
        TokenCard(
            name: "colorBorder",
            type: "Color",
            defaultValue: "-",
            description: "Border Color (Keyboard Border)",
            sectionId: "token"
        ) {
            Moin.Typography.Text(tr("typography.example.keyboard"), keyboard: true)
        } editor: {
            ColorPresetRow(label: "colorBorder", color: $config.token.colorBorder)
        } code: { "config.token.colorBorder = Color(...)" }
        .scrollAnchor("token.colorBorder")
    }
}
// Helper for accessing Moin.ConfigProvider.shared more easily if needed, 
// but local 'config' is available. 
// Note: In `lineHeightSMCard` I used `CONFIG`, which is invalid. Fixed to `config`.
