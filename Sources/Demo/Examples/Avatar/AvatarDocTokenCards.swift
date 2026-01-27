import SwiftUI
import MoinUI

// MARK: - Avatar Token Cards Extension

extension AvatarTokenView {
    
    // MARK: - Component Tokens - Sizes
    
    var avatarSizeCard: some View {
        TokenCard(
            name: "size",
            type: "CGFloat",
            defaultValue: "token.controlHeight",
            description: tr("avatar.token.size"),
            sectionId: "component"
        ) {
            Moin.Avatar(icon: "person", size: .default)
        } editor: {
            TokenValueRow(label: "size", value: Binding(
                get: { config.components.avatar.size },
                set: { config.components.avatar.size = $0 }
            ))
        } code: {
            "config.components.avatar.size = \(Int(config.components.avatar.size))"
        }
    }
    
    var avatarSizeLGCard: some View {
        TokenCard(
            name: "sizeLG",
            type: "CGFloat",
            defaultValue: "token.controlHeightLG",
            description: tr("avatar.token.sizeLG"),
            sectionId: "component"
        ) {
            Moin.Avatar(icon: "person", size: .large)
        } editor: {
            TokenValueRow(label: "sizeLG", value: Binding(
                get: { config.components.avatar.sizeLG },
                set: { config.components.avatar.sizeLG = $0 }
            ))
        } code: {
            "config.components.avatar.sizeLG = \(Int(config.components.avatar.sizeLG))"
        }
    }
    
    var avatarSizeSMCard: some View {
        TokenCard(
            name: "sizeSM",
            type: "CGFloat",
            defaultValue: "token.controlHeightSM",
            description: tr("avatar.token.sizeSM"),
            sectionId: "component"
        ) {
            Moin.Avatar(icon: "person", size: .small)
        } editor: {
            TokenValueRow(label: "sizeSM", value: Binding(
                get: { config.components.avatar.sizeSM },
                set: { config.components.avatar.sizeSM = $0 }
            ))
        } code: {
            "config.components.avatar.sizeSM = \(Int(config.components.avatar.sizeSM))"
        }
    }
    
    // MARK: - Component Tokens - Font Sizes
    
    var avatarFontSizeCard: some View {
        TokenCard(
            name: "fontSize",
            type: "CGFloat",
            defaultValue: "token.fontSizeHeading5",
            description: tr("avatar.token.fontSize"),
            sectionId: "component"
        ) {
             Moin.Avatar("M", size: .default)
        } editor: {
            TokenValueRow(label: "fontSize", value: Binding(
                get: { config.components.avatar.fontSize },
                set: { config.components.avatar.fontSize = $0 }
            ))
        } code: {
            "config.components.avatar.fontSize = \(Int(config.components.avatar.fontSize))"
        }
    }
    
    var avatarFontSizeLGCard: some View {
        TokenCard(
            name: "fontSizeLG",
            type: "CGFloat",
            defaultValue: "token.fontSizeHeading3",
            description: tr("avatar.token.fontSizeLG"),
            sectionId: "component"
        ) {
             Moin.Avatar("L", size: .large)
        } editor: {
            TokenValueRow(label: "fontSizeLG", value: Binding(
                get: { config.components.avatar.fontSizeLG },
                set: { config.components.avatar.fontSizeLG = $0 }
            ))
        } code: {
            "config.components.avatar.fontSizeLG = \(Int(config.components.avatar.fontSizeLG))"
        }
    }
    
    var avatarFontSizeSMCard: some View {
        TokenCard(
            name: "fontSizeSM",
            type: "CGFloat",
            defaultValue: "token.fontSize",
            description: tr("avatar.token.fontSizeSM"),
            sectionId: "component"
        ) {
             Moin.Avatar("S", size: .small)
        } editor: {
            TokenValueRow(label: "fontSizeSM", value: Binding(
                get: { config.components.avatar.fontSizeSM },
                set: { config.components.avatar.fontSizeSM = $0 }
            ))
        } code: {
            "config.components.avatar.fontSizeSM = \(Int(config.components.avatar.fontSizeSM))"
        }
    }

    // MARK: - Component Tokens - Group
    
