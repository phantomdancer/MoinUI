import SwiftUI
import MoinUI

// MARK: - Button Token 卡片扩展

extension ButtonTokenView {

    // MARK: - 边框相关 Token

    var borderColorDisabledTokenCard: some View {
        TokenCard(
            name: "borderColorDisabled",
            type: "Color",
            defaultValue: "border.opacity(0.5)",
            description: tr("button.api.token.borderColorDisabled"),
            sectionId: "token"
        ) {
            Moin.Button(tr("button.label.disabled"), variant: .outlined, isDisabled: true) {}
        } editor: {
            ColorPresetRow(label: "borderColorDisabled", color: $config.components.button.borderColorDisabled)
        } code: {
            "config.components.button.borderColorDisabled = Color(...)"
        }
        .scrollAnchor("token.borderColorDisabled")
    }

    // MARK: - 颜色相关 Token

    var defaultColorTokenCard: some View {
        TokenCard(
            name: "defaultColor",
            type: "Color",
            defaultValue: "textPrimary",
            description: tr("button.api.token.defaultColor"),
            sectionId: "token"
        ) {
            Moin.Button(tr("button.label.default")) {}
        } editor: {
            ColorPresetRow(label: "defaultColor", color: $config.components.button.defaultColor)
        } code: {
            "config.components.button.defaultColor = Color(...)"
        }
        .scrollAnchor("token.defaultColor")
    }

    var defaultBgTokenCard: some View {
        TokenCard(
            name: "defaultBg",
            type: "Color",
            defaultValue: "background",
            description: tr("button.api.token.defaultBg"),
            sectionId: "token"
        ) {
            Moin.Button(tr("button.label.default")) {}
        } editor: {
            ColorPresetRow(label: "defaultBg", color: $config.components.button.defaultBg)
        } code: {
            "config.components.button.defaultBg = Color(...)"
        }
        .scrollAnchor("token.defaultBg")
    }

    var defaultBorderColorTokenCard: some View {
        TokenCard(
            name: "defaultBorderColor",
            type: "Color",
            defaultValue: "border",
            description: tr("button.api.token.defaultBorderColor"),
            sectionId: "token"
        ) {
            Moin.Button(tr("button.label.default"), variant: .outlined) {}
        } editor: {
            ColorPresetRow(label: "defaultBorderColor", color: $config.components.button.defaultBorderColor)
        } code: {
            "config.components.button.defaultBorderColor = Color(...)"
        }
        .scrollAnchor("token.defaultBorderColor")
    }

    var dangerColorTokenCard: some View {
        TokenCard(
            name: "dangerColor",
            type: "Color",
            defaultValue: ".white",
            description: tr("button.api.token.dangerColor"),
            sectionId: "token"
        ) {
            Moin.Button(tr("button.label.danger"), color: .danger) {}
        } editor: {
            ColorPresetRow(label: "dangerColor", color: $config.components.button.dangerColor)
        } code: {
            "config.components.button.dangerColor = Color(...)"
        }
        .scrollAnchor("token.dangerColor")
    }

    var defaultActiveBgTokenCard: some View {
        TokenCard(
            name: "defaultActiveBg",
            type: "Color",
            defaultValue: "background",
            description: tr("button.api.token.defaultActiveBg"),
            sectionId: "token"
        ) {
            Moin.Button(tr("button.label.click_active")) {}
        } editor: {
            ColorPresetRow(label: "defaultActiveBg", color: $config.components.button.defaultActiveBg)
        } code: {
            "config.components.button.defaultActiveBg = Color(...)"
        }
        .scrollAnchor("token.defaultActiveBg")
    }

    var defaultActiveBorderColorTokenCard: some View {
        TokenCard(
            name: "defaultActiveBorderColor",
            type: "Color",
            defaultValue: "primaryActive",
            description: tr("button.api.token.defaultActiveBorderColor"),
            sectionId: "token"
        ) {
            Moin.Button(tr("button.label.default"), variant: .outlined) {}
        } editor: {
            ColorPresetRow(label: "defaultActiveBorderColor", color: $config.components.button.defaultActiveBorderColor)
        } code: {
            "config.components.button.defaultActiveBorderColor = Color(...)"
        }
        .scrollAnchor("token.defaultActiveBorderColor")
    }

