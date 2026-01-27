import SwiftUI
import MoinUI

// MARK: - SpinTokenView

struct SpinTokenView: View {
    @Localized var tr
    @Environment(\.moinToken) var token
    @ObservedObject var config = Moin.ConfigProvider.shared
    
    // MARK: - Token Sections
    
    private var tokenSections: [DocSidebarSection] {
        [
            // 组件 Token
            DocSidebarSection(
                title: tr("doc.section.component_token"),
                items: [.init(id: "dotSize"), .init(id: "dotSizeSM"), .init(id: "dotSizeLG"), .init(id: "contentHeight"), .init(id: "motionDuration")],
                sectionId: "component"
            ),
            // 全局 Token
            DocSidebarSection(
                title: tr("doc.section.global_token"),
                items: [.init(id: "colorPrimary"), .init(id: "colorTextTertiary"), .init(id: "colorBgMask")],
                sectionId: "global"
            )
        ]
    }
    
    // 重置所有 Token 到默认值
    private func resetAll() {
        // 重置 global
        config.seed = Moin.SeedToken.default
        config.regenerateTokens()
        
        // 重置组件
        config.components.spin = .generate(from: config.token)
    }
    
    var body: some View {
        ComponentDocBody(
            sections: tokenSections,
            initialItemId: "component"
        ) { sectionId in
            if sectionId == "component" {
                Text(tr("doc.section.component_token")).font(.title3).fontWeight(.semibold)
            } else if sectionId == "global" {
                Text(tr("doc.section.global_token")).font(.title3).fontWeight(.semibold)
            }
        } item: { item in
            cardForItem(item)
                .id(item)
        } footer: {
            HStack(spacing: Moin.Constants.Spacing.sm) {
                Moin.Button(tr("playground.token.reset"), color: .primary, variant: .solid) {
                    resetAll()
                }
                
                Text(tr("token.playground.reset_desc"))
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
                
                Spacer()
            }
            .padding(Moin.Constants.Spacing.md)
        }
    }
    
    @ViewBuilder
    private func cardForItem(_ item: String) -> some View {
        switch item {
        // Size
        case "dotSize": dotSizeCard
        case "dotSizeSM": dotSizeSMCard
        case "dotSizeLG": dotSizeLGCard
        case "contentHeight": contentHeightCard
        case "motionDuration": motionDurationCard
        // Global
        case "colorPrimary": colorPrimaryCard
        case "colorTextTertiary": colorTextTertiaryCard
        case "colorBgMask": colorBgMaskCard
        default: EmptyView()
        }
    }
    
    // MARK: - Component Token Cards
    
    private var dotSizeCard: some View {
        TokenCard(
            name: "dotSize",
            type: "CGFloat",
            defaultValue: "token.controlHeightLG / 2",
            description: tr("spin.token.dotSize_desc"),
            sectionId: "component"
        ) {
            Moin.Spin(size: .default)
        } editor: {
            TokenValueRow(label: "dotSize", value: Binding(
                get: { config.components.spin.dotSize },
                set: { config.components.spin.dotSize = $0 }
            ))
        } code: {
            "config.components.spin.dotSize = \(Int(config.components.spin.dotSize))"
        }
    }
    
    private var dotSizeSMCard: some View {
        TokenCard(
            name: "dotSizeSM",
            type: "CGFloat",
            defaultValue: "token.controlHeightLG * 0.35",
            description: tr("spin.token.dotSizeSM_desc"),
            sectionId: "component"
        ) {
            Moin.Spin(size: .small)
        } editor: {
            TokenValueRow(label: "dotSizeSM", value: Binding(
                get: { config.components.spin.dotSizeSM },
                set: { config.components.spin.dotSizeSM = $0 }
            ))
        } code: {
            "config.components.spin.dotSizeSM = \(Int(config.components.spin.dotSizeSM))"
        }
    }
    
