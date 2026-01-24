import SwiftUI
import MoinUI

// MARK: - Checkbox Token 卡片扩展

extension CheckboxTokenView {

    // MARK: - Component Tokens (Sizes)

    var checkboxSizeTokenCard: some View {
        TokenCard(
            name: "checkboxSize",
            type: "CGFloat",
            defaultValue: "16",
            description: tr("checkbox.api.token.checkboxSize"),
            sectionId: "component"
        ) {
            HStack(spacing: Moin.Constants.Spacing.md) {
                Moin.Checkbox(tr("component.checkbox"), checked: .constant(true))
                Text("size: \(Int(config.components.checkbox.checkboxSize))px")
                    .font(.system(size: 11, design: .monospaced))
                    .foregroundStyle(.secondary)
            }
        } editor: {
            TokenValueRow(label: "checkboxSize", value: $config.components.checkbox.checkboxSize, range: 12...24)
        } code: {
            "config.components.checkbox.checkboxSize = \(Int(config.components.checkbox.checkboxSize))"
        }
        .scrollAnchor("component.checkboxSize")
    }

    // MARK: - Component Tokens (Borders)

    var borderRadiusTokenCard: some View {
        TokenCard(
            name: "borderRadius",
            type: "CGFloat",
            defaultValue: "2",
            description: tr("checkbox.api.token.borderRadius"),
            sectionId: "component"
        ) {
            HStack(spacing: Moin.Constants.Spacing.md) {
                Moin.Checkbox(tr("component.checkbox"), checked: .constant(true))
                Text("radius: \(String(format: "%.1f", config.components.checkbox.borderRadius))px")
                    .font(.system(size: 11, design: .monospaced))
                    .foregroundStyle(.secondary)
            }
        } editor: {
            TokenValueRow(label: "borderRadius", value: $config.components.checkbox.borderRadius, range: 0...8)
        } code: {
            "config.components.checkbox.borderRadius = \(String(format: "%.1f", config.components.checkbox.borderRadius))"
        }
        .scrollAnchor("component.borderRadius")
    }

    var lineWidthTokenCard: some View {
        TokenCard(
            name: "lineWidth",
            type: "CGFloat",
            defaultValue: "1",
            description: tr("checkbox.api.token.lineWidth"),
            sectionId: "component"
        ) {
            HStack(spacing: Moin.Constants.Spacing.md) {
                Moin.Checkbox(tr("component.checkbox"), checked: .constant(false))
                Text("width: \(String(format: "%.1f", config.components.checkbox.lineWidth))px")
                    .font(.system(size: 11, design: .monospaced))
                    .foregroundStyle(.secondary)
            }
        } editor: {
            TokenValueRow(label: "lineWidth", value: $config.components.checkbox.lineWidth, range: 0.5...3)
        } code: {
            "config.components.checkbox.lineWidth = \(String(format: "%.1f", config.components.checkbox.lineWidth))"
        }
        .scrollAnchor("component.lineWidth")
    }

    var lineWidthBoldTokenCard: some View {
        TokenCard(
            name: "lineWidthBold",
            type: "CGFloat",
            defaultValue: "2",
            description: tr("checkbox.api.token.lineWidthBold"),
            sectionId: "component"
        ) {
            HStack(spacing: Moin.Constants.Spacing.md) {
                Moin.Checkbox(tr("component.checkbox"), checked: .constant(true))
                Text("width: \(String(format: "%.1f", config.components.checkbox.lineWidthBold))px")
                    .font(.system(size: 11, design: .monospaced))
                    .foregroundStyle(.secondary)
            }
        } editor: {
            TokenValueRow(label: "lineWidthBold", value: $config.components.checkbox.lineWidthBold, range: 1...4)
        } code: {
            "config.components.checkbox.lineWidthBold = \(String(format: "%.1f", config.components.checkbox.lineWidthBold))"
        }
        .scrollAnchor("component.lineWidthBold")
    }

    // MARK: - Component Tokens (Colors)

