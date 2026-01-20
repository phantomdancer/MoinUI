import SwiftUI
import MoinUI

// MARK: - Badge Token Cards Extension

extension BadgeTokenView {
    
    // MARK: - Height Tokens
    
    var badgeIndicatorHeightCard: some View {
        TokenCard(
            name: "indicatorHeight",
            type: "CGFloat",
            defaultValue: "\(Int(Moin.ConfigProvider.shared.components.badge.indicatorHeight))",
            description: tr("badge.token.indicatorHeight"),
            sectionId: "token"
        ) {
            Moin.Badge(count: 5) { sampleBox }
        } editor: {
            TokenValueRow(label: "indicatorHeight", value: Binding(
                get: { Moin.ConfigProvider.shared.components.badge.indicatorHeight },
                set: { Moin.ConfigProvider.shared.components.badge.indicatorHeight = $0 }
            ))
        } code: {
            "config.components.badge.indicatorHeight = \(Int(config.components.badge.indicatorHeight))"
        }
        .scrollAnchor("token.indicatorHeight")
    }
    
    var badgeIndicatorHeightSMCard: some View {
        TokenCard(
            name: "indicatorHeightSM",
            type: "CGFloat",
            defaultValue: "\(Int(Moin.ConfigProvider.shared.components.badge.indicatorHeightSM))",
            description: tr("badge.token.indicatorHeightSM"),
            sectionId: "token"
        ) {
            Moin.Badge(count: 5, size: .small) { sampleBox }
        } editor: {
            TokenValueRow(label: "indicatorHeightSM", value: Binding(
                get: { Moin.ConfigProvider.shared.components.badge.indicatorHeightSM },
                set: { Moin.ConfigProvider.shared.components.badge.indicatorHeightSM = $0 }
            ))
        } code: {
            "config.components.badge.indicatorHeightSM = \(Int(config.components.badge.indicatorHeightSM))"
        }
        .scrollAnchor("token.indicatorHeightSM")
    }
    
    // MARK: - Dot Size Tokens
    
    var badgeDotSizeCard: some View {
        TokenCard(
            name: "dotSize",
            type: "CGFloat",
            defaultValue: "\(Int(Moin.ConfigProvider.shared.components.badge.dotSize))",
            description: tr("badge.token.dotSize"),
            sectionId: "token"
        ) {
            Moin.Badge(dot: true) { sampleBox }
        } editor: {
            TokenValueRow(label: "dotSize", value: Binding(
                get: { Moin.ConfigProvider.shared.components.badge.dotSize },
                set: { Moin.ConfigProvider.shared.components.badge.dotSize = $0 }
            ))
        } code: {
            "config.components.badge.dotSize = \(Int(config.components.badge.dotSize))"
        }
        .scrollAnchor("token.dotSize")
    }
    
    var badgeDotSizeSMCard: some View {
        TokenCard(
            name: "dotSizeSM",
            type: "CGFloat",
            defaultValue: "\(Int(Moin.ConfigProvider.shared.components.badge.dotSizeSM))",
            description: tr("badge.token.dotSizeSM"),
            sectionId: "token"
        ) {
             // Badge dot doesn't really have "small" size explicitly unless we expose it or use wrapper?
             // Assuming Moin.Badge(size: .small, dot: true) uses dotSizeSM?
             Moin.Badge(dot: true, size: .small) { sampleBox }
        } editor: {
            TokenValueRow(label: "dotSizeSM", value: Binding(
                get: { Moin.ConfigProvider.shared.components.badge.dotSizeSM },
                set: { Moin.ConfigProvider.shared.components.badge.dotSizeSM = $0 }
            ))
        } code: {
            "config.components.badge.dotSizeSM = \(Int(config.components.badge.dotSizeSM))"
        }
        .scrollAnchor("token.dotSizeSM")
    }
    
    // MARK: - Text Font Size Tokens
    
