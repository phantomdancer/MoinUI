import SwiftUI
import MoinUI

// MARK: - RadioTokenView

/// Radio 组件 Token 文档视图
struct RadioTokenView: View {
    @Localized var tr
    @ObservedObject var config = Moin.ConfigProvider.shared

    // MARK: - Interactive States for TOKEN previews
    @State var checked = true
    
    // MARK: - Token Sections

    private var tokenSections: [DocSidebarSection] {
        [
            DocSidebarSection(
                title: tr("token.radio.global"),
                items: [
                    // Colors - Primary
                    "colorPrimary",
                    // Colors - Border & Background
                    "colorBorder",
                    "colorBgContainer",
                    "colorDot",
                    // Colors - Disabled
                    "colorBgContainerDisabled",
                    "colorBorderDisabled",
                    "colorTextDisabled",
                    "colorDotDisabled",
                    // Sizes & Borders
                    "radioSize",
                    "dotSize",
                    "lineWidth",
                    // Spacing
                    "paddingXS",
                    "wrapperMarginEnd",
                    // Motion
                    "motionDurationMid",
                    "motionDurationSlow"
                ],
                sectionId: "global"
            ),
            DocSidebarSection(
                title: tr("token.radio.component"),
                items: [
                    "radioSize",
                    "dotSize"
                ],
                sectionId: "component"
            )
        ]
    }

    // 重置所有 Token 到默认值
    private func resetAll() {
        // 重置全局token
        config.seed = Moin.SeedToken.default
        config.regenerateTokens()

        // 重置组件 Token
        config.components.radio = .resolve(token: config.token)

        // 通知重置
        NotificationCenter.default.post(name: .radioDocReset, object: nil)
    }

    var body: some View {
        ComponentDocBody(
            sections: tokenSections,
            initialItemId: "global"
        ) { sectionId in
            if sectionId == "global" {
                Text(tr("token.radio.global"))
                    .font(.title3)
                    .fontWeight(.semibold)
            } else if sectionId == "component" {
                Text(tr("token.radio.component"))
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
        case "colorDot": AnyView(colorDotGlobalTokenCard)
        case "colorBgContainerDisabled": AnyView(colorBgContainerDisabledGlobalTokenCard)
        case "colorBorderDisabled": AnyView(colorBorderDisabledGlobalTokenCard)
        case "colorTextDisabled": AnyView(colorTextDisabledGlobalTokenCard)
        case "colorDotDisabled": AnyView(colorDotDisabledGlobalTokenCard)
        case "radioSize": AnyView(radioSizeGlobalTokenCard)
        case "dotSize": AnyView(dotSizeGlobalTokenCard)
        case "lineWidth": AnyView(lineWidthGlobalTokenCard)
        case "paddingXS": AnyView(paddingXSGlobalTokenCard)
        case "wrapperMarginEnd": AnyView(wrapperMarginEndGlobalTokenCard)
        case "motionDurationMid": AnyView(motionDurationMidGlobalTokenCard)
        case "motionDurationSlow": AnyView(motionDurationSlowGlobalTokenCard)
        default: AnyView(EmptyView())
        }
    }
}

// MARK: - Notification Name Extension

extension Notification.Name {
    static let radioDocReset = Notification.Name("radioDocReset")
}
