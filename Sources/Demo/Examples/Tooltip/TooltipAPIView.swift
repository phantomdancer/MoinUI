import SwiftUI
import MoinUI

struct TooltipAPIView: View {
    @Localized var tr

    // MARK: - State Variables

    @State private var open = false

    private var apiSections: [DocSidebarSection] {
        [
            DocSidebarSection(
                title: tr("component.tooltip"),
                items: [
                    .init(id: "title"),
                    .init(id: "placement"),
                    .init(id: "arrow"),
                    .init(id: "color"),
                    .init(id: "trigger"),
                    .init(id: "open")
                ],
                sectionId: "tooltip"
            )
        ]
    }

    var body: some View {
        ComponentDocBody(
            sections: apiSections,
            initialItemId: "tooltip"
        ) { sectionId in
            if sectionId == "tooltip" {
                Text(tr("component.tooltip")).font(.title3).fontWeight(.semibold)
            }
        } item: { item in
            cardForItem(item)
        }
    }

    @ViewBuilder
    private func cardForItem(_ item: String) -> some View {
        switch item {
        case "title": titlePropertyCard
        case "placement": placementPropertyCard
        case "arrow": arrowPropertyCard
        case "color": colorPropertyCard
        case "trigger": triggerPropertyCard
        case "open": openPropertyCard
        default: EmptyView()
        }
    }

    @State private var titleDisabled = false
    
