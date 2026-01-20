import SwiftUI
import MoinUI

// MARK: - Avatar Token Cards Extension

extension AvatarTokenView {
    
    // MARK: - Color Tokens
    
    var avatarContainerBgCard: some View {
        TokenCard(
            name: "containerBg",
            type: "Color",
            defaultValue: "token.colorFillTertiary",
            description: tr("avatar.token.containerBg"),
            sectionId: "token"
        ) {
            HStack {
                Moin.Avatar(icon: "person")
                Moin.Avatar("U")
            }
        } editor: {
            ColorPresetRow(label: "containerBg", color: Binding(
                get: { Moin.ConfigProvider.shared.components.avatar.containerBg },
                set: { Moin.ConfigProvider.shared.components.avatar.containerBg = $0 }
            ))
        } code: {
            "config.components.avatar.containerBg = Color(...)"
        }
        .scrollAnchor("token.containerBg")
    }
    
    var avatarColorTextCard: some View {
        TokenCard(
            name: "colorText",
            type: "Color",
            defaultValue: "token.colorText",
            description: tr("avatar.token.colorText"),
            sectionId: "token"
        ) {
            HStack {
                Moin.Avatar("Dark", backgroundColor: .custom(.white))
                    .foregroundStyle(Moin.ConfigProvider.shared.components.avatar.colorText) // Force apply to show effect if component doesn't auto-apply in all cases
                // Usually component should use this token internally.
                Moin.Avatar("Text")
            }
        } editor: {
            ColorPresetRow(label: "colorText", color: Binding(
                get: { Moin.ConfigProvider.shared.components.avatar.colorText },
                set: { Moin.ConfigProvider.shared.components.avatar.colorText = $0 }
            ))
        } code: {
            "config.components.avatar.colorText = Color(...)"
        }
        .scrollAnchor("token.colorText")
    }
    
    var avatarColorTextLightCard: some View {
        TokenCard(
            name: "colorTextLight",
            type: "Color",
            defaultValue: "token.colorTextLightSolid",
            description: tr("avatar.token.colorTextLight"),
            sectionId: "token"
        ) {
            HStack {
                Moin.Avatar("U", backgroundColor: .custom(.primary))
            }
        } editor: {
            ColorPresetRow(label: "colorTextLight", color: Binding(
                get: { Moin.ConfigProvider.shared.components.avatar.colorTextLight },
                set: { Moin.ConfigProvider.shared.components.avatar.colorTextLight = $0 }
            ))
        } code: {
            "config.components.avatar.colorTextLight = Color(...)"
        }
        .scrollAnchor("token.colorTextLight")
    }
    
    var avatarGroupBorderColorCard: some View {
        TokenCard(
            name: "groupBorderColor",
            type: "Color",
            defaultValue: ".white",
            description: tr("avatar.token.groupBorderColor"),
            sectionId: "token"
        ) {
            Moin.AvatarGroup {
                Moin.Avatar("A")
                Moin.Avatar("B")
            }
        } editor: {
            ColorPresetRow(label: "groupBorderColor", color: Binding(
                get: { Moin.ConfigProvider.shared.components.avatar.groupBorderColor },
                set: { Moin.ConfigProvider.shared.components.avatar.groupBorderColor = $0 }
            ))
        } code: {
            "config.components.avatar.groupBorderColor = Color(...)"
        }
        .scrollAnchor("token.groupBorderColor")
    }
    
    // MARK: - Size Tokens
    
    var avatarSizeCard: some View {
        TokenCard(
            name: "size",
            type: "CGFloat",
            defaultValue: "token.controlHeight",
            description: tr("avatar.token.size"),
            sectionId: "token"
        ) {
            Moin.Avatar(icon: "person", size: .default)
        } editor: {
            TokenValueRow(label: "size", value: Binding(
                get: { Moin.ConfigProvider.shared.components.avatar.size },
                set: { Moin.ConfigProvider.shared.components.avatar.size = $0 }
            ))
        } code: {
            "config.components.avatar.size = \(Int(config.components.avatar.size))"
        }
        .scrollAnchor("token.size")
    }
    
