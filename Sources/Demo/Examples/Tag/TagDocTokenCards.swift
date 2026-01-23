import SwiftUI
import MoinUI

// MARK: - Tag Token Cards Extension

extension TagTokenView {
    
    // MARK: - Component Token Cards (组件专属)

    var tagDefaultBgTokenCard: some View {
        TokenCard(
            name: "defaultBg",
            type: "Color",
            defaultValue: "token.colorFillSecondary",
            description: tr("tag.token.defaultBg"),
            sectionId: "component"
        ) {
            HStack {
                Moin.Tag(tr("tag.example.default"), color: .default)
                Moin.Tag(tr("tag.label.another"), color: .default)
            }
        } editor: {
            ColorPresetRow(label: "defaultBg", color: Binding(
                get: { Moin.ConfigProvider.shared.components.tag.defaultBg },
                set: { Moin.ConfigProvider.shared.components.tag.defaultBg = $0 }
            ))
        } code: {
            "config.components.tag.defaultBg = Color(...)"
        }
    }

    var tagDefaultColorTokenCard: some View {
        TokenCard(
            name: "defaultColor",
            type: "Color",
            defaultValue: "token.colorText",
            description: tr("tag.token.defaultColor"),
            sectionId: "component"
        ) {
            HStack {
                Moin.Tag(tr("tag.example.default"), color: .default)
            }
        } editor: {
            ColorPresetRow(label: "defaultColor", color: Binding(
                get: { Moin.ConfigProvider.shared.components.tag.defaultColor },
                set: { Moin.ConfigProvider.shared.components.tag.defaultColor = $0 }
            ))
        } code: {
            "config.components.tag.defaultColor = Color(...)"
        }
    }
    
    var tagSolidTextColorTokenCard: some View {
        TokenCard(
            name: "solidTextColor",
            type: "Color",
            defaultValue: ".white",
            description: tr("tag.token.solidTextColor"),
            sectionId: "component"
        ) {
            HStack {
                Moin.Tag(tr("tag.example.solid"), color: .default, variant: .solid)
                Moin.Tag(tr("tag.example.success"), color: .success, variant: .solid)
            }
        } editor: {
            ColorPresetRow(label: "solidTextColor", color: Binding(
                get: { Moin.ConfigProvider.shared.components.tag.solidTextColor },
                set: { Moin.ConfigProvider.shared.components.tag.solidTextColor = $0 }
            ))
        } code: {
            "config.components.tag.solidTextColor = Color(...)"
        }
    }

    // MARK: - Padding Tokens (组件专属)

    var tagPaddingHTokenCard: some View {
        TokenCard(
            name: "paddingH",
            type: "CGFloat",
            defaultValue: "token.paddingSM",
            description: tr("tag.token.paddingHMD"),
            sectionId: "component"
        ) {
            HStack {
                Moin.Tag(tr("tag.example.medium"), size: .medium)
            }
        } editor: {
            TokenValueRow(label: "paddingH", value: Binding(
                get: { Moin.ConfigProvider.shared.components.tag.paddingH },
                set: { Moin.ConfigProvider.shared.components.tag.paddingH = $0 }
            ))
        } code: {
            "config.components.tag.paddingH = \(Int(config.components.tag.paddingH))"
        }
    }
    
    var tagPaddingHLGTokenCard: some View {
        TokenCard(
            name: "paddingHLG",
            type: "CGFloat",
            defaultValue: "token.paddingMD",
            description: tr("tag.token.paddingHLG"),
            sectionId: "component"
        ) {
            HStack {
                Moin.Tag(tr("tag.example.large"), size: .large)
            }
        } editor: {
            TokenValueRow(label: "paddingHLG", value: Binding(
                get: { Moin.ConfigProvider.shared.components.tag.paddingHLG },
                set: { Moin.ConfigProvider.shared.components.tag.paddingHLG = $0 }
            ))
        } code: {
            "config.components.tag.paddingHLG = \(Int(config.components.tag.paddingHLG))"
        }
    }
    
    var tagPaddingHSMTokenCard: some View {
        TokenCard(
            name: "paddingHSM",
            type: "CGFloat",
            defaultValue: "token.paddingXS",
            description: tr("tag.token.paddingHSM"),
            sectionId: "component"
        ) {
            HStack {
                Moin.Tag(tr("tag.example.small"), size: .small)
            }
        } editor: {
            TokenValueRow(label: "paddingHSM", value: Binding(
                get: { Moin.ConfigProvider.shared.components.tag.paddingHSM },
                set: { Moin.ConfigProvider.shared.components.tag.paddingHSM = $0 }
            ))
        } code: {
            "config.components.tag.paddingHSM = \(Int(config.components.tag.paddingHSM))"
        }
    }
    
