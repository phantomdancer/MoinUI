import SwiftUI
import MoinUI

// MARK: - Tag Token Cards Extension

extension TagTokenView {
    
    // MARK: - Color Tokens

    var tagDefaultBgTokenCard: some View {
        TokenCard(
            name: "defaultBg",
            type: "Color",
            defaultValue: "token.colorFillSecondary",
            description: tr("tag.token.defaultBg"),
            sectionId: "token"
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
            """
            // \(tr("api.component_token_desc"))
            // config.components.tag.defaultBg = Color(...)
            """
        }
        .scrollAnchor("token.defaultBg")
    }

    var tagDefaultColorTokenCard: some View {
        TokenCard(
            name: "defaultColor",
            type: "Color",
            defaultValue: "token.colorText",
            description: tr("tag.token.defaultColor"),
            sectionId: "token"
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
        .scrollAnchor("token.defaultColor")
    }
    
    var tagSolidTextColorTokenCard: some View {
        TokenCard(
            name: "solidTextColor",
            type: "Color",
            defaultValue: ".white",
            description: tr("tag.token.solidTextColor"),
            sectionId: "token"
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
        .scrollAnchor("token.solidTextColor")
    }
    
    var tagLineWidthTokenCard: some View {
        TokenCard(
            name: "lineWidth",
            type: "CGFloat",
            defaultValue: "token.lineWidth",
            description: tr("tag.token.lineWidth"),
            sectionId: "token"
        ) {
            HStack {
                Moin.Tag(tr("tag.example.outlined"), variant: .outlined)
            }
        } editor: {
            TokenValueRow(label: "lineWidth", value: Binding(
                get: { Moin.ConfigProvider.shared.components.tag.lineWidth },
                set: { Moin.ConfigProvider.shared.components.tag.lineWidth = $0 }
            ), range: 0...5)
        } code: {
            "config.components.tag.lineWidth = \(Int(config.components.tag.lineWidth))"
        }
        .scrollAnchor("token.lineWidth")
    }

    // MARK: - Font Size Tokens

    var tagFontSizeTokenCard: some View {
        TokenCard(
            name: "fontSize",
            type: "CGFloat",
            defaultValue: "token.fontSizeSM",
            description: tr("tag.token.fontSizeMD"),
            sectionId: "token"
        ) {
            HStack {
                Moin.Tag(tr("tag.example.medium"), size: .medium)
            }
        } editor: {
            TokenValueRow(label: "fontSize", value: Binding(
                get: { Moin.ConfigProvider.shared.components.tag.fontSize },
                set: { Moin.ConfigProvider.shared.components.tag.fontSize = $0 }
            ))
        } code: {
            "config.components.tag.fontSize = \(Int(config.components.tag.fontSize))"
        }
        .scrollAnchor("token.fontSize")
    }
    
    var tagFontSizeLGTokenCard: some View {
        TokenCard(
            name: "fontSizeLG",
            type: "CGFloat",
            defaultValue: "token.fontSize",
            description: tr("tag.token.fontSizeLG"),
            sectionId: "token"
        ) {
            HStack {
                Moin.Tag(tr("tag.example.large"), size: .large)
            }
        } editor: {
            TokenValueRow(label: "fontSizeLG", value: Binding(
                get: { Moin.ConfigProvider.shared.components.tag.fontSizeLG },
                set: { Moin.ConfigProvider.shared.components.tag.fontSizeLG = $0 }
            ))
        } code: {
            "config.components.tag.fontSizeLG = \(Int(config.components.tag.fontSizeLG))"
        }
        .scrollAnchor("token.fontSizeLG")
    }
    
    var tagFontSizeSMTokenCard: some View {
        TokenCard(
            name: "fontSizeSM",
            type: "CGFloat",
            defaultValue: "token.fontSizeSM - 2",
            description: tr("tag.token.fontSizeSM"),
            sectionId: "token"
        ) {
            HStack {
                Moin.Tag(tr("tag.example.small"), size: .small)
            }
        } editor: {
            TokenValueRow(label: "fontSizeSM", value: Binding(
                get: { Moin.ConfigProvider.shared.components.tag.fontSizeSM },
                set: { Moin.ConfigProvider.shared.components.tag.fontSizeSM = $0 }
            ))
        } code: {
            "config.components.tag.fontSizeSM = \(Int(config.components.tag.fontSizeSM))"
        }
        .scrollAnchor("token.fontSizeSM")
    }

    // MARK: - Padding Tokens

    var tagPaddingHTokenCard: some View {
        TokenCard(
            name: "paddingH",
            type: "CGFloat",
            defaultValue: "token.paddingSM",
            description: tr("tag.token.paddingHMD"),
            sectionId: "token"
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
        .scrollAnchor("token.paddingH")
    }
    
    var tagPaddingHLGTokenCard: some View {
        TokenCard(
            name: "paddingHLG",
            type: "CGFloat",
            defaultValue: "token.paddingMD",
            description: tr("tag.token.paddingHLG"),
            sectionId: "token"
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
        .scrollAnchor("token.paddingHLG")
    }
    
    var tagPaddingHSMTokenCard: some View {
        TokenCard(
            name: "paddingHSM",
            type: "CGFloat",
            defaultValue: "token.paddingXS",
            description: tr("tag.token.paddingHSM"),
            sectionId: "token"
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
        .scrollAnchor("token.paddingHSM")
    }
    
    // Padding Vertical
    var tagPaddingVTokenCard: some View {
        TokenCard(
            name: "paddingV",
            type: "CGFloat",
            defaultValue: "2",
            description: tr("tag.token.paddingVMD"),
            sectionId: "token"
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
        .scrollAnchor("token.paddingV")
    }
    
    var tagPaddingVLGTokenCard: some View {
        TokenCard(
            name: "paddingVLG",
            type: "CGFloat",
            defaultValue: "3",
            description: tr("tag.token.paddingVLG"),
            sectionId: "token"
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
        .scrollAnchor("token.paddingVLG")
    }
    
    var tagPaddingVSMTokenCard: some View {
        TokenCard(
            name: "paddingVSM",
            type: "CGFloat",
            defaultValue: "0",
            description: tr("tag.token.paddingVSM"),
            sectionId: "token"
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
        .scrollAnchor("token.paddingVSM")
    }
    
    // MARK: - Icon Tokens
    
    var tagIconSizeTokenCard: some View {
        TokenCard(
            name: "iconSize",
            type: "CGFloat",
            defaultValue: "12",
            description: tr("tag.token.iconSizeMD"),
            sectionId: "token"
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
        .scrollAnchor("token.iconSize")
    }
    
    var tagIconSizeLGTokenCard: some View {
        TokenCard(
            name: "iconSizeLG",
            type: "CGFloat",
            defaultValue: "14",
            description: tr("tag.token.iconSizeLG"),
            sectionId: "token"
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
        .scrollAnchor("token.iconSizeLG")
    }
    
    var tagIconSizeSMTokenCard: some View {
        TokenCard(
            name: "iconSizeSM",
            type: "CGFloat",
            defaultValue: "10",
            description: tr("tag.token.iconSizeSM"),
            sectionId: "token"
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
        .scrollAnchor("token.iconSizeSM")
    }
    
    var tagIconGapTokenCard: some View {
        TokenCard(
            name: "iconGap",
            type: "CGFloat",
            defaultValue: "4",
            description: tr("tag.token.iconGapMD"),
            sectionId: "token"
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
        .scrollAnchor("token.iconGap")
    }
    // Icon Gap LG/SM Omitted for brevity but included in spirit if requested. 
    // User requested "ALL", so I should add them.
    
    var tagIconGapLGTokenCard: some View {
        TokenCard(
            name: "iconGapLG",
            type: "CGFloat",
            defaultValue: "4",
            description: tr("tag.token.iconGapLG"),
            sectionId: "token"
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
        .scrollAnchor("token.iconGapLG")
    }
    
    var tagIconGapSMTokenCard: some View {
        TokenCard(
            name: "iconGapSM",
            type: "CGFloat",
            defaultValue: "2",
            description: tr("tag.token.iconGapSM"),
            sectionId: "token"
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
        .scrollAnchor("token.iconGapSM")
    }


    // MARK: - Global Tokens

    var tagGlobalFontSizeCard: some View {
        TokenCard(
            name: "fontSizeSM",
            type: "CGFloat",
            defaultValue: "12",
            description: tr("tag.token.fontSizeSM"),
            sectionId: "global"
        ) {
            HStack {
                Text(tr("tag.label.text_font_size")).font(.system(size: Moin.ConfigProvider.shared.token.fontSizeSM))
                Moin.Tag(tr("tag.label.tag_font_size"))
            }
        } editor: {
            TokenValueRow(label: "fontSize", value: Binding(
                get: { Moin.ConfigProvider.shared.token.fontSizeSM },
                set: { 
                    Moin.ConfigProvider.shared.seed.fontSize = $0 + 2 // approx reverse mapping
                    Moin.ConfigProvider.shared.regenerateTokens()
                }
            ))
        } code: {
            "// \(tr("api.derived_from")) fontSize - 2"
        }
        .scrollAnchor("global.fontSizeSM")
    }
}
