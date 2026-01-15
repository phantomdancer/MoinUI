import SwiftUI
import MoinUI

struct TokenAvatarPanel: View {
    @Localized var tr
    @ObservedObject private var config = Moin.ConfigProvider.shared

    var body: some View {
        VStack(alignment: .leading, spacing: Moin.Constants.Spacing.md) {
            TokenGroup(title: tr("token.playground.avatar_colors")) {
                ColorPresetRow(label: "containerBg", color: $config.components.avatar.containerBg)
                ColorPresetRow(label: "colorText", color: $config.components.avatar.colorText)
                ColorPresetRow(label: "colorTextLight", color: $config.components.avatar.colorTextLight)
                ColorPresetRow(label: "groupBorderColor", color: $config.components.avatar.groupBorderColor)
            }

            TokenGroup(title: tr("token.playground.avatar_sizes")) {
                TokenValueRow(label: "size", value: $config.components.avatar.size)
                TokenValueRow(label: "sizeLG", value: $config.components.avatar.sizeLG)
                TokenValueRow(label: "sizeSM", value: $config.components.avatar.sizeSM)
            }

            TokenGroup(title: tr("token.playground.avatar_fonts")) {
                TokenValueRow(label: "fontSize", value: $config.components.avatar.fontSize)
                TokenValueRow(label: "fontSizeLG", value: $config.components.avatar.fontSizeLG)
                TokenValueRow(label: "fontSizeSM", value: $config.components.avatar.fontSizeSM)
            }

            TokenGroup(title: tr("token.playground.avatar_radius")) {
                TokenValueRow(label: "borderRadius", value: $config.components.avatar.borderRadius)
                TokenValueRow(label: "borderRadiusLG", value: $config.components.avatar.borderRadiusLG)
                TokenValueRow(label: "borderRadiusSM", value: $config.components.avatar.borderRadiusSM)
            }

            TokenGroup(title: tr("token.playground.avatar_group")) {
                TokenValueRow(label: "groupSpacing", value: $config.components.avatar.groupSpacing)
                TokenValueRow(label: "groupBorderWidth", value: $config.components.avatar.groupBorderWidth)
            }
        }
    }
}