    private var dotSizeLGCard: some View {
        TokenCard(
            name: "dotSizeLG",
            type: "CGFloat",
            defaultValue: "token.controlHeight",
            description: tr("spin.token.dotSizeLG_desc"),
            sectionId: "component"
        ) {
            Moin.Spin(size: .large)
        } editor: {
            TokenValueRow(label: "dotSizeLG", value: Binding(
                get: { config.components.spin.dotSizeLG },
                set: { config.components.spin.dotSizeLG = $0 }
            ))
        } code: {
            "config.components.spin.dotSizeLG = \(Int(config.components.spin.dotSizeLG))"
        }
    }
    
    private var contentHeightCard: some View {
        TokenCard(
            name: "contentHeight",
            type: "CGFloat",
            defaultValue: "400",
            description: tr("spin.token.contentHeight_desc"),
            sectionId: "component"
        ) {
            // 使用 ScrollView 展示 contentHeight 效果
            Moin.Spin(spinning: true, tip: tr("spin.loading")) {
                ScrollView {
                    VStack(spacing: 8) {
                        ForEach(0..<5, id: \.self) { i in
                            Text("Line \(i + 1)")
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 8)
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(4)
                        }
                    }
                    .padding(8)
                }
                .frame(height: 150) // Demo中固定高度，实际使用 config.components.spin.contentHeight
            }
        } editor: {
            TokenValueRow(label: "contentHeight", value: Binding(
                get: { config.components.spin.contentHeight },
                set: { config.components.spin.contentHeight = $0 }
            ), range: 50...600, step: 50)
        } code: {
            "config.components.spin.contentHeight = \(Int(config.components.spin.contentHeight))"
        }
    }
    
    private var motionDurationCard: some View {
        TokenCard(
            name: "motionDuration",
            type: "Double",
            defaultValue: "1.2",
            description: tr("spin.token.motionDuration_desc"),
            sectionId: "component"
        ) {
            Moin.Spin()
        } editor: {
            TokenValueRow(label: "motionDuration", value: Binding(
                get: { CGFloat(config.components.spin.motionDuration) },
                set: { config.components.spin.motionDuration = Double($0) }
            ), range: 0.1...5, step: 0.1)
        } code: {
            "config.components.spin.motionDuration = \(config.components.spin.motionDuration)"
        }
    }
    
    // MARK: - Global Token Cards
    
    private var colorPrimaryCard: some View {
        TokenCard(
            name: "colorPrimary",
            type: "Color",
            defaultValue: "seed.colorPrimary",
            description: tr("spin.token.dotColor_desc"),
            sectionId: "global"
        ) {
            Moin.Spin()
        } editor: {
            ColorPresetRow(label: "seed.colorPrimary", color: Binding(
                get: { config.seed.colorPrimary },
                set: {
                    config.seed.colorPrimary = $0
                    config.regenerateTokens()
                }
            ))
        } code: {
            "config.seed.colorPrimary = Color(...)"
        }
    }
    
    private var colorTextTertiaryCard: some View {
        TokenCard(
            name: "colorTextTertiary",
            type: "Color",
            defaultValue: "token.colorTextTertiary",
            description: tr("spin.token.tipColor_desc"),
            sectionId: "global"
        ) {
            Moin.Spin(tip: "Loading...")
        } code: {
            "// \(tr("api.derived_from")) seed.colorTextBase"
        }
    }
    
    private var colorBgMaskCard: some View {
        TokenCard(
            name: "colorBgMask",
            type: "Color",
            defaultValue: "token.colorBgMask",
            description: tr("spin.token.maskBackground_desc"),
            sectionId: "global"
        ) {
            ZStack {
                VStack(spacing: 4) {
                    Text("Bg").font(.caption)
                }
                .frame(width: 80, height: 60)
                .background(Color.white)
                
                config.token.colorBgMask
                    .cornerRadius(4)
                
                Moin.Spin.Indicator(
                    size: config.components.spin.dotSize,
                    color: .white,
                    duration: config.components.spin.motionDuration
                )
            }
            .frame(width: 80, height: 60)
        } code: {
            "// \(tr("api.derived_from")) seed.colorBgBase"
        }
    }
}
