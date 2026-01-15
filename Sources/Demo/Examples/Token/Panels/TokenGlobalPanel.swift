import SwiftUI
import MoinUI

struct TokenGlobalPanel: View {
    @Localized var tr
    @ObservedObject private var config = Moin.ConfigProvider.shared

    var body: some View {
        VStack(alignment: .leading, spacing: Moin.Constants.Spacing.md) {
            // 颜色 (只读展示)
            TokenGroup(title: tr("token.playground.derived_colors")) {
                TokenColorDisplayRow(label: "colorPrimaryHover", color: config.token.colorPrimaryHover)
                TokenColorDisplayRow(label: "colorPrimaryActive", color: config.token.colorPrimaryActive)
                TokenColorDisplayRow(label: "colorPrimaryBg", color: config.token.colorPrimaryBg)
                TokenColorDisplayRow(label: "colorPrimaryBorder", color: config.token.colorPrimaryBorder)
            }

            // 文本颜色
            TokenGroup(title: tr("token.playground.text_colors")) {
                TokenColorDisplayRow(label: "colorText", color: config.token.colorText)
                TokenColorDisplayRow(label: "colorTextSecondary", color: config.token.colorTextSecondary)
                TokenColorDisplayRow(label: "colorTextTertiary", color: config.token.colorTextTertiary)
            }

            // 背景颜色
            TokenGroup(title: tr("token.playground.bg_colors")) {
                TokenColorDisplayRow(label: "colorBgContainer", color: config.token.colorBgContainer)
                TokenColorDisplayRow(label: "colorBgElevated", color: config.token.colorBgElevated)
                TokenColorDisplayRow(label: "colorBgLayout", color: config.token.colorBgLayout)
            }

            // 边框颜色
            TokenGroup(title: tr("token.playground.border_colors")) {
                TokenColorDisplayRow(label: "colorBorder", color: config.token.colorBorder)
                TokenColorDisplayRow(label: "colorBorderSecondary", color: config.token.colorBorderSecondary)
            }

            // 派生尺寸
            TokenGroup(title: tr("token.playground.derived_sizes")) {
                TokenDisplayRow(label: "fontSizeSM", value: "\(Int(config.token.fontSizeSM))px")
                TokenDisplayRow(label: "fontSizeLG", value: "\(Int(config.token.fontSizeLG))px")
                TokenDisplayRow(label: "controlHeightSM", value: "\(Int(config.token.controlHeightSM))px")
                TokenDisplayRow(label: "controlHeightLG", value: "\(Int(config.token.controlHeightLG))px")
                TokenDisplayRow(label: "borderRadiusSM", value: "\(Int(config.token.borderRadiusSM))px")
                TokenDisplayRow(label: "borderRadiusLG", value: "\(Int(config.token.borderRadiusLG))px")
            }

            // 间距
            TokenGroup(title: tr("token.playground.spacing_values")) {
                TokenDisplayRow(label: "paddingXS", value: "\(Int(config.token.paddingXS))px")
                TokenDisplayRow(label: "paddingSM", value: "\(Int(config.token.paddingSM))px")
                TokenDisplayRow(label: "padding", value: "\(Int(config.token.padding))px")
                TokenDisplayRow(label: "paddingMD", value: "\(Int(config.token.paddingMD))px")
                TokenDisplayRow(label: "paddingLG", value: "\(Int(config.token.paddingLG))px")
            }
        }
    }
}
