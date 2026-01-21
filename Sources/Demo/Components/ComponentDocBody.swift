import SwiftUI
import MoinUI

/// 通用组件文档视图框架
///
/// 提供标准的左侧内容（LazyStack + ScrollSpy）+ 右侧导航（Sticky + Search）布局。
/// 自动处理锚点同步、滚动跳转等逻辑。
struct ComponentDocBody<ItemView: View, HeaderView: View, Footer: View>: View {
    
    // MARK: - Properties
    
    let sections: [DocSidebarSection]
    
    // Builders
    @ViewBuilder let headerBuilder: (String) -> HeaderView
    @ViewBuilder let itemBuilder: (String) -> ItemView
    @ViewBuilder let footerBuilder: () -> Footer
    
    // State
    @State private var selectedItemId: String?
    @State private var targetScrollId: String?
    
    // Configuration
    private let initialItemId: String?
    
    // MARK: - Init
    
    init(
        sections: [DocSidebarSection],
        initialItemId: String? = nil,
        @ViewBuilder header: @escaping (String) -> HeaderView,
        @ViewBuilder item: @escaping (String) -> ItemView,
        @ViewBuilder footer: @escaping () -> Footer = { EmptyView() }
    ) {
        self.sections = sections
        self.initialItemId = initialItemId
        self.headerBuilder = header
        self.itemBuilder = item
        self.footerBuilder = footer
        
        // Initialize state
        _selectedItemId = State(initialValue: initialItemId)
    }
    
    // MARK: - Body
    
    var body: some View {
        HStack(spacing: 0) {
            // Main Content Area
            AnchorScrollView(targetScrollId: $targetScrollId, currentScrollId: $selectedItemId) {
                VStack(alignment: .leading, spacing: Moin.Constants.Spacing.xl) {
                    
                    ForEach(groupedSections, id: \.id) { group in
                        VStack(alignment: .leading, spacing: Moin.Constants.Spacing.xl) {
                            // Section Header (e.g. "API" or "Component Token")
                            headerBuilder(group.id)
                                .scrollAnchor(group.id) // Anchor for the header itself
                            
                            // Items in this group
                            ForEach(group.sections) { section in
                                // We flatten sub-sections (like "Style", "Feature") here, 
                                // only displaying their items.
                                ForEach(section.sortedItems, id: \.self) { item in
                                    // Extract ID part (before |) for itemBuilder
                                    let itemId = item.split(separator: "|", maxSplits: 1).first.map(String.init) ?? item
                                    itemBuilder(itemId)
                                }
                            }
                            
                            // Add a divider if it's not the last group
                            if group.id != groupedSections.last?.id {
                                Divider()
                            }
                        }
                    }
                }
                .padding(Moin.Constants.Spacing.lg)
                .padding(.bottom, 100) // Extra padding at bottom
            }
            .onAppear {
                // Ensure initial selection is set if provided
                if selectedItemId == nil, let initial = initialItemId {
                    selectedItemId = initial
                }
            }
            
            Divider()
            
            // Sidebar Area
            DocSidebar(
                sections: sections,
                selectedItemId: $selectedItemId,
                targetScrollId: $targetScrollId,
                footer: footerBuilder
            )
            .frame(width: 280)
        }
        .background(Color(nsColor: .controlBackgroundColor))
    }
    
    // MARK: - Helpers
    
    /// Group consecutive sections by `sectionId`
    private var groupedSections: [(id: String, sections: [DocSidebarSection])] {
        var result: [(id: String, sections: [DocSidebarSection])] = []
        for section in sections {
            if let last = result.last, last.id == section.sectionId {
                result[result.count - 1].sections.append(section)
            } else {
                result.append((id: section.sectionId, sections: [section]))
            }
        }
        return result
    }
}