    var avatarSizeLGCard: some View {
        TokenCard(
            name: "sizeLG",
            type: "CGFloat",
            defaultValue: "token.controlHeightLG",
            description: tr("avatar.token.sizeLG"),
            sectionId: "token"
        ) {
            Moin.Avatar(icon: "person", size: .large)
        } editor: {
            TokenValueRow(label: "sizeLG", value: Binding(
                get: { Moin.ConfigProvider.shared.components.avatar.sizeLG },
                set: { Moin.ConfigProvider.shared.components.avatar.sizeLG = $0 }
            ))
        } code: {
            "config.components.avatar.sizeLG = \(Int(config.components.avatar.sizeLG))"
        }
        .scrollAnchor("token.sizeLG")
    }
    
    var avatarSizeSMCard: some View {
        TokenCard(
            name: "sizeSM",
            type: "CGFloat",
            defaultValue: "token.controlHeightSM",
            description: tr("avatar.token.sizeSM"),
            sectionId: "token"
        ) {
            Moin.Avatar(icon: "person", size: .small)
        } editor: {
            TokenValueRow(label: "sizeSM", value: Binding(
                get: { Moin.ConfigProvider.shared.components.avatar.sizeSM },
                set: { Moin.ConfigProvider.shared.components.avatar.sizeSM = $0 }
            ))
        } code: {
            "config.components.avatar.sizeSM = \(Int(config.components.avatar.sizeSM))"
        }
        .scrollAnchor("token.sizeSM")
    }
    
    // MARK: - Font Size Tokens
    
    var avatarFontSizeCard: some View {
        TokenCard(
            name: "fontSize",
            type: "CGFloat",
            defaultValue: "18",
            description: tr("avatar.token.fontSize"),
            sectionId: "token"
        ) {
             Moin.Avatar("M", size: .default)
        } editor: {
            TokenValueRow(label: "fontSize", value: Binding(
                get: { Moin.ConfigProvider.shared.components.avatar.fontSize },
                set: { Moin.ConfigProvider.shared.components.avatar.fontSize = $0 }
            ))
        } code: {
            "config.components.avatar.fontSize = \(Int(config.components.avatar.fontSize))"
        }
        .scrollAnchor("token.fontSize")
    }
    
    var avatarFontSizeLGCard: some View {
        TokenCard(
            name: "fontSizeLG",
            type: "CGFloat",
            defaultValue: "24",
            description: tr("avatar.token.fontSizeLG"),
            sectionId: "token"
        ) {
             Moin.Avatar("L", size: .large)
        } editor: {
            TokenValueRow(label: "fontSizeLG", value: Binding(
                get: { Moin.ConfigProvider.shared.components.avatar.fontSizeLG },
                set: { Moin.ConfigProvider.shared.components.avatar.fontSizeLG = $0 }
            ))
        } code: {
            "config.components.avatar.fontSizeLG = \(Int(config.components.avatar.fontSizeLG))"
        }
        .scrollAnchor("token.fontSizeLG")
    }
    
    var avatarFontSizeSMCard: some View {
        TokenCard(
            name: "fontSizeSM",
            type: "CGFloat",
            defaultValue: "14",
            description: tr("avatar.token.fontSizeSM"),
            sectionId: "token"
        ) {
             Moin.Avatar("S", size: .small)
        } editor: {
            TokenValueRow(label: "fontSizeSM", value: Binding(
                get: { Moin.ConfigProvider.shared.components.avatar.fontSizeSM },
                set: { Moin.ConfigProvider.shared.components.avatar.fontSizeSM = $0 }
            ))
        } code: {
            "config.components.avatar.fontSizeSM = \(Int(config.components.avatar.fontSizeSM))"
        }
        .scrollAnchor("token.fontSizeSM")
    }

    // MARK: - Border Radius Matches
    
    var avatarBorderRadiusCard: some View {
        TokenCard(
            name: "borderRadius",
            type: "CGFloat",
            defaultValue: "token.borderRadius",
            description: tr("avatar.token.borderRadius"),
            sectionId: "token"
        ) {
             Moin.Avatar("R", size: .default, shape: .square)
        } editor: {
            TokenValueRow(label: "borderRadius", value: Binding(
                get: { Moin.ConfigProvider.shared.components.avatar.borderRadius },
                set: { Moin.ConfigProvider.shared.components.avatar.borderRadius = $0 }
            ))
        } code: {
            "config.components.avatar.borderRadius = \(Int(config.components.avatar.borderRadius))"
        }
        .scrollAnchor("token.borderRadius")
    }
    