    var defaultActiveColorTokenCard: some View {
        TokenCard(
            name: "defaultActiveColor",
            type: "Color",
            defaultValue: "primaryActive",
            description: tr("button.api.token.defaultActiveColor"),
            sectionId: "token"
        ) {
            Moin.Button(tr("button.label.click_active")) {}
        } editor: {
            ColorPresetRow(label: "defaultActiveColor", color: $config.components.button.defaultActiveColor)
        } code: {
            "config.components.button.defaultActiveColor = Color(...)"
        }
        .scrollAnchor("token.defaultActiveColor")
    }

    var defaultBgDisabledTokenCard: some View {
        TokenCard(
            name: "defaultBgDisabled",
            type: "Color",
            defaultValue: "bgDisabled",
            description: tr("button.api.token.defaultBgDisabled"),
            sectionId: "token"
        ) {
            Moin.Button(tr("button.label.disabled"), isDisabled: true) {}
        } editor: {
            ColorPresetRow(label: "defaultBgDisabled", color: $config.components.button.defaultBgDisabled)
        } code: {
            "config.components.button.defaultBgDisabled = Color(...)"
        }
        .scrollAnchor("token.defaultBgDisabled")
    }

    var defaultGhostBorderColorTokenCard: some View {
        TokenCard(
            name: "defaultGhostBorderColor",
            type: "Color",
            defaultValue: ".white",
            description: tr("button.api.token.defaultGhostBorderColor"),
            sectionId: "token"
        ) {
            ZStack {
                Color(white: 0.3).frame(height: 50).cornerRadius(8)
                Moin.Button(tr("button.label.ghost"), isGhost: true) {}
            }
        } editor: {
            ColorPresetRow(label: "defaultGhostBorderColor", color: $config.components.button.defaultGhostBorderColor)
        } code: {
            "config.components.button.defaultGhostBorderColor = Color(...)"
        }
        .scrollAnchor("token.defaultGhostBorderColor")
    }

    var defaultGhostColorTokenCard: some View {
        TokenCard(
            name: "defaultGhostColor",
            type: "Color",
            defaultValue: ".white",
            description: tr("button.api.token.defaultGhostColor"),
            sectionId: "token"
        ) {
            ZStack {
                Color(white: 0.3).frame(height: 50).cornerRadius(8)
                Moin.Button(tr("button.label.ghost"), isGhost: true) {}
            }
        } editor: {
            ColorPresetRow(label: "defaultGhostColor", color: $config.components.button.defaultGhostColor)
        } code: {
            "config.components.button.defaultGhostColor = Color(...)"
        }
        .scrollAnchor("token.defaultGhostColor")
    }

    var defaultHoverBgTokenCard: some View {
        TokenCard(
            name: "defaultHoverBg",
            type: "Color",
            defaultValue: "background",
            description: tr("button.api.token.defaultHoverBg"),
            sectionId: "token"
        ) {
            Moin.Button(tr("button.label.hover_me")) {}
        } editor: {
            ColorPresetRow(label: "defaultHoverBg", color: $config.components.button.defaultHoverBg)
        } code: {
            "config.components.button.defaultHoverBg = Color(...)"
        }
        .scrollAnchor("token.defaultHoverBg")
    }

    var defaultHoverBorderColorTokenCard: some View {
        TokenCard(
            name: "defaultHoverBorderColor",
            type: "Color",
            defaultValue: "primaryHover",
            description: tr("button.api.token.defaultHoverBorderColor"),
            sectionId: "token"
        ) {
            Moin.Button(tr("button.label.hover_me"), variant: .outlined) {}
        } editor: {
            ColorPresetRow(label: "defaultHoverBorderColor", color: $config.components.button.defaultHoverBorderColor)
        } code: {
            "config.components.button.defaultHoverBorderColor = Color(...)"
        }
        .scrollAnchor("token.defaultHoverBorderColor")
    }

