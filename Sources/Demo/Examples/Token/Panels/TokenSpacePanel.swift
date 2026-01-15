import SwiftUI
import MoinUI

struct TokenSpacePanel: View {
    @Localized var tr
    @ObservedObject private var config = Moin.ConfigProvider.shared

    var body: some View {
        VStack(alignment: .leading, spacing: Moin.Constants.Spacing.md) {
            TokenGroup(title: tr("token.playground.space_sizes")) {
                TokenValueRow(label: "sizeSmall", value: $config.components.space.sizeSmall)
                TokenValueRow(label: "sizeMedium", value: $config.components.space.sizeMedium)
                TokenValueRow(label: "sizeLarge", value: $config.components.space.sizeLarge)
            }
        }
    }
}
