import SwiftUI
import MoinUI

struct ProgressTokenView: View {
    @Localized var tr
    @Environment(\.moinToken) var token
    // 使用 moinProgressToken 而不是重新生成
    @Environment(\.moinProgressToken) var progressToken
    @ObservedObject var config = Moin.ConfigProvider.shared
    
    // 我们需要修改 ConfigProvider 里的 Seed 从而影响 Token
    // 或者修改 ConfigProvider 里的 ComponentToken 从而影响 ProgressToken
    // 但是 Progress 组件现在是从 Environment 读取 moinProgressToken
    // moinProgressToken 是 ConfigProvider 注入的。
    // ConfigProvider.shared.config.components.progress 就是源头。
    
    private var tokenSections: [DocSidebarSection] {
        [
            DocSidebarSection(
                title: tr("doc.section.component_token"),
                items: [.init(id: "defaultColor"), .init(id: "remainingColor"), .init(id: "circleTextColor"), .init(id: "lineBorderRadius"), .init(id: "circleTextFontSize"), .init(id: "circleIconFontSize")],
                sectionId: "component"
            ),
            DocSidebarSection(
                title: tr("doc.section.global_token"),
                items: [.init(id: "colorInfo"), .init(id: "colorSuccess"), .init(id: "colorError"), .init(id: "colorText"), .init(id: "colorFillSecondary"), .init(id: "marginXS"), .init(id: "fontSize"), .init(id: "fontSizeSM")],
                sectionId: "global"
            )
        ]
    }
    
