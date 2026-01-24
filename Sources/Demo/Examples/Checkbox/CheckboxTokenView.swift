import SwiftUI
import MoinUI

// MARK: - CheckboxTokenView

/// Checkbox 组件 Token 文档视图
struct CheckboxTokenView: View {
    @Localized var tr
    @ObservedObject var config = Moin.ConfigProvider.shared

    // MARK: - Token Sections

    // Component Tokens Sections
    private var componentSections: [DocSidebarSection] {
        [
            DocSidebarSection(
                title: tr("doc.section.component_token"),
                items: ["checkboxSize", "borderRadius", "lineWidth", "lineWidthBold"],
                sectionId: "component"
            ),
            DocSidebarSection(
                title: tr("doc.section.colors"),
                items: ["colorPrimary", "colorPrimaryHover", "colorBorder", "colorBgContainer", "colorWhite"],
                sectionId: "component"
            ),
            DocSidebarSection(
                title: tr("doc.section.disabled"),
                items: ["colorBgContainerDisabled", "colorBorderDisabled", "colorTextDisabled"],
                sectionId: "component"
            ),
            DocSidebarSection(
                title: tr("doc.section.layout"),
                items: ["paddingXS", "motionDurationSlow"],
                sectionId: "component"
            )
        ]
    }

    // Global Tokens Sections
    private var globalSections: [DocSidebarSection] {
        [
            DocSidebarSection(
                title: tr("doc.section.global_token"),
                items: [
                    "borderRadiusSM", "lineWidth", "lineWidthBold",
                    "colorPrimary", "colorPrimaryHover",
                    "colorBorder", "colorBgContainer", "colorBgDisabled",
                    "colorTextDisabled", "paddingXS", "motionDurationSlow"
                ],
                sectionId: "global"
            )
        ]
    }

    private var allSections: [DocSidebarSection] {
        componentSections + globalSections
    }

    // 重置所有 Token 到默认值
    private func resetAll() {
        // 重置全局token
        config.seed = Moin.SeedToken.default
        config.regenerateTokens()

        // 重置组件 Token
        config.components.checkbox = .resolve(token: config.token)

        // 通知重置
        NotificationCenter.default.post(name: .checkboxDocReset, object: nil)
    }

    var body: some View {
        ComponentDocBody(
            sections: allSections,
            initialItemId: "component"
        ) { sectionId in
            if sectionId == "component" {
                Text(tr("doc.section.component_token"))
                    .font(.title3)
                    .fontWeight(.semibold)
            } else if sectionId == "global" {
                Text(tr("doc.section.global_token"))
                    .font(.title3)
                    .fontWeight(.semibold)
            }
        } item: { item in
            if globalSections.flatMap({ $0.items }).contains(item) {
                cardForItem(item, sectionId: "global")
            } else {
                cardForItem(item, sectionId: "component")
            }
        } footer: {
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

    // MARK: - Item -> Card 映射

    @ViewBuilder
    private func cardForItem(_ item: String, sectionId: String) -> some View {
        if sectionId == "component" {
            switch item {
            case "checkboxSize": AnyView(checkboxSizeTokenCard)
            case "borderRadius": AnyView(borderRadiusTokenCard)
            case "lineWidth": AnyView(lineWidthTokenCard)
            case "lineWidthBold": AnyView(lineWidthBoldTokenCard)
            case "colorPrimary": AnyView(colorPrimaryTokenCard)
            case "colorPrimaryHover": AnyView(colorPrimaryHoverTokenCard)
            case "colorBorder": AnyView(colorBorderTokenCard)
            case "colorBgContainer": AnyView(colorBgContainerTokenCard)
            case "colorWhite": AnyView(colorWhiteTokenCard)
            case "colorBgContainerDisabled": AnyView(colorBgContainerDisabledTokenCard)
            case "colorBorderDisabled": AnyView(colorBorderDisabledTokenCard)
            case "colorTextDisabled": AnyView(colorTextDisabledTokenCard)
            case "paddingXS": AnyView(paddingXSTokenCard)
            case "motionDurationSlow": AnyView(motionDurationSlowTokenCard)
            default: AnyView(EmptyView())
            }
        } else {
            // global
            switch item {
            case "borderRadiusSM": AnyView(borderRadiusSMGlobalTokenCard)
            case "lineWidth": AnyView(lineWidthGlobalTokenCard)
            case "lineWidthBold": AnyView(lineWidthBoldGlobalTokenCard)
            case "colorPrimary": AnyView(colorPrimaryGlobalTokenCard)
            case "colorPrimaryHover": AnyView(colorPrimaryHoverGlobalTokenCard)
            case "colorBorder": AnyView(colorBorderGlobalTokenCard)
            case "colorBgContainer": AnyView(colorBgContainerGlobalTokenCard)
            case "colorBgDisabled": AnyView(colorBgDisabledGlobalTokenCard)
            case "colorTextDisabled": AnyView(colorTextDisabledGlobalTokenCard)
            case "paddingXS": AnyView(paddingXSGlobalTokenCard)
            case "motionDurationSlow": AnyView(motionDurationSlowGlobalTokenCard)
            default: AnyView(EmptyView())
            }
        }
    }
}

// MARK: - Notification Name Extension

extension Notification.Name {
    static let checkboxDocReset = Notification.Name("checkboxDocReset")
}
