import SwiftUI
import MoinUI

// MARK: - Checkbox Token 卡片扩展

extension CheckboxTokenView {

    // MARK: - Primary Colors

    var colorPrimaryGlobalTokenCard: some View {
        TokenCard(
            name: "colorPrimary",
            type: "Color",
            defaultValue: "#1677ff",
            description: tr("doc.global.colorPrimary"),
            sectionId: "global"
        ) {
            Moin.Checkbox(tr("component.checkbox"), checked: $colorPrimaryChecked)
                .id(config.token.colorPrimary)
        } editor: {
            ColorPresetRow(label: "colorPrimary", color: $config.token.colorPrimary) {
                config.components = Moin.ComponentToken.generate(from: config.token, isDark: config.isDarkMode)
            }
        } code: {
            "config.token.colorPrimary = \(config.token.colorPrimary.description)"
        }
        .scrollAnchor("global.colorPrimary")
    }

    // MARK: - Border & Background Colors

    var colorBorderGlobalTokenCard: some View {
        TokenCard(
            name: "colorBorder",
            type: "Color",
            defaultValue: "#d9d9d9",
            description: tr("doc.global.colorBorder"),
            sectionId: "global"
        ) {
            Moin.Checkbox(tr("component.checkbox"), checked: $colorBorderChecked)
                .id(config.token.colorBorder)
        } editor: {
            ColorPresetRow(label: "colorBorder", color: $config.token.colorBorder) {
                config.components = Moin.ComponentToken.generate(from: config.token, isDark: config.isDarkMode)
            }
        } code: {
            "config.token.colorBorder = \(config.token.colorBorder.description)"
        }
        .scrollAnchor("global.colorBorder")
    }

    var colorBgContainerGlobalTokenCard: some View {
        TokenCard(
            name: "colorBgContainer",
            type: "Color",
            defaultValue: "#ffffff",
            description: tr("doc.global.colorBgContainer"),
            sectionId: "global"
        ) {
            Moin.Checkbox(tr("component.checkbox"), checked: $colorBgContainerChecked)
                .id(config.token.colorBgContainer)
        } editor: {
            ColorPresetRow(label: "colorBgContainer", color: $config.token.colorBgContainer) {
                config.components = Moin.ComponentToken.generate(from: config.token, isDark: config.isDarkMode)
            }
        } code: {
            "config.token.colorBgContainer = \(config.token.colorBgContainer.description)"
        }
        .scrollAnchor("global.colorBgContainer")
    }

    // MARK: - Text & Disabled Colors

    var colorTextGlobalTokenCard: some View {
        TokenCard(
            name: "colorText",
            type: "Color",
            defaultValue: "#000000",
            description: tr("doc.global.colorText"),
            sectionId: "global"
        ) {
            Moin.Checkbox(tr("component.checkbox"), checked: $colorTextChecked)
                .id(config.token.colorText)
        } editor: {
            ColorPresetRow(label: "colorText", color: $config.token.colorText) {
                config.components = Moin.ComponentToken.generate(from: config.token, isDark: config.isDarkMode)
            }
        } code: {
            "config.token.colorText = \(config.token.colorText.description)"
        }
        .scrollAnchor("global.colorText")
    }

    var colorTextDisabledGlobalTokenCard: some View {
        TokenCard(
            name: "colorTextDisabled",
            type: "Color",
            defaultValue: "rgba(0,0,0,0.25)",
            description: tr("doc.global.colorTextDisabled"),
            sectionId: "global"
        ) {
            Moin.Checkbox(tr("component.checkbox"), checked: $colorTextDisabledChecked, isDisabled: true)
                .id(config.token.colorTextDisabled)
        } editor: {
            ColorPresetRow(label: "colorTextDisabled", color: $config.token.colorTextDisabled) {
                config.components = Moin.ComponentToken.generate(from: config.token, isDark: config.isDarkMode)
            }
        } code: {
            "config.token.colorTextDisabled = \(config.token.colorTextDisabled.description)"
        }
        .scrollAnchor("global.colorTextDisabled")
    }

    var colorBgDisabledGlobalTokenCard: some View {
        TokenCard(
            name: "colorBgDisabled",
            type: "Color",
            defaultValue: "#f5f5f5",
            description: tr("doc.global.colorBgDisabled"),
            sectionId: "global"
        ) {
            Moin.Checkbox(tr("component.checkbox"), checked: $colorBgDisabledChecked, isDisabled: true)
                .id(config.token.colorBgDisabled)
        } editor: {
            ColorPresetRow(label: "colorBgDisabled", color: $config.token.colorBgDisabled) {
                config.components = Moin.ComponentToken.generate(from: config.token, isDark: config.isDarkMode)
            }
        } code: {
            "config.token.colorBgDisabled = \(config.token.colorBgDisabled.description)"
        }
        .scrollAnchor("global.colorBgDisabled")
    }

