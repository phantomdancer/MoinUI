import SwiftUI
import MoinUI

// MARK: - ButtonDocView

/// Button 组件文档视图 - 每属性独立卡片
struct ButtonDocView: View {
    @Localized var tr
    @ObservedObject var config = Moin.ConfigProvider.shared
    
    @State var selectedItemId: String?
    @State var scrollProxy: ScrollViewProxy?
    
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
                .frame(width: 180)
        }
        .background(Color(nsColor: .controlBackgroundColor))
        .onReceive(NotificationCenter.default.publisher(for: .buttonDocReset)) { _ in
            resetAll()
        }
    }
    
    // MARK: - 右栏导航
    
    private var navigationSidebar: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.sm) {
                navSection(title: "API", items: ["color", "icon", "iconPlacement", "isBlock", "isDisabled", "isGhost", "loading", "shape", "size", "variant"], sectionId: "api")
                navSection(title: tr("doc.section.component_token"), items: ["contentFontSize", "dangerColor", "defaultBg", "defaultBorderColor", "defaultColor", "iconGap", "paddingBlock", "paddingInline", "paddingInlineLG", "paddingInlineSM", "primaryColor"], sectionId: "token")
                navSection(title: tr("doc.section.global_token"), items: ["borderRadius", "colorPrimary", "controlHeight"], sectionId: "global")
            }
            .padding(Moin.Constants.Spacing.md)
        }
    }
    
    private func navSection(title: String, items: [String], sectionId: String) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .font(.system(size: 11, weight: .semibold))
                .foregroundStyle(.secondary)
                .padding(.vertical, Moin.Constants.Spacing.xs)
            
            ForEach(items, id: \.self) { item in
                navItem(name: item, sectionId: sectionId)
            }
        }
        .padding(.bottom, Moin.Constants.Spacing.md)
    }
    
    private func navItem(name: String, sectionId: String) -> some View {
        let itemId = "\(sectionId).\(name)"
        return Button {
            selectedItemId = itemId
            scrollProxy?.scrollTo(itemId, anchor: .top)
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
            ScrollViewReader { proxy in
                ScrollView {
                    VStack(alignment: .leading, spacing: Moin.Constants.Spacing.xl) {
                        // API 分组
                        Text("API")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .id("api")
                        
                        colorPropertyCard
                        iconPropertyCard
                        iconPlacementPropertyCard
                        blockPropertyCard
                        disabledPropertyCard
                        ghostPropertyCard
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
                        
                        contentFontSizeTokenCard
                        dangerColorTokenCard
                        defaultBgTokenCard
                        defaultBorderColorTokenCard
                        defaultColorTokenCard
                        iconGapTokenCard
                        paddingBlockTokenCard
                        paddingInlineTokenCard
                        paddingInlineLGTokenCard
                        paddingInlineSMTokenCard
                        primaryColorTokenCard
                        
                        Divider().padding(.vertical, Moin.Constants.Spacing.md)
                        
                        // 全局 Token 分组
                        Text(tr("doc.section.global_token"))
                            .font(.title3)
                            .fontWeight(.semibold)
                            .id("global")
                        
                        borderRadiusGlobalTokenCard
                        colorPrimaryGlobalTokenCard
                        controlHeightGlobalTokenCard
                    }
                    .padding(Moin.Constants.Spacing.lg)
                }
                .onAppear { scrollProxy = proxy }
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
            enumValues: ".primary | .success | .warning | .danger | .info | .default | .custom(Color)",
            sectionId: "api"
        ) {
            // 预览：展示所有颜色
            HStack(spacing: Moin.Constants.Spacing.sm) {
                ForEach([Moin.ButtonColor.primary, .success, .warning, .danger, .info], id: \.self) { color in
                    Moin.Button(color.description, color: color, size: .small) {}
                }
            }
        } tryIt: {
            // 试一试 - 按钮组
            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.sm) {
                HStack(spacing: Moin.Constants.Spacing.xs) {
                    ForEach(Moin.ButtonColor.allCases, id: \.self) { color in
                        Button {
                            selectedColor = color
                        } label: {
                            Text(color.description)
                                .font(.system(size: 11))
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(selectedColor == color ? config.token.colorPrimary : Color.secondary.opacity(0.1))
                                .foregroundStyle(selectedColor == color ? .white : .primary)
                                .cornerRadius(4)
                        }
                        .buttonStyle(.plain)
                    }
                }
                Moin.Button("Button", color: selectedColor) {}
            }
        } code: {
            "Moin.Button(\"Button\", color: .\(selectedColor)) {}"
        }
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
                ForEach(Moin.ButtonVariant.allCases, id: \.self) { variant in
                    Moin.Button(variant.description, color: .primary, size: .small, variant: variant) {}
                }
            }
        } tryIt: {
            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.sm) {
                HStack(spacing: Moin.Constants.Spacing.xs) {
                    ForEach(Moin.ButtonVariant.allCases, id: \.self) { variant in
                        Button {
                            selectedVariant = variant
                        } label: {
                            Text(variant.description)
                                .font(.system(size: 11))
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(selectedVariant == variant ? config.token.colorPrimary : Color.secondary.opacity(0.1))
                                .foregroundStyle(selectedVariant == variant ? .white : .primary)
                                .cornerRadius(4)
                        }
                        .buttonStyle(.plain)
                    }
                }
                Moin.Button("Button", color: .primary, variant: selectedVariant) {}
            }
        } code: {
            "Moin.Button(\"Hello\", variant: .\(selectedVariant)) {}"
        }
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
                Moin.Button("Small", color: .primary, size: .small) {}
                Moin.Button("Medium", color: .primary, size: .medium) {}
                Moin.Button("Large", color: .primary, size: .large) {}
            }
        } tryIt: {
            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.sm) {
                HStack(spacing: Moin.Constants.Spacing.xs) {
                    ForEach(Moin.ButtonSize.allCases, id: \.self) { size in
                        Button {
                            selectedSize = size
                        } label: {
                            Text(size.description)
                                .font(.system(size: 11))
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(selectedSize == size ? config.token.colorPrimary : Color.secondary.opacity(0.1))
                                .foregroundStyle(selectedSize == size ? .white : .primary)
                                .cornerRadius(4)
                        }
                        .buttonStyle(.plain)
                    }
                }
                Moin.Button("Button", color: .primary, size: selectedSize) {}
            }
        } code: {
            "Moin.Button(\"Hello\", size: .\(selectedSize)) {}"
        }
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
                Moin.Button("Default", color: .primary, shape: .default) {}
                Moin.Button("Round", color: .primary, shape: .round) {}
                Moin.Button(icon: "plus", color: .primary, shape: .circle) {}
            }
        } tryIt: {
            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.sm) {
                HStack(spacing: Moin.Constants.Spacing.xs) {
                    ForEach(Moin.ButtonShape.allCases, id: \.self) { shape in
                        Button {
                            selectedShape = shape
                        } label: {
                            Text(shape.description)
                                .font(.system(size: 11))
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(selectedShape == shape ? config.token.colorPrimary : Color.secondary.opacity(0.1))
                                .foregroundStyle(selectedShape == shape ? .white : .primary)
                                .cornerRadius(4)
                        }
                        .buttonStyle(.plain)
                    }
                }
                Moin.Button("Button", color: .primary, shape: selectedShape) {}
            }
        } code: {
            "Moin.Button(\"Hello\", shape: .\(selectedShape)) {}"
        }
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
            Moin.Button("Primary Button", color: .primary) {}
        } editor: {
            ColorPresetRow(label: "primaryColor", color: $config.components.button.primaryColor)
        }
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
                Moin.Button("Button", color: .primary) {}
                Text("padding: \(Int(config.components.button.paddingInline))px")
                    .font(.system(size: 11, design: .monospaced))
                    .foregroundStyle(.secondary)
            }
        } editor: {
            TokenValueRow(label: "paddingInline", value: $config.components.button.paddingInline, range: 0...30)
        }
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
    @ViewBuilder let tryIt: () -> TryIt
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
    
    @Localized var tr
    @ObservedObject private var config = Moin.ConfigProvider.shared
    
    var body: some View {
        Moin.BadgeRibbon(text: name, color: .custom(.gray), placement: .end) {
            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.md) {
                // 标题行
                HStack {
                    Text(name)
                        .font(.system(size: 14, weight: .semibold, design: .monospaced))
                        .foregroundStyle(config.token.colorPrimary)
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
                .id("\(sectionId).\(name)")
            
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
            .background(config.isDarkMode ? Color(white: 0.12) : Color(white: 0.98))
            .cornerRadius(Moin.Constants.Radius.sm)
            
            // 试一试
            VStack(alignment: .trailing, spacing: 0) {
                // 标签溢出到上方
                Text(tr("doc.try_it"))
                    .font(.system(size: 10, weight: .medium))
                    .foregroundStyle(config.token.colorPrimary)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 3)
                    .background(config.token.colorPrimary.opacity(0.15))
                    .cornerRadius(3)
                    .offset(y: 8)
                
                HStack {
                    tryIt()
                    Spacer()
                }
                .padding(Moin.Constants.Spacing.md)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(config.token.colorPrimary.opacity(0.05))
                .cornerRadius(Moin.Constants.Radius.sm)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            
            // 代码
            ScrollView(.horizontal, showsIndicators: false) {
                HighlightedCodeView(code: code(), fontSize: 12)
                    .padding(Moin.Constants.Spacing.sm)
            }
            .background(config.isDarkMode ? Color(white: 0.08) : Color(white: 0.96))
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
    @ViewBuilder let editor: () -> Editor
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
    
    @Localized var tr
    @ObservedObject private var config = Moin.ConfigProvider.shared
    
    var body: some View {
        Moin.BadgeRibbon(text: name, color: .custom(.gray), placement: .end) {
            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.md) {
                // 标题行
                HStack {
                    Text(name)
                        .font(.system(size: 14, weight: .semibold, design: .monospaced))
                        .foregroundStyle(config.token.colorPrimary)
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
                .id("\(sectionId).\(name)")
                
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
                .background(config.isDarkMode ? Color(white: 0.12) : Color(white: 0.98))
                .cornerRadius(Moin.Constants.Radius.sm)
                
                // 试一试
                VStack(alignment: .trailing, spacing: 0) {
                    Text(tr("doc.try_it"))
                        .font(.system(size: 10, weight: .medium))
                        .foregroundStyle(config.token.colorPrimary)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 3)
                        .background(config.token.colorPrimary.opacity(0.15))
                        .cornerRadius(3)
                        .offset(y: 8)
                    
                    HStack {
                        editor()
                        Spacer()
                    }
                    .padding(Moin.Constants.Spacing.md)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(config.token.colorPrimary.opacity(0.05))
                    .cornerRadius(Moin.Constants.Radius.sm)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                
                // 代码
                let codeText = code()
                if !codeText.isEmpty {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HighlightedCodeView(code: codeText, fontSize: 12)
                            .padding(Moin.Constants.Spacing.sm)
                    }
                    .background(config.isDarkMode ? Color(white: 0.08) : Color(white: 0.96))
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
    }
}
