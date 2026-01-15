import SwiftUI
import MoinUI

struct TokenButtonPanel: View {
    @Localized var tr
    @ObservedObject private var config = Moin.ConfigProvider.shared

    var body: some View {
        VStack(alignment: .leading, spacing: Moin.Constants.Spacing.md) {
            TokenGroup(title: tr("token.playground.button_colors")) {
                ColorPresetRow(label: "defaultColor", color: $config.components.button.defaultColor)
                ColorPresetRow(label: "defaultBg", color: $config.components.button.defaultBg)
                ColorPresetRow(label: "defaultBorderColor", color: $config.components.button.defaultBorderColor)
                ColorPresetRow(label: "primaryColor", color: $config.components.button.primaryColor)
                ColorPresetRow(label: "dangerColor", color: $config.components.button.dangerColor)
            }

            TokenGroup(title: tr("token.playground.button_sizes")) {
                TokenValueRow(label: "paddingInline", value: $config.components.button.paddingInline)
                TokenValueRow(label: "paddingInlineLG", value: $config.components.button.paddingInlineLG)
                TokenValueRow(label: "paddingInlineSM", value: $config.components.button.paddingInlineSM)
                TokenValueRow(label: "paddingBlock", value: $config.components.button.paddingBlock)
                TokenValueRow(label: "iconGap", value: $config.components.button.iconGap)
            }

            TokenGroup(title: tr("token.playground.button_font")) {
                TokenValueRow(label: "contentFontSize", value: $config.components.button.contentFontSize)
                TokenValueRow(label: "contentFontSizeLG", value: $config.components.button.contentFontSizeLG)
                TokenValueRow(label: "contentFontSizeSM", value: $config.components.button.contentFontSizeSM)
            }
        }
    }
}
