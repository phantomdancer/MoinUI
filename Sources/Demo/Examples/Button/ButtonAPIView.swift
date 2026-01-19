import SwiftUI
import MoinUI

// MARK: - ButtonAPIView

/// Button 组件 API 文档视图 - 每属性独立卡片
struct ButtonAPIView: View {
    @Localized var tr
    @ObservedObject var config = Moin.ConfigProvider.shared
    
    @State var selectedItemId: String? = "api"
    @State var scrollPosition: String?
    @State private var targetScrollId: String?
    @State var searchText: String = ""
    
    // 各属性的当前选中值
    @State var selectedColor: Moin.ButtonColor = .primary
    @State var selectedVariant: Moin.ButtonVariant = .solid
    @State var selectedSize: Moin.ButtonSize = .medium
    @State var selectedShape: Moin.ButtonShape = .default
    @State var selectedIcon: String = "star.fill"
    @State var selectedIconPlacement: Moin.ButtonIconPlacement = .start
    @State var isLoading: Bool = false
    @State var isDisabled: Bool = false
    @State var isBlock: Bool = false
    @State var isGhost: Bool = false
    
    // 重置所有属性到默认值
    private func resetAll() {
        selectedColor = .primary
        selectedVariant = .solid
        selectedSize = .medium
        selectedShape = .default
        selectedIcon = "star.fill"
        selectedIconPlacement = .start
        isLoading = false
        isDisabled = false
        isBlock = false
        isGhost = false
        // 重置全局token
        config.seed.colorPrimary = Moin.Colors.blue
        config.seed.borderRadius = 6
        config.seed.controlHeight = 32
        config.regenerateTokens()
    }
    
