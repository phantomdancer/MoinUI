import SwiftUI
import MoinUI

// MARK: - TagTokenView

/// Tag 组件 Token 文档视图
struct TagTokenView: View {
    @Localized var tr
    @ObservedObject var config = Moin.ConfigProvider.shared
    
    @State var selectedItemId: String? = "token"
    @State var scrollPosition: String?
    @State private var targetScrollId: String?
    @State var searchText: String = ""
    
    // 重置所有 Token 到默认值
    private func resetAll() {
        // 重置 Component Token
        config.components.tag = Moin.TagToken.generate(from: config.token)
        
        // 重置 Global Token (涉及到的)
        config.seed.fontSize = 14
        
        // 重新生成
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
                    navSection(title: tr("doc.section.component_token"), items: [
                        "fontSizeLG", "fontSize", "fontSizeSM",
                        "defaultBg", "defaultColor", "solidTextColor", "lineWidth",
                        "paddingHLG", "paddingH", "paddingHSM",
                        "paddingVLG", "paddingV", "paddingVSM",
                        "iconSizeLG", "iconSize", "iconSizeSM",
                        "iconGapLG", "iconGap", "iconGapSM"
                    ], sectionId: "token")
                    
                    navSection(title: tr("doc.section.global_token"), items: ["fontSizeSM"], sectionId: "global")
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
                Text(tr("doc.section.component_token"))
                    .font(.title3)
                    .fontWeight(.semibold)
                    .scrollAnchor("token")

                    // Component - Font
                    tagFontSizeLGTokenCard
                    tagFontSizeTokenCard
                    tagFontSizeSMTokenCard
                    
                    // Component - Color
                    tagDefaultBgTokenCard
                    tagDefaultColorTokenCard
                    tagSolidTextColorTokenCard
                    tagLineWidthTokenCard

                    // Component - Padding H
                    tagPaddingHLGTokenCard
                    tagPaddingHTokenCard
                    tagPaddingHSMTokenCard
                    
                    // Component - Padding V
                    tagPaddingVLGTokenCard
                    tagPaddingVTokenCard
                    tagPaddingVSMTokenCard
                    
                    // Component - Icon Size
                    tagIconSizeLGTokenCard
                    tagIconSizeTokenCard
                    tagIconSizeSMTokenCard
                    
                    // Component - Icon Gap
                    tagIconGapLGTokenCard
                    tagIconGapTokenCard
                    tagIconGapSMTokenCard

                // Global Token 分组
                Text(tr("doc.section.global_token"))
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding(.top, Moin.Constants.Spacing.xl)
                    .scrollAnchor("global")
                
                tagGlobalFontSizeCard
            }
            .padding(Moin.Constants.Spacing.lg)
        }
    }
}
