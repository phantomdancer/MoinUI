import SwiftUI
import MoinUI

// MARK: - Button Token 卡片扩展

extension ButtonDocView {
    
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
    
    // MARK: - 尺寸相关 Token
    
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
}
