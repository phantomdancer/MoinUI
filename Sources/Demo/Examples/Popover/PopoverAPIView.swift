import SwiftUI
import MoinUI

struct PopoverAPIView: View {
    @Localized var tr
    @State private var open = false

    private var apiSections: [DocSidebarSection] {
        [
            DocSidebarSection(
                title: tr("component.popover"),
                items: [
                    .init(id: "title"),
                    .init(id: "content"),
                    .init(id: "placement"),
                    .init(id: "arrow"),
                    .init(id: "trigger"),
                    .init(id: "open")
                ],
                sectionId: "popover"
            )
        ]
    }

    var body: some View {
        ComponentDocBody(
            sections: apiSections,
            initialItemId: "popover"
        ) { sectionId in
            if sectionId == "popover" {
                Text(tr("component.popover")).font(.title3).fontWeight(.semibold)
            }
        } item: { item in
            cardForItem(item)
        }
    }

    @ViewBuilder
    private func cardForItem(_ item: String) -> some View {
        switch item {
        case "title": titlePropertyCard
        case "content": contentPropertyCard
        case "placement": placementPropertyCard
        case "arrow": arrowPropertyCard
        case "trigger": triggerPropertyCard
        case "open": openPropertyCard
        default: EmptyView()
        }
    }

    // MARK: - title

    private var titlePropertyCard: some View {
        PropertyCard(
            name: "title",
            type: "String | View",
            defaultValue: "-",
            description: tr("popover.api_title_desc"),
            sectionId: "popover"
        ) {
            Moin.Popover("Title", content: {
                Moin.Button("Hover me") {}
            }, popoverContent: {
                Text("Content")
            })
        } code: {
            """
            Moin.Popover("Title", content: {
                Moin.Button("Hover me") {}
            }, popoverContent: {
                Text("Content")
            })
            """
        }
        .scrollAnchor("popover.title")
    }

    // MARK: - content

    private var contentPropertyCard: some View {
        PropertyCard(
            name: "content",
            type: "View",
            defaultValue: "-",
            description: tr("popover.api_content_desc"),
            sectionId: "popover"
        ) {
            Moin.Popover("Title", content: {
                Moin.Button("Hover me") {}
            }, popoverContent: {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Content line 1")
                    Text("Content line 2")
                }
            })
        } code: {
            """
            Moin.Popover("Title", content: {
                Moin.Button("Hover me") {}
            }, popoverContent: {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Content line 1")
                    Text("Content line 2")
                }
            })
            """
        }
        .scrollAnchor("popover.content")
    }

    // MARK: - placement

    private var placementPropertyCard: some View {
        PropertyCard(
            name: "placement",
            type: "Placement",
            defaultValue: ".top",
            description: tr("popover.api_placement_desc"),
            enumValues: ".top | .topLeft | .topRight | .bottom | .bottomLeft | .bottomRight | .left | .leftTop | .leftBottom | .right | .rightTop | .rightBottom",
            sectionId: "popover"
        ) {
            HStack(spacing: 16) {
                Moin.Popover("Title", content: {
                    Moin.Button("Top") {}
                }, popoverContent: { Text("Content") }, placement: .top)
                
                Moin.Popover("Title", content: {
                    Moin.Button("Right") {}
                }, popoverContent: { Text("Content") }, placement: .right)
            }
        } code: {
            """
            Moin.Popover("Title", content: {
                Moin.Button("Top") {}
            }, popoverContent: { Text("Content") }, placement: .top)
            """
        }
        .scrollAnchor("popover.placement")
    }

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
            description: tr("popover.api_arrow_desc"),
            enumValues: "true | false | .center",
            sectionId: "popover"
        ) {
            VStack(spacing: 16) {
                Picker("", selection: $arrowState) {
                    Text("Show").tag("Show")
                    Text("Hide").tag("Hide")
                    Text("Center").tag("Center")
                }
                .pickerStyle(.segmented)
                .frame(maxWidth: 240)
                
                Moin.Popover("Title", content: {
                    Moin.Button("TL") {}
                }, popoverContent: { Text("Content") }, placement: .topLeft, arrow: arrowConfig)
            }
        } code: {
            """
            Moin.Popover("Title", content: {
                Moin.Button("TL") {}
            }, popoverContent: { Text("Content") }, placement: .topLeft, arrow: \(arrowState == "Center" ? ".center" : (arrowState == "Show" ? ".true" : ".false")))
            """
        }
        .scrollAnchor("popover.arrow")
    }

    // MARK: - trigger

    private var triggerPropertyCard: some View {
        PropertyCard(
            name: "trigger",
            type: "Trigger",
            defaultValue: ".hover",
            description: tr("popover.api_trigger_desc"),
            enumValues: ".hover | .click",
            sectionId: "popover"
        ) {
            HStack(spacing: 16) {
                Moin.Popover("Title", content: {
                    Moin.Button("Hover") {}
                }, popoverContent: { Text("Content") }, trigger: .hover)
                
                Moin.Popover("Title", content: {
                    Moin.Button("Click") {}
                }, popoverContent: { Text("Content") }, trigger: .click)
            }
        } code: {
            """
            Moin.Popover("Title", content: {
                Moin.Button("Hover") {}
            }, popoverContent: { Text("Content") }, trigger: .hover)
            """
        }
        .scrollAnchor("popover.trigger")
    }

    // MARK: - open

    private var openPropertyCard: some View {
        PropertyCard(
            name: "open",
            type: "Binding<Bool>?",
            defaultValue: "nil",
            description: tr("popover.api_open_desc"),
            sectionId: "popover"
        ) {
            HStack(spacing: 16) {
                Moin.Popover("Title", content: {
                    Moin.Button("Target") {}
                }, popoverContent: {
                    VStack {
                        Text("Content")
                        Button("Close") { open = false }
                    }
                }, trigger: .click, open: $open)
                
                Toggle("Show Popover", isOn: $open)
            }
        } code: {
            """
            @State private var open = false
            
            Moin.Popover("Title", content: {
                Moin.Button("Target") {}
            }, popoverContent: {
                VStack {
                    Text("Content")
                    Button("Close") { open = false }
                }
            }, trigger: .click, open: $open)
            """
        }
        .scrollAnchor("popover.open")
    }
}
