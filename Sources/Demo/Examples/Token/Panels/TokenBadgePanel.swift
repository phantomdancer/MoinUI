import SwiftUI
import MoinUI

struct TokenBadgePanel: View {
    @Localized var tr
    @ObservedObject private var config = Moin.ConfigProvider.shared

    var body: some View {
        VStack(alignment: .leading, spacing: Moin.Constants.Spacing.md) {
            TokenGroup(title: tr("token.playground.badge_colors")) {
                ColorPresetRow(label: "badgeColor", color: $config.components.badge.badgeColor)
                ColorPresetRow(label: "textColor", color: $config.components.badge.textColor)
            }

            TokenGroup(title: tr("token.playground.badge_sizes")) {
                TokenValueRow(label: "indicatorHeight", value: $config.components.badge.indicatorHeight)
                TokenValueRow(label: "indicatorHeightSM", value: $config.components.badge.indicatorHeightSM)
                TokenValueRow(label: "dotSize", value: $config.components.badge.dotSize)
                TokenValueRow(label: "dotSizeSM", value: $config.components.badge.dotSizeSM)
                TokenValueRow(label: "textFontSize", value: $config.components.badge.textFontSize)
                TokenValueRow(label: "textFontSizeSM", value: $config.components.badge.textFontSizeSM)
                TokenValueRow(label: "paddingH", value: $config.components.badge.paddingH)
                TokenValueRow(label: "paddingHSM", value: $config.components.badge.paddingHSM)
            }
            
            TokenGroup(title: tr("token.playground.badge_shadow")) {
                TokenValueRow(label: "shadowRadius", value: $config.components.badge.shadowRadius)
                TokenValueRow(label: "shadowOpacity", value: Binding(
                    get: { CGFloat(config.components.badge.shadowOpacity) },
                    set: { config.components.badge.shadowOpacity = Double($0) }
                ))
            }
        }
    }
}
