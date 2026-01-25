import SwiftUI
import MoinUI

// MARK: - RadioTokenView

/// Radio 组件 Token 文档视图
struct RadioTokenView: View {
    @Localized var tr
    @ObservedObject var config = Moin.ConfigProvider.shared

    // MARK: - Interactive States for TOKEN previews
    @State var checked = true
    @State var buttonValue: String = "A"
    @State var groupValue: Int = 1

    // MARK: - Token Sections (Component Token first, then Global Token)

    private var tokenSections: [DocSidebarSection] {
        [
            // Component Token (在上)
            DocSidebarSection(
                title: tr("token.radio.component"),
                items: [.init(id: "buttonBg"), .init(id: "buttonCheckedBg"), .init(id: "buttonCheckedBgDisabled"), .init(id: "buttonCheckedColorDisabled"), .init(id: "buttonColor"), .init(id: "buttonPaddingInline"), .init(id: "buttonSolidCheckedActiveBg"), .init(id: "buttonSolidCheckedBg"), .init(id: "buttonSolidCheckedColor"), .init(id: "buttonSolidCheckedHoverBg"), .init(id: "dotColorDisabled"), .init(id: "dotSize"), .init(id: "radioSize"), .init(id: "wrapperMarginInlineEnd")],
                sectionId: "component"
            ),
            // Global Token (在下)
            DocSidebarSection(
                title: tr("token.radio.global"),
                items: [.init(id: "colorBgContainer"), .init(id: "colorBgContainerDisabled"), .init(id: "colorBorder"), .init(id: "colorPrimary"), .init(id: "colorPrimaryHover"), .init(id: "colorText"), .init(id: "colorTextDisabled"), .init(id: "lineWidth"), .init(id: "motionDurationMid"), .init(id: "motionDurationSlow"), .init(id: "paddingXS")],
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
        config.components.radio = .resolve(token: config.token)

        // 通知重置
        NotificationCenter.default.post(name: .radioDocReset, object: nil)
    }

    var body: some View {
        ComponentDocBody(
            sections: tokenSections,
            initialItemId: "component"
        ) { sectionId in
            if sectionId == "component" {
                Text(tr("token.radio.component"))
                    .font(.title3)
                    .fontWeight(.semibold)
            } else if sectionId == "global" {
                Text(tr("token.radio.global"))
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
        // Component Tokens
        case "buttonBg": AnyView(buttonBgTokenCard)
        case "buttonCheckedBg": AnyView(buttonCheckedBgTokenCard)
        case "buttonCheckedBgDisabled": AnyView(buttonCheckedBgDisabledTokenCard)
        case "buttonCheckedColorDisabled": AnyView(buttonCheckedColorDisabledTokenCard)
        case "buttonColor": AnyView(buttonColorTokenCard)
        case "buttonPaddingInline": AnyView(buttonPaddingInlineTokenCard)
        case "buttonSolidCheckedActiveBg": AnyView(buttonSolidCheckedActiveBgTokenCard)
        case "buttonSolidCheckedBg": AnyView(buttonSolidCheckedBgTokenCard)
        case "buttonSolidCheckedColor": AnyView(buttonSolidCheckedColorTokenCard)
        case "buttonSolidCheckedHoverBg": AnyView(buttonSolidCheckedHoverBgTokenCard)
        case "dotColorDisabled": AnyView(dotColorDisabledTokenCard)
        case "dotSize": AnyView(dotSizeTokenCard)
        case "radioSize": AnyView(radioSizeTokenCard)
        case "wrapperMarginInlineEnd": AnyView(wrapperMarginInlineEndTokenCard)
        // Global Tokens
        case "colorBgContainer": AnyView(colorBgContainerGlobalTokenCard)
        case "colorBgContainerDisabled": AnyView(colorBgContainerDisabledGlobalTokenCard)
        case "colorBorder": AnyView(colorBorderGlobalTokenCard)
        case "colorPrimary": AnyView(colorPrimaryGlobalTokenCard)
        case "colorPrimaryHover": AnyView(colorPrimaryHoverGlobalTokenCard)
        case "colorText": AnyView(colorTextGlobalTokenCard)
        case "colorTextDisabled": AnyView(colorTextDisabledGlobalTokenCard)
        case "lineWidth": AnyView(lineWidthGlobalTokenCard)
        case "motionDurationMid": AnyView(motionDurationMidGlobalTokenCard)
        case "motionDurationSlow": AnyView(motionDurationSlowGlobalTokenCard)
        case "paddingXS": AnyView(paddingXSGlobalTokenCard)
        default: AnyView(EmptyView())
        }
    }
}

// MARK: - Notification Name Extension

extension Notification.Name {
    static let radioDocReset = Notification.Name("radioDocReset")
}