    var avatarGroupSpacingCard: some View {
        TokenCard(
            name: "groupSpacing",
            type: "CGFloat",
            defaultValue: "4",
            description: tr("avatar.token.groupSpacing"),
            sectionId: "component"
        ) {
            Moin.Avatar.Group {
                Moin.Avatar("A")
                Moin.Avatar("B")
                Moin.Avatar("C")
            }
        } editor: {
            TokenValueRow(label: "groupSpacing", value: Binding(
                get: { config.components.avatar.groupSpacing },
                set: { config.components.avatar.groupSpacing = $0 }
            ), range: -20...20)
        } code: {
            "config.components.avatar.groupSpacing = \(Int(config.components.avatar.groupSpacing))"
        }
    }
    
    var avatarGroupBorderColorCard: some View {
        TokenCard(
            name: "groupBorderColor",
            type: "Color",
            defaultValue: ".white",
            description: tr("avatar.token.groupBorderColor"),
            sectionId: "component"
        ) {
            Moin.Avatar.Group {
                Moin.Avatar("A")
                Moin.Avatar("B")
            }
        } editor: {
            ColorPresetRow(label: "groupBorderColor", color: Binding(
                get: { config.components.avatar.groupBorderColor },
                set: { config.components.avatar.groupBorderColor = $0 }
            ))
        } code: {
            "config.components.avatar.groupBorderColor = Color(...)"
        }
    }
    
    // MARK: - Global Tokens (Readonly/Derived)
    
    var avatarContainerBgCard: some View {
        TokenCard(
            name: "containerBg",
            type: "Color",
            defaultValue: "token.colorTextPlaceholder",
            description: tr("avatar.token.containerBg"),
            sectionId: "global"
        ) {
            HStack {
                Moin.Avatar(icon: "person")
                Moin.Avatar("U")
            }
        } code: {
            "// \(tr("api.derived_from")) seed.colorTextBase"
        }
    }
    
    var avatarColorTextCard: some View {
        TokenCard(
            name: "colorText",
            type: "Color",
            defaultValue: "token.colorTextLightSolid",
            description: tr("avatar.token.colorText"),
            sectionId: "global"
        ) {
            Moin.Avatar("T")
        } code: {
            "// \(tr("api.derived_from")) seed.colorTextBase"
        }
    }
    
    var avatarColorTextLightCard: some View {
        TokenCard(
            name: "colorTextLight",
            type: "Color",
            defaultValue: "token.colorTextLightSolid",
            description: tr("avatar.token.colorTextLight"),
            sectionId: "global"
        ) {
            Moin.Avatar("U", backgroundColor: .custom(.primary))
        } code: {
            "// \(tr("api.derived_from")) seed.colorTextBase"
        }
    }

    var avatarBorderRadiusCard: some View {
        TokenCard(
            name: "borderRadius",
            type: "CGFloat",
            defaultValue: "token.borderRadius",
            description: tr("avatar.token.borderRadius"),
            sectionId: "global"
        ) {
             Moin.Avatar("R", size: .default, shape: .square)
        } code: {
            "// token.borderRadius"
        }
    }
    
    var avatarBorderRadiusLGCard: some View {
        TokenCard(
            name: "borderRadiusLG",
            type: "CGFloat",
            defaultValue: "token.borderRadiusLG",
            description: tr("avatar.token.borderRadiusLG"),
            sectionId: "global"
        ) {
             Moin.Avatar("R", size: .large, shape: .square)
        } code: {
            "// token.borderRadiusLG"
        }
    }
    
    var avatarBorderRadiusSMCard: some View {
        TokenCard(
            name: "borderRadiusSM",
            type: "CGFloat",
            defaultValue: "token.borderRadiusSM",
            description: tr("avatar.token.borderRadiusSM"),
            sectionId: "global"
        ) {
             Moin.Avatar("R", size: .small, shape: .square)
        } code: {
            "// token.borderRadiusSM"
        }
    }
    
    var avatarGroupBorderWidthCard: some View {
        TokenCard(
            name: "groupBorderWidth",
            type: "CGFloat",
            defaultValue: "token.lineWidth",
            description: tr("avatar.token.groupBorderWidth"),
            sectionId: "global"
        ) {
            Moin.Avatar.Group {
                Moin.Avatar("A")
                Moin.Avatar("B")
            }
        } code: {
            "// token.lineWidth"
        }
    }
}