    var avatarBorderRadiusLGCard: some View {
        TokenCard(
            name: "borderRadiusLG",
            type: "CGFloat",
            defaultValue: "token.borderRadiusLG",
            description: tr("avatar.token.borderRadiusLG"),
            sectionId: "token"
        ) {
             Moin.Avatar("R", size: .large, shape: .square)
        } editor: {
            TokenValueRow(label: "borderRadiusLG", value: Binding(
                get: { Moin.ConfigProvider.shared.components.avatar.borderRadiusLG },
                set: { Moin.ConfigProvider.shared.components.avatar.borderRadiusLG = $0 }
            ))
        } code: {
            "config.components.avatar.borderRadiusLG = \(Int(config.components.avatar.borderRadiusLG))"
        }
        .scrollAnchor("token.borderRadiusLG")
    }
    
    var avatarBorderRadiusSMCard: some View {
        TokenCard(
            name: "borderRadiusSM",
            type: "CGFloat",
            defaultValue: "token.borderRadiusSM",
            description: tr("avatar.token.borderRadiusSM"),
            sectionId: "token"
        ) {
             Moin.Avatar("R", size: .small, shape: .square)
        } editor: {
            TokenValueRow(label: "borderRadiusSM", value: Binding(
                get: { Moin.ConfigProvider.shared.components.avatar.borderRadiusSM },
                set: { Moin.ConfigProvider.shared.components.avatar.borderRadiusSM = $0 }
            ))
        } code: {
            "config.components.avatar.borderRadiusSM = \(Int(config.components.avatar.borderRadiusSM))"
        }
        .scrollAnchor("token.borderRadiusSM")
    }
    
    // MARK: - Group Tokens
    
    var avatarGroupSpacingCard: some View {
        TokenCard(
            name: "groupSpacing",
            type: "CGFloat",
            defaultValue: "-8",
            description: tr("avatar.token.groupSpacing"),
            sectionId: "token"
        ) {
            Moin.AvatarGroup {
                Moin.Avatar("A")
                Moin.Avatar("B")
                Moin.Avatar("C")
            }
        } editor: {
            TokenValueRow(label: "groupSpacing", value: Binding(
                get: { Moin.ConfigProvider.shared.components.avatar.groupSpacing },
                set: { Moin.ConfigProvider.shared.components.avatar.groupSpacing = $0 }
            ), range: -20...10)
        } code: {
            "config.components.avatar.groupSpacing = \(Int(config.components.avatar.groupSpacing))"
        }
        .scrollAnchor("token.groupSpacing")
    }
    
    var avatarGroupBorderWidthCard: some View {
        TokenCard(
            name: "groupBorderWidth",
            type: "CGFloat",
            defaultValue: "2",
            description: tr("avatar.token.groupBorderWidth"),
            sectionId: "token"
        ) {
            Moin.AvatarGroup {
                Moin.Avatar("A")
                Moin.Avatar("B")
            }
        } editor: {
            TokenValueRow(label: "groupBorderWidth", value: Binding(
                get: { Moin.ConfigProvider.shared.components.avatar.groupBorderWidth },
                set: { Moin.ConfigProvider.shared.components.avatar.groupBorderWidth = $0 }
            ))
        } code: {
            "config.components.avatar.groupBorderWidth = \(Int(config.components.avatar.groupBorderWidth))"
        }
        .scrollAnchor("token.groupBorderWidth")
    }
    
    // MARK: - Global Tokens
    
    var globalColorTextSecondaryCard: some View {
        TokenCard(
            name: "colorTextSecondary",
            type: "Color",
            defaultValue: "token.colorTextSecondary",
            description: tr("avatar.token.colorTextSecondary"),
            sectionId: "global"
        ) {
            Text("Text").foregroundStyle(config.token.colorTextSecondary)
        } editor: {
            ColorPresetRow(label: "colorTextSecondary", color: Binding(
                get: { config.token.colorTextSecondary },
                set: { config.token.colorTextSecondary = $0 }
            ))
        } code: {
            "config.token.colorTextSecondary = Color(...)"
        }
    }

    var globalColorFillTertiaryCard: some View {
        TokenCard(
            name: "colorFillTertiary",
            type: "Color",
            defaultValue: "token.colorFillTertiary",
            description: tr("avatar.token.colorFillTertiary"),
            sectionId: "global"
        ) {
            Rectangle().fill(config.token.colorFillTertiary).frame(width: 50, height: 50)
        } editor: {
            ColorPresetRow(label: "colorFillTertiary", color: Binding(
                get: { config.token.colorFillTertiary },
                set: { config.token.colorFillTertiary = $0 }
            ))
        } code: {
            "config.token.colorFillTertiary = Color(...)"
        }
    }
}