    var colorPrimaryTokenCard: some View {
        TokenCard(
            name: "colorPrimary",
            type: "Color",
            defaultValue: "blue6",
            description: tr("checkbox.api.token.colorPrimary"),
            sectionId: "component"
        ) {
            HStack(spacing: Moin.Constants.Spacing.md) {
                Moin.Checkbox(tr("component.checkbox"), checked: .constant(true))
                Circle()
                    .fill(config.components.checkbox.colorPrimary)
                    .frame(width: 24, height: 24)
                    .border(.gray.opacity(0.3), width: 1)
            }
        } editor: {
            ColorPresetRow(label: "colorPrimary", color: $config.components.checkbox.colorPrimary)
        } code: {
            "config.components.checkbox.colorPrimary = <Color>"
        }
        .scrollAnchor("component.colorPrimary")
    }

    var colorPrimaryHoverTokenCard: some View {
        TokenCard(
            name: "colorPrimaryHover",
            type: "Color",
            defaultValue: "blue5",
            description: tr("checkbox.api.token.colorPrimaryHover"),
            sectionId: "component"
        ) {
            HStack(spacing: Moin.Constants.Spacing.md) {
                Moin.Checkbox(tr("component.checkbox"), checked: .constant(true))
                    .onHover { _ in }
                Circle()
                    .fill(config.components.checkbox.colorPrimaryHover)
                    .frame(width: 24, height: 24)
                    .border(.gray.opacity(0.3), width: 1)
            }
        } editor: {
            ColorPresetRow(label: "colorPrimaryHover", color: $config.components.checkbox.colorPrimaryHover)
        } code: {
            "config.components.checkbox.colorPrimaryHover = <Color>"
        }
        .scrollAnchor("component.colorPrimaryHover")
    }

    var colorBorderTokenCard: some View {
        TokenCard(
            name: "colorBorder",
            type: "Color",
            defaultValue: "#D9D9D9",
            description: tr("checkbox.api.token.colorBorder"),
            sectionId: "component"
        ) {
            HStack(spacing: Moin.Constants.Spacing.md) {
                Moin.Checkbox(tr("component.checkbox"), checked: .constant(false))
                Circle()
                    .fill(config.components.checkbox.colorBorder)
                    .frame(width: 24, height: 24)
                    .border(.gray.opacity(0.3), width: 1)
            }
        } editor: {
            ColorPresetRow(label: "colorBorder", color: $config.components.checkbox.colorBorder)
        } code: {
            "config.components.checkbox.colorBorder = <Color>"
        }
        .scrollAnchor("component.colorBorder")
    }

    var colorBgContainerTokenCard: some View {
        TokenCard(
            name: "colorBgContainer",
            type: "Color",
            defaultValue: "white",
            description: tr("checkbox.api.token.colorBgContainer"),
            sectionId: "component"
        ) {
            HStack(spacing: Moin.Constants.Spacing.md) {
                Moin.Checkbox(tr("component.checkbox"), checked: .constant(false))
                Circle()
                    .fill(config.components.checkbox.colorBgContainer)
                    .frame(width: 24, height: 24)
                    .border(.gray.opacity(0.3), width: 1)
            }
        } editor: {
            ColorPresetRow(label: "colorBgContainer", color: $config.components.checkbox.colorBgContainer)
        } code: {
            "config.components.checkbox.colorBgContainer = <Color>"
        }
        .scrollAnchor("component.colorBgContainer")
    }

    var colorWhiteTokenCard: some View {
        TokenCard(
            name: "colorWhite",
            type: "Color",
            defaultValue: "white",
            description: tr("checkbox.api.token.colorWhite"),
            sectionId: "component"
        ) {
            HStack(spacing: Moin.Constants.Spacing.md) {
                Moin.Checkbox(tr("component.checkbox"), checked: .constant(true))
                Circle()
                    .fill(config.components.checkbox.colorWhite)
                    .frame(width: 24, height: 24)
                    .border(.gray.opacity(0.3), width: 1)
            }
        } editor: {
            ColorPresetRow(label: "colorWhite", color: $config.components.checkbox.colorWhite)
        } code: {
            "config.components.checkbox.colorWhite = <Color>"
        }
        .scrollAnchor("component.colorWhite")
    }

    // MARK: - Component Tokens (Disabled)

