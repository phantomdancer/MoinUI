import SwiftUI
import MoinUI

// MARK: - Radio Token Cards Extension

extension RadioTokenView {

    // MARK: - Component Tokens

    var radioSizeGlobalTokenCard: some View {
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
                // Direct update
            }
        } code: {
            "config.components.radio.radioSize = \(Int(config.components.radio.radioSize))"
        }
        .scrollAnchor("component.radioSize")
    }

    var dotSizeGlobalTokenCard: some View {
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
                // Direct update
            }
        } code: {
            "config.components.radio.dotSize = \(Int(config.components.radio.dotSize))"
        }
        .scrollAnchor("component.dotSize")
    }

    // MARK: - Global Tokens

    // MARK: - Primary Colors

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

    // MARK: - Border & Background Colors

    var colorBorderGlobalTokenCard: some View {
        TokenCard(
            name: "colorBorder",
            type: "Color",
            defaultValue: "#d9d9d9",
            description: tr("doc.global.colorBorder"),
            sectionId: "global"
        ) {
            Moin.Radio("Radio", checked: .constant(false)) // Unchecked shows border
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
    
    var colorDotGlobalTokenCard: some View {
        TokenCard(
            name: "colorDot",
            type: "Color",
            defaultValue: "#1677ff",
            description: tr("doc.global.colorPrimary"),
            sectionId: "global"
        ) {
            Moin.Radio("Radio", checked: $checked)
        } editor: {
             // colorDot is typically colorPrimary. We can render it but editing 'colorDot' specifically isn't possible via 'config.token.colorDot' because that doesn't exist.
             // But we can edit config.components.radio.colorDot?
             // But here we are in Global section.
             // If we want to show it comes from Primary, we can just show it.
             // Or allow editing radio.colorDot component token.
             // Let's make this a Component Token editor masquerading in global section if we want?
             // No, let's just use ColorPresetRow relative to Component Token if possible.
             ColorPresetRow(label: "colorDot", color: $config.components.radio.colorDot) {
                 // direct update
             }
        } code: {
            "config.components.radio.colorDot = ..."
        }
        .scrollAnchor("global.colorDot")
    }

    // MARK: - Disabled Colors

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

    var colorBorderDisabledGlobalTokenCard: some View {
        TokenCard(
            name: "colorBorderDisabled",
            type: "Color",
            defaultValue: "#d9d9d9",
            description: tr("doc.global.colorBorder"), // Reuses colorBorder description or similar
            sectionId: "global"
        ) {
            Moin.Radio("Radio", checked: .constant(false), disabled: true)
                .id(config.token.colorBorder)
        } editor: {
            // Usually comes from colorBorder
            ColorPresetRow(label: "colorBorder", color: $config.token.colorBorder) {
                 config.components = Moin.ComponentToken.generate(from: config.token, isDark: config.isDarkMode)
            }
        } code: {
             "config.token.colorBorder = ..."
        }
        .scrollAnchor("global.colorBorderDisabled")
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
    
    var colorDotDisabledGlobalTokenCard: some View {
        TokenCard(
            name: "colorDotDisabled",
            type: "Color",
            defaultValue: "rgba(0,0,0,0.25)",
            description: tr("doc.global.colorTextDisabled"),
            sectionId: "global"
        ) {
            Moin.Radio("Radio", checked: .constant(true), disabled: true)
        } editor: {
             ColorPresetRow(label: "colorDotDisabled", color: $config.components.radio.colorDotDisabled) {
             }
        } code: {
            "config.components.radio.colorDotDisabled = ..."
        }
        .scrollAnchor("global.colorDotDisabled")
    }

    // MARK: - Borders & Spacing

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
    
    var wrapperMarginEndGlobalTokenCard: some View {
        TokenCard(
            name: "wrapperMarginEnd",
            type: "CGFloat",
            defaultValue: "8",
            description: tr("doc.global.paddingXS"),
            sectionId: "global"
        ) {
             HStack(spacing: Moin.Constants.Spacing.md) {
                 // Should show a group to demonstrate spacing
                 Moin.RadioGroup(selection: .constant(1), options: [1, 2])
                    .id(config.token.paddingXS)
             }
        } editor: {
            // wrapperMarginEnd usually comes from paddingXS
            TokenValueRow(label: "paddingXS", value: $config.token.paddingXS, range: 4...16) {
                config.components = Moin.ComponentToken.generate(from: config.token, isDark: config.isDarkMode)
            }
        } code: {
            "config.token.paddingXS = \(Int(config.token.paddingXS))"
        }
        .scrollAnchor("global.wrapperMarginEnd")
    }

    // MARK: - Motion Tokens

    var motionDurationMidGlobalTokenCard: some View {
        TokenCard(
            name: "motionDurationMid",
            type: "Double",
            defaultValue: "0.2",
            description: tr("doc.global.motionDurationMid"),
            sectionId: "global"
        ) {
            HStack(spacing: Moin.Constants.Spacing.md) {
                Moin.Radio("Radio", checked: $checked)
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
                Moin.Radio("Radio", checked: $checked)
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
