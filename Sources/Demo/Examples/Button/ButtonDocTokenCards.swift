import SwiftUI
import MoinUI

// MARK: - Button Token 卡片扩展

extension ButtonAPIView {

    // MARK: - 边框相关 Token

    var borderColorDisabledTokenCard: some View {
        TokenCard(
            name: "borderColorDisabled",
            type: "Color",
            defaultValue: "border.opacity(0.5)",
            description: tr("button.api.token.borderColorDisabled"),
            sectionId: "token"
        ) {
            Moin.Button("Disabled", variant: .outlined, isDisabled: true) {}
        }
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
            Moin.Button("Default Button") {}
        } editor: {
            ColorPresetRow(label: "defaultColor", color: $config.components.button.defaultColor)
        } code: {
            "config.components.button.defaultColor = Color(...)"
        }
    }
    
    var defaultBgTokenCard: some View {
        TokenCard(
            name: "defaultBg",
            type: "Color",
            defaultValue: "background",
            description: tr("button.api.token.defaultBg"),
            sectionId: "token"
        ) {
            Moin.Button("Default Button") {}
        } editor: {
            ColorPresetRow(label: "defaultBg", color: $config.components.button.defaultBg)
        }
    }
    
    var defaultBorderColorTokenCard: some View {
        TokenCard(
            name: "defaultBorderColor",
            type: "Color",
            defaultValue: "border",
            description: tr("button.api.token.defaultBorderColor"),
            sectionId: "token"
        ) {
            Moin.Button("Default Button", variant: .outlined) {}
        } editor: {
            ColorPresetRow(label: "defaultBorderColor", color: $config.components.button.defaultBorderColor)
        }
    }
    
    var dangerColorTokenCard: some View {
        TokenCard(
            name: "dangerColor",
            type: "Color",
            defaultValue: ".white",
            description: tr("button.api.token.dangerColor"),
            sectionId: "token"
        ) {
            Moin.Button("Danger", color: .danger) {}
        } editor: {
            ColorPresetRow(label: "dangerColor", color: $config.components.button.dangerColor)
        }
    }

    var defaultActiveBgTokenCard: some View {
        TokenCard(
            name: "defaultActiveBg",
            type: "Color",
            defaultValue: "background",
            description: tr("button.api.token.defaultActiveBg"),
            sectionId: "token"
        ) {
            Moin.Button("Default (click to see active)") {}
        }
    }

    var defaultActiveBorderColorTokenCard: some View {
        TokenCard(
            name: "defaultActiveBorderColor",
            type: "Color",
            defaultValue: "primaryActive",
            description: tr("button.api.token.defaultActiveBorderColor"),
            sectionId: "token"
        ) {
            Moin.Button("Default", variant: .outlined) {}
        }
    }

    var defaultActiveColorTokenCard: some View {
        TokenCard(
            name: "defaultActiveColor",
            type: "Color",
            defaultValue: "primaryActive",
            description: tr("button.api.token.defaultActiveColor"),
            sectionId: "token"
        ) {
            Moin.Button("Default (click to see active)") {}
        }
    }

    var defaultBgDisabledTokenCard: some View {
        TokenCard(
            name: "defaultBgDisabled",
            type: "Color",
            defaultValue: "bgDisabled",
            description: tr("button.api.token.defaultBgDisabled"),
            sectionId: "token"
        ) {
            Moin.Button("Disabled", isDisabled: true) {}
        }
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
                Moin.Button("Ghost", isGhost: true) {}
            }
        }
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
                Moin.Button("Ghost", isGhost: true) {}
            }
        }
    }

    var defaultHoverBgTokenCard: some View {
        TokenCard(
            name: "defaultHoverBg",
            type: "Color",
            defaultValue: "background",
            description: tr("button.api.token.defaultHoverBg"),
            sectionId: "token"
        ) {
            Moin.Button("Hover me") {}
        }
    }

    var defaultHoverBorderColorTokenCard: some View {
        TokenCard(
            name: "defaultHoverBorderColor",
            type: "Color",
            defaultValue: "primaryHover",
            description: tr("button.api.token.defaultHoverBorderColor"),
            sectionId: "token"
        ) {
            Moin.Button("Hover me", variant: .outlined) {}
        }
    }

    var defaultHoverColorTokenCard: some View {
        TokenCard(
            name: "defaultHoverColor",
            type: "Color",
            defaultValue: "primaryHover",
            description: tr("button.api.token.defaultHoverColor"),
            sectionId: "token"
        ) {
            Moin.Button("Hover me") {}
        }
    }

    var fontWeightTokenCard: some View {
        TokenCard(
            name: "fontWeight",
            type: "Font.Weight",
            defaultValue: ".medium",
            description: tr("button.api.token.fontWeight"),
            sectionId: "token"
        ) {
            Moin.Button("Button", color: .primary) {}
        }
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
                Moin.Button("Ghost", color: .primary, isGhost: true) {}
            }
        }
    }

    var linkHoverBgTokenCard: some View {
        TokenCard(
            name: "linkHoverBg",
            type: "Color",
            defaultValue: ".clear",
            description: tr("button.api.token.linkHoverBg"),
            sectionId: "token"
        ) {
            Moin.Button("Link Button", variant: .link) {}
        }
    }

    var onlyIconSizeTokenCard: some View {
        TokenCard(
            name: "onlyIconSize",
            type: "CGFloat",
            defaultValue: "16",
            description: tr("button.api.token.onlyIconSize"),
            sectionId: "token"
        ) {
            Moin.Button(icon: "plus", color: .primary) {}
        }
    }

    var onlyIconSizeLGTokenCard: some View {
        TokenCard(
            name: "onlyIconSizeLG",
            type: "CGFloat",
            defaultValue: "18",
            description: tr("button.api.token.onlyIconSizeLG"),
            sectionId: "token"
        ) {
            Moin.Button(icon: "plus", color: .primary, size: .large) {}
        }
    }

    var onlyIconSizeSMTokenCard: some View {
        TokenCard(
            name: "onlyIconSizeSM",
            type: "CGFloat",
            defaultValue: "14",
            description: tr("button.api.token.onlyIconSizeSM"),
            sectionId: "token"
        ) {
            Moin.Button(icon: "plus", color: .primary, size: .small) {}
        }
    }

    var solidTextColorTokenCard: some View {
        TokenCard(
            name: "solidTextColor",
            type: "Color",
            defaultValue: ".white",
            description: tr("button.api.token.solidTextColor"),
            sectionId: "token"
        ) {
            Moin.Button("Solid", color: .primary) {}
        }
    }

    var textHoverBgTokenCard: some View {
        TokenCard(
            name: "textHoverBg",
            type: "Color",
            defaultValue: "black.opacity(0.04)",
            description: tr("button.api.token.textHoverBg"),
            sectionId: "token"
        ) {
            Moin.Button("Text Button", variant: .text) {}
        }
    }

    var textTextActiveColorTokenCard: some View {
        TokenCard(
            name: "textTextActiveColor",
            type: "Color",
            defaultValue: "textPrimary",
            description: tr("button.api.token.textTextActiveColor"),
            sectionId: "token"
        ) {
            Moin.Button("Text Button", variant: .text) {}
        }
    }

    var textTextColorTokenCard: some View {
        TokenCard(
            name: "textTextColor",
            type: "Color",
            defaultValue: "textPrimary",
            description: tr("button.api.token.textTextColor"),
            sectionId: "token"
        ) {
            Moin.Button("Text Button", variant: .text) {}
        }
    }

    var textTextHoverColorTokenCard: some View {
        TokenCard(
            name: "textTextHoverColor",
            type: "Color",
            defaultValue: "textPrimary",
            description: tr("button.api.token.textTextHoverColor"),
            sectionId: "token"
        ) {
            Moin.Button("Text Button", variant: .text) {}
        }
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
            Moin.Button("Large", color: .primary, size: .large) {}
        }
    }

    var contentFontSizeSMTokenCard: some View {
        TokenCard(
            name: "contentFontSizeSM",
            type: "CGFloat",
            defaultValue: "12",
            description: tr("button.api.token.contentFontSizeSM"),
            sectionId: "token"
        ) {
            Moin.Button("Small", color: .primary, size: .small) {}
        }
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
                Moin.Button("Button", color: .primary) {}
                Text("paddingBlock: \(Int(config.components.button.paddingBlock))px")
                    .font(.system(size: 11, design: .monospaced))
                    .foregroundStyle(.secondary)
            }
        } editor: {
            TokenValueRow(label: "paddingBlock", value: $config.components.button.paddingBlock, range: 0...20)
        }
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
                Moin.Button("Icon", color: .primary, icon: "star.fill") {}
                Text("iconGap: \(Int(config.components.button.iconGap))px")
                    .font(.system(size: 11, design: .monospaced))
                    .foregroundStyle(.secondary)
            }
        } editor: {
            TokenValueRow(label: "iconGap", value: $config.components.button.iconGap, range: 0...20)
        } code: {
            "config.components.button.iconGap = \(Int(config.components.button.iconGap))"
        }
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
                Moin.Button("Button", color: .primary) {}
                Text("fontSize: \(Int(config.components.button.contentFontSize))px")
                    .font(.system(size: 11, design: .monospaced))
                    .foregroundStyle(.secondary)
            }
        } editor: {
            TokenValueRow(label: "contentFontSize", value: $config.components.button.contentFontSize, range: 10...20)
        }
    }
    
    var paddingInlineLGTokenCard: some View {
        TokenCard(
            name: "paddingInlineLG",
            type: "CGFloat",
            defaultValue: "15",
            description: tr("button.api.token.paddingInlineLG"),
            sectionId: "token"
        ) {
            Moin.Button("Large Button", color: .primary, size: .large) {}
        } editor: {
            TokenValueRow(label: "paddingInlineLG", value: $config.components.button.paddingInlineLG, range: 0...40)
        }
    }
    
    var paddingInlineSMTokenCard: some View {
        TokenCard(
            name: "paddingInlineSM",
            type: "CGFloat",
            defaultValue: "7",
            description: tr("button.api.token.paddingInlineSM"),
            sectionId: "token"
        ) {
            Moin.Button("Small", color: .primary, size: .small) {}
        } editor: {
            TokenValueRow(label: "paddingInlineSM", value: $config.components.button.paddingInlineSM, range: 0...20)
        }
    }

    var paddingBlockLGTokenCard: some View {
        TokenCard(
            name: "paddingBlockLG",
            type: "CGFloat",
            defaultValue: "0",
            description: tr("button.api.token.paddingBlockLG"),
            sectionId: "token"
        ) {
            Moin.Button("Large", color: .primary, size: .large) {}
        }
    }

    var paddingBlockSMTokenCard: some View {
        TokenCard(
            name: "paddingBlockSM",
            type: "CGFloat",
            defaultValue: "0",
            description: tr("button.api.token.paddingBlockSM"),
            sectionId: "token"
        ) {
            Moin.Button("Small", color: .primary, size: .small) {}
        }
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
                Moin.Button("Primary", color: .primary) {}
                Moin.Button("Primary", color: .primary, variant: .outlined) {}
            }
        } editor: {
            ColorPresetRow(label: "colorPrimary", color: $config.seed.colorPrimary, onChange: { config.regenerateTokens() })
        } code: {
            "config.seed.colorPrimary = Color(...)"
        }
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
                Moin.Button("Button", color: .primary) {}
                Text("radius: \(Int(config.seed.borderRadius))px")
                    .font(.system(size: 11, design: .monospaced))
                    .foregroundStyle(.secondary)
            }
        } editor: {
            TokenValueRow(label: "borderRadius", value: $config.seed.borderRadius, range: 0...20, onChange: { config.regenerateTokens() })
        } code: {
            "config.seed.borderRadius = \(Int(config.seed.borderRadius))"
        }
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
                Moin.Button("Small", color: .primary, size: .small) {}
                Moin.Button("Medium", color: .primary) {}
                Moin.Button("Large", color: .primary, size: .large) {}
            }
        } editor: {
            TokenValueRow(label: "controlHeight", value: $config.seed.controlHeight, range: 24...48, onChange: { config.regenerateTokens() })
        }
    }

    var borderRadiusLGGlobalTokenCard: some View {
        TokenCard(
            name: "borderRadiusLG",
            type: "CGFloat",
            defaultValue: "8",
            description: tr("api.global_token.borderRadiusLG"),
            sectionId: "global"
        ) {
            Moin.Button("Large", color: .primary, size: .large) {}
        }
    }

    var borderRadiusSMGlobalTokenCard: some View {
        TokenCard(
            name: "borderRadiusSM",
            type: "CGFloat",
            defaultValue: "4",
            description: tr("api.global_token.borderRadiusSM"),
            sectionId: "global"
        ) {
            Moin.Button("Small", color: .primary, size: .small) {}
        }
    }

    var colorPrimaryActiveGlobalTokenCard: some View {
        TokenCard(
            name: "colorPrimaryActive",
            type: "Color",
            defaultValue: "primaryActive",
            description: tr("api.global_token.colorPrimaryActive"),
            sectionId: "global"
        ) {
            Moin.Button("Click me", color: .primary) {}
        }
    }

    var colorPrimaryHoverGlobalTokenCard: some View {
        TokenCard(
            name: "colorPrimaryHover",
            type: "Color",
            defaultValue: "primaryHover",
            description: tr("api.global_token.colorPrimaryHover"),
            sectionId: "global"
        ) {
            Moin.Button("Hover me", color: .primary) {}
        }
    }

    var colorTextDisabledGlobalTokenCard: some View {
        TokenCard(
            name: "colorTextDisabled",
            type: "Color",
            defaultValue: "textDisabled",
            description: tr("api.global_token.colorTextDisabled"),
            sectionId: "global"
        ) {
            Moin.Button("Disabled", isDisabled: true) {}
        }
    }

    var controlHeightLGGlobalTokenCard: some View {
        TokenCard(
            name: "controlHeightLG",
            type: "CGFloat",
            defaultValue: "40",
            description: tr("api.global_token.controlHeightLG"),
            sectionId: "global"
        ) {
            Moin.Button("Large", color: .primary, size: .large) {}
        }
    }

    var controlHeightSMGlobalTokenCard: some View {
        TokenCard(
            name: "controlHeightSM",
            type: "CGFloat",
            defaultValue: "24",
            description: tr("api.global_token.controlHeightSM"),
            sectionId: "global"
        ) {
            Moin.Button("Small", color: .primary, size: .small) {}
        }
    }

    var motionDurationGlobalTokenCard: some View {
        TokenCard(
            name: "motionDuration",
            type: "Double",
            defaultValue: "0.2",
            description: tr("api.global_token.motionDuration"),
            sectionId: "global"
        ) {
            Moin.Button("Button", color: .primary) {}
        }
    }
}
