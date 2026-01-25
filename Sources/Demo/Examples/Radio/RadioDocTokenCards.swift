import SwiftUI
import MoinUI

// MARK: - Radio Token Cards Extension

extension RadioTokenView {

    // MARK: - Component Tokens

    var radioSizeTokenCard: some View {
        TokenCard(
            name: "radioSize",
            type: "CGFloat",
            defaultValue: "16",
            description: tr("doc.component.radioSize"),
            sectionId: "component"
        ) {
            HStack(spacing: Moin.Constants.Spacing.md) {
                Moin.Radio("Radio", checked: $checked)
                    .id(config.components.radio.radioSize)
                Text("size: \(Int(config.components.radio.radioSize))px")
                    .font(.system(size: 11, design: .monospaced))
                    .foregroundStyle(.secondary)
            }
        } editor: {
            TokenValueRow(label: "radioSize", value: $config.components.radio.radioSize, range: 12...32) {
            }
        } code: {
            "config.components.radio.radioSize = \(Int(config.components.radio.radioSize))"
        }
        .scrollAnchor("component.radioSize")
    }

    var dotSizeTokenCard: some View {
        TokenCard(
            name: "dotSize",
            type: "CGFloat",
            defaultValue: "8",
            description: tr("doc.component.dotSize"),
            sectionId: "component"
        ) {
            HStack(spacing: Moin.Constants.Spacing.md) {
                Moin.Radio("Radio", checked: $checked)
                    .id(config.components.radio.dotSize)
                Text("size: \(Int(config.components.radio.dotSize))px")
                    .font(.system(size: 11, design: .monospaced))
                    .foregroundStyle(.secondary)
            }
        } editor: {
            TokenValueRow(label: "dotSize", value: $config.components.radio.dotSize, range: 4...16) {
            }
        } code: {
            "config.components.radio.dotSize = \(Int(config.components.radio.dotSize))"
        }
        .scrollAnchor("component.dotSize")
    }

    var dotColorDisabledTokenCard: some View {
        TokenCard(
            name: "dotColorDisabled",
            type: "Color",
            defaultValue: "rgba(0,0,0,0.25)",
            description: tr("doc.component.dotColorDisabled"),
            sectionId: "component"
        ) {
            Moin.Radio("Radio", checked: .constant(true), disabled: true)
        } editor: {
            ColorPresetRow(label: "dotColorDisabled", color: $config.components.radio.dotColorDisabled) {
            }
        } code: {
            "config.components.radio.dotColorDisabled = ..."
        }
        .scrollAnchor("component.dotColorDisabled")
    }

    var wrapperMarginInlineEndTokenCard: some View {
        TokenCard(
            name: "wrapperMarginInlineEnd",
            type: "CGFloat",
            defaultValue: "8",
            description: tr("doc.component.wrapperMarginInlineEnd"),
            sectionId: "component"
        ) {
            HStack(spacing: Moin.Constants.Spacing.md) {
                Moin.RadioGroup(value: $groupValue, options: [1, 2, 3])
                    .id(config.components.radio.wrapperMarginInlineEnd)
            }
        } editor: {
            TokenValueRow(label: "wrapperMarginInlineEnd", value: $config.components.radio.wrapperMarginInlineEnd, range: 0...24) {
            }
        } code: {
            "config.components.radio.wrapperMarginInlineEnd = \(Int(config.components.radio.wrapperMarginInlineEnd))"
        }
        .scrollAnchor("component.wrapperMarginInlineEnd")
    }

    // MARK: - Button Style Component Tokens

    var buttonBgTokenCard: some View {
        TokenCard(
            name: "buttonBg",
            type: "Color",
            defaultValue: "#ffffff",
            description: tr("doc.component.buttonBg"),
            sectionId: "component"
        ) {
            Moin.RadioGroup(
                value: $buttonValue,
                options: ["A", "B", "C"],
                optionType: .button
            )
        } editor: {
            ColorPresetRow(label: "buttonBg", color: $config.components.radio.buttonBg) {
            }
        } code: {
            "config.components.radio.buttonBg = ..."
        }
        .scrollAnchor("component.buttonBg")
    }