    var defaultHoverColorTokenCard: some View {
        TokenCard(
            name: "defaultHoverColor",
            type: "Color",
            defaultValue: "primaryHover",
            description: tr("button.api.token.defaultHoverColor"),
            sectionId: "token"
        ) {
            Moin.Button(tr("button.label.hover_me")) {}
        } editor: {
            ColorPresetRow(label: "defaultHoverColor", color: $config.components.button.defaultHoverColor)
        } code: {
            "config.components.button.defaultHoverColor = Color(...)"
        }
        .scrollAnchor("token.defaultHoverColor")
    }

    var fontWeightTokenCard: some View {
        TokenCard(
            name: "fontWeight",
            type: "Font.Weight",
            defaultValue: ".medium",
            description: tr("button.api.token.fontWeight"),
            sectionId: "token"
        ) {
            Moin.Button(tr("button.label.button"), color: .primary) {}
        } editor: {
            FontWeightPickerRow(label: "fontWeight", selection: $config.components.button.fontWeight)
        } code: {
            "config.components.button.fontWeight = \(config.components.button.fontWeight.codeDescription)"
        }
        .scrollAnchor("token.fontWeight")
    }

    var ghostBgTokenCard: some View {
        TokenCard(
            name: "ghostBg",
            type: "Color",
            defaultValue: ".clear",
            description: tr("button.api.token.ghostBg"),
            sectionId: "token"
        ) {
            ZStack {
                Color(white: 0.3).frame(height: 50).cornerRadius(8)
                Moin.Button(tr("button.label.ghost"), color: .primary, isGhost: true) {}
            }
        } editor: {
            ColorPresetRow(label: "ghostBg", color: $config.components.button.ghostBg)
        } code: {
            "config.components.button.ghostBg = Color(...)"
        }
        .scrollAnchor("token.ghostBg")
    }

    var linkHoverBgTokenCard: some View {
        TokenCard(
            name: "linkHoverBg",
            type: "Color",
            defaultValue: ".clear",
            description: tr("button.api.token.linkHoverBg"),
            sectionId: "token"
        ) {
            Moin.Button(tr("button.label.link_button"), variant: .link) {}
        } editor: {
            ColorPresetRow(label: "linkHoverBg", color: $config.components.button.linkHoverBg)
        } code: {
            "config.components.button.linkHoverBg = Color(...)"
        }
        .scrollAnchor("token.linkHoverBg")
    }

    var onlyIconSizeTokenCard: some View {
        TokenCard(
            name: "onlyIconSize",
            type: "CGFloat",
            defaultValue: "16",
            description: tr("button.api.token.onlyIconSize"),
            sectionId: "token"
        ) {
            HStack(spacing: Moin.Constants.Spacing.md) {
                Moin.Button(icon: "plus", color: .primary) {}
                Text("iconSize: \(Int(config.components.button.onlyIconSize))px")
                    .font(.system(size: 11, design: .monospaced))
                    .foregroundStyle(.secondary)
            }
        } editor: {
            TokenValueRow(label: "onlyIconSize", value: $config.components.button.onlyIconSize, range: 10...30)
        } code: {
            "config.components.button.onlyIconSize = \(Int(config.components.button.onlyIconSize))"
        }
        .scrollAnchor("token.onlyIconSize")
    }

    var onlyIconSizeLGTokenCard: some View {
        TokenCard(
            name: "onlyIconSizeLG",
            type: "CGFloat",
            defaultValue: "18",
            description: tr("button.api.token.onlyIconSizeLG"),
            sectionId: "token"
        ) {
            HStack(spacing: Moin.Constants.Spacing.md) {
                Moin.Button(icon: "plus", color: .primary, size: .large) {}
                Text("iconSize: \(Int(config.components.button.onlyIconSizeLG))px")
                    .font(.system(size: 11, design: .monospaced))
                    .foregroundStyle(.secondary)
            }
        } editor: {
            TokenValueRow(label: "onlyIconSizeLG", value: $config.components.button.onlyIconSizeLG, range: 12...36)
        } code: {
            "config.components.button.onlyIconSizeLG = \(Int(config.components.button.onlyIconSizeLG))"
        }
        .scrollAnchor("token.onlyIconSizeLG")
    }