    private func resetAll() {
        config.reset()
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
            cardForItem(item).id(item)
        } footer: {
            HStack(spacing: Moin.Constants.Spacing.sm) {
                Moin.Button(tr("playground.token.reset"), color: .primary, variant: .solid) {
                    resetAll()
                }
                Text(tr("token.playground.reset_desc"))
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Spacer()
            }
            .padding(Moin.Constants.Spacing.md)
        }
    }

    @ViewBuilder
    private func cardForItem(_ item: String) -> some View {
        switch item {
        // Component
        case "defaultColor":
            TokenCard(name: "defaultColor", type: "Color", defaultValue: "#1677ff", description: tr("token.progress.defaultColor"), sectionId: "component") {
                Moin.Progress(percent: 50)
            } editor: {
                ColorPresetRow(label: "defaultColor", color: binding(\.defaultColor))
            } code: { "config.components.progress.defaultColor = Color(...)" }
            
        case "remainingColor":
            TokenCard(name: "remainingColor", type: "Color", defaultValue: "rgba(0,0,0,0.06)", description: tr("token.progress.remainingColor"), sectionId: "component") {
                Moin.Progress(percent: 50)
            } editor: {
                ColorPresetRow(label: "remainingColor", color: binding(\.remainingColor))
            } code: { "config.components.progress.remainingColor = Color(...)" }
            
        case "circleTextColor":
             TokenCard(name: "circleTextColor", type: "Color", defaultValue: "rgba(0,0,0,0.88)", description: tr("token.progress.circleTextColor"), sectionId: "component") {
                Moin.Progress(percent: 50, type: .circle)
            } editor: {
                ColorPresetRow(label: "circleTextColor", color: binding(\.circleTextColor))
            } code: { "config.components.progress.circleTextColor = Color(...)" }
            
        case "lineBorderRadius":
             TokenCard(name: "lineBorderRadius", type: "CGFloat", defaultValue: "100", description: tr("token.progress.lineBorderRadius"), sectionId: "component") {
                Moin.Progress(percent: 50, strokeLinecap: .round)
            } editor: {
                TokenValueRow(label: "lineBorderRadius", value: binding(\.lineBorderRadius), range: 0...100, step: 1)
            } code: { "config.components.progress.lineBorderRadius = 100" }

        case "circleTextFontSize":
             TokenCard(name: "circleTextFontSize", type: "CGFloat", defaultValue: "14", description: tr("token.progress.circleTextFontSize"), sectionId: "component") {
                Moin.Progress(percent: 50, type: .circle)
            } editor: {
                TokenValueRow(label: "circleTextFontSize", value: binding(\.circleTextFontSize), range: 1...100, step: 1)
            } code: { "config.components.progress.circleTextFontSize = \(String(format: "%.2f", config.components.progress.circleTextFontSize))" }

        case "circleIconFontSize":
             TokenCard(name: "circleIconFontSize", type: "CGFloat", defaultValue: "16", description: tr("token.progress.circleIconFontSize"), sectionId: "component") {
                Moin.Progress(percent: 100, type: .circle)
            } editor: {
                TokenValueRow(label: "circleIconFontSize", value: binding(\.circleIconFontSize), range: 1...100, step: 1)
            } code: { "config.components.progress.circleIconFontSize = \(String(format: "%.2f", config.components.progress.circleIconFontSize))" }
        
        // Global
        case "colorInfo":
            TokenCard(name: "colorInfo", type: "Color", defaultValue: "#1677ff", description: tr("token.progress.colorInfo"), sectionId: "global") {
                Moin.Progress(percent: 50)
            } editor: {
                ColorPresetRow(label: "seed.colorInfo", color: $config.seed.colorInfo, onChange: { config.regenerateTokens() })
            }
            
        case "colorSuccess":
            TokenCard(name: "colorSuccess", type: "Color", defaultValue: "#52c41a", description: tr("token.progress.colorSuccess"), sectionId: "global") {
                Moin.Progress(percent: 100)
            } editor: {
                 ColorPresetRow(label: "seed.colorSuccess", color: $config.seed.colorSuccess, onChange: { config.regenerateTokens() })
            }
            
        case "colorError":
            TokenCard(name: "colorError", type: "Color", defaultValue: "#ff4d4f", description: tr("token.progress.colorError"), sectionId: "global") {
                Moin.Progress(percent: 70, status: .exception)
            } editor: {
                 ColorPresetRow(label: "seed.colorError", color: $config.seed.colorError, onChange: { config.regenerateTokens() })
            }
            
        case "colorText":
            TokenCard(name: "colorText", type: "Color", defaultValue: "rgba(0,0,0,0.88)", description: tr("token.progress.colorText"), sectionId: "global") {
                Moin.Progress(percent: 50, type: .circle)
            } editor: {
                ColorPresetRow(label: "token.colorText", color: Binding(
                    get: { config.token.colorText },
                    set: {
                        config.token.colorText = $0
                        config.components.progress = Moin.ProgressToken.generate(from: config.token)
                    }
                ))
            } code: { "// derived from colorText" }
            
        case "colorFillSecondary":
            TokenCard(name: "colorFillSecondary", type: "Color", defaultValue: "rgba(0,0,0,0.06)", description: tr("token.progress.colorFillSecondary"), sectionId: "global") {
                Moin.Progress(percent: 50)
            } editor: {
                 ColorPresetRow(label: "token.colorFillSecondary", color: Binding(
                    get: { config.token.colorFillSecondary },
                    set: {
                        config.token.colorFillSecondary = $0
                        config.components.progress = Moin.ProgressToken.generate(from: config.token)
                    }
                 ))
            } code: { "// derived from colorFillSecondary" }
            
        case "marginXS":
            TokenCard(name: "marginXS", type: "number", defaultValue: "8", description: tr("token.progress.marginXS"), sectionId: "global") {
                 Moin.Progress(percent: 50)
            } editor: {
                TokenValueRow(label: "token.marginXS", value: Binding(
                    get: { config.token.marginXS },
                    set: {
                        config.token.marginXS = $0
                        config.components.progress = Moin.ProgressToken.generate(from: config.token)
                    }
                ), range: 0...50, step: 4)
            }
            
        case "fontSize":
             TokenCard(name: "fontSize", type: "number", defaultValue: "14", description: tr("token.progress.fontSize"), sectionId: "global") {
                 Moin.Progress(percent: 50)
            } editor: {
                 TokenValueRow(label: "seed.fontSize", value: Binding(
                    get: { config.seed.fontSize },
                    set: {
                        config.seed.fontSize = $0
                        config.regenerateTokens()
                    }
                ), range: 12...100, step: 1)
            }
            
        case "fontSizeSM":
             TokenCard(name: "fontSizeSM", type: "number", defaultValue: "12", description: tr("token.progress.fontSizeSM"), sectionId: "global") {
                 Moin.Progress(percent: 100, type: .circle)
            } editor: {
                TokenValueRow(label: "token.fontSizeSM", value: Binding(
                    get: { config.token.fontSizeSM },
                    set: {
                        config.token.fontSizeSM = $0
                        config.components.progress = Moin.ProgressToken.generate(from: config.token)
                    }
                ), range: 8...100, step: 4)
            } code: {
                "// fontSizeSM: \(Int(config.token.fontSizeSM)) => IconSize: \(String(format: "%.0f", config.components.progress.circleIconFontSize))"
            }
            
        default: EmptyView()
        }
    }
    
    private func binding<T>(_ keyPath: WritableKeyPath<Moin.ProgressToken, T>) -> Binding<T> {
        Binding(
            get: { config.components.progress[keyPath: keyPath] },
            set: { config.components.progress[keyPath: keyPath] = $0 }
        )
    }
}