    var body: some View {
        HStack(spacing: 0) {
            // 左栏：属性卡片列表
            mainContent
            
            Divider()
            
            // 右栏：导航树
            navigationSidebar
                .frame(width: 280)
        }
        .background(Color(nsColor: .controlBackgroundColor))
        .onReceive(NotificationCenter.default.publisher(for: .buttonDocReset)) { _ in
            resetAll()
        }
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
                    navSection(title: "API", items: ["action", "color", "fontColor", "gradient", "href", "icon", "iconPlacement", "isBlock", "isDisabled", "isGhost", "label", "loading", "shape", "size", "variant"], sectionId: "api")
                    navSection(title: tr("doc.section.component_token"), items: ["borderColorDisabled", "contentFontSize", "contentFontSizeLG", "contentFontSizeSM", "dangerColor", "defaultActiveBg", "defaultActiveBorderColor", "defaultActiveColor", "defaultBg", "defaultBgDisabled", "defaultBorderColor", "defaultColor", "defaultGhostBorderColor", "defaultGhostColor", "defaultHoverBg", "defaultHoverBorderColor", "defaultHoverColor", "fontWeight", "ghostBg", "iconGap", "linkHoverBg", "onlyIconSize", "onlyIconSizeLG", "onlyIconSizeSM", "paddingBlock", "paddingBlockLG", "paddingBlockSM", "paddingInline", "paddingInlineLG", "paddingInlineSM", "primaryColor", "solidTextColor", "textHoverBg", "textTextActiveColor", "textTextColor", "textTextHoverColor"], sectionId: "token")
                    navSection(title: tr("doc.section.global_token"), items: ["borderRadius", "borderRadiusLG", "borderRadiusSM", "colorPrimary", "colorPrimaryActive", "colorPrimaryHover", "colorTextDisabled", "controlHeight", "controlHeightLG", "controlHeightSM", "motionDuration"], sectionId: "global")
                }
                .padding(Moin.Constants.Spacing.md)
            }
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
        VStack(spacing: 0) {
            // 固定顶部重置按钮
            HStack {
                Spacer()
                Button {
                    resetAll()
                } label: {
                    Text(tr("playground.token.reset"))
                        .font(.system(size: 12))
                        .foregroundStyle(.blue)
                }
                .buttonStyle(.plain)
            }
            .padding(.horizontal, Moin.Constants.Spacing.lg)
            .padding(.vertical, Moin.Constants.Spacing.sm)
            
            // 可滚动内容
            AnchorScrollView(targetScrollId: $targetScrollId) {
                LazyVStack(alignment: .leading, spacing: Moin.Constants.Spacing.xl) {
                    // API 分组
                    Text("API")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .id("api")

                    actionPropertyCard
                    colorPropertyCard
                    fontColorPropertyCard
                    gradientPropertyCard
                    hrefPropertyCard
                    iconPropertyCard
                    iconPlacementPropertyCard
                    blockPropertyCard
                    disabledPropertyCard
                    ghostPropertyCard
                    labelPropertyCard
                    loadingPropertyCard
                    shapePropertyCard
                    sizePropertyCard
                    variantPropertyCard

                    Divider().padding(.vertical, Moin.Constants.Spacing.md)

                    // Token 分组
                    Text(tr("doc.section.component_token"))
                        .font(.title3)
                        .fontWeight(.semibold)
                        .id("token")

                    borderColorDisabledTokenCard
                    contentFontSizeTokenCard
                    contentFontSizeLGTokenCard
                    contentFontSizeSMTokenCard
                    dangerColorTokenCard
                    defaultActiveBgTokenCard
                    defaultActiveBorderColorTokenCard
                    defaultActiveColorTokenCard
                    defaultBgTokenCard
                    defaultBgDisabledTokenCard
                    defaultBorderColorTokenCard
                    defaultColorTokenCard
                    defaultGhostBorderColorTokenCard
                    defaultGhostColorTokenCard
                    defaultHoverBgTokenCard
                    defaultHoverBorderColorTokenCard
                    defaultHoverColorTokenCard
                    fontWeightTokenCard
                    ghostBgTokenCard
                    iconGapTokenCard
                    linkHoverBgTokenCard
                    onlyIconSizeTokenCard
                    onlyIconSizeLGTokenCard
                    onlyIconSizeSMTokenCard
                    paddingBlockTokenCard
                    paddingBlockLGTokenCard
                    paddingBlockSMTokenCard
                    paddingInlineTokenCard
                    paddingInlineLGTokenCard
                    paddingInlineSMTokenCard
                    primaryColorTokenCard
                    solidTextColorTokenCard
                    textHoverBgTokenCard
                    textTextActiveColorTokenCard
                    textTextColorTokenCard
                    textTextHoverColorTokenCard

                    Divider().padding(.vertical, Moin.Constants.Spacing.md)

                    // 全局 Token 分组
                    Text(tr("doc.section.global_token"))
                        .font(.title3)
                        .fontWeight(.semibold)
                        .id("global")

                    borderRadiusGlobalTokenCard
                    borderRadiusLGGlobalTokenCard
                    borderRadiusSMGlobalTokenCard
                    colorPrimaryGlobalTokenCard
                    colorPrimaryActiveGlobalTokenCard
                    colorPrimaryHoverGlobalTokenCard
                    colorTextDisabledGlobalTokenCard
                    controlHeightGlobalTokenCard
                    controlHeightLGGlobalTokenCard
                    controlHeightSMGlobalTokenCard
                    motionDurationGlobalTokenCard
                }
                .padding(Moin.Constants.Spacing.lg)
            }
        }
    }
    
    // MARK: - Color 属性卡片
    
    private var colorPropertyCard: some View {
        PropertyCard(
            name: "color",
            type: "Moin.ButtonColor",
            defaultValue: ".default",
            description: tr("button.api.type"),
            enumValues: ".primary | .success | .warning | .danger | .info | .default | .custom(Color) | .red | .blue | .green | .cyan | .purple | .magenta | .orange | .yellow | .lime | .gold | .volcano | .geekblue",
            sectionId: "api"
        ) {
            // 预览：展示所有颜色
            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.sm) {
                // Semantic Colors
                Text(tr("button.semantic_colors"))
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundStyle(.secondary)
                HStack(alignment: .center, spacing: Moin.Constants.Spacing.sm) {
                    Moin.Button(tr("button.label.primary"), color: .primary) {}
                    Moin.Button(tr("button.label.success"), color: .success) {}
                    Moin.Button(tr("button.label.warning"), color: .warning) {}
                    Moin.Button(tr("button.label.danger"), color: .danger) {}
                    Moin.Button(tr("button.label.info"), color: .info) {}
                    Moin.Button(tr("button.label.default"), color: .default) {}
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                // Preset Colors
                Text(tr("button.preset_colors"))
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundStyle(.secondary)
                    .padding(.top, Moin.Constants.Spacing.sm)
                HStack(alignment: .center, spacing: Moin.Constants.Spacing.sm) {
                    Moin.Button(tr("button.label.cyan"), color: .cyan) {}
                    Moin.Button(tr("button.label.purple"), color: .purple) {}
                    Moin.Button(tr("button.label.magenta"), color: .magenta) {}
                    Moin.Button(tr("button.label.orange"), color: .orange) {}
                    Moin.Button(tr("button.label.yellow"), color: .yellow) {}
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                // Custom Colors
                Text(tr("button.custom_colors"))
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundStyle(.secondary)
                    .padding(.top, Moin.Constants.Spacing.sm)
                HStack(alignment: .center, spacing: Moin.Constants.Spacing.sm) {
                    Moin.Button(tr("button.label.brown"), color: .custom(Color(red: 0.6, green: 0.3, blue: 0.1))) {}
                    Moin.Button(tr("button.label.custom"), color: .custom(Color(red: 0.6, green: 0.2, blue: 0.8))) {}
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        } code: {
            """
Moin.Button("\(tr("button.label.primary"))", color: .primary) {}
Moin.Button("\(tr("button.label.cyan"))", color: .cyan) {}
Moin.Button("\(tr("button.label.brown"))", color: .custom(Color(red: 0.6, green: 0.3, blue: 0.1))) {}
Moin.Button("\(tr("button.label.custom"))", color: .custom(Color(red: 0.6, green: 0.2, blue: 0.8))) {}
"""
        }
        .id("api.color")
    }
    
    // MARK: - Variant 属性卡片
    
    private var variantPropertyCard: some View {
        PropertyCard(
            name: "variant",
            type: "Moin.ButtonVariant",
            defaultValue: ".solid",
            description: tr("button.api.variant"),
            enumValues: ".solid | .outlined | .dashed | .filled | .text | .link",
            sectionId: "api"
        ) {
            HStack(spacing: Moin.Constants.Spacing.sm) {
                Moin.Button(tr("button.label.solid"), color: .primary, variant: .solid) {}
                Moin.Button(tr("button.label.outlined"), color: .primary, variant: .outlined) {}
                Moin.Button(tr("button.label.dashed"), color: .primary, variant: .dashed) {}
                Moin.Button(tr("button.label.filled"), color: .primary, variant: .filled) {}
                Moin.Button(tr("button.label.text"), color: .primary, variant: .text) {}
                Moin.Button(tr("button.label.link"), color: .primary, variant: .link) {}
            }
        } code: {
            "Moin.Button(\"\(tr("button.label.solid"))\", variant: .solid) {}"
        }
        .id("api.variant")
    }

    // MARK: - Size 属性卡片

    private var sizePropertyCard: some View {
        PropertyCard(
            name: "size",
            type: "Moin.ButtonSize",
            defaultValue: ".medium",
            description: tr("button.api.size"),
            enumValues: ".small | .medium | .large",
            sectionId: "api"
        ) {
            HStack(alignment: .center, spacing: Moin.Constants.Spacing.md) {
                Moin.Button(tr("button.label.small"), color: .primary, size: .small) {}
                Moin.Button(tr("button.label.medium"), color: .primary, size: .medium) {}
                Moin.Button(tr("button.label.large"), color: .primary, size: .large) {}
            }
        } code: {
            "Moin.Button(\"\(tr("button.label.medium"))\", size: .medium) {}"
        }
        .id("api.size")
    }

    // MARK: - Shape 属性卡片

    private var shapePropertyCard: some View {
        PropertyCard(
            name: "shape",
            type: "Moin.ButtonShape",
            defaultValue: ".default",
            description: tr("button.api.shape"),
            enumValues: ".default | .round | .circle",
            sectionId: "api"
        ) {
            HStack(spacing: Moin.Constants.Spacing.md) {
                Moin.Button(tr("button.label.normal"), color: .primary, shape: .default) {}
                Moin.Button(tr("button.label.round"), color: .primary, shape: .round) {}
                Moin.Button(icon: "plus", color: .primary, shape: .circle) {}
            }
        } code: {
            "Moin.Button(\"\(tr("button.label.normal"))\", shape: .default) {}"
        }
        .id("api.shape")
    }
    
    // MARK: - Token 卡片
    
    private var primaryColorTokenCard: some View {
        TokenCard(
            name: "primaryColor",
            type: "Color",
            defaultValue: ".white",
            description: tr("button.api.token.primaryColor"),
            sectionId: "token"
        ) {
            Moin.Button(tr("button.label.primary"), color: .primary) {}
        } editor: {
            ColorPresetRow(label: "primaryColor", color: $config.components.button.primaryColor)
        }
        .id("token.primaryColor")
    }

    private var paddingInlineTokenCard: some View {
        TokenCard(
            name: "paddingInline",
            type: "CGFloat",
            defaultValue: "15",
            description: tr("button.api.token.paddingInline"),
            sectionId: "token"
        ) {
            HStack(spacing: Moin.Constants.Spacing.md) {
                Moin.Button(tr("button.label.button"), color: .primary) {}
                Text("padding: \(Int(config.components.button.paddingInline))px")
                    .font(.system(size: 11, design: .monospaced))
                    .foregroundStyle(.secondary)
            }
        } editor: {
            TokenValueRow(label: "paddingInline", value: $config.components.button.paddingInline, range: 0...30)
        }
        .id("token.paddingInline")
    }
}

// MARK: - PropertyCard 属性卡片组件

struct PropertyCard<Preview: View, TryIt: View>: View {
    let name: String
    let type: String
    let defaultValue: String
    let description: String
    let enumValues: String?  // 可选枚举值说明
    let sectionId: String
    @ViewBuilder let preview: () -> Preview
    @ViewBuilder let tryIt: (() -> TryIt)?
    let code: () -> String
    
    init(
        name: String,
        type: String,
        defaultValue: String,
        description: String,
        enumValues: String? = nil,
        sectionId: String,
        @ViewBuilder preview: @escaping () -> Preview,
        @ViewBuilder tryIt: @escaping () -> TryIt,
        code: @escaping () -> String
    ) {
        self.name = name
        self.type = type
        self.defaultValue = defaultValue
        self.description = description
        self.enumValues = enumValues
        self.sectionId = sectionId
        self.preview = preview
        self.tryIt = tryIt
        self.code = code
    }
    
    init(
        name: String,
        type: String,
        defaultValue: String,
        description: String,
        enumValues: String? = nil,
        sectionId: String,
        @ViewBuilder preview: @escaping () -> Preview,
        code: @escaping () -> String
    ) where TryIt == EmptyView {
        self.name = name
        self.type = type
        self.defaultValue = defaultValue
        self.description = description
        self.enumValues = enumValues
        self.sectionId = sectionId
        self.preview = preview
        self.tryIt = nil
        self.code = code
    }
    
    @Localized var tr
    @Environment(\.moinToken) private var token
    @Environment(\.colorScheme) private var colorScheme

    private var isDarkMode: Bool { colorScheme == .dark }

    var body: some View {
        Moin.BadgeRibbon(text: name, color: .custom(.gray), placement: .end) {
            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.md) {
                // 标题行
                HStack {
                    Text(name)
                        .font(.system(size: 14, weight: .semibold, design: .monospaced))
                        .foregroundStyle(token.colorPrimary)
                        .textSelection(.enabled)
                    Text(type)
                        .font(.system(size: 12, design: .monospaced))
                        .foregroundStyle(.secondary)
                        .textSelection(.enabled)
                    Text("= \(defaultValue)")
                        .font(.system(size: 11, design: .monospaced))
                        .foregroundStyle(.tertiary)
                        .textSelection(.enabled)
                    Spacer()
                }

            // 说明
            Text(description)
                .font(.system(size: 13))
                .foregroundStyle(.secondary)
                .textSelection(.enabled)

            // 枚举值说明
            if let values = enumValues {
                Text(values)
                    .font(.system(size: 12, design: .monospaced))
                    .foregroundStyle(.tertiary)
                    .textSelection(.enabled)
                    .padding(.horizontal, Moin.Constants.Spacing.sm)
                    .padding(.vertical, Moin.Constants.Spacing.xs)
                    .background(Color.secondary.opacity(0.1))
                    .cornerRadius(4)
            }

            // 预览区
            HStack {
                preview()
                Spacer()
            }
            .padding(Moin.Constants.Spacing.md)
            .frame(maxWidth: .infinity, alignment: .leading)

            // 试一试
            if let tryIt = tryIt {
                VStack(alignment: .trailing, spacing: 0) {
                    // 标签溢出到上方
                    Text(tr("doc.try_it"))
                        .font(.system(size: 10, weight: .medium))
                        .foregroundStyle(token.colorPrimary)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 3)
                        .background(token.colorPrimary.opacity(0.15))
                        .cornerRadius(3)
                        .offset(y: 8)

                    HStack {
                        tryIt()
                        Spacer()
                    }
                    .padding(Moin.Constants.Spacing.md)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(token.colorPrimary.opacity(0.05))
                    .cornerRadius(Moin.Constants.Radius.sm)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }

            // 代码
            ScrollView(.horizontal, showsIndicators: false) {
                HighlightedCodeView(code: code(), fontSize: 12)
                    .padding(Moin.Constants.Spacing.sm)
            }
            .background(isDarkMode ? Color(white: 0.08) : Color(white: 0.96))
            .cornerRadius(Moin.Constants.Radius.sm)
            }
            .padding(Moin.Constants.Spacing.md)
            .background(Color(nsColor: .controlBackgroundColor))
            .cornerRadius(Moin.Constants.Radius.md)
            .overlay(
                RoundedRectangle(cornerRadius: Moin.Constants.Radius.md)
                    .stroke(Color.primary.opacity(0.1), lineWidth: 1)
            )
        }
        .id("\(sectionId).\(name)")
    }
}

// MARK: - TokenCard Token卡片组件

struct TokenCard<Preview: View, Editor: View>: View {
    let name: String
    let type: String
    let defaultValue: String
    let description: String
    let sectionId: String
    @ViewBuilder let preview: () -> Preview
    @ViewBuilder let editor: (() -> Editor)?
    let code: () -> String
    
    init(
        name: String,
        type: String,
        defaultValue: String,
        description: String,
        sectionId: String,
        @ViewBuilder preview: @escaping () -> Preview,
        @ViewBuilder editor: @escaping () -> Editor,
        code: @escaping () -> String = { "" }
    ) {
        self.name = name
        self.type = type
        self.defaultValue = defaultValue
        self.description = description
        self.sectionId = sectionId
        self.preview = preview
        self.editor = editor
        self.code = code
    }
    
    init(
        name: String,
        type: String,
        defaultValue: String,
        description: String,
        sectionId: String,
        @ViewBuilder preview: @escaping () -> Preview,
        code: @escaping () -> String = { "" }
    ) where Editor == EmptyView {
        self.name = name
        self.type = type
        self.defaultValue = defaultValue
        self.description = description
        self.sectionId = sectionId
        self.preview = preview
        self.editor = nil
        self.code = code
    }
    
    @Localized var tr
    @Environment(\.moinToken) private var token
    @Environment(\.colorScheme) private var colorScheme

    private var isDarkMode: Bool { colorScheme == .dark }

    var body: some View {
        Moin.BadgeRibbon(text: name, color: .custom(.gray), placement: .end) {
            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.md) {
                // 标题行
                HStack {
                    Text(name)
                        .font(.system(size: 14, weight: .semibold, design: .monospaced))
                        .foregroundStyle(token.colorPrimary)
                        .textSelection(.enabled)
                    Text(type)
                        .font(.system(size: 12, design: .monospaced))
                        .foregroundStyle(.secondary)
                        .textSelection(.enabled)
                    Text("= \(defaultValue)")
                        .font(.system(size: 11, design: .monospaced))
                        .foregroundStyle(.tertiary)
                        .textSelection(.enabled)
                    Spacer()
                }

                Text(description)
                    .font(.system(size: 13))
                    .foregroundStyle(.secondary)
                    .textSelection(.enabled)

                // 预览
                HStack {
                    preview()
                    Spacer()
                }
                .padding(Moin.Constants.Spacing.md)
                .background(isDarkMode ? Color(white: 0.12) : Color(white: 0.98))
                .cornerRadius(Moin.Constants.Radius.sm)

                // 试一试
                if let editor = editor {
                    VStack(alignment: .trailing, spacing: 0) {
                        Text(tr("doc.try_it"))
                            .font(.system(size: 10, weight: .medium))
                            .foregroundStyle(token.colorPrimary)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 3)
                            .background(token.colorPrimary.opacity(0.15))
                            .cornerRadius(3)
                            .offset(y: 8)

                        HStack {
                            editor()
                            Spacer()
                        }
                        .padding(Moin.Constants.Spacing.md)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(token.colorPrimary.opacity(0.05))
                        .cornerRadius(Moin.Constants.Radius.sm)
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }

                // 代码
                let codeText = code()
                if !codeText.isEmpty {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HighlightedCodeView(code: codeText, fontSize: 12)
                            .padding(Moin.Constants.Spacing.sm)
                    }
                    .background(isDarkMode ? Color(white: 0.08) : Color(white: 0.96))
                    .cornerRadius(Moin.Constants.Radius.sm)
                }
            }
            .padding(Moin.Constants.Spacing.md)
            .background(Color(nsColor: .controlBackgroundColor))
            .cornerRadius(Moin.Constants.Radius.md)
            .overlay(
                RoundedRectangle(cornerRadius: Moin.Constants.Radius.md)
                    .stroke(Color.primary.opacity(0.1), lineWidth: 1)
            )
        }
        .id("\(sectionId).\(name)")
    }
}
