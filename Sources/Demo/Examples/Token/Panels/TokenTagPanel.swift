import SwiftUI
import MoinUI

struct TokenTagPanel: View {
    @Localized var tr
    @ObservedObject private var config = Moin.ConfigProvider.shared

    var body: some View {
        VStack(alignment: .leading, spacing: Moin.Constants.Spacing.md) {
            TokenGroup(title: tr("token.playground.tag_colors")) {
                ColorPresetRow(label: "defaultBg", color: $config.components.tag.defaultBg)
                ColorPresetRow(label: "defaultColor", color: $config.components.tag.defaultColor)
                ColorPresetRow(label: "solidTextColor", color: $config.components.tag.solidTextColor)
            }

            TokenGroup(title: tr("token.playground.tag_sizes")) {
                TokenValueRow(label: "fontSize", value: $config.components.tag.fontSize)
                TokenValueRow(label: "fontSizeLG", value: $config.components.tag.fontSizeLG)
                TokenValueRow(label: "fontSizeSM", value: $config.components.tag.fontSizeSM)
                TokenValueRow(label: "paddingH", value: $config.components.tag.paddingH)
                TokenValueRow(label: "paddingV", value: $config.components.tag.paddingV)
            }
        }
    }
}
