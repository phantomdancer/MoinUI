import SwiftUI
import MoinUI

// MARK: - 文档区块模型

/// 文档分组类型
enum DocSectionType: String, CaseIterable {
    case api
    case componentToken
    case globalToken
    
    var titleKey: String {
        switch self {
        case .api: return "doc.section.api"
        case .componentToken: return "doc.section.component_token"
        case .globalToken: return "doc.section.global_token"
        }
    }
}

/// 文档分组
struct DocSection: Identifiable {
    let id: String
    let title: String
    let type: DocSectionType
    let items: [DocItem]
}

/// 文档项（属性或Token）
struct DocItem: Identifiable {
    let id: String
    let name: String
    let dataType: String
    let defaultValue: String
    let description: String
    let codeExample: String?
    
    init(
        name: String,
        dataType: String,
        defaultValue: String = "-",
        description: String,
        codeExample: String? = nil
    ) {
        self.id = name
        self.name = name
        self.dataType = dataType
        self.defaultValue = defaultValue
        self.description = description
        self.codeExample = codeExample
    }
}

// MARK: - 三栏布局容器

/// 组件文档视图 - 三栏布局
struct ComponentDocView<Preview: View, Controls: View>: View {
    let componentName: String
    let apiItems: [DocItem]
    let componentTokenItems: [DocItem]
    let globalTokenItems: [DocItem]
    @ViewBuilder let preview: () -> Preview
    @ViewBuilder let controls: () -> Controls
    
    @State private var selectedItemId: String?
    @State private var scrollProxy: ScrollViewProxy?
    @ObservedObject private var config = Moin.ConfigProvider.shared
    @Localized var tr
    
    private var sections: [DocSection] {
        [
            DocSection(
                id: "api",
                title: tr("doc.section.api"),
                type: .api,
                items: apiItems
            ),
            DocSection(
                id: "component_token",
                title: tr("doc.section.component_token"),
                type: .componentToken,
                items: componentTokenItems
            ),
            DocSection(
                id: "global_token",
                title: tr("doc.section.global_token"),
                type: .globalToken,
                items: globalTokenItems
            )
        ]
    }
    
    var body: some View {
        HStack(spacing: 0) {
            // 左栏：导航树
            navigationSidebar
                .frame(width: 200)
            
            Divider()
            
            // 中栏：详情内容
            detailContent
            
            Divider()
            
            // 右栏：预览与控制
            previewPanel
                .frame(width: 360)
        }
        .background(Color(nsColor: .controlBackgroundColor))
    }
    
    // MARK: - 左栏：导航树
    
    private var navigationSidebar: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.sm) {
                ForEach(sections) { section in
                    sectionGroup(section)
                }
            }
            .padding(Moin.Constants.Spacing.md)
        }
    }
    
    private func sectionGroup(_ section: DocSection) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            // 分组标题
            Text(section.title)
                .font(.system(size: 11, weight: .semibold))
                .foregroundStyle(.secondary)
                .padding(.vertical, Moin.Constants.Spacing.xs)
            
            // 子项列表
            ForEach(section.items) { item in
                navItem(item, sectionId: section.id)
            }
        }
        .padding(.bottom, Moin.Constants.Spacing.md)
    }
    
    private func navItem(_ item: DocItem, sectionId: String) -> some View {
        Button {
            selectedItemId = "\(sectionId).\(item.id)"
            scrollProxy?.scrollTo("\(sectionId).\(item.id)", anchor: .top)
        } label: {
            HStack(spacing: Moin.Constants.Spacing.xs) {
                Circle()
                    .fill(selectedItemId == "\(sectionId).\(item.id)" ? config.token.colorPrimary : Color.secondary.opacity(0.3))
                    .frame(width: 6, height: 6)
                Text(item.name)
                    .font(.system(size: 12, design: .monospaced))
                    .foregroundStyle(selectedItemId == "\(sectionId).\(item.id)" ? config.token.colorPrimary : .primary)
                Spacer()
            }
            .padding(.vertical, 4)
            .padding(.horizontal, Moin.Constants.Spacing.sm)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .background(selectedItemId == "\(sectionId).\(item.id)" ? config.token.colorPrimary.opacity(0.1) : .clear)
        .cornerRadius(Moin.Constants.Radius.sm)
    }
    
    // MARK: - 中栏：详情内容
    
    private var detailContent: some View {
        ScrollViewReader { proxy in
            ScrollView {
                VStack(alignment: .leading, spacing: Moin.Constants.Spacing.xl) {
                    ForEach(sections) { section in
                        sectionContent(section)
                    }
                }
                .padding(Moin.Constants.Spacing.lg)
            }
            .onAppear { scrollProxy = proxy }
        }
    }
    
    private func sectionContent(_ section: DocSection) -> some View {
        VStack(alignment: .leading, spacing: Moin.Constants.Spacing.lg) {
            // 分组标题
            Text(section.title)
                .font(.title2)
                .fontWeight(.semibold)
                .id(section.id)
            
            Divider()
            
            // 各项详情
            ForEach(section.items) { item in
                itemDetail(item, section: section)
            }
        }
    }
    
    private func itemDetail(_ item: DocItem, section: DocSection) -> some View {
        VStack(alignment: .leading, spacing: Moin.Constants.Spacing.sm) {
            // 属性名
            Text(item.name)
                .font(.system(size: 16, weight: .medium, design: .monospaced))
                .foregroundStyle(config.token.colorPrimary)
                .id("\(section.id).\(item.id)")
            
            // 类型 / 默认值
            HStack(spacing: Moin.Constants.Spacing.lg) {
                Label {
                    Text(item.dataType)
                        .font(.system(size: 12, design: .monospaced))
                } icon: {
                    Text(tr("doc.type"))
                        .font(.system(size: 11))
                        .foregroundStyle(.secondary)
                }
                
                Label {
                    Text(item.defaultValue)
                        .font(.system(size: 12, design: .monospaced))
                } icon: {
                    Text(tr("doc.default"))
                        .font(.system(size: 11))
                        .foregroundStyle(.secondary)
                }
            }
            
            // 说明
            Text(item.description)
                .font(.system(size: 13))
                .foregroundStyle(.secondary)
                .padding(.top, Moin.Constants.Spacing.xs)
            
            // 示例代码
            if let code = item.codeExample {
                ScrollView(.horizontal, showsIndicators: false) {
                    HighlightedCodeView(code: code, fontSize: 11)
                        .padding(Moin.Constants.Spacing.sm)
                }
                .background(config.isDarkMode ? Color(white: 0.08) : Color(white: 0.96))
                .cornerRadius(Moin.Constants.Radius.sm)
            }
            
            Divider()
                .padding(.top, Moin.Constants.Spacing.sm)
        }
    }
    
    // MARK: - 右栏：预览与控制
    
    private var previewPanel: some View {
        VStack(spacing: 0) {
            // 预览区
            VStack(spacing: Moin.Constants.Spacing.sm) {
                HStack {
                    Text(tr("doc.preview"))
                        .font(.system(size: 11, weight: .medium))
                        .foregroundStyle(.secondary)
                    Spacer()
                }
                
                Spacer()
                preview()
                Spacer()
            }
            .padding(Moin.Constants.Spacing.md)
            .frame(height: 180)
            
            Divider()
            
            // 控制面板
            ScrollView {
                controls()
                    .padding(Moin.Constants.Spacing.md)
            }
        }
    }
}