    var onlyIconSizeSMTokenCard: some View {
        TokenCard(
            name: "onlyIconSizeSM",
            type: "CGFloat",
            defaultValue: "14",
            description: tr("button.api.token.onlyIconSizeSM"),
            sectionId: "token"
        ) {
            HStack(spacing: Moin.Constants.Spacing.md) {
                Moin.Button(icon: "plus", color: .primary, size: .small) {}
                Text("iconSize: \(Int(config.components.button.onlyIconSizeSM))px")
                    .font(.system(size: 11, design: .monospaced))
                    .foregroundStyle(.secondary)
            }
        } editor: {
            TokenValueRow(label: "onlyIconSizeSM", value: $config.components.button.onlyIconSizeSM, range: 8...24)
        } code: {
            "config.components.button.onlyIconSizeSM = \(Int(config.components.button.onlyIconSizeSM))"
        }
        .scrollAnchor("token.onlyIconSizeSM")
    }

    var primaryColorTokenCard: some View {
        TokenCard(
            name: "primaryColor",
            type: "Color",
            defaultValue: ".white",
            description: tr("button.api.token.primaryColor"),
            sectionId: "token"
        ) {
            Moin.Button(tr("button.label.primary"), color: .primary) {}
        } editor: {
            ColorPresetRow(label: "primaryColor", color: $config.components.button.primaryColor)
        } code: {
            "config.components.button.primaryColor = Color(...)"
        }
        .scrollAnchor("token.primaryColor")
    }

    var solidTextColorTokenCard: some View {
        TokenCard(
            name: "solidTextColor",
            type: "Color",
            defaultValue: ".white",
            description: tr("button.api.token.solidTextColor"),
            sectionId: "token"
        ) {
            Moin.Button(tr("button.label.solid"), color: .success) {}
        } editor: {
            ColorPresetRow(label: "solidTextColor", color: $config.components.button.solidTextColor)
        } code: {
            "config.components.button.solidTextColor = Color(...)"
        }
        .scrollAnchor("token.solidTextColor")
    }

    var textHoverBgTokenCard: some View {
        TokenCard(
            name: "textHoverBg",
            type: "Color",
            defaultValue: "black.opacity(0.04)",
            description: tr("button.api.token.textHoverBg"),
            sectionId: "token"
        ) {
            Moin.Button(tr("button.label.text_button"), variant: .text) {}
        } editor: {
            ColorPresetRow(label: "textHoverBg", color: $config.components.button.textHoverBg)
        } code: {
            "config.components.button.textHoverBg = Color(...)"
        }
        .scrollAnchor("token.textHoverBg")
    }

    var textTextActiveColorTokenCard: some View {
        TokenCard(
            name: "textTextActiveColor",
            type: "Color",
            defaultValue: "textPrimary",
            description: tr("button.api.token.textTextActiveColor"),
            sectionId: "token"
        ) {
            Moin.Button(tr("button.label.text_button"), variant: .text) {}
        } editor: {
            ColorPresetRow(label: "textTextActiveColor", color: $config.components.button.textTextActiveColor)
        } code: {
            "config.components.button.textTextActiveColor = Color(...)"
        }
        .scrollAnchor("token.textTextActiveColor")
    }

    var textTextColorTokenCard: some View {
        TokenCard(
            name: "textTextColor",
            type: "Color",
            defaultValue: "textPrimary",
            description: tr("button.api.token.textTextColor"),
            sectionId: "token"
        ) {
            Moin.Button(tr("button.label.text_button"), variant: .text) {}
        } editor: {
            ColorPresetRow(label: "textTextColor", color: $config.components.button.textTextColor)
        } code: {
            "config.components.button.textTextColor = Color(...)"
        }
        .scrollAnchor("token.textTextColor")
    }