    private var titlePropertyCard: some View {
        PropertyCard(
            name: "title",
            type: "String | String? | View",
            defaultValue: "-",
            description: tr("tooltip.api_title_desc"),
            sectionId: "tooltip"
        ) {
            VStack(alignment: .leading, spacing: 16) {
                // 基础用法
                Moin.Tooltip(tr("tooltip.prompt_text")) {
                    Moin.Button("Hover me") {}
                }
                
                // 可选用法：nil 或 "" 时禁用
                HStack(spacing: 12) {
                    Moin.Tooltip(optional: titleDisabled ? nil : tr("tooltip.prompt_text")) {
                        Moin.Button(titleDisabled ? tr("tooltip.enable") : tr("tooltip.disable")) {
                            titleDisabled.toggle()
                        }
                    }
                    Text(tr("tooltip.disabled_tip"))
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
        } code: {
            """
            // \(tr("tooltip.basic"))
            Moin.Tooltip("\(tr("tooltip.prompt_text"))") {
                Moin.Button("Hover me") {}
            }
            
            // \(tr("tooltip.disabled_tip"))
            @State private var disabled = \(titleDisabled)
            Moin.Tooltip(optional: disabled ? nil : "prompt text") {
                Moin.Button(disabled ? "Enable" : "Disable") {
                    disabled.toggle()
                }
            }
            """
        }
        .scrollAnchor("tooltip.title")
    }

    // MARK: - placement

    private var placementPropertyCard: some View {
        PropertyCard(
            name: "placement",
            type: "Placement",
            defaultValue: ".top",
            description: tr("tooltip.api_placement_desc"),
            enumValues: ".top | .topLeft | .topRight | .bottom | .bottomLeft | .bottomRight | .left | .leftTop | .leftBottom | .right | .rightTop | .rightBottom",
            sectionId: "tooltip"
        ) {
            HStack(spacing: 16) {
                Moin.Tooltip("Top", placement: .top) {
                    Moin.Button("Top") {}
                }
                Moin.Tooltip("Bottom", placement: .bottom) {
                    Moin.Button("Bottom") {}
                }
                Moin.Tooltip("Left", placement: .left) {
                    Moin.Button("Left") {}
                }
                Moin.Tooltip("Right", placement: .right) {
                    Moin.Button("Right") {}
                }
            }
        } code: {
            """
            Moin.Tooltip("Top", placement: .top) {
                Moin.Button("Top") {}
            }
            """
        }
        .scrollAnchor("tooltip.placement")
    }

    // MARK: - arrow

    // MARK: - arrow
    
    @State private var arrowState: String = "Show"
    
    private var arrowConfig: _TooltipArrowConfig {
        switch arrowState {
        case "Show": return .true
        case "Hide": return .false
        case "Center": return .center
        default: return .true
        }
    }

    private var arrowPropertyCard: some View {
        PropertyCard(
            name: "arrow",
            type: "Bool | ArrowConfig",
            defaultValue: "true",
            description: tr("tooltip.api_arrow_desc"),
            enumValues: "true | false | .center",
            sectionId: "tooltip"
        ) {
            VStack(spacing: 20) {
                Picker("", selection: $arrowState) {
                    Text("Show").tag("Show")
                    Text("Hide").tag("Hide")
                    Text("Center").tag("Center")
                }
                .pickerStyle(.segmented)
                .frame(maxWidth: 300)
                
                HStack(spacing: 16) {
                    Moin.Tooltip("Top Left", placement: .topLeft, arrow: arrowConfig) {
                        Moin.Button("TL") {}
                    }
                    Moin.Tooltip("Top Center", placement: .top, arrow: arrowConfig) {
                        Moin.Button("Top") {}
                    }
                    Moin.Tooltip("Top Right", placement: .topRight, arrow: arrowConfig) {
                        Moin.Button("TR") {}
                    }
                }
            }
        } code: {
            """
            // dynamic arrow config
            let arrowConfig: _TooltipArrowConfig = \(arrowState == "Center" ? ".center" : (arrowState == "Show" ? ".true" : ".false"))
            
            Moin.Tooltip("Top Left", placement: .topLeft, arrow: arrowConfig) {
                Moin.Button("TL") {}
            }
            """
        }
        .scrollAnchor("tooltip.arrow")
    }

    // MARK: - color

    private var colorPropertyCard: some View {
        PropertyCard(
            name: "color",
            type: "Color?",
            defaultValue: "nil",
            description: tr("tooltip.api_color_desc"),
            sectionId: "tooltip"
        ) {
            HStack(spacing: 16) {
                Moin.Tooltip("Pink", color: .pink) {
                    Moin.Button("Pink") {}
                }
                Moin.Tooltip("Blue", color: .blue) {
                    Moin.Button("Blue") {}
                }
            }
        } code: {
            """
            Moin.Tooltip("Pink", color: .pink) {
                Moin.Button("Pink") {}
            }
            """
        }
        .scrollAnchor("tooltip.color")
    }

    // MARK: - trigger

    private var triggerPropertyCard: some View {
        PropertyCard(
            name: "trigger",
            type: "Trigger",
            defaultValue: ".hover",
            description: tr("tooltip.api_trigger_desc"),
            enumValues: ".hover | .click",
            sectionId: "tooltip"
        ) {
            HStack(spacing: 16) {
                Moin.Tooltip("Hover", trigger: .hover) {
                    Moin.Button("Hover") {}
                }
                
                // Debugging Click Trigger
                Moin.Tooltip("Click", trigger: .click) {
                    Moin.Button("Click Debug") {}
                }
            }
        } code: {
            """
            Moin.Tooltip("Hover", trigger: .hover) { ... }
            Moin.Tooltip("Click", trigger: .click) { ... }
            """
        }
        .scrollAnchor("tooltip.trigger")
    }

    // MARK: - open

    private var openPropertyCard: some View {
        PropertyCard(
            name: "open",
            type: "Binding<Bool>?",
            defaultValue: "nil",
            description: tr("tooltip.api_open_desc"),
            sectionId: "tooltip"
        ) {
            HStack(spacing: 16) {
                Moin.Tooltip("Controlled", open: $open) {
                    Moin.Button("Target") {}
                }
                
                Toggle("Show Tooltip", isOn: $open)
            }
        } code: {
            """
            @State private var open = false
            
            Moin.Tooltip("Controlled", open: $open) {
                Moin.Button("Target") {}
            }
            
            Toggle("Show Tooltip", isOn: $open)
            """
        }
        .scrollAnchor("tooltip.open")
    }
}
