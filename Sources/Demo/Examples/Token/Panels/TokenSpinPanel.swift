import SwiftUI
import MoinUI

struct TokenSpinPanel: View {
    @Localized var tr
    @ObservedObject private var config = Moin.ConfigProvider.shared

    var body: some View {
        VStack(alignment: .leading, spacing: Moin.Constants.Spacing.md) {
            // 预览
            TokenGroup(title: tr("token.playground.spin_preview")) {
                HStack(spacing: 32) {
                    VStack {
                        Spin(size: .small)
                        Text("Small").font(.caption).foregroundStyle(.secondary)
                    }
                    VStack {
                        Spin()
                        Text("Default").font(.caption).foregroundStyle(.secondary)
                    }
                    VStack {
                        Spin(size: .large)
                        Text("Large").font(.caption).foregroundStyle(.secondary)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
            }

            // 尺寸
            TokenGroup(title: tr("token.playground.spin_sizes")) {
                TokenValueRow(label: "dotSize", value: $config.components.spin.dotSize)
                TokenValueRow(label: "dotSizeSM", value: $config.components.spin.dotSizeSM)
                TokenValueRow(label: "dotSizeLG", value: $config.components.spin.dotSizeLG)
                TokenValueRow(label: "contentHeight", value: $config.components.spin.contentHeight)
            }

            // 颜色
            TokenGroup(title: tr("token.playground.spin_colors")) {
                ColorPresetRow(label: "dotColor", color: $config.components.spin.dotColor)
                ColorPresetRow(label: "tipColor", color: $config.components.spin.tipColor)
                ColorPresetRow(label: "maskBackground", color: $config.components.spin.maskBackground)
            }

            // 动画
            TokenGroup(title: tr("token.playground.spin_animation")) {
                TokenValueRow(label: "motionDuration", value: Binding(
                    get: { CGFloat(config.components.spin.motionDuration) },
                    set: { config.components.spin.motionDuration = Double($0) }
                ))
            }

            // 带提示预览
            TokenGroup(title: tr("token.playground.spin_with_tip")) {
                VStack(spacing: 16) {
                    Spin(tip: "Loading...")
                    Spin(size: .large, tip: "加载中...")
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
            }
        }
    }
}

#Preview("Token Spin Panel") {
    ScrollView {
        TokenSpinPanel()
            .padding()
    }
    .frame(width: 400, height: 600)
    .moinThemeRoot()
}
