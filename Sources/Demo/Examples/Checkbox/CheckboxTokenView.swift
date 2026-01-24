import SwiftUI
import MoinUI

// MARK: - CheckboxTokenView

/// Checkbox 组件 Token 文档视图
struct CheckboxTokenView: View {
    @Localized var tr
    @ObservedObject var config = Moin.ConfigProvider.shared

    // MARK: - Interactive States for TOKEN previews
    @State var colorPrimaryChecked = true
    @State var colorBorderChecked = false
    @State var colorBgContainerChecked = false
    @State var colorTextChecked = true
    @State var colorTextDisabledChecked = true
    @State var colorBgDisabledChecked = false
    @State var borderRadiusSMChecked = true
    @State var lineWidthChecked = false
    @State var lineWidthBoldChecked = true
    @State var paddingXSChecked = true
    @State var fontSizeChecked = true
    @State var motionDurationFastChecked = true
    @State var motionDurationMidChecked = true
    @State var motionDurationSlowChecked = true

    // MARK: - Token Sections

    private var tokenSections: [DocSidebarSection] {
        [
            DocSidebarSection(
                title: tr("token.checkbox.global"),
                items: [
                    // Colors - Primary
                    "colorPrimary",
                    // Colors - Border & Background
                    "colorBorder",
                    "colorBgContainer",
                    // Colors - Text & Disabled
                    "colorText",
                    "colorTextDisabled",
                    "colorBgDisabled",
                    // Sizes & Borders
                    "borderRadiusSM",
                    "lineWidth",
                    "lineWidthBold",
                    // Spacing
                    "paddingXS",
                    // Typography
                    "fontSize",
                    // Motion
                    "motionDurationFast",
                    "motionDurationMid",
                    "motionDurationSlow"
                ],
                sectionId: "global"
            )
        ]
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
            sections: tokenSections,
            initialItemId: "global"
        ) { sectionId in
            if sectionId == "global" {
                Text(tr("token.checkbox.global"))
                    .font(.title3)
                    .fontWeight(.semibold)
            }
        } item: { item in
            cardForItem(item)
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
    private func cardForItem(_ item: String) -> some View {
        switch item {
        case "colorPrimary": AnyView(colorPrimaryGlobalTokenCard)
        case "colorBorder": AnyView(colorBorderGlobalTokenCard)
        case "colorBgContainer": AnyView(colorBgContainerGlobalTokenCard)
        case "colorText": AnyView(colorTextGlobalTokenCard)
        case "colorTextDisabled": AnyView(colorTextDisabledGlobalTokenCard)
        case "colorBgDisabled": AnyView(colorBgDisabledGlobalTokenCard)
        case "borderRadiusSM": AnyView(borderRadiusSMGlobalTokenCard)
        case "lineWidth": AnyView(lineWidthGlobalTokenCard)
        case "lineWidthBold": AnyView(lineWidthBoldGlobalTokenCard)
        case "paddingXS": AnyView(paddingXSGlobalTokenCard)
        case "fontSize": AnyView(fontSizeGlobalTokenCard)
        case "motionDurationFast": AnyView(motionDurationFastGlobalTokenCard)
        case "motionDurationMid": AnyView(motionDurationMidGlobalTokenCard)
        case "motionDurationSlow": AnyView(motionDurationSlowGlobalTokenCard)
        default: AnyView(EmptyView())
        }
    }
}

// MARK: - Notification Name Extension

extension Notification.Name {
    static let checkboxDocReset = Notification.Name("checkboxDocReset")
}
