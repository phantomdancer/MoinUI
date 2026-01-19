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
            docSidebar
                .frame(width: 280)
        }
        .background(Color(nsColor: .controlBackgroundColor))
    }
    
    // MARK: - 右栏导航

    // MARK: - Doc Sidebar

    private var docSidebar: some View {
        DocSidebar(
            sections: [
                DocSidebarSection(
                    title: tr("api.button.section.font"),
                    items: ["contentFontSize", "contentFontSizeSM", "contentFontSizeLG", "fontWeight"],
                    sectionId: "token"
                ),
                DocSidebarSection(
                    title: tr("api.button.section.dimensions"),
                    items: ["paddingBlock", "paddingBlockSM", "paddingBlockLG", "paddingInline", "paddingInlineSM", "paddingInlineLG", "iconGap", "onlyIconSize", "onlyIconSizeSM", "onlyIconSizeLG"],
                    sectionId: "token"
                ),
                DocSidebarSection(
                    title: tr("api.button.section.color_primary"),
                    items: ["primaryColor", "solidTextColor", "dangerColor"],
                    sectionId: "token"
                ),
                DocSidebarSection(
                    title: tr("api.button.section.color_default"),
                    items: ["defaultColor", "defaultBg", "defaultBorderColor", "defaultHoverColor", "defaultHoverBg", "defaultHoverBorderColor", "defaultActiveColor", "defaultActiveBg", "defaultActiveBorderColor", "defaultBgDisabled", "borderColorDisabled"],
                    sectionId: "token"
                ),
                DocSidebarSection(
                    title: tr("api.button.section.color_other"),
                    items: ["defaultGhostColor", "defaultGhostBorderColor", "ghostBg", "textTextColor", "textHoverBg", "textTextHoverColor", "textTextActiveColor", "linkHoverBg"],
                    sectionId: "token"
                ),
                DocSidebarSection(
                    title: tr("doc.section.global_token"),
                    items: ["borderRadius", "borderRadiusLG", "borderRadiusSM", "colorPrimary", "colorPrimaryActive", "colorPrimaryHover", "colorTextDisabled", "controlHeight", "controlHeightLG", "controlHeightSM", "motionDurationMid", "motionDurationSlow", "motionEase"],
                    sectionId: "global"
                )
            ],
            selectedItemId: $selectedItemId,
            targetScrollId: $targetScrollId
        ) {
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

    // MARK: - 主内容区
    
    private var mainContent: some View {
        VStack(spacing: 0) {

            
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
