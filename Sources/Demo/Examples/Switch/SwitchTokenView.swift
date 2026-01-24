import SwiftUI
import MoinUI

struct SwitchTokenView: View {
    @Localized var tr
    @Environment(\.moinSwitchToken) var token
    // Access ConfigProvider directly to modify tokens
    @ObservedObject var config = Moin.ConfigProvider.shared
    
    private var tokenSections: [DocSidebarSection] {
        [
            DocSidebarSection(
                title: tr("doc.section.component_token"),
                items: [
                   "handleBg", "handleShadow", "handleSize", "handleSizeSM",
                   "innerMaxMargin", "innerMaxMarginSM", "innerMinMargin", "innerMinMarginSM",
                   "trackHeight", "trackHeightSM", "trackMinWidth", "trackMinWidthSM", "trackPadding"
                ],
                sectionId: "component"
            ),
            DocSidebarSection(
                title: tr("doc.section.global_token"),
                items: [
                    "colorPrimary", "colorTextQuaternary", "colorTextTertiary", 
                    "opacityLoading", "motionDurationMid"
                ],
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
        // MARK: - Component Tokens
        
        case "handleBg":
            TokenCard(name: "handleBg", type: "Color", defaultValue: "#fff", description: tr("token.switch.handleBg"), sectionId: "component") {
                InteractiveSwitch(isOn: true, checkedText: "开启", uncheckedText: "关闭")
                    .id(config.components.switch.handleBg)
            } editor: {
                ColorPresetRow(label: "handleBg", color: binding(\.handleBg))
            } code: { 
                "config.components.switch.handleBg = \(config.components.switch.handleBg)" 
            }
            
        case "handleShadow":
            TokenCard(name: "handleShadow", type: "Color", defaultValue: "rgba(0,35,11,0.2)", description: tr("token.switch.handleShadow"), sectionId: "component") {
               InteractiveSwitch(isOn: true, checkedText: "开启", uncheckedText: "关闭")
                   .id(config.components.switch.handleShadow)
            } editor: {
                ColorPresetRow(label: "handleShadow", color: binding(\.handleShadow))
            } code: { 
                "config.components.switch.handleShadow = \(config.components.switch.handleShadow)" 
            }
            
        case "handleSize":
            TokenCard(name: "handleSize", type: "number", defaultValue: "18", description: tr("token.switch.handleSize"), sectionId: "component") {
               InteractiveSwitch(isOn: true, checkedText: "开启", uncheckedText: "关闭")
                   .id(config.components.switch.handleSize)
            } editor: {
                TokenValueRow(label: "handleSize", value: binding(\.handleSize), range: 10...50)
            } code: {
                "config.components.switch.handleSize = \(String(format: "%.1f", config.components.switch.handleSize))"
            }
            
        case "handleSizeSM":
            TokenCard(name: "handleSizeSM", type: "number", defaultValue: "12", description: tr("token.switch.handleSizeSM"), sectionId: "component") {
               InteractiveSwitch(isOn: true, size: .small, checkedText: "开启", uncheckedText: "关闭")
                   .id(config.components.switch.handleSizeSM)
            } editor: {
                TokenValueRow(label: "handleSizeSM", value: binding(\.handleSizeSM), range: 8...40)
            } code: {
                "config.components.switch.handleSizeSM = \(String(format: "%.1f", config.components.switch.handleSizeSM))"
            }
            
        case "innerMaxMargin":
            TokenCard(name: "innerMaxMargin", type: "number", defaultValue: "24", description: tr("token.switch.innerMaxMargin"), sectionId: "component") {
               InteractiveSwitch(isOn: true, checkedText: "开启", uncheckedText: "关闭")
                   .id(config.components.switch.innerMaxMargin)
            } editor: {
                TokenValueRow(label: "innerMaxMargin", value: binding(\.innerMaxMargin), range: 10...50)
            } code: {
                "config.components.switch.innerMaxMargin = \(String(format: "%.1f", config.components.switch.innerMaxMargin))"
            }
            
        case "innerMaxMarginSM":
             TokenCard(name: "innerMaxMarginSM", type: "number", defaultValue: "18", description: tr("token.switch.innerMaxMarginSM"), sectionId: "component") {
               InteractiveSwitch(isOn: true, size: .small, checkedText: "开启", uncheckedText: "关闭")
                   .id(config.components.switch.innerMaxMarginSM)
            } editor: {
                 TokenValueRow(label: "innerMaxMarginSM", value: binding(\.innerMaxMarginSM), range: 10...50)
            } code: {
                "config.components.switch.innerMaxMarginSM = \(String(format: "%.1f", config.components.switch.innerMaxMarginSM))"
            }
        
        case "innerMinMargin":
             TokenCard(name: "innerMinMargin", type: "number", defaultValue: "9", description: tr("token.switch.innerMinMargin"), sectionId: "component") {
               InteractiveSwitch(isOn: true, checkedText: "开启", uncheckedText: "关闭")
                   .id(config.components.switch.innerMinMargin)
            } editor: {
                 TokenValueRow(label: "innerMinMargin", value: binding(\.innerMinMargin), range: 0...50)
            } code: {
                "config.components.switch.innerMinMargin = \(String(format: "%.1f", config.components.switch.innerMinMargin))"
            }

        case "innerMinMarginSM":
             TokenCard(name: "innerMinMarginSM", type: "number", defaultValue: "6", description: tr("token.switch.innerMinMarginSM"), sectionId: "component") {
               InteractiveSwitch(isOn: true, size: .small, checkedText: "开启", uncheckedText: "关闭")
                   .id(config.components.switch.innerMinMarginSM)
            } editor: {
                 TokenValueRow(label: "innerMinMarginSM", value: binding(\.innerMinMarginSM), range: 0...50)
            } code: {
                "config.components.switch.innerMinMarginSM = \(String(format: "%.1f", config.components.switch.innerMinMarginSM))"
            }
            
        case "trackHeight":
             TokenCard(name: "trackHeight", type: "number", defaultValue: "22", description: tr("token.switch.trackHeight"), sectionId: "component") {
               InteractiveSwitch(isOn: true, checkedText: "开启", uncheckedText: "关闭")
                   .id(config.components.switch.trackHeight)
            } editor: {
                 TokenValueRow(label: "trackHeight", value: binding(\.trackHeight), range: 10...50)
            } code: {
                "config.components.switch.trackHeight = \(String(format: "%.1f", config.components.switch.trackHeight))"
            }
            
        case "trackHeightSM":
             TokenCard(name: "trackHeightSM", type: "number", defaultValue: "16", description: tr("token.switch.trackHeightSM"), sectionId: "component") {
               InteractiveSwitch(isOn: true, size: .small, checkedText: "开启", uncheckedText: "关闭")
                   .id(config.components.switch.trackHeightSM)
            } editor: {
                 TokenValueRow(label: "trackHeightSM", value: binding(\.trackHeightSM), range: 10...50)
            } code: {
                "config.components.switch.trackHeightSM = \(String(format: "%.1f", config.components.switch.trackHeightSM))"
            }
            
        case "trackMinWidth":
             TokenCard(name: "trackMinWidth", type: "number", defaultValue: "44", description: tr("token.switch.trackMinWidth"), sectionId: "component") {
               InteractiveSwitch(isOn: true, checkedText: "开启", uncheckedText: "关闭")
                   .id(config.components.switch.trackMinWidth)
            } editor: {
                 TokenValueRow(label: "trackMinWidth", value: binding(\.trackMinWidth), range: 20...100)
            } code: {
                "config.components.switch.trackMinWidth = \(String(format: "%.1f", config.components.switch.trackMinWidth))"
            }
            
        case "trackMinWidthSM":
             TokenCard(name: "trackMinWidthSM", type: "number", defaultValue: "28", description: tr("token.switch.trackMinWidthSM"), sectionId: "component") {
               InteractiveSwitch(isOn: true, size: .small, checkedText: "开启", uncheckedText: "关闭")
                   .id(config.components.switch.trackMinWidthSM)
            } editor: {
                 TokenValueRow(label: "trackMinWidthSM", value: binding(\.trackMinWidthSM), range: 20...100)
            } code: {
                "config.components.switch.trackMinWidthSM = \(String(format: "%.1f", config.components.switch.trackMinWidthSM))"
            }
            
        case "trackPadding":
             TokenCard(name: "trackPadding", type: "number", defaultValue: "2", description: tr("token.switch.trackPadding"), sectionId: "component") {
               InteractiveSwitch(isOn: true, checkedText: "开启", uncheckedText: "关闭")
                   .id(config.components.switch.trackPadding)
            } editor: {
                 TokenValueRow(label: "trackPadding", value: binding(\.trackPadding), range: 0...10, step: 0.5)
            } code: {
                "config.components.switch.trackPadding = \(String(format: "%.1f", config.components.switch.trackPadding))"
            }

        // MARK: - Global Tokens
        
        case "colorPrimary":
            TokenCard(name: "colorPrimary", type: "Color", defaultValue: "#1677ff", description: tr("token.switch.colorPrimary"), sectionId: "global") {
                InteractiveSwitch(isOn: true, checkedText: "开启", uncheckedText: "关闭")
                    .id(config.seed.colorPrimary)
            } editor: {
                ColorPresetRow(label: "seed.colorPrimary", color: $config.seed.colorPrimary, onChange: { config.regenerateTokens() })
            } code: {
                "config.seed.colorPrimary = \(config.seed.colorPrimary)"
            }
            
        case "colorTextQuaternary":
             TokenCard(name: "colorTextQuaternary", type: "Color", defaultValue: "rgba(0,0,0,0.25)", description: tr("token.switch.colorTextQuaternary"), sectionId: "global") {
                InteractiveSwitch(isOn: false, checkedText: "开启", uncheckedText: "关闭")
                    .id(token.colorTextQuaternary)
            } editor: {
                 ColorPresetRow(label: "token.colorTextQuaternary", color: Binding(
                    get: { config.token.colorTextQuaternary },
                    set: {
                        config.token.colorTextQuaternary = $0
                        config.regenerateTokens()
                    }
                 ))
            } code: {
                "config.token.colorTextQuaternary = \(config.token.colorTextQuaternary)"
            }
            
        case "colorTextTertiary":
             TokenCard(name: "colorTextTertiary", type: "Color", defaultValue: "rgba(0,0,0,0.45)", description: tr("token.switch.colorTextTertiary"), sectionId: "global") {
                InteractiveSwitch(isOn: true, checkedText: "Hover Me", uncheckedText: "Hover Me") // Hover state uses this for bg
                     .id(token.colorTextTertiary)
            } editor: {
                 ColorPresetRow(label: "token.colorTextTertiary", color: Binding(
                    get: { config.token.colorTextTertiary },
                    set: {
                        config.token.colorTextTertiary = $0
                        config.regenerateTokens()
                    }
                 ))
            } code: {
                "config.token.colorTextTertiary = \(config.token.colorTextTertiary)"
            }
            
        case "opacityLoading":
             TokenCard(name: "opacityLoading", type: "number", defaultValue: "0.65", description: tr("token.switch.opacityLoading"), sectionId: "global") {
                InteractiveSwitch(isOn: true, loading: true, checkedText: "Loading", uncheckedText: "Loading")
                     .id(config.components.switch.opacityLoading)
            } editor: {
                 TokenValueRow(label: "opacityLoading", value: binding(\.opacityLoading), range: 0...1, step: 0.05)
            } code: {
                "config.components.switch.opacityLoading = \(String(format: "%.2f", config.components.switch.opacityLoading))"
            }
        
        case "motionDurationMid":
             TokenCard(name: "motionDurationMid", type: "string", defaultValue: "0.2s", description: tr("token.switch.motionDurationMid"), sectionId: "global") {
                InteractiveSwitch(isOn: true, checkedText: "Click Me", uncheckedText: "Click Me")
                     .id(config.components.switch.motionDuration)
            } editor: {
                TokenValueRow(label: "motionDuration (sec)", value: Binding(
                    get: { CGFloat(config.components.`switch`.motionDuration) },
                    set: { config.components.`switch`.motionDuration = TimeInterval($0) }
                ), range: 0.1...2.0, step: 0.1)
            } code: {
                "config.components.switch.motionDuration = \(String(format: "%.2f", config.components.switch.motionDuration))"
            }
            
        default: EmptyView()
        }
    }
    
    private func binding<T>(_ keyPath: WritableKeyPath<Moin.SwitchToken, T>) -> Binding<T> {
        Binding(
            get: { config.components.`switch`[keyPath: keyPath] },
            set: { config.components.`switch`[keyPath: keyPath] = $0 }
        )
    }
}

private struct InteractiveSwitch: View {
    @State var isOn: Bool
    var loading: Bool
    var isDisabled: Bool
    var size: ControlSize
    var checkedText: String?
    var uncheckedText: String?
    
    init(isOn: Bool = true, loading: Bool = false, isDisabled: Bool = false, size: ControlSize = .regular, checkedText: String? = nil, uncheckedText: String? = nil) {
        self._isOn = State(initialValue: isOn)
        self.loading = loading
        self.isDisabled = isDisabled
        self.size = size
        self.checkedText = checkedText
        self.uncheckedText = uncheckedText
    }
    
    var body: some View {
        if let checked = checkedText, let unchecked = uncheckedText {
            Moin.Switch(isOn: $isOn, loading: loading, isDisabled: isDisabled, size: size, checkedText: checked, uncheckedText: unchecked)
        } else {
            Moin.Switch(isOn: $isOn, loading: loading, isDisabled: isDisabled, size: size)
        }
    }
}