    var badgeTextFontSizeCard: some View {
        TokenCard(
            name: "textFontSize",
            type: "CGFloat",
            defaultValue: "\(Int(Moin.ConfigProvider.shared.components.badge.textFontSize))",
            description: tr("badge.token.textFontSize"),
            sectionId: "token"
        ) {
             Moin.Badge(count: 10) { sampleBox }
        } editor: {
            TokenValueRow(label: "textFontSize", value: Binding(
                get: { Moin.ConfigProvider.shared.components.badge.textFontSize },
                set: { Moin.ConfigProvider.shared.components.badge.textFontSize = $0 }
            ))
        } code: {
            "config.components.badge.textFontSize = \(Int(config.components.badge.textFontSize))"
        }
        .scrollAnchor("token.textFontSize")
    }
    
    var badgeTextFontSizeSMCard: some View {
        TokenCard(
            name: "textFontSizeSM",
            type: "CGFloat",
            defaultValue: "\(Int(Moin.ConfigProvider.shared.components.badge.textFontSizeSM))",
            description: tr("badge.token.textFontSizeSM"),
            sectionId: "token"
        ) {
             Moin.Badge(count: 10, size: .small) { sampleBox }
        } editor: {
            TokenValueRow(label: "textFontSizeSM", value: Binding(
                get: { Moin.ConfigProvider.shared.components.badge.textFontSizeSM },
                set: { Moin.ConfigProvider.shared.components.badge.textFontSizeSM = $0 }
            ))
        } code: {
            "config.components.badge.textFontSizeSM = \(Int(config.components.badge.textFontSizeSM))"
        }
        .scrollAnchor("token.textFontSizeSM")
    }
    
    // MARK: - Other Component Tokens
    
    var badgeStatusSizeCard: some View {
        TokenCard(
            name: "statusSize",
            type: "CGFloat",
            defaultValue: "\(Int(Moin.ConfigProvider.shared.components.badge.statusSize))",
            description: tr("badge.token.statusSize"),
            sectionId: "token"
        ) {
            Moin.Badge(status: .processing)
        } editor: {
            TokenValueRow(label: "statusSize", value: Binding(
                get: { Moin.ConfigProvider.shared.components.badge.statusSize },
                set: { Moin.ConfigProvider.shared.components.badge.statusSize = $0 }
            ))
        } code: {
            "config.components.badge.statusSize = \(Int(config.components.badge.statusSize))"
        }
        .scrollAnchor("token.statusSize")
    }
    
    var badgeShadowRadiusCard: some View {
        TokenCard(
            name: "shadowRadius",
            type: "CGFloat",
            defaultValue: "\(Int(Moin.ConfigProvider.shared.components.badge.shadowRadius))",
            description: tr("badge.token.shadowRadius"),
            sectionId: "token"
        ) {
             Moin.Badge(count: 5) { sampleBox }
        } editor: {
            TokenValueRow(label: "shadowRadius", value: Binding(
                get: { Moin.ConfigProvider.shared.components.badge.shadowRadius },
                set: { Moin.ConfigProvider.shared.components.badge.shadowRadius = $0 }
            ))
        } code: {
            "config.components.badge.shadowRadius = \(Int(config.components.badge.shadowRadius))"
        }
        .scrollAnchor("token.shadowRadius")
    }
    
    var badgePaddingHCard: some View {
        TokenCard(
            name: "paddingH",
            type: "CGFloat",
            defaultValue: "\(Int(Moin.ConfigProvider.shared.components.badge.paddingH))",
            description: tr("badge.token.paddingH"),
            sectionId: "token"
        ) {
             Moin.Badge(count: 10) { sampleBox }
        } editor: {
            TokenValueRow(label: "paddingH", value: Binding(
                get: { Moin.ConfigProvider.shared.components.badge.paddingH },
                set: { Moin.ConfigProvider.shared.components.badge.paddingH = $0 }
            ))
        } code: {
            "config.components.badge.paddingH = \(Int(config.components.badge.paddingH))"
        }
        .scrollAnchor("token.paddingH")
    }
    
