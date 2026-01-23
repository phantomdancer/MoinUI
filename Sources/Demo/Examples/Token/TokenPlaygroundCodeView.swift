import SwiftUI
import MoinUI

struct TokenPlaygroundCodeView: View {
    let selectedPanel: TokenPlaygroundPanelTab
    @Localized var tr
    @ObservedObject private var config = Moin.ConfigProvider.shared

    var body: some View {
        VStack(alignment: .leading, spacing: Moin.Constants.Spacing.sm) {
            HStack {
                Text(tr("token.playground.code"))
                    .font(.system(size: 11, weight: .medium))
                    .foregroundStyle(.secondary)
                Spacer()
            }

            GeometryReader { geo in
                ScrollView([.horizontal, .vertical], showsIndicators: true) {
                    HStack {
                        VStack(alignment: .leading) {
                            HighlightedCodeView(code: generateCode(), fontSize: 12)
                                .fixedSize()
                            Spacer(minLength: 0)
                        }
                        Spacer(minLength: 0)
                    }
                    .padding(Moin.Constants.Spacing.sm)
                    .frame(minWidth: geo.size.width, minHeight: geo.size.height, alignment: .topLeading)
                }
            }
            .frame(minHeight: 150, maxHeight: 200)
            .background(config.isDarkMode ? Color(white: 0.08) : Color(white: 0.96))
            .cornerRadius(Moin.Constants.Radius.sm)
            .id("code-\(selectedPanel.rawValue)")
        }
    }

