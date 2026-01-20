import SwiftUI
import MoinUI

// MARK: - SpaceAPIView

struct SpaceAPIView: View {
    @Localized var tr
    
    // MARK: - API Sections
    
    private var apiSections: [DocSidebarSection] {
        [
            DocSidebarSection(
                title: "Moin.Space",
                items: ["size", "direction", "alignment", "wrap", "separator", "content"],
                sectionId: "space"
            )
        ]
    }
    
    var body: some View {
        ComponentDocBody(
            sections: apiSections,
            initialItemId: "space"
        ) { sectionId in
            if sectionId == "space" {
                Text("Moin.Space").font(.title3).fontWeight(.semibold)
            }
        } item: { item in
            cardForItem(item)
        }
    }
    
    @ViewBuilder
    private func cardForItem(_ item: String) -> some View {
        switch item {
        case "size": sizePropertyCard
        case "direction": directionPropertyCard
        case "alignment": alignmentPropertyCard
        case "wrap": wrapPropertyCard
        case "separator": separatorPropertyCard
        case "content": contentPropertyCard
        default: EmptyView()
        }
    }
    
    // MARK: - Property Cards
    
    private var sizePropertyCard: some View {
        PropertyCard(
            name: "size",
            type: "SpaceSize",
            defaultValue: ".medium",
            description: tr("api.space.size"),
            enumValues: ".small | .medium | .large | CGFloat",
            sectionId: "space"
        ) {
            VStack {
                 Moin.Space(size: .small) {
                    Text("S")
                    Text("S")
                }
                 Moin.Space(size: .large) {
                    Text("L")
                    Text("L")
                }
            }
        } code: {
            """
            Moin.Space(size: .small) { ... }
            Moin.Space(size: .large) { ... }
            Moin.Space(size: 20) { ... }
            """
        }
        .scrollAnchor("space.size")
    }
    
    private var directionPropertyCard: some View {
        PropertyCard(
            name: "direction",
            type: "SpaceDirection",
            defaultValue: ".horizontal",
            description: tr("api.space.direction"),
            enumValues: ".horizontal | .vertical",
            sectionId: "space"
        ) {
            HStack(spacing: 20) {
                 Moin.Space(direction: .horizontal) {
                    Text("H")
                    Text("H")
                }
                 Moin.Space(direction: .vertical) {
                    Text("V")
                    Text("V")
                }
            }
        } code: {
            """
            Moin.Space(direction: .horizontal) { ... }
            Moin.Space(direction: .vertical) { ... }
            """
        }
        .scrollAnchor("space.direction")
    }
    
    private var alignmentPropertyCard: some View {
        PropertyCard(
            name: "alignment",
            type: "SpaceAlignment",
            defaultValue: ".center",
            description: tr("api.space.alignment"),
            enumValues: ".start | .center | .end",
            sectionId: "space"
        ) {
            VStack(alignment: .leading, spacing: 10) {
                Moin.Space(alignment: .start) {
                    Text("Start")
                    Rectangle().frame(width: 10, height: 20)
                }
                Moin.Space(alignment: .center) {
                    Text("Center")
                    Rectangle().frame(width: 10, height: 20)
                }
            }
        } code: {
            """
            Moin.Space(alignment: .start) { ... }
            Moin.Space(alignment: .center) { ... }
            """
        }
        .scrollAnchor("space.alignment")
    }
    
    private var wrapPropertyCard: some View {
        PropertyCard(
            name: "wrap",
            type: "Bool",
            defaultValue: "false",
            description: tr("api.space.wrap"),
            sectionId: "space"
        ) {
            Moin.Space(wrap: true) {               
                    Text("1")
                    Text("2")
            }
        } code: {
            "Moin.Space(wrap: true) { ... }"
        }
        .scrollAnchor("space.wrap")
    }
    
    private var separatorPropertyCard: some View {
         PropertyCard(
             name: "separator",
             type: "() -> View",
             defaultValue: "nil",
             description: tr("api.space.separator"), // Check if this key exists or if I need to add/guess. Old file used existing texts but didn't show this prop explicitly in APITable? 
             // Logic check: Old APITable didn't include "separator". But Example had it. 
             // I should add it.
             sectionId: "space"
         ) {
             Moin.Space(separator: { Text("|") }) {
                 Text("A")
                 Text("B")
             }
         } code: {
             """
             Moin.Space(separator: { Text("|") }) {
                 Text("A")
                 Text("B")
             }
             """
         }
         .scrollAnchor("space.separator")
     }
    
    private var contentPropertyCard: some View {
        PropertyCard(
            name: "content",
            type: "@ViewBuilder",
            defaultValue: "nil",
            description: tr("api.space.content"),
            sectionId: "space"
        ) {
            Moin.Space {
                Text("Item")
            }
        } code: {
            "Moin.Space { ... }"
        }
        .scrollAnchor("space.content")
    }
}
