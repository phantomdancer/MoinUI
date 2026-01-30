import SwiftUI
import MoinUI

struct TooltipAPIView: View {
    @Localized var tr

    // MARK: - State Variables

    @State private var isOpen = false

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
                    .init(id: "isOpen")
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
        case "isOpen": isOpenPropertyCard
        default: EmptyView()
        }
    }

    // MARK: - title

    private var titlePropertyCard: some View {
        PropertyCard(
            name: "title",
            type: "String | View",
            defaultValue: "-",
            description: tr("tooltip.api_title_desc"),
            sectionId: "tooltip"
        ) {
            Moin.Tooltip(tr("tooltip.prompt_text")) {
                Moin.Button("Hover me") {}
            }
        } code: {
            """
            Moin.Tooltip("\\(tr("tooltip.prompt_text"))") {
                Moin.Button("Hover me") {}
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

    private var arrowPropertyCard: some View {
        PropertyCard(
            name: "arrow",
            type: "Bool",
            defaultValue: "true",
            description: tr("tooltip.api_arrow_desc"),
            sectionId: "tooltip"
        ) {
            HStack(spacing: 16) {
                Moin.Tooltip(tr("tooltip.with_arrow"), arrow: true) {
                    Moin.Button(tr("tooltip.with_arrow")) {}
                }
                Moin.Tooltip(tr("tooltip.no_arrow"), arrow: false) {
                    Moin.Button(tr("tooltip.no_arrow")) {}
                }
            }
        } code: {
            """
            Moin.Tooltip("\\(tr("tooltip.with_arrow"))", arrow: true) { ... }
            Moin.Tooltip("\\(tr("tooltip.no_arrow"))", arrow: false) { ... }
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
                Moin.Tooltip("Click", trigger: .click) {
                    Moin.Button("Click") {}
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

    // MARK: - isOpen

    private var isOpenPropertyCard: some View {
        PropertyCard(
            name: "isOpen",
            type: "Binding<Bool>?",
            defaultValue: "nil",
            description: tr("tooltip.api_isOpen_desc"),
            sectionId: "tooltip"
        ) {
            HStack(spacing: 16) {
                Moin.Tooltip("Controlled", isOpen: $isOpen) {
                    Moin.Button("Target") {}
                }
                
                Toggle("Show Tooltip", isOn: $isOpen)
            }
        } code: {
            """
            @State private var isOpen = false
            
            Moin.Tooltip("Controlled", isOpen: $isOpen) {
                Moin.Button("Target") {}
            }
            
            Toggle("Show Tooltip", isOn: $isOpen)
            """
        }
        .scrollAnchor("tooltip.isOpen")
    }
}