    var textTextHoverColorTokenCard: some View {
        TokenCard(
            name: "textTextHoverColor",
            type: "Color",
            defaultValue: "textPrimary",
            description: tr("button.api.token.textTextHoverColor"),
            sectionId: "token"
        ) {
            Moin.Button(tr("button.label.text_button"), variant: .text) {}
        } editor: {
            ColorPresetRow(label: "textTextHoverColor", color: $config.components.button.textTextHoverColor)
        } code: {
            "config.components.button.textTextHoverColor = Color(...)"
        }
        .scrollAnchor("token.textTextHoverColor")
    }

    // MARK: - 尺寸相关 Token

    var contentFontSizeLGTokenCard: some View {
        TokenCard(
            name: "contentFontSizeLG",
            type: "CGFloat",
            defaultValue: "16",
            description: tr("button.api.token.contentFontSizeLG"),
            sectionId: "token"
        ) {
            HStack(spacing: Moin.Constants.Spacing.md) {
                Moin.Button(tr("button.label.large"), color: .primary, size: .large) {}
                Text("fontSize: \(Int(config.components.button.contentFontSizeLG))px")
                    .font(.system(size: 11, design: .monospaced))
                    .foregroundStyle(.secondary)
            }
        } editor: {
            TokenValueRow(label: "contentFontSizeLG", value: $config.components.button.contentFontSizeLG, range: 12...24)
        } code: {
            "config.components.button.contentFontSizeLG = \(Int(config.components.button.contentFontSizeLG))"
        }
        .scrollAnchor("token.contentFontSizeLG")
    }

    var contentFontSizeSMTokenCard: some View {
        TokenCard(
            name: "contentFontSizeSM",
            type: "CGFloat",
            defaultValue: "12",
            description: tr("button.api.token.contentFontSizeSM"),
            sectionId: "token"
        ) {
            HStack(spacing: Moin.Constants.Spacing.md) {
                Moin.Button(tr("button.label.small"), color: .primary, size: .small) {}
                Text("fontSize: \(Int(config.components.button.contentFontSizeSM))px")
                    .font(.system(size: 11, design: .monospaced))
                    .foregroundStyle(.secondary)
            }
        } editor: {
            TokenValueRow(label: "contentFontSizeSM", value: $config.components.button.contentFontSizeSM, range: 8...18)
        } code: {
            "config.components.button.contentFontSizeSM = \(Int(config.components.button.contentFontSizeSM))"
        }
        .scrollAnchor("token.contentFontSizeSM")
    }

    var paddingBlockTokenCard: some View {
        TokenCard(
            name: "paddingBlock",
            type: "CGFloat",
            defaultValue: "0",
            description: tr("button.api.token.paddingBlock"),
            sectionId: "token"
        ) {
            HStack(spacing: Moin.Constants.Spacing.md) {
                Moin.Button(tr("button.label.button"), color: .primary) {}
                Text("paddingBlock: \(Int(config.components.button.paddingBlock))px")
                    .font(.system(size: 11, design: .monospaced))
                    .foregroundStyle(.secondary)
            }
        } editor: {
            TokenValueRow(label: "paddingBlock", value: $config.components.button.paddingBlock, range: 0...20)
        } code: {
            "config.components.button.paddingBlock = \(Int(config.components.button.paddingBlock))"
        }
        .scrollAnchor("token.paddingBlock")
    }

    var iconGapTokenCard: some View {
        TokenCard(
            name: "iconGap",
            type: "CGFloat",
            defaultValue: "6",
            description: tr("button.api.token.iconGap"),
            sectionId: "token"
        ) {
            HStack(spacing: Moin.Constants.Spacing.md) {
                Moin.Button(tr("button.label.icon"), color: .primary, icon: "star.fill") {}
                Text("iconGap: \(Int(config.components.button.iconGap))px")
                    .font(.system(size: 11, design: .monospaced))
                    .foregroundStyle(.secondary)
            }
        } editor: {
            TokenValueRow(label: "iconGap", value: $config.components.button.iconGap, range: 0...20)
        } code: {
            "config.components.button.iconGap = \(Int(config.components.button.iconGap))"
        }
        .scrollAnchor("token.iconGap")
    }