    // Padding Vertical
    var tagPaddingVTokenCard: some View {
        TokenCard(
            name: "paddingV",
            type: "CGFloat",
            defaultValue: "2",
            description: tr("tag.token.paddingVMD"),
            sectionId: "component"
        ) {
            HStack {
                Moin.Tag(tr("tag.example.medium"), size: .medium)
            }
        } editor: {
            TokenValueRow(label: "paddingV", value: Binding(
                get: { Moin.ConfigProvider.shared.components.tag.paddingV },
                set: { Moin.ConfigProvider.shared.components.tag.paddingV = $0 }
            ))
        } code: {
            "config.components.tag.paddingV = \(Int(config.components.tag.paddingV))"
        }
    }
    
    var tagPaddingVLGTokenCard: some View {
        TokenCard(
            name: "paddingVLG",
            type: "CGFloat",
            defaultValue: "3",
            description: tr("tag.token.paddingVLG"),
            sectionId: "component"
        ) {
            HStack {
                Moin.Tag(tr("tag.example.large"), size: .large)
            }
        } editor: {
            TokenValueRow(label: "paddingVLG", value: Binding(
                get: { Moin.ConfigProvider.shared.components.tag.paddingVLG },
                set: { Moin.ConfigProvider.shared.components.tag.paddingVLG = $0 }
            ))
        } code: {
            "config.components.tag.paddingVLG = \(Int(config.components.tag.paddingVLG))"
        }
    }
    
    var tagPaddingVSMTokenCard: some View {
        TokenCard(
            name: "paddingVSM",
            type: "CGFloat",
            defaultValue: "0",
            description: tr("tag.token.paddingVSM"),
            sectionId: "component"
        ) {
            HStack {
                Moin.Tag(tr("tag.example.small"), size: .small)
            }
        } editor: {
            TokenValueRow(label: "paddingVSM", value: Binding(
                get: { Moin.ConfigProvider.shared.components.tag.paddingVSM },
                set: { Moin.ConfigProvider.shared.components.tag.paddingVSM = $0 }
            ))
        } code: {
            "config.components.tag.paddingVSM = \(Int(config.components.tag.paddingVSM))"
        }
    }
    
    // MARK: - Icon Tokens (组件专属)
    
    var tagIconSizeTokenCard: some View {
        TokenCard(
            name: "iconSize",
            type: "CGFloat",
            defaultValue: "10",
            description: tr("tag.token.iconSizeMD"),
            sectionId: "component"
        ) {
            HStack {
                Moin.Tag(tr("tag.example.apple"), size: .medium, icon: "apple.logo")
            }
        } editor: {
            TokenValueRow(label: "iconSize", value: Binding(
                get: { Moin.ConfigProvider.shared.components.tag.iconSize },
                set: { Moin.ConfigProvider.shared.components.tag.iconSize = $0 }
            ))
        } code: {
            "config.components.tag.iconSize = \(Int(config.components.tag.iconSize))"
        }
    }
    
    var tagIconSizeLGTokenCard: some View {
        TokenCard(
            name: "iconSizeLG",
            type: "CGFloat",
            defaultValue: "12",
            description: tr("tag.token.iconSizeLG"),
            sectionId: "component"
        ) {
            HStack {
                Moin.Tag(tr("tag.example.apple"), size: .large, icon: "apple.logo")
            }
        } editor: {
            TokenValueRow(label: "iconSizeLG", value: Binding(
                get: { Moin.ConfigProvider.shared.components.tag.iconSizeLG },
                set: { Moin.ConfigProvider.shared.components.tag.iconSizeLG = $0 }
            ))
        } code: {
            "config.components.tag.iconSizeLG = \(Int(config.components.tag.iconSizeLG))"
        }
    }
    
    var tagIconSizeSMTokenCard: some View {
        TokenCard(
            name: "iconSizeSM",
            type: "CGFloat",
            defaultValue: "8",
            description: tr("tag.token.iconSizeSM"),
            sectionId: "component"
        ) {
            HStack {
                Moin.Tag(tr("tag.example.apple"), size: .small, icon: "apple.logo")
            }
        } editor: {
            TokenValueRow(label: "iconSizeSM", value: Binding(
                get: { Moin.ConfigProvider.shared.components.tag.iconSizeSM },
                set: { Moin.ConfigProvider.shared.components.tag.iconSizeSM = $0 }
            ))
        } code: {
            "config.components.tag.iconSizeSM = \(Int(config.components.tag.iconSizeSM))"
        }
    }
    
