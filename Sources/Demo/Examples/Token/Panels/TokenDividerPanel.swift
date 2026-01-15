import SwiftUI
import MoinUI

struct TokenDividerPanel: View {
    @Localized var tr
    @ObservedObject private var config = Moin.ConfigProvider.shared

    var body: some View {
        VStack(alignment: .leading, spacing: Moin.Constants.Spacing.md) {
            TokenGroup(title: tr("token.playground.divider_colors")) {
                ColorPresetRow(label: "lineColor", color: $config.components.divider.lineColor)
                ColorPresetRow(label: "textColor", color: $config.components.divider.textColor)
            }

            TokenGroup(title: tr("token.playground.divider_sizes")) {
                TokenValueRow(label: "fontSize", value: $config.components.divider.fontSize)
                TokenValueRow(label: "lineWidth", value: $config.components.divider.lineWidth)
                TokenValueRow(label: "verticalMargin", value: $config.components.divider.verticalMargin)
                TokenValueRow(label: "horizontalMargin", value: $config.components.divider.horizontalMargin)
                TokenValueRow(label: "textPadding", value: $config.components.divider.textPadding)
            }
        }
    }
}