    // MARK: - Border & Size Tokens

    var borderRadiusSMGlobalTokenCard: some View {
        TokenCard(
            name: "borderRadiusSM",
            type: "CGFloat",
            defaultValue: "4",
            description: tr("doc.global.borderRadiusSM"),
            sectionId: "global"
        ) {
            HStack(spacing: Moin.Constants.Spacing.md) {
                Moin.Checkbox(tr("component.checkbox"), checked: $borderRadiusSMChecked)
                    .id(config.token.borderRadiusSM)
                Text("radius: \(String(format: "%.1f", config.token.borderRadiusSM))px")
                    .font(.system(size: 11, design: .monospaced))
                    .foregroundStyle(.secondary)
            }
        } editor: {
            TokenValueRow(label: "borderRadiusSM", value: $config.token.borderRadiusSM, range: 0...8) {
                config.components = Moin.ComponentToken.generate(from: config.token, isDark: config.isDarkMode)
            }
        } code: {
            "config.token.borderRadiusSM = \(String(format: "%.1f", config.token.borderRadiusSM))"
        }
        .scrollAnchor("global.borderRadiusSM")
    }

    var lineWidthGlobalTokenCard: some View {
        TokenCard(
            name: "lineWidth",
            type: "CGFloat",
            defaultValue: "1",
            description: tr("doc.global.lineWidth"),
            sectionId: "global"
        ) {
            HStack(spacing: Moin.Constants.Spacing.md) {
                Moin.Checkbox(tr("component.checkbox"), checked: $lineWidthChecked)
                    .id(config.token.lineWidth)
                Text("width: \(String(format: "%.1f", config.token.lineWidth))px")
                    .font(.system(size: 11, design: .monospaced))
                    .foregroundStyle(.secondary)
            }
        } editor: {
            TokenValueRow(label: "lineWidth", value: $config.token.lineWidth, range: 0.5...3) {
                config.components = Moin.ComponentToken.generate(from: config.token, isDark: config.isDarkMode)
            }
        } code: {
            "config.token.lineWidth = \(String(format: "%.1f", config.token.lineWidth))"
        }
        .scrollAnchor("global.lineWidth")
    }

    var lineWidthBoldGlobalTokenCard: some View {
        TokenCard(
            name: "lineWidthBold",
            type: "CGFloat",
            defaultValue: "2",
            description: tr("doc.global.lineWidthBold"),
            sectionId: "global"
        ) {
            HStack(spacing: Moin.Constants.Spacing.md) {
                Moin.Checkbox(tr("component.checkbox"), checked: $lineWidthBoldChecked)
                    .id(config.token.lineWidthBold)
                Text("width: \(String(format: "%.1f", config.token.lineWidthBold))px")
                    .font(.system(size: 11, design: .monospaced))
                    .foregroundStyle(.secondary)
            }
        } editor: {
            TokenValueRow(label: "lineWidthBold", value: $config.token.lineWidthBold, range: 1...3) {
                config.components = Moin.ComponentToken.generate(from: config.token, isDark: config.isDarkMode)
            }
        } code: {
            "config.token.lineWidthBold = \(String(format: "%.1f", config.token.lineWidthBold))"
        }
        .scrollAnchor("global.lineWidthBold")
    }

    // MARK: - Spacing Tokens

    var paddingXSGlobalTokenCard: some View {
        TokenCard(
            name: "paddingXS",
            type: "CGFloat",
            defaultValue: "8",
            description: tr("doc.global.paddingXS"),
            sectionId: "global"
        ) {
            HStack(spacing: Moin.Constants.Spacing.md) {
                Moin.Checkbox(tr("component.checkbox"), checked: $paddingXSChecked)
                    .id(config.token.paddingXS)
                Text("spacing: \(Int(config.token.paddingXS))px")
                    .font(.system(size: 11, design: .monospaced))
                    .foregroundStyle(.secondary)
            }
        } editor: {
            TokenValueRow(label: "paddingXS", value: $config.token.paddingXS, range: 4...16) {
                config.components = Moin.ComponentToken.generate(from: config.token, isDark: config.isDarkMode)
            }
        } code: {
            "config.token.paddingXS = \(Int(config.token.paddingXS))"
        }
        .scrollAnchor("global.paddingXS")
    }