    var badgePaddingHSMCard: some View {
        TokenCard(
            name: "paddingHSM",
            type: "CGFloat",
            defaultValue: "\(Int(Moin.ConfigProvider.shared.components.badge.paddingHSM))",
            description: tr("badge.token.paddingHSM"),
            sectionId: "token"
        ) {
             Moin.Badge(count: 10, size: .small) { sampleBox }
        } editor: {
            TokenValueRow(label: "paddingHSM", value: Binding(
                get: { Moin.ConfigProvider.shared.components.badge.paddingHSM },
                set: { Moin.ConfigProvider.shared.components.badge.paddingHSM = $0 }
            ))
        } code: {
            "config.components.badge.paddingHSM = \(Int(config.components.badge.paddingHSM))"
        }
        .scrollAnchor("token.paddingHSM")
    }
    
    // MARK: - Global Tokens
    
    var globalColorDangerCard: some View {
        TokenCard(
            name: "colorDanger",
            type: "Color",
            defaultValue: "seed.colorError",
            description: tr("badge.token.colorDanger"),
            sectionId: "global"
        ) {
            Moin.Badge(count: 5) { sampleBox }
        } editor: {
            ColorPresetRow(label: "colorError", color: $config.seed.colorError, onChange: { config.regenerateTokens() })
        } code: {
            "config.seed.colorError = Color(...)"
        }
        .scrollAnchor("global.colorDanger")
    }
    
    var globalColorSuccessCard: some View {
        TokenCard(
            name: "colorSuccess",
            type: "Color",
            defaultValue: "seed.colorSuccess",
            description: tr("badge.token.colorSuccess"),
            sectionId: "global"
        ) {
            Moin.Badge(count: 5, color: .success) { sampleBox }
        } editor: {
            ColorPresetRow(label: "colorSuccess", color: $config.seed.colorSuccess, onChange: { config.regenerateTokens() })
        } code: {
            "config.seed.colorSuccess = Color(...)"
        }
        .scrollAnchor("global.colorSuccess")
    }
    
    var globalColorPrimaryCard: some View {
        TokenCard(
            name: "colorPrimary",
            type: "Color",
            defaultValue: "seed.colorPrimary",
            description: tr("badge.token.colorPrimary"),
            sectionId: "global"
        ) {
            Moin.Badge(count: 5, color: .processing) { sampleBox }
        } editor: {
            ColorPresetRow(label: "colorPrimary", color: $config.seed.colorPrimary, onChange: { config.regenerateTokens() })
        } code: {
            "config.seed.colorPrimary = Color(...)"
        }
        .scrollAnchor("global.colorPrimary")
    }
    
    var globalColorWarningCard: some View {
        TokenCard(
            name: "colorWarning",
            type: "Color",
            defaultValue: "seed.colorWarning",
            description: tr("badge.token.colorWarning"),
            sectionId: "global"
        ) {
            Moin.Badge(count: 5, color: .warning) { sampleBox }
        } editor: {
            ColorPresetRow(label: "colorWarning", color: $config.seed.colorWarning, onChange: { config.regenerateTokens() })
        } code: {
            "config.seed.colorWarning = Color(...)"
        }
        .scrollAnchor("global.colorWarning")
    }
    
    var globalColorTextCard: some View {
        TokenCard(
            name: "colorText",
            type: "Color",
            defaultValue: "seed.colorTextBase",
            description: tr("badge.token.colorText"),
            sectionId: "global"
        ) {
            Moin.Badge(status: .default, text: "Text Color")
        } editor: {
            ColorPresetRow(label: "colorTextBase", color: $config.seed.colorTextBase, onChange: { config.regenerateTokens() })
        } code: {
            "config.seed.colorTextBase = Color(...)"
        }
        .scrollAnchor("global.colorText")
    }
    
    var globalColorTextSecondaryCard: some View {
        TokenCard(
            name: "colorTextSecondary",
            type: "Color",
            defaultValue: "seed.colorTextBase",
            description: tr("badge.token.colorTextSecondary"),
            sectionId: "global"
        ) {
            Text("Secondary").foregroundStyle(Moin.ConfigProvider.shared.token.colorTextSecondary)
        } code: {
            "// \(tr("api.derived_from")) colorTextBase"
        }
        .scrollAnchor("global.colorTextSecondary")
    }
    
    // Helper
    private var sampleBox: some View {
        RoundedRectangle(cornerRadius: 6)
            .fill(Color.gray.opacity(0.3))
            .frame(width: 40, height: 40)
    }
}