    var colorBgContainerDisabledTokenCard: some View {
        TokenCard(
            name: "colorBgContainerDisabled",
            type: "Color",
            defaultValue: "#F5F5F5",
            description: tr("checkbox.api.token.colorBgContainerDisabled"),
            sectionId: "component"
        ) {
            HStack(spacing: Moin.Constants.Spacing.md) {
                Moin.Checkbox(tr("component.checkbox"), checked: .constant(false), isDisabled: true)
                Circle()
                    .fill(config.components.checkbox.colorBgContainerDisabled)
                    .frame(width: 24, height: 24)
                    .border(.gray.opacity(0.3), width: 1)
            }
        } editor: {
            ColorPresetRow(label: "colorBgContainerDisabled", color: $config.components.checkbox.colorBgContainerDisabled)
        } code: {
            "config.components.checkbox.colorBgContainerDisabled = <Color>"
        }
        .scrollAnchor("component.colorBgContainerDisabled")
    }

    var colorBorderDisabledTokenCard: some View {
        TokenCard(
            name: "colorBorderDisabled",
            type: "Color",
            defaultValue: "#D9D9D9",
            description: tr("checkbox.api.token.colorBorderDisabled"),
            sectionId: "component"
        ) {
            HStack(spacing: Moin.Constants.Spacing.md) {
                Moin.Checkbox(tr("component.checkbox"), checked: .constant(false), isDisabled: true)
                Circle()
                    .fill(config.components.checkbox.colorBorderDisabled)
                    .frame(width: 24, height: 24)
                    .border(.gray.opacity(0.3), width: 1)
            }
        } editor: {
            ColorPresetRow(label: "colorBorderDisabled", color: $config.components.checkbox.colorBorderDisabled)
        } code: {
            "config.components.checkbox.colorBorderDisabled = <Color>"
        }
        .scrollAnchor("component.colorBorderDisabled")
    }

    var colorTextDisabledTokenCard: some View {
        TokenCard(
            name: "colorTextDisabled",
            type: "Color",
            defaultValue: "rgba(0,0,0,0.25)",
            description: tr("checkbox.api.token.colorTextDisabled"),
            sectionId: "component"
        ) {
            HStack(spacing: Moin.Constants.Spacing.md) {
                Moin.Checkbox(tr("component.checkbox"), checked: .constant(true), isDisabled: true)
                Circle()
                    .fill(config.components.checkbox.colorTextDisabled)
                    .frame(width: 24, height: 24)
                    .border(.gray.opacity(0.3), width: 1)
            }
        } editor: {
            ColorPresetRow(label: "colorTextDisabled", color: $config.components.checkbox.colorTextDisabled)
        } code: {
            "config.components.checkbox.colorTextDisabled = <Color>"
        }
        .scrollAnchor("component.colorTextDisabled")
    }

    // MARK: - Component Tokens (Layout)

    var paddingXSTokenCard: some View {
        TokenCard(
            name: "paddingXS",
            type: "CGFloat",
            defaultValue: "8",
            description: tr("checkbox.api.token.paddingXS"),
            sectionId: "component"
        ) {
            HStack(spacing: Moin.Constants.Spacing.md) {
                Moin.Checkbox(tr("component.checkbox"), checked: .constant(true))
                Text("spacing: \(Int(config.components.checkbox.paddingXS))px")
                    .font(.system(size: 11, design: .monospaced))
                    .foregroundStyle(.secondary)
            }
        } editor: {
            TokenValueRow(label: "paddingXS", value: $config.components.checkbox.paddingXS, range: 4...16)
        } code: {
            "config.components.checkbox.paddingXS = \(Int(config.components.checkbox.paddingXS))"
        }
        .scrollAnchor("component.paddingXS")
    }

    var motionDurationSlowTokenCard: some View {
        TokenCard(
            name: "motionDurationSlow",
            type: "Double",
            defaultValue: "0.3",
            description: tr("checkbox.api.token.motionDurationSlow"),
            sectionId: "component"
        ) {
            HStack(spacing: Moin.Constants.Spacing.md) {
                Moin.Checkbox(tr("component.checkbox"), checked: .constant(true))
                Text("duration: \(String(format: "%.1f", config.components.checkbox.motionDurationSlow))s")
                    .font(.system(size: 11, design: .monospaced))
                    .foregroundStyle(.secondary)
            }
        } editor: {
            TokenValueRow(label: "motionDurationSlow", value: Binding(get: { CGFloat(config.components.checkbox.motionDurationSlow) }, set: { config.components.checkbox.motionDurationSlow = Double($0) }), range: 0.1...1)
        } code: {
            "config.components.checkbox.motionDurationSlow = \(String(format: "%.1f", config.components.checkbox.motionDurationSlow))"
        }
        .scrollAnchor("component.motionDurationSlow")
    }

