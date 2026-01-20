import SwiftUI
import MoinUI

// MARK: - DividerAPIView

struct DividerAPIView: View {
    @Localized var tr
    
    // MARK: - API Sections
    
    private var apiSections: [DocSidebarSection] {
        [
            DocSidebarSection(
                title: "Moin.Divider",
                items: ["orientation", "variant", "titlePlacement", "plain", "title", "content"],
                sectionId: "divider"
            )
        ]
    }
    
    var body: some View {
        ComponentDocBody(
            sections: apiSections,
            initialItemId: "divider"
        ) { sectionId in
            if sectionId == "divider" {
                Text("Moin.Divider").font(.title3).fontWeight(.semibold)
            }
        } item: { item in
            cardForItem(item)
        }
    }
    
    @ViewBuilder
    private func cardForItem(_ item: String) -> some View {
        switch item {
        case "orientation": orientationPropertyCard
        case "variant": variantPropertyCard
        case "titlePlacement": titlePlacementPropertyCard
        case "plain": plainPropertyCard
        case "title": titlePropertyCard
        case "content": contentPropertyCard
        default: EmptyView()
        }
    }
    
    // MARK: - Property Cards
    
    private var orientationPropertyCard: some View {
        PropertyCard(
            name: "orientation",
            type: "DividerOrientation",
            defaultValue: ".horizontal",
            description: tr("api.divider.orientation"),
            enumValues: ".horizontal | .vertical",
            sectionId: "divider"
        ) {
            HStack(spacing: 20) {
                // Horizontal
                VStack {
                    Text("H")
                    Moin.Divider()
                    Text("H")
                }.frame(width: 50)
                
                // Vertical
                HStack {
                    Text("V")
                    Moin.Divider(orientation: .vertical).frame(height: 40)
                    Text("V")
                }
            }
        } code: {
            """
            Moin.Divider() // .horizontal
            Moin.Divider(orientation: .vertical)
            """
        }
        .scrollAnchor("divider.orientation")
    }
    
    private var variantPropertyCard: some View {
        PropertyCard(
            name: "variant",
            type: "DividerVariant",
            defaultValue: ".solid",
            description: tr("api.divider.variant"),
            enumValues: ".solid | .dashed | .dotted",
            sectionId: "divider"
        ) {
            VStack(spacing: 12) {
                Moin.Divider(variant: .solid)
                Moin.Divider(variant: .dashed)
                Moin.Divider(variant: .dotted)
            }
            .frame(width: 150)
        } code: {
            """
            Moin.Divider(variant: .solid)
            Moin.Divider(variant: .dashed)
            Moin.Divider(variant: .dotted)
            """
        }
        .scrollAnchor("divider.variant")
    }
    
    private var titlePlacementPropertyCard: some View {
        PropertyCard(
            name: "titlePlacement",
            type: "DividerTitlePlacement",
            defaultValue: ".center",
            description: tr("api.divider.title_placement"),
            enumValues: ".left | .center | .right",
            sectionId: "divider"
        ) {
            VStack(spacing: 12) {
                Moin.Divider("L", titlePlacement: .left)
                Moin.Divider("C", titlePlacement: .center)
                Moin.Divider("R", titlePlacement: .right)
            }
            .frame(width: 200)
        } code: {
            """
            Moin.Divider("Text", titlePlacement: .left)
            Moin.Divider("Text", titlePlacement: .center)
            Moin.Divider("Text", titlePlacement: .right)
            """
        }
        .scrollAnchor("divider.titlePlacement")
    }
    
    private var plainPropertyCard: some View {
        PropertyCard(
            name: "plain",
            type: "Bool",
            defaultValue: "false",
            description: tr("api.divider.plain"),
            sectionId: "divider"
        ) {
            VStack {
                Moin.Divider("Bold (Default)")
                Moin.Divider("Plain (Normal Weight)", plain: true)
            }
            .frame(width: 200)
        } code: {
            """
            Moin.Divider("Text")
            Moin.Divider("Text", plain: true)
            """
        }
        .scrollAnchor("divider.plain")
    }
    
    private var titlePropertyCard: some View {
        PropertyCard(
            name: "title",
            type: "String?",
            defaultValue: "nil",
            description: tr("api.divider.title"),
            sectionId: "divider"
        ) {
            Moin.Divider("Title String")
        } code: {
            "Moin.Divider(\"Title String\")"
        }
        .scrollAnchor("divider.title")
    }
    
    private var contentPropertyCard: some View {
        PropertyCard(
            name: "content",
            type: "@ViewBuilder",
            defaultValue: "nil",
            description: tr("api.divider.content"),
            sectionId: "divider"
        ) {
            Moin.Divider {
                 Image(systemName: "scissors")
            }
        } code: {
            """
            Moin.Divider {
                Image(systemName: "scissors")
            }
            """
        }
        .scrollAnchor("divider.content")
    }
}
