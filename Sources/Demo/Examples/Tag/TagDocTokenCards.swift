import SwiftUI
import MoinUI

// MARK: - Tag Token Cards Extension

extension TagTokenView {
    
    // MARK: - Component Tokens

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
            config.components.tag.defaultBg = ...
            // \(tr("api.component_token_desc"))
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
            "config.components.tag.defaultColor = ..."
        }
        .scrollAnchor("token.defaultColor")
    }

    var tagFontSizeTokenCard: some View {
        TokenCard(
            name: "fontSize",
            type: "CGFloat",
            defaultValue: "token.fontSizeSM",
            description: tr("tag.token.fontSizeMD"),
            sectionId: "token"
        ) {
            HStack {
                Moin.Tag(tr("tag.label.font_demo"), size: .medium)
            }
        } editor: {
            TokenValueRow(label: "fontSize", value: Binding(
                get: { Moin.ConfigProvider.shared.components.tag.fontSize },
                set: { Moin.ConfigProvider.shared.components.tag.fontSize = $0 }
            ))
        } code: {
            "config.components.tag.fontSize = 14"
        }
        .scrollAnchor("token.fontSize")
    }

    var tagPaddingHTokenCard: some View {
        TokenCard(
            name: "paddingH",
            type: "CGFloat",
            defaultValue: "token.paddingSM",
            description: tr("tag.token.paddingHMD"),
            sectionId: "token"
        ) {
            HStack {
                Moin.Tag(tr("tag.label.padding_demo"), size: .medium)
            }
        } editor: {
            TokenValueRow(label: "paddingH", value: Binding(
                get: { Moin.ConfigProvider.shared.components.tag.paddingH },
                set: { Moin.ConfigProvider.shared.components.tag.paddingH = $0 }
            ))
        } code: {
            "config.components.tag.paddingH = 10"
        }
        .scrollAnchor("token.paddingH")
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
