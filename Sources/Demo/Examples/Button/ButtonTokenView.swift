import SwiftUI
import MoinUI

// MARK: - ButtonTokenView

/// Button 组件 Token 文档视图
struct ButtonTokenView: View {
    @Localized var tr
    @ObservedObject var config = Moin.ConfigProvider.shared
    
    @State var selectedItemId: String? = "token"
    @State var scrollPosition: String?
    @State private var targetScrollId: String?
    @State var searchText: String = ""
    
    // 重置所有 Token 到默认值
    private func resetAll() {
        // 重置全局token
        config.seed.colorPrimary = Moin.Colors.blue
        config.seed.borderRadius = 6
        config.seed.controlHeight = 32
        config.seed.motionUnit = 0.1 // 重置动画 Unit
        config.seed.motionBase = 2   // 重置动画 Base
        config.regenerateTokens()
        // 通知重置
        NotificationCenter.default.post(name: .buttonDocReset, object: nil)
    }
    
    var body: some View {
        HStack(spacing: 0) {
            // 左栏：Token 卡片列表
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
                    navSection(title: tr("doc.section.component_token"), items: ["borderColorDisabled", "contentFontSize", "contentFontSizeLG", "contentFontSizeSM", "dangerColor", "defaultActiveBg", "defaultActiveBorderColor", "defaultActiveColor", "defaultBg", "defaultBgDisabled", "defaultBorderColor", "defaultColor", "defaultGhostBorderColor", "defaultGhostColor", "defaultHoverBg", "defaultHoverBorderColor", "defaultHoverColor", "fontWeight", "ghostBg", "iconGap", "linkHoverBg", "onlyIconSize", "onlyIconSizeLG", "onlyIconSizeSM", "paddingBlock", "paddingBlockLG", "paddingBlockSM", "paddingInline", "paddingInlineLG", "paddingInlineSM", "primaryColor", "solidTextColor", "textHoverBg", "textTextActiveColor", "textTextColor", "textTextHoverColor"], sectionId: "token")
                    navSection(title: tr("doc.section.global_token"), items: ["borderRadius", "borderRadiusLG", "borderRadiusSM", "colorPrimary", "colorPrimaryActive", "colorPrimaryHover", "colorTextDisabled", "controlHeight", "controlHeightLG", "controlHeightSM", "motionDurationMid", "motionDurationSlow", "motionEase"], sectionId: "global")
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
                Moin.Button(tr("playground.token.reset"), color: .primary, variant: .solid) {
                    resetAll()
                }
                Spacer()
            }
            .padding(.horizontal, Moin.Constants.Spacing.lg)
            .padding(.vertical, Moin.Constants.Spacing.sm)
            
            // 可滚动内容
            AnchorScrollView(targetScrollId: $targetScrollId, currentScrollId: $selectedItemId) {
                LazyVStack(alignment: .leading, spacing: Moin.Constants.Spacing.xl) {
                    // Token 分组
                    Text(tr("doc.section.component_token"))
                        .font(.title3)
                        .fontWeight(.semibold)
                        .scrollAnchor("token")

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
                        .scrollAnchor("global")

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
                    motionDurationMidGlobalTokenCard
                    motionDurationSlowGlobalTokenCard
                    motionEaseGlobalTokenCard
                }
                .padding(Moin.Constants.Spacing.lg)
            }
        }
    }
}