    var tagCloseIconSizeTokenCard: some View {
        TokenCard(
            name: "closeIconSize",
            type: "CGFloat",
            defaultValue: "8",
            description: tr("tag.token.closeIconSize"),
            sectionId: "component"
        ) {
            HStack {
                Moin.Tag(tr("tag.example.closable"), closable: true)
            }
        } editor: {
            TokenValueRow(label: "closeIconSize", value: Binding(
                get: { Moin.ConfigProvider.shared.components.tag.closeIconSize },
                set: { Moin.ConfigProvider.shared.components.tag.closeIconSize = $0 }
            ))
        } code: {
            "config.components.tag.closeIconSize = \(Int(config.components.tag.closeIconSize))"
        }
    }
    
    var tagIconGapTokenCard: some View {
        TokenCard(
            name: "iconGap",
            type: "CGFloat",
            defaultValue: "4",
            description: tr("tag.token.iconGapMD"),
            sectionId: "component"
        ) {
            HStack {
                Moin.Tag(tr("tag.example.apple"), size: .medium, icon: "apple.logo")
            }
        } editor: {
            TokenValueRow(label: "iconGap", value: Binding(
                get: { Moin.ConfigProvider.shared.components.tag.iconGap },
                set: { Moin.ConfigProvider.shared.components.tag.iconGap = $0 }
            ))
        } code: {
            "config.components.tag.iconGap = \(Int(config.components.tag.iconGap))"
        }
    }
    
    var tagIconGapLGTokenCard: some View {
        TokenCard(
            name: "iconGapLG",
            type: "CGFloat",
            defaultValue: "4",
            description: tr("tag.token.iconGapLG"),
            sectionId: "component"
        ) {
            HStack {
                Moin.Tag(tr("tag.example.apple"), size: .large, icon: "apple.logo")
            }
        } editor: {
            TokenValueRow(label: "iconGapLG", value: Binding(
                get: { Moin.ConfigProvider.shared.components.tag.iconGapLG },
                set: { Moin.ConfigProvider.shared.components.tag.iconGapLG = $0 }
            ))
        } code: {
            "config.components.tag.iconGapLG = \(Int(config.components.tag.iconGapLG))"
        }
    }
    
    var tagIconGapSMTokenCard: some View {
        TokenCard(
            name: "iconGapSM",
            type: "CGFloat",
            defaultValue: "2",
            description: tr("tag.token.iconGapSM"),
            sectionId: "component"
        ) {
            HStack {
                Moin.Tag(tr("tag.example.apple"), size: .small, icon: "apple.logo")
            }
        } editor: {
            TokenValueRow(label: "iconGapSM", value: Binding(
                get: { Moin.ConfigProvider.shared.components.tag.iconGapSM },
                set: { Moin.ConfigProvider.shared.components.tag.iconGapSM = $0 }
            ))
        } code: {
            "config.components.tag.iconGapSM = \(Int(config.components.tag.iconGapSM))"
        }
    }

    // MARK: - Global Tokens (全局Token，影响所有组件)

    var tagFontSizeCard: some View {
        TokenCard(
            name: "fontSize",
            type: "CGFloat",
            defaultValue: "14",
            description: tr("tag.token.fontSize"),
            sectionId: "global"
        ) {
            HStack(spacing: Moin.Constants.Spacing.md) {
                Moin.Tag(tr("tag.example.large"), size: .large)
                Text("fontSize: \(Int(config.token.fontSize))px")
                    .font(.system(size: 11, design: .monospaced))
                    .foregroundStyle(.secondary)
            }
        } editor: {
            TokenValueRow(label: "seed.fontSize", value: Binding(
                get: { config.seed.fontSize },
                set: { config.seed.fontSize = $0 }
            ), range: 10...24, onChange: { config.regenerateTokens() })
        } code: {
            "config.seed.fontSize = \(Int(config.seed.fontSize))"
        }
    }
    
    var tagFontSizeSMCard: some View {
        TokenCard(
            name: "fontSizeSM",
            type: "CGFloat",
            defaultValue: "12",
            description: tr("tag.token.fontSizeSM"),
            sectionId: "global"
        ) {
            HStack(spacing: Moin.Constants.Spacing.md) {
                Moin.Tag(tr("tag.example.medium"), size: .medium)
                Text("fontSizeSM: \(Int(config.token.fontSizeSM))px")
                    .font(.system(size: 11, design: .monospaced))
                    .foregroundStyle(.secondary)
            }
        } code: {
            "// \(tr("api.derived_from")) seed.fontSize - 2"
        }
    }
    
