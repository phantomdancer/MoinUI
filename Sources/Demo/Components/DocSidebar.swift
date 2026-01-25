import SwiftUI
import MoinUI

/// Sidebar Navigation Item Model
struct DocSidebarItem: Identifiable, Equatable {
    var id: String          // 内部 ID，用于锚点和匹配
    var displayName: String // 显示名称，用于 UI 展示

    init(id: String, displayName: String? = nil) {
        self.id = id
        self.displayName = displayName ?? id
    }
}

/// Sidebar Navigation Section Model
struct DocSidebarSection: Identifiable {
    let id = UUID()
    let title: String
    let items: [DocSidebarItem]
    let sectionId: String // Prefix for anchor, e.g. "api" or "token"

    /// 返回排序后的 items，供主内容区和侧边栏共用
    var sortedItems: [DocSidebarItem] {
        items.sorted { $0.displayName < $1.displayName }
    }
}

/// Generic Documentation Sidebar with Search, Grouping, and Sorting
struct DocSidebar<Footer: View>: View {
    let sections: [DocSidebarSection]
    @Binding var selectedItemId: String?
    @Binding var targetScrollId: String?
    
    // Footer content (e.g. Reset button)
    let footer: Footer
    
    @ObservedObject var config = Moin.ConfigProvider.shared
    @State private var searchText: String = ""
    @Localized var tr

    init(
        sections: [DocSidebarSection],
        selectedItemId: Binding<String?>,
        targetScrollId: Binding<String?>,
        @ViewBuilder footer: () -> Footer
    ) {
        self.sections = sections
        self._selectedItemId = selectedItemId
        self._targetScrollId = targetScrollId
        self.footer = footer()
    }

    var body: some View {
        VStack(spacing: 0) {
            // Search Bar
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

            // Navigation List
            ScrollView {
                VStack(alignment: .leading, spacing: Moin.Constants.Spacing.sm) {
                    ForEach(sections) { section in
                        navSection(title: section.title, items: section.items, sectionId: section.sectionId)
                    }
                }
                .padding(Moin.Constants.Spacing.md)
            }
            
            // Footer
            if !(Footer.self == EmptyView.self) { 
                Divider()
                footer
            }
        }
        .background(Color(nsColor: .controlBackgroundColor))
    }

    private func navSection(title: String, items: [DocSidebarItem], sectionId: String) -> some View {
        let sortedItems = items.sorted { $0.displayName < $1.displayName }
        let filteredItems = searchText.isEmpty ? sortedItems : sortedItems.filter { $0.displayName.localizedCaseInsensitiveContains(searchText) }

        return Group {
            if !filteredItems.isEmpty {
                VStack(alignment: .leading, spacing: 0) {
                    Text(title)
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundStyle(.secondary)
                        .padding(.vertical, Moin.Constants.Spacing.xs)

                    ForEach(filteredItems) { item in
                        navItem(item: item, sectionId: sectionId)
                    }
                }
                .padding(.bottom, Moin.Constants.Spacing.md)
            }
        }
    }

    private func navItem(item: DocSidebarItem, sectionId: String) -> some View {
        let itemId = "\(sectionId).\(item.id)"

        return Button {
            selectedItemId = itemId
            targetScrollId = itemId
        } label: {
            HStack(spacing: Moin.Constants.Spacing.xs) {
                Circle()
                    .fill(selectedItemId == itemId ? config.token.colorPrimary : Color.secondary.opacity(0.3))
                    .frame(width: 6, height: 6)
                Text(item.displayName)
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
}

extension DocSidebar where Footer == EmptyView {
    init(
        sections: [DocSidebarSection],
        selectedItemId: Binding<String?>,
        targetScrollId: Binding<String?>
    ) {
        self.init(
            sections: sections,
            selectedItemId: selectedItemId,
            targetScrollId: targetScrollId,
            footer: { EmptyView() }
        )
    }
}