    private func generateCode() -> String {
        switch selectedPanel {
        case .seed:
            return """
// \(tr("token.playground.code_seed_config"))
let config = Moin.ConfigProvider.shared
config.configureSeed { seed in
    // \(tr("token.playground.brand_colors"))
    seed.colorPrimary = Color(hex: "\(config.seed.colorPrimary.hexString)")
    seed.colorSuccess = Color(hex: "\(config.seed.colorSuccess.hexString)")
    seed.colorWarning = Color(hex: "\(config.seed.colorWarning.hexString)")
    seed.colorError = Color(hex: "\(config.seed.colorError.hexString)")
    seed.colorInfo = Color(hex: "\(config.seed.colorInfo.hexString)")
    seed.colorLink = Color(hex: "\(config.seed.colorLink.hexString)")
    // \(tr("token.playground.base_colors"))
    seed.colorTextBase = Color(hex: "\(config.seed.colorTextBase.hexString)")
    seed.colorBgBase = Color(hex: "\(config.seed.colorBgBase.hexString)")
    // \(tr("token.playground.font"))
    seed.fontSize = \(Int(config.seed.fontSize))
    // \(tr("token.playground.radius"))
    seed.borderRadius = \(Int(config.seed.borderRadius))
    // \(tr("token.playground.size"))
    seed.controlHeight = \(Int(config.seed.controlHeight))
    seed.sizeUnit = \(Int(config.seed.sizeUnit))
    // \(tr("token.playground.line"))
    seed.lineWidth = \(Int(config.seed.lineWidth))
}
"""
        case .global:
            return """
// \(tr("token.playground.code_global_readonly"))
// \(tr("token.playground.derived_colors"))
token.colorPrimaryHover    // \(config.token.colorPrimaryHover.hexString)
token.colorPrimaryActive   // \(config.token.colorPrimaryActive.hexString)
token.colorPrimaryBg       // \(config.token.colorPrimaryBg.hexString)
token.colorPrimaryBorder   // \(config.token.colorPrimaryBorder.hexString)
// \(tr("token.playground.text_colors"))
token.colorText            // \(config.token.colorText.hexString)
token.colorTextSecondary   // \(config.token.colorTextSecondary.hexString)
token.colorTextTertiary    // \(config.token.colorTextTertiary.hexString)
// \(tr("token.playground.bg_colors"))
token.colorBgContainer     // \(config.token.colorBgContainer.hexString)
token.colorBgElevated      // \(config.token.colorBgElevated.hexString)
token.colorBgLayout        // \(config.token.colorBgLayout.hexString)
// \(tr("token.playground.border_colors"))
token.colorBorder          // \(config.token.colorBorder.hexString)
token.colorBorderSecondary // \(config.token.colorBorderSecondary.hexString)
// \(tr("token.playground.derived_sizes"))
token.fontSizeSM = \(Int(config.token.fontSizeSM))
token.fontSizeLG = \(Int(config.token.fontSizeLG))
token.controlHeightSM = \(Int(config.token.controlHeightSM))
token.controlHeightLG = \(Int(config.token.controlHeightLG))
token.borderRadiusSM = \(Int(config.token.borderRadiusSM))
token.borderRadiusLG = \(Int(config.token.borderRadiusLG))
// \(tr("token.playground.spacing_values"))
token.paddingXS = \(Int(config.token.paddingXS))
token.paddingSM = \(Int(config.token.paddingSM))
token.padding = \(Int(config.token.padding))
token.paddingMD = \(Int(config.token.paddingMD))
token.paddingLG = \(Int(config.token.paddingLG))
"""
        case .button:
            return """
// \(tr("token.playground.code_button_config"))
config.components.button.defaultColor = Color(hex: "\(config.components.button.defaultColor.hexString)")
config.components.button.defaultBg = Color(hex: "\(config.components.button.defaultBg.hexString)")
config.components.button.defaultBorderColor = Color(hex: "\(config.components.button.defaultBorderColor.hexString)")
config.components.button.primaryColor = Color(hex: "\(config.components.button.primaryColor.hexString)")
config.components.button.dangerColor = Color(hex: "\(config.components.button.dangerColor.hexString)")
// \(tr("token.playground.button_sizes"))
config.components.button.paddingInline = \(Int(config.components.button.paddingInline))
config.components.button.paddingInlineLG = \(Int(config.components.button.paddingInlineLG))
config.components.button.paddingInlineSM = \(Int(config.components.button.paddingInlineSM))
config.components.button.paddingBlock = \(Int(config.components.button.paddingBlock))
config.components.button.iconGap = \(Int(config.components.button.iconGap))
// \(tr("token.playground.button_font"))
config.components.button.contentFontSize = \(Int(config.components.button.contentFontSize))
config.components.button.contentFontSizeLG = \(Int(config.components.button.contentFontSizeLG))
config.components.button.contentFontSizeSM = \(Int(config.components.button.contentFontSizeSM))
"""
        case .tag:
            return """
// \(tr("token.playground.code_tag_config"))
config.components.tag.defaultBg = Color(hex: "\(config.components.tag.defaultBg.hexString)")
config.components.tag.defaultColor = Color(hex: "\(config.components.tag.defaultColor.hexString)")
config.components.tag.solidTextColor = Color(hex: "\(config.components.tag.solidTextColor.hexString)")
// \(tr("token.playground.tag_sizes"))
config.components.tag.paddingH = \(Int(config.components.tag.paddingH))
config.components.tag.paddingV = \(Int(config.components.tag.paddingV))
config.components.tag.iconSize = \(Int(config.components.tag.iconSize))
// \(tr("token.playground.code_global_readonly"))
// seed.fontSize = \(Int(config.seed.fontSize)) // -> token.fontSizeSM
"""
        case .badge:
            return """
// \(tr("token.playground.code_badge_config"))
config.components.badge.badgeColor = Color(hex: "\(config.components.badge.badgeColor.hexString)")
config.components.badge.textColor = Color(hex: "\(config.components.badge.textColor.hexString)")
// \(tr("token.playground.badge_sizes"))
config.components.badge.indicatorHeight = \(Int(config.components.badge.indicatorHeight))
config.components.badge.dotSize = \(Int(config.components.badge.dotSize))
config.components.badge.textFontSize = \(Int(config.components.badge.textFontSize))
config.components.badge.paddingH = \(Int(config.components.badge.paddingH))
"""
        case .avatar:
            return """
// \(tr("token.playground.code_avatar_config"))
config.components.avatar.containerBg = Color(hex: "\(config.components.avatar.containerBg.hexString)")
config.components.avatar.colorText = Color(hex: "\(config.components.avatar.colorText.hexString)")
// \(tr("token.playground.avatar_sizes"))
config.components.avatar.size = \(Int(config.components.avatar.size))
config.components.avatar.sizeLG = \(Int(config.components.avatar.sizeLG))
config.components.avatar.sizeSM = \(Int(config.components.avatar.sizeSM))
// \(tr("token.playground.avatar_group"))
config.components.avatar.groupSpacing = \(Int(config.components.avatar.groupSpacing))
config.components.avatar.groupBorderWidth = \(Int(config.components.avatar.groupBorderWidth))
"""
        case .space:
            return """
// \(tr("token.playground.code_space_config"))
config.components.space.sizeSmall = \(Int(config.components.space.sizeSmall))
config.components.space.sizeMedium = \(Int(config.components.space.sizeMedium))
config.components.space.sizeLarge = \(Int(config.components.space.sizeLarge))
"""
        case .divider:
            return """
// \(tr("token.playground.code_divider_config"))
config.components.divider.lineColor = Color(hex: "\(config.components.divider.lineColor.hexString)")
config.components.divider.textColor = Color(hex: "\(config.components.divider.textColor.hexString)")
// \(tr("token.playground.divider_sizes"))
config.components.divider.fontSize = \(Int(config.components.divider.fontSize))
config.components.divider.lineWidth = \(Int(config.components.divider.lineWidth))
config.components.divider.verticalMargin = \(Int(config.components.divider.verticalMargin))
config.components.divider.horizontalMargin = \(Int(config.components.divider.horizontalMargin))
config.components.divider.textPadding = \(Int(config.components.divider.textPadding))
config.components.divider.orientationMargin = \(String(format: "%.2f", config.components.divider.orientationMargin))
"""
        case .empty:
            return """
// \(tr("token.playground.code_empty_config"))
config.components.empty.imageHeight = \(Int(config.components.empty.imageHeight))
config.components.empty.imageHeightSM = \(Int(config.components.empty.imageHeightSM))
config.components.empty.descriptionFontSize = \(Int(config.components.empty.descriptionFontSize))
config.components.empty.imageMarginBottom = \(Int(config.components.empty.imageMarginBottom))
config.components.empty.contentMarginTop = \(Int(config.components.empty.contentMarginTop))
"""
        case .spin:
            return """
// \(tr("token.playground.code_spin_config"))
config.components.spin.dotColor = Color(hex: "\(config.components.spin.dotColor.hexString)")
config.components.spin.tipColor = Color(hex: "\(config.components.spin.tipColor.hexString)")
// \(tr("token.playground.spin_sizes"))
config.components.spin.dotSize = \(Int(config.components.spin.dotSize))
config.components.spin.dotSizeSM = \(Int(config.components.spin.dotSizeSM))
config.components.spin.dotSizeLG = \(Int(config.components.spin.dotSizeLG))
// \(tr("token.playground.spin_animation"))
config.components.spin.motionDuration = \(String(format: "%.1f", config.components.spin.motionDuration))
"""
        }
    }
}