    var buttonCheckedBgTokenCard: some View {
        TokenCard(
            name: "buttonCheckedBg",
            type: "Color",
            defaultValue: "#ffffff",
            description: tr("doc.component.buttonCheckedBg"),
            sectionId: "component"
        ) {
            Moin.RadioGroup(
                value: $buttonValue,
                options: ["A", "B", "C"],
                optionType: .button,
                buttonStyle: .outline
            )
        } editor: {
            ColorPresetRow(label: "buttonCheckedBg", color: $config.components.radio.buttonCheckedBg) {
            }
        } code: {
            "config.components.radio.buttonCheckedBg = ..."
        }
        .scrollAnchor("component.buttonCheckedBg")
    }

    var buttonCheckedBgDisabledTokenCard: some View {
        TokenCard(
            name: "buttonCheckedBgDisabled",
            type: "Color",
            defaultValue: "#f5f5f5",
            description: tr("doc.component.buttonCheckedBgDisabled"),
            sectionId: "component"
        ) {
            Moin.RadioGroup(
                value: $buttonValue,
                options: ["A", "B", "C"],
                disabled: true,
                optionType: .button
            )
        } editor: {
            ColorPresetRow(label: "buttonCheckedBgDisabled", color: $config.components.radio.buttonCheckedBgDisabled) {
            }
        } code: {
            "config.components.radio.buttonCheckedBgDisabled = ..."
        }
        .scrollAnchor("component.buttonCheckedBgDisabled")
    }

    var buttonCheckedColorDisabledTokenCard: some View {
        TokenCard(
            name: "buttonCheckedColorDisabled",
            type: "Color",
            defaultValue: "rgba(0,0,0,0.25)",
            description: tr("doc.component.buttonCheckedColorDisabled"),
            sectionId: "component"
        ) {
            Moin.RadioGroup(
                value: $buttonValue,
                options: ["A", "B", "C"],
                disabled: true,
                optionType: .button
            )
        } editor: {
            ColorPresetRow(label: "buttonCheckedColorDisabled", color: $config.components.radio.buttonCheckedColorDisabled) {
            }
        } code: {
            "config.components.radio.buttonCheckedColorDisabled = ..."
        }
        .scrollAnchor("component.buttonCheckedColorDisabled")
    }

    var buttonColorTokenCard: some View {
        TokenCard(
            name: "buttonColor",
            type: "Color",
            defaultValue: "rgba(0,0,0,0.88)",
            description: tr("doc.component.buttonColor"),
            sectionId: "component"
        ) {
            Moin.RadioGroup(
                value: $buttonValue,
                options: ["A", "B", "C"],
                optionType: .button
            )
        } editor: {
            ColorPresetRow(label: "buttonColor", color: $config.components.radio.buttonColor) {
            }
        } code: {
            "config.components.radio.buttonColor = ..."
        }
        .scrollAnchor("component.buttonColor")
    }

    var buttonPaddingInlineTokenCard: some View {
        TokenCard(
            name: "buttonPaddingInline",
            type: "CGFloat",
            defaultValue: "15",
            description: tr("doc.component.buttonPaddingInline"),
            sectionId: "component"
        ) {
            HStack(spacing: Moin.Constants.Spacing.md) {
                Moin.RadioGroup(
                    value: Binding.constant("A"),
                    options: ["A", "B", "C"],
                    optionType: .button
                )
                .id(config.components.radio.buttonPaddingInline)
                Text("padding: \(Int(config.components.radio.buttonPaddingInline))px")
                    .font(.system(size: 11, design: .monospaced))
                    .foregroundStyle(.secondary)
            }
        } editor: {
            TokenValueRow(label: "buttonPaddingInline", value: $config.components.radio.buttonPaddingInline, range: 8...32) {
            }
        } code: {
            "config.components.radio.buttonPaddingInline = \(Int(config.components.radio.buttonPaddingInline))"
        }
        .scrollAnchor("component.buttonPaddingInline")
    }