    // MARK: - Global Token Cards

    var borderRadiusSMGlobalTokenCard: some View {
        TokenCard(
            name: "borderRadiusSM",
            type: "CGFloat",
            defaultValue: "2",
            description: tr("doc.global.borderRadiusSM"),
            sectionId: "global"
        ) {
            HStack(spacing: Moin.Constants.Spacing.md) {
                Moin.Checkbox(tr("component.checkbox"), checked: .constant(true))
                Text("radius: \(String(format: "%.1f", config.token.borderRadiusSM))px")
                    .font(.system(size: 11, design: .monospaced))
                    .foregroundStyle(.secondary)
            }
        } editor: {
            TokenValueRow(label: "borderRadiusSM", value: $config.token.borderRadiusSM, range: 0...8)
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
                Moin.Checkbox(tr("component.checkbox"), checked: .constant(false))
                Text("width: \(String(format: "%.1f", config.token.lineWidth))px")
                    .font(.system(size: 11, design: .monospaced))
                    .foregroundStyle(.secondary)
            }
        } editor: {
            TokenValueRow(label: "lineWidth", value: $config.token.lineWidth, range: 0.5...3)
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
                Moin.Checkbox(tr("component.checkbox"), checked: .constant(true))
                Text("width: \(String(format: "%.1f", config.token.lineWidthBold))px")
                    .font(.system(size: 11, design: .monospaced))
                    .foregroundStyle(.secondary)
            }
        } editor: {
            TokenValueRow(label: "lineWidthBold", value: $config.token.lineWidthBold, range: 1...4)
        } code: {
            "config.token.lineWidthBold = \(String(format: "%.1f", config.token.lineWidthBold))"
        }
        .scrollAnchor("global.lineWidthBold")
    }

    var colorPrimaryGlobalTokenCard: some View {
        TokenCard(
            name: "colorPrimary",
            type: "Color",
            defaultValue: "blue6",
            description: tr("doc.global.colorPrimary"),
            sectionId: "global"
        ) {
            HStack(spacing: Moin.Constants.Spacing.md) {
                Moin.Checkbox(tr("component.checkbox"), checked: .constant(true))
                Circle()
                    .fill(config.token.colorPrimary)
                    .frame(width: 24, height: 24)
                    .border(.gray.opacity(0.3), width: 1)
            }
        } editor: {
            ColorPresetRow(label: "colorPrimary", color: $config.token.colorPrimary)
        } code: {
            "config.token.colorPrimary = <Color>"
        }
        .scrollAnchor("global.colorPrimary")
    }

    var colorPrimaryHoverGlobalTokenCard: some View {
        TokenCard(
            name: "colorPrimaryHover",
            type: "Color",
            defaultValue: "blue5",
            description: tr("doc.global.colorPrimaryHover"),
            sectionId: "global"
        ) {
            HStack(spacing: Moin.Constants.Spacing.md) {
                Moin.Checkbox(tr("component.checkbox"), checked: .constant(true))
                Circle()
                    .fill(config.token.colorPrimaryHover)
                    .frame(width: 24, height: 24)
                    .border(.gray.opacity(0.3), width: 1)
            }
        } editor: {
            ColorPresetRow(label: "colorPrimaryHover", color: $config.token.colorPrimaryHover)
        } code: {
            "config.token.colorPrimaryHover = <Color>"
        }
        .scrollAnchor("global.colorPrimaryHover")
    }

    var colorBorderGlobalTokenCard: some View {
        TokenCard(
            name: "colorBorder",
            type: "Color",
            defaultValue: "#D9D9D9",
            description: tr("doc.global.colorBorder"),
            sectionId: "global"
        ) {
            HStack(spacing: Moin.Constants.Spacing.md) {
                Moin.Checkbox(tr("component.checkbox"), checked: .constant(false))
                Circle()
                    .fill(config.token.colorBorder)
                    .frame(width: 24, height: 24)
                    .border(.gray.opacity(0.3), width: 1)
            }
        } editor: {
            ColorPresetRow(label: "colorBorder", color: $config.token.colorBorder)
        } code: {
            "config.token.colorBorder = <Color>"
        }
        .scrollAnchor("global.colorBorder")
    }

    var colorBgContainerGlobalTokenCard: some View {
        TokenCard(
            name: "colorBgContainer",
            type: "Color",
            defaultValue: "white",
            description: tr("doc.global.colorBgContainer"),
            sectionId: "global"
        ) {
            HStack(spacing: Moin.Constants.Spacing.md) {
                Moin.Checkbox(tr("component.checkbox"), checked: .constant(false))
                Circle()
                    .fill(config.token.colorBgContainer)
                    .frame(width: 24, height: 24)
                    .border(.gray.opacity(0.3), width: 1)
            }
        } editor: {
            ColorPresetRow(label: "colorBgContainer", color: $config.token.colorBgContainer)
        } code: {
            "config.token.colorBgContainer = <Color>"
        }
        .scrollAnchor("global.colorBgContainer")
    }

    var colorBgDisabledGlobalTokenCard: some View {
        TokenCard(
            name: "colorBgDisabled",
            type: "Color",
            defaultValue: "#F5F5F5",
            description: tr("doc.global.colorBgDisabled"),
            sectionId: "global"
        ) {
            HStack(spacing: Moin.Constants.Spacing.md) {
                Moin.Checkbox(tr("component.checkbox"), checked: .constant(false), isDisabled: true)
                Circle()
                    .fill(config.token.colorBgDisabled)
                    .frame(width: 24, height: 24)
                    .border(.gray.opacity(0.3), width: 1)
            }
        } editor: {
            ColorPresetRow(label: "colorBgDisabled", color: $config.token.colorBgDisabled)
        } code: {
            "config.token.colorBgDisabled = <Color>"
        }
        .scrollAnchor("global.colorBgDisabled")
    }

    var colorTextDisabledGlobalTokenCard: some View {
        TokenCard(
            name: "colorTextDisabled",
            type: "Color",
            defaultValue: "rgba(0,0,0,0.25)",
            description: tr("doc.global.colorTextDisabled"),
            sectionId: "global"
        ) {
            HStack(spacing: Moin.Constants.Spacing.md) {
                Moin.Checkbox(tr("component.checkbox"), checked: .constant(true), isDisabled: true)
                Circle()
                    .fill(config.token.colorTextDisabled)
                    .frame(width: 24, height: 24)
                    .border(.gray.opacity(0.3), width: 1)
            }
        } editor: {
            ColorPresetRow(label: "colorTextDisabled", color: $config.token.colorTextDisabled)
        } code: {
            "config.token.colorTextDisabled = <Color>"
        }
        .scrollAnchor("global.colorTextDisabled")
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
                Moin.Checkbox(tr("component.checkbox"), checked: .constant(true))
                Text("spacing: \(Int(config.token.paddingXS))px")
                    .font(.system(size: 11, design: .monospaced))
                    .foregroundStyle(.secondary)
            }
        } editor: {
            TokenValueRow(label: "paddingXS", value: $config.token.paddingXS, range: 4...16)
        } code: {
            "config.token.paddingXS = \(Int(config.token.paddingXS))"
        }
        .scrollAnchor("global.paddingXS")
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
                Moin.Checkbox(tr("component.checkbox"), checked: .constant(true))
                Text("duration: \(String(format: "%.1f", config.token.motionDurationSlow))s")
                    .font(.system(size: 11, design: .monospaced))
                    .foregroundStyle(.secondary)
            }
        } editor: {
            TokenValueRow(label: "motionDurationSlow", value: Binding(get: { CGFloat(config.token.motionDurationSlow) }, set: { config.token.motionDurationSlow = Double($0) }), range: 0.1...1)
        } code: {
            "config.token.motionDurationSlow = \(String(format: "%.1f", config.token.motionDurationSlow))"
        }
        .scrollAnchor("global.motionDurationSlow")
    }
}