    var tagLineWidthCard: some View {
        TokenCard(
            name: "lineWidth",
            type: "CGFloat",
            defaultValue: "1",
            description: tr("tag.token.lineWidth"),
            sectionId: "global"
        ) {
            HStack(spacing: Moin.Constants.Spacing.md) {
                Moin.Tag(tr("tag.example.outlined"), variant: .outlined)
                Text("lineWidth: \(Int(config.token.lineWidth))px")
                    .font(.system(size: 11, design: .monospaced))
                    .foregroundStyle(.secondary)
            }
        } editor: {
            TokenValueRow(label: "seed.lineWidth", value: Binding(
                get: { config.seed.lineWidth },
                set: { config.seed.lineWidth = $0 }
            ), range: 0...5, onChange: { config.regenerateTokens() })
        } code: {
            "config.seed.lineWidth = \(Int(config.seed.lineWidth))"
        }
    }
    
    var tagBorderRadiusSMCard: some View {
        TokenCard(
            name: "borderRadiusSM",
            type: "CGFloat",
            defaultValue: "4",
            description: tr("tag.token.borderRadiusSM"),
            sectionId: "global"
        ) {
            HStack(spacing: Moin.Constants.Spacing.md) {
                Moin.Tag(tr("tag.example.default"))
                Text("borderRadiusSM: \(Int(config.token.borderRadiusSM))px")
                    .font(.system(size: 11, design: .monospaced))
                    .foregroundStyle(.secondary)
            }
        } editor: {
            TokenValueRow(label: "seed.borderRadius", value: Binding(
                get: { config.seed.borderRadius },
                set: { config.seed.borderRadius = $0 }
            ), range: 0...20, onChange: { config.regenerateTokens() })
        } code: {
            "// \(tr("api.derived_from")) seed.borderRadius - 2"
        }
    }
    
    var tagColorSuccessCard: some View {
        TokenCard(
            name: "colorSuccess",
            type: "Color",
            defaultValue: "#52c41a",
            description: tr("tag.token.colorSuccess"),
            sectionId: "global"
        ) {
            HStack {
                Moin.Tag(tr("tag.example.success"), color: .success)
                Moin.Tag(tr("tag.example.success"), color: .success, variant: .solid)
            }
        } editor: {
            ColorPresetRow(label: "seed.colorSuccess", color: Binding(
                get: { config.seed.colorSuccess },
                set: { config.seed.colorSuccess = $0 }
            ), onChange: { config.regenerateTokens() })
        } code: {
            "config.seed.colorSuccess = Color(...)"
        }
    }
    
    var tagColorWarningCard: some View {
        TokenCard(
            name: "colorWarning",
            type: "Color",
            defaultValue: "#faad14",
            description: tr("tag.token.colorWarning"),
            sectionId: "global"
        ) {
            HStack {
                Moin.Tag(tr("tag.example.warning"), color: .warning)
                Moin.Tag(tr("tag.example.warning"), color: .warning, variant: .solid)
            }
        } editor: {
            ColorPresetRow(label: "seed.colorWarning", color: Binding(
                get: { config.seed.colorWarning },
                set: { config.seed.colorWarning = $0 }
            ), onChange: { config.regenerateTokens() })
        } code: {
            "config.seed.colorWarning = Color(...)"
        }
    }
    
    var tagColorErrorCard: some View {
        TokenCard(
            name: "colorError",
            type: "Color",
            defaultValue: "#ff4d4f",
            description: tr("tag.token.colorError"),
            sectionId: "global"
        ) {
            HStack {
                Moin.Tag(tr("tag.example.error"), color: .error)
                Moin.Tag(tr("tag.example.error"), color: .error, variant: .solid)
            }
        } editor: {
            ColorPresetRow(label: "seed.colorError", color: Binding(
                get: { config.seed.colorError },
                set: { config.seed.colorError = $0 }
            ), onChange: { config.regenerateTokens() })
        } code: {
            "config.seed.colorError = Color(...)"
        }
    }
    
    var tagColorPrimaryCard: some View {
        TokenCard(
            name: "colorPrimary",
            type: "Color",
            defaultValue: "#1677ff",
            description: tr("tag.token.colorPrimary"),
            sectionId: "global"
        ) {
            HStack {
                Moin.Tag(tr("tag.example.processing"), color: .processing)
                Moin.Tag(tr("tag.example.processing"), color: .processing, variant: .solid)
            }
        } editor: {
            ColorPresetRow(label: "seed.colorPrimary", color: Binding(
                get: { config.seed.colorPrimary },
                set: { config.seed.colorPrimary = $0 }
            ), onChange: { config.regenerateTokens() })
        } code: {
            "config.seed.colorPrimary = Color(...)"
        }
    }
}