    var buttonSolidCheckedActiveBgTokenCard: some View {
        TokenCard(
            name: "buttonSolidCheckedActiveBg",
            type: "Color",
            defaultValue: "#0958d9",
            description: tr("doc.component.buttonSolidCheckedActiveBg"),
            sectionId: "component"
        ) {
            Moin.RadioGroup(
                value: $buttonValue,
                options: ["A", "B", "C"],
                optionType: .button,
                buttonStyle: .solid
            )
        } editor: {
            ColorPresetRow(label: "buttonSolidCheckedActiveBg", color: $config.components.radio.buttonSolidCheckedActiveBg) {
            }
        } code: {
            "config.components.radio.buttonSolidCheckedActiveBg = ..."
        }
        .scrollAnchor("component.buttonSolidCheckedActiveBg")
    }

    var buttonSolidCheckedBgTokenCard: some View {
        TokenCard(
            name: "buttonSolidCheckedBg",
            type: "Color",
            defaultValue: "#1677ff",
            description: tr("doc.component.buttonSolidCheckedBg"),
            sectionId: "component"
        ) {
            Moin.RadioGroup(
                value: $buttonValue,
                options: ["A", "B", "C"],
                optionType: .button,
                buttonStyle: .solid
            )
        } editor: {
            ColorPresetRow(label: "buttonSolidCheckedBg", color: $config.components.radio.buttonSolidCheckedBg) {
            }
        } code: {
            "config.components.radio.buttonSolidCheckedBg = ..."
        }
        .scrollAnchor("component.buttonSolidCheckedBg")
    }

    var buttonSolidCheckedColorTokenCard: some View {
        TokenCard(
            name: "buttonSolidCheckedColor",
            type: "Color",
            defaultValue: "#ffffff",
            description: tr("doc.component.buttonSolidCheckedColor"),
            sectionId: "component"
        ) {
            Moin.RadioGroup(
                value: $buttonValue,
                options: ["A", "B", "C"],
                optionType: .button,
                buttonStyle: .solid
            )
        } editor: {
            ColorPresetRow(label: "buttonSolidCheckedColor", color: $config.components.radio.buttonSolidCheckedColor) {
            }
        } code: {
            "config.components.radio.buttonSolidCheckedColor = ..."
        }
        .scrollAnchor("component.buttonSolidCheckedColor")
    }

    var buttonSolidCheckedHoverBgTokenCard: some View {
        TokenCard(
            name: "buttonSolidCheckedHoverBg",
            type: "Color",
            defaultValue: "#4096ff",
            description: tr("doc.component.buttonSolidCheckedHoverBg"),
            sectionId: "component"
        ) {
            Moin.RadioGroup(
                value: $buttonValue,
                options: ["A", "B", "C"],
                optionType: .button,
                buttonStyle: .solid
            )
        } editor: {
            ColorPresetRow(label: "buttonSolidCheckedHoverBg", color: $config.components.radio.buttonSolidCheckedHoverBg) {
            }
        } code: {
            "config.components.radio.buttonSolidCheckedHoverBg = ..."
        }
        .scrollAnchor("component.buttonSolidCheckedHoverBg")
    }

    // MARK: - Global Tokens