    var contentFontSizeTokenCard: some View {
        TokenCard(
            name: "contentFontSize",
            type: "CGFloat",
            defaultValue: "14",
            description: tr("button.api.token.contentFontSize"),
            sectionId: "token"
        ) {
            HStack(spacing: Moin.Constants.Spacing.md) {
                Moin.Button(tr("button.label.button"), color: .primary) {}
                Text("fontSize: \(Int(config.components.button.contentFontSize))px")
                    .font(.system(size: 11, design: .monospaced))
                    .foregroundStyle(.secondary)
            }
        } editor: {
            TokenValueRow(label: "contentFontSize", value: $config.components.button.contentFontSize, range: 10...20)
        } code: {
            "config.components.button.contentFontSize = \(Int(config.components.button.contentFontSize))"
        }
        .scrollAnchor("token.contentFontSize")
    }

    var paddingInlineTokenCard: some View {
        TokenCard(
            name: "paddingInline",
            type: "CGFloat",
            defaultValue: "15",
            description: tr("button.api.token.paddingInline"),
            sectionId: "token"
        ) {
            HStack(spacing: Moin.Constants.Spacing.md) {
                Moin.Button(tr("button.label.button"), color: .primary) {}
                Text("padding: \(Int(config.components.button.paddingInline))px")
                    .font(.system(size: 11, design: .monospaced))
                    .foregroundStyle(.secondary)
            }
        } editor: {
            TokenValueRow(label: "paddingInline", value: $config.components.button.paddingInline, range: 0...30)
        } code: {
            "config.components.button.paddingInline = \(Int(config.components.button.paddingInline))"
        }
        .scrollAnchor("token.paddingInline")
    }

    var paddingInlineLGTokenCard: some View {
        TokenCard(
            name: "paddingInlineLG",
            type: "CGFloat",
            defaultValue: "15",
            description: tr("button.api.token.paddingInlineLG"),
            sectionId: "token"
        ) {
            HStack(spacing: Moin.Constants.Spacing.md) {
                Moin.Button(tr("button.label.large_button"), color: .primary, size: .large) {}
                Text("padding: \(Int(config.components.button.paddingInlineLG))px")
                    .font(.system(size: 11, design: .monospaced))
                    .foregroundStyle(.secondary)
            }
        } editor: {
            TokenValueRow(label: "paddingInlineLG", value: $config.components.button.paddingInlineLG, range: 0...40)
        } code: {
            "config.components.button.paddingInlineLG = \(Int(config.components.button.paddingInlineLG))"
        }
        .scrollAnchor("token.paddingInlineLG")
    }

    var paddingInlineSMTokenCard: some View {
        TokenCard(
            name: "paddingInlineSM",
            type: "CGFloat",
            defaultValue: "7",
            description: tr("button.api.token.paddingInlineSM"),
            sectionId: "token"
        ) {
            HStack(spacing: Moin.Constants.Spacing.md) {
                Moin.Button(tr("button.label.small"), color: .primary, size: .small) {}
                Text("padding: \(Int(config.components.button.paddingInlineSM))px")
                    .font(.system(size: 11, design: .monospaced))
                    .foregroundStyle(.secondary)
            }
        } editor: {
            TokenValueRow(label: "paddingInlineSM", value: $config.components.button.paddingInlineSM, range: 0...20)
        } code: {
            "config.components.button.paddingInlineSM = \(Int(config.components.button.paddingInlineSM))"
        }
        .scrollAnchor("token.paddingInlineSM")
    }

