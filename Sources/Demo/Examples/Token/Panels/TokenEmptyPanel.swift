import SwiftUI
import MoinUI

struct TokenEmptyPanel: View {
    @Localized var tr
    @ObservedObject private var config = Moin.ConfigProvider.shared

    var body: some View {
        VStack(alignment: .leading, spacing: Moin.Constants.Spacing.md) {
            TokenGroup(title: tr("token.playground.empty_image")) {
                TokenValueRow(label: "imageHeight", value: $config.components.empty.imageHeight)
                TokenValueRow(label: "imageHeightSM", value: $config.components.empty.imageHeightSM)
                ColorPresetRow(label: "imageColor", color: $config.components.empty.imageColor)
            }

            TokenGroup(title: tr("token.playground.empty_description")) {
                ColorPresetRow(label: "descriptionColor", color: $config.components.empty.descriptionColor)
                TokenValueRow(label: "descriptionFontSize", value: $config.components.empty.descriptionFontSize)
            }

            TokenGroup(title: tr("token.playground.empty_spacing")) {
                TokenValueRow(label: "imageMarginBottom", value: $config.components.empty.imageMarginBottom)
                TokenValueRow(label: "contentMarginTop", value: $config.components.empty.contentMarginTop)
            }
        }
    }
}
