import SwiftUI
import MoinUI

struct TokenSeedPanel: View {
    @Localized var tr
    @ObservedObject private var config = Moin.ConfigProvider.shared

    var body: some View {
        VStack(alignment: .leading, spacing: Moin.Constants.Spacing.md) {
            // 品牌色
            TokenGroup(title: tr("token.playground.brand_colors")) {
                ColorPresetRow(label: "colorPrimary", color: $config.seed.colorPrimary, onChange: config.regenerateTokens)
                ColorPresetRow(label: "colorSuccess", color: $config.seed.colorSuccess, onChange: config.regenerateTokens)
                ColorPresetRow(label: "colorWarning", color: $config.seed.colorWarning, onChange: config.regenerateTokens)
                ColorPresetRow(label: "colorError", color: $config.seed.colorError, onChange: config.regenerateTokens)
                ColorPresetRow(label: "colorInfo", color: $config.seed.colorInfo, onChange: config.regenerateTokens)
                ColorPresetRow(label: "colorLink", color: $config.seed.colorLink, onChange: config.regenerateTokens)
            }

            // 基础色
            TokenGroup(title: tr("token.playground.base_colors")) {
                ColorPresetRow(label: "colorTextBase", color: $config.seed.colorTextBase, onChange: config.regenerateTokens)
                ColorPresetRow(label: "colorBgBase", color: $config.seed.colorBgBase, onChange: config.regenerateTokens)
            }

            // 字体
            TokenGroup(title: tr("token.playground.font")) {
                TokenValueRow(label: "fontSize", value: $config.seed.fontSize, onChange: config.regenerateTokens)
            }

            // 圆角
            TokenGroup(title: tr("token.playground.radius")) {
                TokenValueRow(label: "borderRadius", value: $config.seed.borderRadius, onChange: config.regenerateTokens)
            }

            // 尺寸
            TokenGroup(title: tr("token.playground.size")) {
                TokenValueRow(label: "controlHeight", value: $config.seed.controlHeight, onChange: config.regenerateTokens)
                TokenValueRow(label: "sizeUnit", value: $config.seed.sizeUnit, onChange: config.regenerateTokens)
            }

            // 线条
            TokenGroup(title: tr("token.playground.line")) {
                TokenValueRow(label: "lineWidth", value: $config.seed.lineWidth, onChange: config.regenerateTokens)
            }
        }
    }
}