    var paddingBlockLGTokenCard: some View {
        TokenCard(
            name: "paddingBlockLG",
            type: "CGFloat",
            defaultValue: "0",
            description: tr("button.api.token.paddingBlockLG"),
            sectionId: "token"
        ) {
            HStack(spacing: Moin.Constants.Spacing.md) {
                Moin.Button(tr("button.label.large"), color: .primary, size: .large) {}
                Text("paddingBlock: \(Int(config.components.button.paddingBlockLG))px")
                    .font(.system(size: 11, design: .monospaced))
                    .foregroundStyle(.secondary)
            }
        } editor: {
            TokenValueRow(label: "paddingBlockLG", value: $config.components.button.paddingBlockLG, range: 0...20)
        } code: {
            "config.components.button.paddingBlockLG = \(Int(config.components.button.paddingBlockLG))"
        }
        .scrollAnchor("token.paddingBlockLG")
    }

    var paddingBlockSMTokenCard: some View {
        TokenCard(
            name: "paddingBlockSM",
            type: "CGFloat",
            defaultValue: "0",
            description: tr("button.api.token.paddingBlockSM"),
            sectionId: "token"
        ) {
            HStack(spacing: Moin.Constants.Spacing.md) {
                Moin.Button(tr("button.label.small"), color: .primary, size: .small) {}
                Text("paddingBlock: \(Int(config.components.button.paddingBlockSM))px")
                    .font(.system(size: 11, design: .monospaced))
                    .foregroundStyle(.secondary)
            }
        } editor: {
            TokenValueRow(label: "paddingBlockSM", value: $config.components.button.paddingBlockSM, range: 0...20)
        } code: {
            "config.components.button.paddingBlockSM = \(Int(config.components.button.paddingBlockSM))"
        }
        .scrollAnchor("token.paddingBlockSM")
    }

    // MARK: - 全局 Token

    var colorPrimaryGlobalTokenCard: some View {
        TokenCard(
            name: "colorPrimary",
            type: "Color",
            defaultValue: "blue-6",
            description: tr("api.global_token.colorPrimary"),
            sectionId: "global"
        ) {
            HStack(spacing: Moin.Constants.Spacing.md) {
                Moin.Button(tr("button.label.primary"), color: .primary) {}
                Moin.Button(tr("button.label.primary"), color: .primary, variant: .outlined) {}
            }
        } editor: {
            ColorPresetRow(label: "colorPrimary", color: $config.seed.colorPrimary, onChange: { config.regenerateTokens() })
        } code: {
            "config.seed.colorPrimary = Color(...)"
        }
        .scrollAnchor("global.colorPrimary")
    }

    var borderRadiusGlobalTokenCard: some View {
        TokenCard(
            name: "borderRadius",
            type: "CGFloat",
            defaultValue: "6",
            description: tr("api.global_token.borderRadius"),
            sectionId: "global"
        ) {
            HStack(spacing: Moin.Constants.Spacing.md) {
                Moin.Button(tr("button.label.button"), color: .primary) {}
                Text("radius: \(Int(config.seed.borderRadius))px")
                    .font(.system(size: 11, design: .monospaced))
                    .foregroundStyle(.secondary)
            }
        } editor: {
            TokenValueRow(label: "borderRadius", value: $config.seed.borderRadius, range: 0...20, onChange: { config.regenerateTokens() })
        } code: {
            "config.seed.borderRadius = \(Int(config.seed.borderRadius))"
        }
        .scrollAnchor("global.borderRadius")
    }

    var controlHeightGlobalTokenCard: some View {
        TokenCard(
            name: "controlHeight",
            type: "CGFloat",
            defaultValue: "32",
            description: tr("api.global_token.controlHeight"),
            sectionId: "global"
        ) {
            HStack(alignment: .center, spacing: Moin.Constants.Spacing.md) {
                Moin.Button(tr("button.label.small"), color: .primary, size: .small) {}
                Moin.Button(tr("button.label.medium"), color: .primary) {}
                Moin.Button(tr("button.label.large"), color: .primary, size: .large) {}
            }
        } editor: {
            TokenValueRow(label: "controlHeight", value: $config.seed.controlHeight, range: 24...48, onChange: { config.regenerateTokens() })
        } code: {
            "config.seed.controlHeight = \(Int(config.seed.controlHeight))"
        }
        .scrollAnchor("global.controlHeight")
    }

