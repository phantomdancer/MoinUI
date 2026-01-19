import SwiftUI
import MoinUI

// MARK: - TypographyAPIView

/// Typography 组件 API 文档视图
struct TypographyAPIView: View {
    @Localized var tr
    @ObservedObject var config = Moin.ConfigProvider.shared
    
    @State var selectedItemId: String? = "api"
    @State private var targetScrollId: String?
    @State var searchText: String = ""
    
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
                    navSection(title: tr("api.typography.section.common"), items: ["content", "type", "disabled"], sectionId: "api")
                    navSection(title: tr("api.typography.section.styles"), items: ["mark", "underline", "delete", "strong", "italic", "code", "keyboard"], sectionId: "api")
                    navSection(title: tr("api.typography.section.title"), items: ["level"], sectionId: "api")
                    navSection(title: tr("api.typography.section.paragraph"), items: ["ellipsis"], sectionId: "api")
                    navSection(title: tr("api.typography.section.link"), items: ["href", "action"], sectionId: "api")
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
        // 可滚动内容
        AnchorScrollView(targetScrollId: $targetScrollId, currentScrollId: $selectedItemId) {
            LazyVStack(alignment: .leading, spacing: Moin.Constants.Spacing.xl) {
                // API 分组标题
                Text(tr("doc.section.api"))
                    .font(.title3)
                    .fontWeight(.semibold)
                    .scrollAnchor("api")

                // Common
                contentPropertyCard
                typePropertyCard
                disabledPropertyCard
                
                // Styles
                markPropertyCard
                underlinePropertyCard
                deletePropertyCard
                strongPropertyCard
                italicPropertyCard
                codePropertyCard
                keyboardPropertyCard
                
                // Title
                levelPropertyCard
                
                // Paragraph
                ellipsisPropertyCard
                
                // Link
                hrefPropertyCard
                actionPropertyCard
            }
            .padding(Moin.Constants.Spacing.lg)
        }
    }
    
    // MARK: - Common Property Cards
    
    private var contentPropertyCard: some View {
        PropertyCard(
            name: "content",
            type: "String",
            defaultValue: "-",
            description: tr("api.typography.content"),
            sectionId: "api"
        ) {
            Moin.Typography.Text(tr("typography.example.default"))
        } code: {
            "Moin.Typography.Text(\"\(tr("typography.example.default"))\")"
        }
        .scrollAnchor("api.content")
    }

    private var typePropertyCard: some View {
        PropertyCard(
            name: "type",
            type: "Moin.Typography.TextType",
            defaultValue: ".default",
            description: tr("api.typography.type"),
            enumValues: ".default | .secondary | .success | .warning | .danger",
            sectionId: "api"
        ) {
            VStack(alignment: .leading, spacing: 4) {
                Moin.Typography.Text(tr("typography.example.type_default"), type: .default)
                Moin.Typography.Text(tr("typography.example.type_secondary"), type: .secondary)
                Moin.Typography.Text(tr("typography.example.type_success"), type: .success)
                Moin.Typography.Text(tr("typography.example.type_warning"), type: .warning)
                Moin.Typography.Text(tr("typography.example.type_danger"), type: .danger)
            }
        } code: {
            """
            Moin.Typography.Text("\(tr("typography.example.type_default"))", type: .default)
            Moin.Typography.Text("\(tr("typography.example.type_secondary"))", type: .secondary)
            """
        }
        .scrollAnchor("api.type")
    }
    
    private var disabledPropertyCard: some View {
        PropertyCard(
            name: "disabled",
            type: "Bool",
            defaultValue: "false",
            description: tr("api.typography.disabled"),
            sectionId: "api"
        ) {
            Moin.Typography.Text(tr("typography.example.type_disabled"), disabled: true)
        } code: {
            """
            Moin.Typography.Text("\(tr("typography.example.type_disabled"))", disabled: true)
            """
        }
        .scrollAnchor("api.disabled")
    }

    // MARK: - Styles Property Cards
    
    private var markPropertyCard: some View {
        PropertyCard(
            name: "mark",
            type: "Bool",
            defaultValue: "false",
            description: tr("api.typography.mark"),
            sectionId: "api"
        ) {
            Moin.Typography.Text(tr("typography.example.mark"), mark: true)
        } code: {
            "Moin.Typography.Text(\"\(tr("typography.example.mark"))\", mark: true)"
        }
        .scrollAnchor("api.mark")
    }
    
    private var underlinePropertyCard: some View {
        PropertyCard(
            name: "underline",
            type: "Bool",
            defaultValue: "false",
            description: tr("api.typography.underline"),
            sectionId: "api"
        ) {
            Moin.Typography.Text(tr("typography.example.underline"), underline: true)
        } code: {
            "Moin.Typography.Text(\"\(tr("typography.example.underline"))\", underline: true)"
        }
        .scrollAnchor("api.underline")
    }
    
    private var deletePropertyCard: some View {
        PropertyCard(
            name: "delete",
            type: "Bool",
            defaultValue: "false",
            description: tr("api.typography.delete"),
            sectionId: "api"
        ) {
            Moin.Typography.Text(tr("typography.example.delete"), delete: true)
        } code: {
            "Moin.Typography.Text(\"\(tr("typography.example.delete"))\", delete: true)"
        }
        .scrollAnchor("api.delete")
    }
    
    private var strongPropertyCard: some View {
        PropertyCard(
            name: "strong",
            type: "Bool",
            defaultValue: "false",
            description: tr("api.typography.strong"),
            sectionId: "api"
        ) {
            Moin.Typography.Text(tr("typography.example.strong"), strong: true)
        } code: {
            "Moin.Typography.Text(\"\(tr("typography.example.strong"))\", strong: true)"
        }
        .scrollAnchor("api.strong")
    }
    
    private var italicPropertyCard: some View {
        PropertyCard(
            name: "italic",
            type: "Bool",
            defaultValue: "false",
            description: tr("api.typography.italic"),
            sectionId: "api"
        ) {
            Moin.Typography.Text(tr("typography.example.italic"), italic: true)
        } code: {
            "Moin.Typography.Text(\"\(tr("typography.example.italic"))\", italic: true)"
        }
        .scrollAnchor("api.italic")
    }
    
    private var codePropertyCard: some View {
        PropertyCard(
            name: "code",
            type: "Bool",
            defaultValue: "false",
            description: tr("api.typography.code"),
            sectionId: "api"
        ) {
            Moin.Typography.Text(tr("typography.example.code"), code: true)
        } code: {
            "Moin.Typography.Text(\"\(tr("typography.example.code"))\", code: true)"
        }
        .scrollAnchor("api.code")
    }
    
    private var keyboardPropertyCard: some View {
        PropertyCard(
            name: "keyboard",
            type: "Bool",
            defaultValue: "false",
            description: tr("api.typography.keyboard"),
            sectionId: "api"
        ) {
            Moin.Typography.Text("Cmd + C", keyboard: true) // Keyboard text usually stays literal or has specific keys
        } code: {
            "Moin.Typography.Text(\"Cmd + C\", keyboard: true)"
        }
        .scrollAnchor("api.keyboard")
    }
    
    // MARK: - Title Property Cards
    
    private var levelPropertyCard: some View {
        PropertyCard(
            name: "level",
            type: "Moin.Typography.TitleLevel",
            defaultValue: ".h1",
            description: tr("api.typography.level"),
            enumValues: ".h1 | .h2 | .h3 | .h4 | .h5",
            sectionId: "api"
        ) {
            VStack(alignment: .leading, spacing: 4) {
                Moin.Typography.Title(tr("typography.example.h1"), level: .h1)
                Moin.Typography.Title(tr("typography.example.h2"), level: .h2)
                Moin.Typography.Title(tr("typography.example.h3"), level: .h3)
            }
        } code: {
            """
            Moin.Typography.Title("\(tr("typography.example.h1"))", level: .h1)
            Moin.Typography.Title("\(tr("typography.example.h2"))", level: .h2)
            """
        }
        .scrollAnchor("api.level")
    }
    
    // MARK: - Paragraph Property Cards
    
    private var ellipsisPropertyCard: some View {
        PropertyCard(
            name: "ellipsis",
            type: "Moin.Typography.EllipsisConfig?",
            defaultValue: "nil",
            description: tr("typography.ellipsis_desc"),
            sectionId: "api"
        ) {
            VStack(alignment: .leading, spacing: 8) {
                Moin.Typography.Paragraph(tr("typography.lorem_long"), ellipsis: .rows(1))
                Moin.Typography.Paragraph(tr("typography.lorem_long"), ellipsis: .expandable(rows: 2))
            }
        } code: {
            """
            Moin.Typography.Paragraph("\(tr("typography.lorem_long"))", ellipsis: .rows(1))
            Moin.Typography.Paragraph("\(tr("typography.lorem_long"))", ellipsis: .expandable(rows: 2))
            """
        }
        .scrollAnchor("api.ellipsis")
    }
    
    // MARK: - Link Property Cards
    
    private var hrefPropertyCard: some View {
        PropertyCard(
            name: "href",
            type: "URL?",
            defaultValue: "nil",
            description: tr("api.typography.href"),
            sectionId: "api"
        ) {
            Moin.Typography.Link("MoinUI", href: URL(string: "https://github.com/phantomdancer/MoinUI.git"))
        } code: {
            "Moin.Typography.Link(\"MoinUI\", href: URL(string: \"...\"))"
        }
        .scrollAnchor("api.href")
    }
    
    private var actionPropertyCard: some View {
        PropertyCard(
            name: "action",
            type: "() -> Void",
            defaultValue: "nil",
            description: tr("api.typography.action"),
            sectionId: "api"
        ) {
            Moin.Typography.Link(tr("typography.example.link")) { print("Clicked") }
        } code: {
            "Moin.Typography.Link(\"\(tr("typography.example.link"))\") { print(\"Clicked\") }"
        }
        .scrollAnchor("api.action")
    }
}
