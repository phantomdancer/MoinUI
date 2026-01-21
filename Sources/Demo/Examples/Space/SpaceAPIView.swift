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
            SpaceSizeDemoView()
        } code: {
            """
            Moin.Space(size: .small) { ... }
            Moin.Space(size: .medium) { ... }
            Moin.Space(size: .large) { ... }
            Moin.Space(size: 24) { ... }
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
            SpaceDirectionDemoView()
        } code: {
            """
            // Horizontal
            Moin.Space(direction: .horizontal) { ... }
            
            // Vertical
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
            SpaceAlignmentDemoView()
        } code: {
            """
            // \(tr("space.horizontal"))
            Moin.Space(alignment: .start) { ... }
            Moin.Space(alignment: .center) { ... }
            Moin.Space(alignment: .end) { ... }
            
            // \(tr("space.vertical"))
            Moin.Space(direction: .vertical, alignment: .start) { ... }
            Moin.Space(direction: .vertical, alignment: .center) { ... }
            Moin.Space(direction: .vertical, alignment: .end) { ... }
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
            SpaceWrapDemoView()
        } code: {
            """
            Moin.Space(wrap: true) {
                ForEach(1...10, id: \\.self) { i in
                    Moin.Button("\\(i)") {}
                }
            }
            """
        }
        .scrollAnchor("space.wrap")
    }
    
    private var separatorPropertyCard: some View {
         PropertyCard(
             name: "separator",
             type: "() -> View",
             defaultValue: "nil",
             description: tr("api.space.separator"),
             sectionId: "space"
         ) {
             SpaceSeparatorDemoView()
         } code: {
             """
             // \(tr("space.horizontal"))
             Moin.Space(size: .small, separator: { Moin.Divider(orientation: .vertical) }) { ... }

             // \(tr("space.vertical"))
             Moin.Space(direction: .vertical, separator: { Moin.Divider() }) { ... }

             // \(tr("space.custom_separator"))
             Moin.Space(separator: { Text("|").foregroundStyle(.secondary) }) { ... }

             // \(tr("space.icon_separator"))
             Moin.Space(separator: {
                 Image(systemName: "star.fill")
                     .font(.system(size: 8))
                     .foregroundStyle(.orange)
             }) { ... }
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
                Moin.Button("Item 1") {}
                Moin.Button("Item 2") {}
                Moin.Button("Item 3") {}
            }
        } code: {
            """
            Moin.Space {
                Moin.Button("Item 1") {}
                Moin.Button("Item 2") {}
                Moin.Button("Item 3") {}
            }
            """
        }
        .scrollAnchor("space.content")
    }

}