    var colorPrimaryGlobalTokenCard: some View {
        TokenCard(
            name: "colorPrimary",
            type: "Color",
            defaultValue: "#1677ff",
            description: tr("doc.global.colorPrimary"),
            sectionId: "global"
        ) {
            Moin.Radio("Radio", checked: $checked)
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

    var colorPrimaryHoverGlobalTokenCard: some View {
        TokenCard(
            name: "colorPrimaryHover",
            type: "Color",
            defaultValue: "#4096ff",
            description: tr("doc.global.colorPrimaryHover"),
            sectionId: "global"
        ) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Hover over the radio button to see effect")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Moin.Radio("Radio", checked: .constant(false))
                    .id(config.token.colorPrimaryHover)
            }
        } editor: {
            ColorPresetRow(label: "colorPrimaryHover", color: $config.token.colorPrimaryHover) {
                config.components = Moin.ComponentToken.generate(from: config.token, isDark: config.isDarkMode)
            }
        } code: {
            "config.token.colorPrimaryHover = \(config.token.colorPrimaryHover.description)"
        }
        .scrollAnchor("global.colorPrimaryHover")
    }

    var colorTextGlobalTokenCard: some View {
        TokenCard(
            name: "colorText",
            type: "Color",
            defaultValue: "rgba(0,0,0,0.88)",
            description: tr("doc.global.colorText"),
            sectionId: "global"
        ) {
            Moin.Radio("Radio Label", checked: $checked)
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

    var colorBorderGlobalTokenCard: some View {
        TokenCard(
            name: "colorBorder",
            type: "Color",
            defaultValue: "#d9d9d9",
            description: tr("doc.global.colorBorder"),
            sectionId: "global"
        ) {
            Moin.Radio("Radio", checked: .constant(false))
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
            Moin.Radio("Radio", checked: .constant(false))
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

    var colorBgContainerDisabledGlobalTokenCard: some View {
        TokenCard(
            name: "colorBgContainerDisabled",
            type: "Color",
            defaultValue: "#f5f5f5",
            description: tr("doc.global.colorBgDisabled"),
            sectionId: "global"
        ) {
            Moin.Radio("Radio", checked: .constant(false), disabled: true)
                .id(config.token.colorBgDisabled)
        } editor: {
            ColorPresetRow(label: "colorBgDisabled", color: $config.token.colorBgDisabled) {
                config.components = Moin.ComponentToken.generate(from: config.token, isDark: config.isDarkMode)
            }
        } code: {
            "config.token.colorBgDisabled = \(config.token.colorBgDisabled.description)"
        }
        .scrollAnchor("global.colorBgContainerDisabled")
    }

    var colorTextDisabledGlobalTokenCard: some View {
        TokenCard(
            name: "colorTextDisabled",
            type: "Color",
            defaultValue: "rgba(0,0,0,0.25)",
            description: tr("doc.global.colorTextDisabled"),
            sectionId: "global"
        ) {
            Moin.Radio("Radio", checked: .constant(true), disabled: true)
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

    var lineWidthGlobalTokenCard: some View {
        TokenCard(
            name: "lineWidth",
            type: "CGFloat",
            defaultValue: "1",
            description: tr("doc.global.lineWidth"),
            sectionId: "global"
        ) {
            HStack(spacing: Moin.Constants.Spacing.md) {
                Moin.Radio("Radio", checked: .constant(false))
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

    var paddingXSGlobalTokenCard: some View {
        TokenCard(
            name: "paddingXS",
            type: "CGFloat",
            defaultValue: "8",
            description: tr("doc.global.paddingXS"),
            sectionId: "global"
        ) {
            HStack(spacing: Moin.Constants.Spacing.md) {
                Moin.Radio("Radio", checked: $checked)
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

    var motionDurationMidGlobalTokenCard: some View {
        TokenCard(
            name: "motionDurationMid",
            type: "Double",
            defaultValue: "0.2",
            description: tr("doc.global.motionDurationMid"),
            sectionId: "global"
        ) {
            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.sm) {
                Moin.RadioGroup(value: $groupValue, options: [1, 2, 3])
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
            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.sm) {
                Moin.RadioGroup(value: $groupValue, options: [1, 2, 3])
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
