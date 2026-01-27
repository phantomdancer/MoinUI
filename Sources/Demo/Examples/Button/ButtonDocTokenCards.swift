import SwiftUI
import MoinUI

// MARK: - Button Token 卡片扩展

extension ButtonTokenView {

    // MARK: - Component Tokens (Font)

    var contentFontSizeTokenCard: some View {
        TokenCard(
            name: "contentFontSize",
            type: "CGFloat",
            defaultValue: "14",
            description: tr("button.api.token.contentFontSize"),
            sectionId: "component"
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
        .scrollAnchor("component.contentFontSize")
    }

    var contentFontSizeLGTokenCard: some View {
        TokenCard(
            name: "contentFontSizeLG",
            type: "CGFloat",
            defaultValue: "16",
            description: tr("button.api.token.contentFontSizeLG"),
            sectionId: "component"
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
        .scrollAnchor("component.contentFontSizeLG")
    }

    var contentFontSizeSMTokenCard: some View {
        TokenCard(
            name: "contentFontSizeSM",
            type: "CGFloat",
            defaultValue: "12",
            description: tr("button.api.token.contentFontSizeSM"),
            sectionId: "component"
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
        .scrollAnchor("component.contentFontSizeSM")
    }
    
    var fontWeightTokenCard: some View {
        TokenCard(
            name: "fontWeight",
            type: "Font.Weight",
            defaultValue: ".medium",
            description: tr("button.api.token.fontWeight"),
            sectionId: "component"
        ) {
            Moin.Button(tr("button.label.button"), color: .primary) {}
        } editor: {
            FontWeightPickerRow(label: "fontWeight", selection: $config.components.button.fontWeight)
        } code: {
            "config.components.button.fontWeight = \(config.components.button.fontWeight.codeDescription)"
        }
        .scrollAnchor("component.fontWeight")
    }

    // MARK: - Component Tokens (Dimensions)

    var paddingBlockTokenCard: some View {
        TokenCard(
            name: "paddingBlock",
            type: "CGFloat",
            defaultValue: "0",
            description: tr("button.api.token.paddingBlock"),
            sectionId: "component"
        ) {
             Moin.Button("Block Padding", color: .primary) {}
        } editor: {
            TokenValueRow(label: "paddingBlock", value: $config.components.button.paddingBlock, range: 0...20)
        } code: {
            "config.components.button.paddingBlock = \(Int(config.components.button.paddingBlock))"
        }
        .scrollAnchor("component.paddingBlock")
    }
    
    var paddingBlockLGTokenCard: some View {
        TokenCard(
            name: "paddingBlockLG",
            type: "CGFloat",
            defaultValue: "0",
            description: tr("button.api.token.paddingBlockLG"),
            sectionId: "component"
        ) {
             Moin.Button("Large Block Padding", color: .primary, size: .large) {}
        } editor: {
            TokenValueRow(label: "paddingBlockLG", value: $config.components.button.paddingBlockLG, range: 0...20)
        } code: {
            "config.components.button.paddingBlockLG = \(Int(config.components.button.paddingBlockLG))"
        }
        .scrollAnchor("component.paddingBlockLG")
    }
    
    var paddingBlockSMTokenCard: some View {
         TokenCard(
             name: "paddingBlockSM",
             type: "CGFloat",
             defaultValue: "0",
             description: tr("button.api.token.paddingBlockSM"),
             sectionId: "component"
         ) {
              Moin.Button("Small Block Padding", color: .primary, size: .small) {}
         } editor: {
             TokenValueRow(label: "paddingBlockSM", value: $config.components.button.paddingBlockSM, range: 0...20)
         } code: {
             "config.components.button.paddingBlockSM = \(Int(config.components.button.paddingBlockSM))"
         }
         .scrollAnchor("component.paddingBlockSM")
     }

    var paddingInlineTokenCard: some View {
        TokenCard(
            name: "paddingInline",
            type: "CGFloat",
            defaultValue: "15",
            description: tr("button.api.token.paddingInline"),
            sectionId: "component"
        ) {
            Moin.Button(tr("button.label.button"), color: .primary) {}
        } editor: {
            TokenValueRow(label: "paddingInline", value: $config.components.button.paddingInline, range: 0...30)
        } code: {
            "config.components.button.paddingInline = \(Int(config.components.button.paddingInline))"
        }
        .scrollAnchor("component.paddingInline")
    }

    var paddingInlineLGTokenCard: some View {
        TokenCard(
            name: "paddingInlineLG",
            type: "CGFloat",
            defaultValue: "15",
            description: tr("button.api.token.paddingInlineLG"),
            sectionId: "component"
        ) {
            Moin.Button(tr("button.label.large_button"), color: .primary, size: .large) {}
        } editor: {
            TokenValueRow(label: "paddingInlineLG", value: $config.components.button.paddingInlineLG, range: 0...40)
        } code: {
            "config.components.button.paddingInlineLG = \(Int(config.components.button.paddingInlineLG))"
        }
        .scrollAnchor("component.paddingInlineLG")
    }

    var paddingInlineSMTokenCard: some View {
        TokenCard(
            name: "paddingInlineSM",
            type: "CGFloat",
            defaultValue: "7",
            description: tr("button.api.token.paddingInlineSM"),
            sectionId: "component"
        ) {
            Moin.Button(tr("button.label.small"), color: .primary, size: .small) {}
        } editor: {
            TokenValueRow(label: "paddingInlineSM", value: $config.components.button.paddingInlineSM, range: 0...20)
        } code: {
            "config.components.button.paddingInlineSM = \(Int(config.components.button.paddingInlineSM))"
        }
        .scrollAnchor("component.paddingInlineSM")
    }

    var iconGapTokenCard: some View {
        TokenCard(
            name: "iconGap",
            type: "CGFloat",
            defaultValue: "6",
            description: tr("button.api.token.iconGap"),
            sectionId: "component"
        ) {
            Moin.Button(tr("button.label.icon"), color: .primary, icon: "star.fill") {}
        } editor: {
            TokenValueRow(label: "iconGap", value: $config.components.button.iconGap, range: 0...20)
        } code: {
            "config.components.button.iconGap = \(Int(config.components.button.iconGap))"
        }
        .scrollAnchor("component.iconGap")
    }

    var onlyIconSizeTokenCard: some View {
        TokenCard(
            name: "onlyIconSize",
            type: "CGFloat",
            defaultValue: "16",
            description: tr("button.api.token.onlyIconSize"),
            sectionId: "component"
        ) {
            Moin.Button(icon: "plus", color: .primary) {}
        } editor: {
            TokenValueRow(label: "onlyIconSize", value: $config.components.button.onlyIconSize, range: 10...30)
        } code: {
            "config.components.button.onlyIconSize = \(Int(config.components.button.onlyIconSize))"
        }
        .scrollAnchor("component.onlyIconSize")
    }

    var onlyIconSizeLGTokenCard: some View {
        TokenCard(
            name: "onlyIconSizeLG",
            type: "CGFloat",
            defaultValue: "18",
            description: tr("button.api.token.onlyIconSizeLG"),
            sectionId: "component"
        ) {
            Moin.Button(icon: "plus", color: .primary, size: .large) {}
        } editor: {
            TokenValueRow(label: "onlyIconSizeLG", value: $config.components.button.onlyIconSizeLG, range: 12...36)
        } code: {
            "config.components.button.onlyIconSizeLG = \(Int(config.components.button.onlyIconSizeLG))"
        }
        .scrollAnchor("component.onlyIconSizeLG")
    }

    var onlyIconSizeSMTokenCard: some View {
        TokenCard(
            name: "onlyIconSizeSM",
            type: "CGFloat",
            defaultValue: "14",
            description: tr("button.api.token.onlyIconSizeSM"),
            sectionId: "component"
        ) {
            Moin.Button(icon: "plus", color: .primary, size: .small) {}
        } editor: {
            TokenValueRow(label: "onlyIconSizeSM", value: $config.components.button.onlyIconSizeSM, range: 8...24)
        } code: {
            "config.components.button.onlyIconSizeSM = \(Int(config.components.button.onlyIconSizeSM))"
        }
        .scrollAnchor("component.onlyIconSizeSM")
    }
    
    // MARK: - Component Tokens (Style)
    
    var groupBorderColorTokenCard: some View {
        TokenCard(
            name: "groupBorderColor",
            type: "Color",
            defaultValue: "primaryHover",
            description: tr("button.api.token.groupBorderColor"),
            sectionId: "component"
        ) {
            HStack(spacing: 0) {
                Moin.Button("Left", color: .primary) {}
                Rectangle().fill(config.components.button.groupBorderColor).frame(width: 1, height: 20)
                Moin.Button("Right", color: .primary) {}
            }
        } editor: {
            ColorPresetRow(label: "groupBorderColor", color: $config.components.button.groupBorderColor)
        } code: {
            "config.components.button.groupBorderColor = Color(...)"
        }
        .scrollAnchor("component.groupBorderColor")
    }
    
    var textTextColorTokenCard: some View {
        TokenCard(
            name: "textTextColor",
            type: "Color",
            defaultValue: "textPrimary",
            description: tr("button.api.token.textTextColor"),
            sectionId: "component"
        ) {
            Moin.Button(tr("button.label.text_button"), variant: .text) {}
        } editor: {
            ColorPresetRow(label: "textTextColor", color: $config.components.button.textTextColor)
        } code: {
            "config.components.button.textTextColor = Color(...)"
        }
        .scrollAnchor("component.textTextColor")
    }

    // MARK: - Global Tokens

    var colorPrimaryGlobalTokenCard: some View {
        TokenCard(
            name: "colorPrimary",
            type: "Color",
            defaultValue: "blue-6",
            description: tr("api.global_token.colorPrimary"),
            sectionId: "global"
        ) {
            Moin.Button(tr("button.label.primary"), color: .primary) {}
        } editor: {
            ColorPresetRow(label: "colorPrimary", color: $config.seed.colorPrimary, onChange: { config.regenerateTokens() })
        } code: {
            "config.seed.colorPrimary = Color(...)"
        }
        .scrollAnchor("global.colorPrimary")
    }
    
    var colorPrimaryHoverGlobalTokenCard: some View {
         TokenCard(
            name: "colorPrimaryHover",
            type: "Color",
            defaultValue: "blue-5",
            description: tr("api.global_token.colorPrimaryHover"),
            sectionId: "global"
        ) {
             Moin.Button(tr("button.label.hover_me"), color: .primary) {}
        } code: {
             "// Derived from colorPrimary (Level 5)"
        }
        .scrollAnchor("global.colorPrimaryHover")
    }
    
    var colorPrimaryActiveGlobalTokenCard: some View {
         TokenCard(
            name: "colorPrimaryActive",
            type: "Color",
            defaultValue: "blue-7",
            description: tr("api.global_token.colorPrimaryActive"),
            sectionId: "global"
        ) {
             Moin.Button("Click Me", color: .primary) {}
        } code: {
             "// Derived from colorPrimary (Level 7)"
        }
        .scrollAnchor("global.colorPrimaryActive")
    }

    var borderRadiusGlobalTokenCard: some View {
        TokenCard(
            name: "borderRadius",
            type: "CGFloat",
            defaultValue: "6",
            description: tr("api.global_token.borderRadius"),
            sectionId: "global"
        ) {
            Moin.Button(tr("button.label.button"), color: .primary) {}
        } editor: {
            TokenValueRow(label: "borderRadius", value: $config.seed.borderRadius, range: 0...20, onChange: { config.regenerateTokens() })
        } code: {
            "config.seed.borderRadius = \(Int(config.seed.borderRadius))"
        }
        .scrollAnchor("global.borderRadius")
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
            "// Derived from borderRadius"
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
            "// Derived from borderRadius"
        }
        .scrollAnchor("global.borderRadiusSM")
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
            "// Derived from controlHeight * 1.25"
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
            "// Derived from controlHeight * 0.75"
        }
        .scrollAnchor("global.controlHeightSM")
    }
    
    var colorTextGlobalTokenCard: some View {
        TokenCard(
            name: "colorText",
            type: "Color",
            defaultValue: "#000000 E0",
            description: tr("api.global_token.colorText"),
            sectionId: "global"
        ) {
            Moin.Button(tr("button.label.default")) {}
        } code: {
            "// Derived from colorTextBase"
        }
        .scrollAnchor("global.colorText")
    }
    
    var colorTextDisabledGlobalTokenCard: some View {
        TokenCard(
            name: "colorTextDisabled",
            type: "Color",
            defaultValue: "#000000 40",
            description: tr("api.global_token.colorTextDisabled"),
            sectionId: "global"
        ) {
             Moin.Button(tr("button.label.disabled"), disabled: true) {}
        } code: {
            "// Derived from colorTextBase"
        }
        .scrollAnchor("global.colorTextDisabled")
    }
    
    var colorBgContainerGlobalTokenCard: some View {
        TokenCard(
            name: "colorBgContainer",
            type: "Color",
            defaultValue: "#FFFFFF",
            description: tr("api.global_token.colorBgContainer"),
            sectionId: "global"
        ) {
             Moin.Button(tr("button.label.default")) {}
        } code: {
            "// Derived from colorBgBase"
        }
        .scrollAnchor("global.colorBgContainer")
    }
    
    var colorBorderGlobalTokenCard: some View {
        TokenCard(
            name: "colorBorder",
            type: "Color",
            defaultValue: "#D9D9D9",
            description: tr("api.global_token.colorBorder"),
            sectionId: "global"
        ) {
            Moin.Button(tr("button.label.default")) {}
        } code: {
            "// Derived from colorBorder"
        }
        .scrollAnchor("global.colorBorder")
    }
}