    // MARK: - Typography Tokens

    var fontSizeGlobalTokenCard: some View {
        TokenCard(
            name: "fontSize",
            type: "CGFloat",
            defaultValue: "14",
            description: tr("doc.global.fontSize"),
            sectionId: "global"
        ) {
            HStack(spacing: Moin.Constants.Spacing.md) {
                Moin.Checkbox(tr("component.checkbox"), checked: $fontSizeChecked)
                    .id(config.token.fontSize)
                Text("size: \(Int(config.token.fontSize))px")
                    .font(.system(size: 11, design: .monospaced))
                    .foregroundStyle(.secondary)
            }
        } editor: {
            TokenValueRow(label: "fontSize", value: $config.token.fontSize, range: 12...18) {
                config.components = Moin.ComponentToken.generate(from: config.token, isDark: config.isDarkMode)
            }
        } code: {
            "config.token.fontSize = \(Int(config.token.fontSize))"
        }
        .scrollAnchor("global.fontSize")
    }

    // MARK: - Motion Tokens

    var motionDurationFastGlobalTokenCard: some View {
        TokenCard(
            name: "motionDurationFast",
            type: "Double",
            defaultValue: "0.1",
            description: tr("doc.global.motionDurationFast"),
            sectionId: "global"
        ) {
            HStack(spacing: Moin.Constants.Spacing.md) {
                Moin.Checkbox(tr("component.checkbox"), checked: $motionDurationFastChecked)
                    .id(config.token.motionDurationFast)
                Text("duration: \(String(format: "%.1f", config.token.motionDurationFast))s")
                    .font(.system(size: 11, design: .monospaced))
                    .foregroundStyle(.secondary)
            }
        } editor: {
            TokenValueRow(label: "motionDurationFast", value: Binding(get: { CGFloat(config.token.motionDurationFast) }, set: { config.token.motionDurationFast = Double($0) }), range: 0.05...0.5) {
                config.components = Moin.ComponentToken.generate(from: config.token, isDark: config.isDarkMode)
            }
        } code: {
            "config.token.motionDurationFast = \(String(format: "%.1f", config.token.motionDurationFast))"
        }
        .scrollAnchor("global.motionDurationFast")
    }

    var motionDurationMidGlobalTokenCard: some View {
        TokenCard(
            name: "motionDurationMid",
            type: "Double",
            defaultValue: "0.2",
            description: tr("doc.global.motionDurationMid"),
            sectionId: "global"
        ) {
            HStack(spacing: Moin.Constants.Spacing.md) {
                Moin.Checkbox(tr("component.checkbox"), checked: $motionDurationMidChecked)
                    .id(config.token.motionDurationMid)
                Text("duration: \(String(format: "%.1f", config.token.motionDurationMid))s")
                    .font(.system(size: 11, design: .monospaced))
                    .foregroundStyle(.secondary)
            }
        } editor: {
            TokenValueRow(label: "motionDurationMid", value: Binding(get: { CGFloat(config.token.motionDurationMid) }, set: { config.token.motionDurationMid = Double($0) }), range: 0.1...0.5) {
                config.components = Moin.ComponentToken.generate(from: config.token, isDark: config.isDarkMode)
            }
        } code: {
            "config.token.motionDurationMid = \(String(format: "%.1f", config.token.motionDurationMid))"
        }
        .scrollAnchor("global.motionDurationMid")
    }

    var motionDurationSlowGlobalTokenCard: some View {
        TokenCard(
            name: "motionDurationSlow",
            type: "Double",
            defaultValue: "0.3",
            description: tr("doc.global.motionDurationSlow"),
            sectionId: "global"
        ) {
            HStack(spacing: Moin.Constants.Spacing.md) {
                Moin.Checkbox(tr("component.checkbox"), checked: $motionDurationSlowChecked)
                    .id(config.token.motionDurationSlow)
                Text("duration: \(String(format: "%.1f", config.token.motionDurationSlow))s")
                    .font(.system(size: 11, design: .monospaced))
                    .foregroundStyle(.secondary)
            }
        } editor: {
            TokenValueRow(label: "motionDurationSlow", value: Binding(get: { CGFloat(config.token.motionDurationSlow) }, set: { config.token.motionDurationSlow = Double($0) }), range: 0.1...1) {
                config.components = Moin.ComponentToken.generate(from: config.token, isDark: config.isDarkMode)
            }
        } code: {
            "config.token.motionDurationSlow = \(String(format: "%.1f", config.token.motionDurationSlow))"
        }
        .scrollAnchor("global.motionDurationSlow")
    }
}