    var borderRadiusLGGlobalTokenCard: some View {
        TokenCard(
            name: "borderRadiusLG",
            type: "CGFloat",
            defaultValue: "8",
            description: tr("api.global_token.borderRadiusLG"),
            sectionId: "global"
        ) {
            Moin.Button(tr("button.label.large"), color: .primary, size: .large) {}
        } code: {
            "// \(tr("api.derived_from")) borderRadius + 2"
        }
        .scrollAnchor("global.borderRadiusLG")
    }

    var borderRadiusSMGlobalTokenCard: some View {
        TokenCard(
            name: "borderRadiusSM",
            type: "CGFloat",
            defaultValue: "4",
            description: tr("api.global_token.borderRadiusSM"),
            sectionId: "global"
        ) {
            Moin.Button(tr("button.label.small"), color: .primary, size: .small) {}
        } code: {
            "// \(tr("api.derived_from")) borderRadius - 2"
        }
        .scrollAnchor("global.borderRadiusSM")
    }

    var colorPrimaryActiveGlobalTokenCard: some View {
        TokenCard(
            name: "colorPrimaryActive",
            type: "Color",
            defaultValue: "primaryActive",
            description: tr("api.global_token.colorPrimaryActive"),
            sectionId: "global"
        ) {
            Moin.Button(tr("button.label.click_me"), color: .primary) {}
        } code: {
            "// \(tr("api.derived_from")) colorPrimary"
        }
        .scrollAnchor("global.colorPrimaryActive")
    }

    var colorPrimaryHoverGlobalTokenCard: some View {
        TokenCard(
            name: "colorPrimaryHover",
            type: "Color",
            defaultValue: "primaryHover",
            description: tr("api.global_token.colorPrimaryHover"),
            sectionId: "global"
        ) {
            Moin.Button(tr("button.label.hover_me"), color: .primary) {}
        } code: {
            "// \(tr("api.derived_from")) colorPrimary"
        }
        .scrollAnchor("global.colorPrimaryHover")
    }

    var colorTextDisabledGlobalTokenCard: some View {
        TokenCard(
            name: "colorTextDisabled",
            type: "Color",
            defaultValue: "textDisabled",
            description: tr("api.global_token.colorTextDisabled"),
            sectionId: "global"
        ) {
            Moin.Button(tr("button.label.disabled"), isDisabled: true) {}
        } code: {
            "// \(tr("api.derived_from")) colorText"
        }
        .scrollAnchor("global.colorTextDisabled")
    }

    var controlHeightLGGlobalTokenCard: some View {
        TokenCard(
            name: "controlHeightLG",
            type: "CGFloat",
            defaultValue: "40",
            description: tr("api.global_token.controlHeightLG"),
            sectionId: "global"
        ) {
            Moin.Button(tr("button.label.large"), color: .primary, size: .large) {}
        } code: {
            "// \(tr("api.derived_from")) controlHeight + 8"
        }
        .scrollAnchor("global.controlHeightLG")
    }

    var controlHeightSMGlobalTokenCard: some View {
        TokenCard(
            name: "controlHeightSM",
            type: "CGFloat",
            defaultValue: "24",
            description: tr("api.global_token.controlHeightSM"),
            sectionId: "global"
        ) {
            Moin.Button(tr("button.label.small"), color: .primary, size: .small) {}
        } code: {
            "// \(tr("api.derived_from")) controlHeight - 8"
        }
        .scrollAnchor("global.controlHeightSM")
    }

    var motionDurationGlobalTokenCard: some View {
        TokenCard(
            name: "motionDuration",
            type: "Double",
            defaultValue: "0.2",
            description: tr("api.global_token.motionDuration"),
            sectionId: "global"
        ) {
            Moin.Button(tr("button.label.button"), color: .primary) {}
        } code: {
            "config.seed.motionDuration = 0.2"
        }
        .scrollAnchor("global.motionDuration")
    }
}
