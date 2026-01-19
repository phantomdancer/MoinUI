import SwiftUI
import MoinUI

// MARK: - TagAPIView

/// Tag 组件 API 文档视图
struct TagAPIView: View {
    @Localized var tr
    @ObservedObject var config = Moin.ConfigProvider.shared
    
    @State var selectedItemId: String? = "api"
    @State var scrollPosition: String?
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
                    navSection(title: "API", items: ["color", "variant", "size", "round", "icon", "closable", "checkable"], sectionId: "api")
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
                // API 分组
                Text("API")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .scrollAnchor("api")

                colorPropertyCard
                variantPropertyCard
                sizePropertyCard
                roundPropertyCard
                iconPropertyCard
                closablePropertyCard
                checkablePropertyCard
            }
            .padding(Moin.Constants.Spacing.lg)
        }
    }
    
    // MARK: - Property Cards
    
    private var colorPropertyCard: some View {
        PropertyCard(
            name: "color",
            type: "Moin.TagColor",
            defaultValue: ".default",
            description: tr("tag.api.color"),
            enumValues: ".default | .success | .processing | .warning | .error | .custom(Color) | .magenta | .red | .volcano | .orange | .gold | .lime | .green | .cyan | .blue | .geekblue | .purple",
            sectionId: "api"
        ) {
            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.sm) {
                Text(tr("tag.semantic_colors")).font(.caption).foregroundStyle(.secondary)
                HStack {
                    Moin.Tag(tr("tag.example.default"), color: .default)
                    Moin.Tag(tr("tag.example.success"), color: .success)
                    Moin.Tag(tr("tag.example.processing"), color: .processing)
                    Moin.Tag(tr("tag.example.warning"), color: .warning)
                    Moin.Tag(tr("tag.example.error"), color: .error)
                }
                
                Text(tr("tag.preset_colors")).font(.caption).foregroundStyle(.secondary)
                HStack {
                    Moin.Tag(tr("tag.example.custom3"), color: .magenta)
                    Moin.Tag(tr("tag.example.custom1"), color: .purple) // mapped to violet/custom1 for variety
                    Moin.Tag(tr("tag.example.custom2"), color: .cyan) // mapped to teal/custom2
                    Moin.Tag("Orange", color: .orange)
                    Moin.Tag("Gold", color: .gold)
                }
            }
        } code: {
            let def = tr("tag.example.default")
            let suc = tr("tag.example.success")
            return """
            Moin.Tag("\(def)", color: .default)
            Moin.Tag("\(suc)", color: .success)
            """
        }
        .scrollAnchor("api.color")
    }
    
    private var variantPropertyCard: some View {
        PropertyCard(
            name: "variant",
            type: "Moin.TagVariant",
            defaultValue: ".filled",
            description: tr("tag.api.variant"),
            enumValues: ".filled | .outlined | .solid | .borderless",
            sectionId: "api"
        ) {
            HStack {
                Moin.Tag(tr("tag.example.filled"), variant: .filled)
                Moin.Tag(tr("tag.example.outlined"), variant: .outlined)
                Moin.Tag(tr("tag.example.solid"), variant: .solid)
                Moin.Tag(tr("tag.example.borderless"), variant: .borderless)
            }
        } code: {
            let label = tr("tag.example.filled")
            return "Moin.Tag(\"\(label)\", variant: .filled)"
        }
        .scrollAnchor("api.variant")
    }
    
    private var sizePropertyCard: some View {
        PropertyCard(
            name: "size",
            type: "Moin.TagSize",
            defaultValue: ".medium",
            description: tr("tag.api.size"),
            enumValues: ".small | .medium | .large",
            sectionId: "api"
        ) {
            HStack(alignment: .center) {
                Moin.Tag(tr("tag.example.small"), size: .small)
                Moin.Tag(tr("tag.example.medium"), size: .medium)
                Moin.Tag(tr("tag.example.large"), size: .large)
            }
        } code: {
            let label = tr("tag.example.medium")
            return "Moin.Tag(\"\(label)\", size: .medium)"
        }
        .scrollAnchor("api.size")
    }
    
    private var roundPropertyCard: some View {
        PropertyCard(
            name: "round",
            type: "Bool",
            defaultValue: "false",
            description: tr("tag.api.round"),
            sectionId: "api"
        ) {
            HStack {
                Moin.Tag(tr("tag.label.normal"), round: false)
                Moin.Tag(tr("tag.label.round"), round: true)
            }
        } code: {
            let label = tr("tag.label.round")
            return "Moin.Tag(\"\(label)\", round: true)"
        }
        .scrollAnchor("api.round")
    }
    
    private var iconPropertyCard: some View {
        PropertyCard(
            name: "icon",
            type: "String?",
            defaultValue: "nil",
            description: tr("tag.api.icon"),
            sectionId: "api"
        ) {
            HStack {
                Moin.Tag(tr("tag.example.apple"), icon: "apple.logo")
                Moin.Tag(tr("tag.example.star"), color: .gold, icon: "star.fill")
            }
        } code: {
            let label = tr("tag.example.apple")
            return "Moin.Tag(\"\(label)\", icon: \"apple.logo\")"
        }
        .scrollAnchor("api.icon")
    }
    
    private var closablePropertyCard: some View {
        PropertyCard(
            name: "closable",
            type: "Bool",
            defaultValue: "false",
            description: tr("tag.api.closable"),
            sectionId: "api"
        ) {
            HStack {
                Moin.Tag(tr("tag.label.closable"), closable: true) { print("Closed") }
            }
        } code: {
            let label = tr("tag.label.closable")
            return "Moin.Tag(\"\(label)\", closable: true)"
        }
        .scrollAnchor("api.closable")
    }
    
    private var checkablePropertyCard: some View {
        PropertyCard(
            name: "checkable",
            type: "Moin.CheckableTag",
            defaultValue: "-",
            description: tr("tag.api.checkable"),
            sectionId: "api"
        ) {
            CheckableTagDemo()
        } code: {
            let label = tr("tag.label.check_me")
            return """
            @State var checked = false
            Moin.CheckableTag("\(label)", isChecked: $checked)
            """
        }
        .scrollAnchor("api.checkable")
    }
}

// 辅助 View 解决闭包中 State 问题
private struct CheckableTagDemo: View {
    @State private var checked = false
    @Localized var tr
    var body: some View {
        Moin.CheckableTag(tr("tag.label.check_me"), isChecked: $checked)
    }
}
