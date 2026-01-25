import SwiftUI
import MoinUI

// MARK: - BadgeAPIView

struct BadgeAPIView: View {
    @Localized var tr
    @ObservedObject var config = Moin.ConfigProvider.shared
    
    // MARK: - API Sections
    
    private var apiSections: [DocSidebarSection] {
        [
            DocSidebarSection(
                title: tr("api.badge.section.badge"),
                items: [.init(id: "count"), .init(id: "dot"), .init(id: "showZero"), .init(id: "overflowCount"), .init(id: "size"), .init(id: "color"), .init(id: "offset"), .init(id: "status"), .init(id: "text"), .init(id: "content")],
                sectionId: "badge"
            ),
            DocSidebarSection(
                title: tr("api.badge.section.ribbon"),
                items: [
                    DocSidebarItem(id: "ribbonText", displayName: "text"),
                    DocSidebarItem(id: "ribbonColor", displayName: "color"),
                    DocSidebarItem(id: "ribbonPlacement", displayName: "placement"),
                    DocSidebarItem(id: "ribbonContent", displayName: "content")
                ],
                sectionId: "ribbon"
            )
        ]
    }
    
    var body: some View {
        ComponentDocBody(
            sections: apiSections,
            initialItemId: "badge"
        ) { sectionId in
            if sectionId == "badge" {
                Text("Moin.Badge").font(.title3).fontWeight(.semibold)
            } else if sectionId == "ribbon" {
                Text("Moin.BadgeRibbon").font(.title3).fontWeight(.semibold)
            }
        } item: { item in
            cardForItem(item)
        }
    }
    
    // MARK: - Item -> Card Mapping
    
    @ViewBuilder
    private func cardForItem(_ item: String) -> some View {
        switch item {
        case "count": countPropertyCard
        case "dot": dotPropertyCard
        case "showZero": showZeroPropertyCard
        case "overflowCount": overflowCountPropertyCard
        case "size": sizePropertyCard
        case "color": colorPropertyCard
        case "offset": offsetPropertyCard
        case "content": contentPropertyCard
        
        case "ribbonText": ribbonTextPropertyCard
        case "ribbonColor": ribbonColorPropertyCard
        case "ribbonPlacement": ribbonPlacementPropertyCard
        case "ribbonContent": ribbonContentPropertyCard
        
        case "status": statusPropertyCard
        case "text": textPropertyCard
        default: EmptyView()
        }
    }
    
    // MARK: - Badge Properties
    
    private var countPropertyCard: some View {
        PropertyCard(
            name: "count",
            type: "Int?",
            defaultValue: "nil",
            description: tr("badge.api.count"),
            sectionId: "badge"
        ) {
            Moin.Badge(count: 5) { sampleBox }
        } code: {
            """
            Moin.Badge(count: 5) {...}
            """
        }
        .scrollAnchor("badge.count")
    }
    
    private var dotPropertyCard: some View {
        PropertyCard(
            name: "dot",
            type: "Bool",
            defaultValue: "false",
            description: tr("badge.api.dot"),
            sectionId: "badge"
        ) {
            Moin.Badge(dot: true) { sampleBox }
        } code: {
            """
            Moin.Badge(dot: true) {...}
            """
        }
        .scrollAnchor("badge.dot")
    }
    
    private var showZeroPropertyCard: some View {
        PropertyCard(
            name: "showZero",
            type: "Bool",
            defaultValue: "false",
            description: tr("badge.api.showZero"),
            sectionId: "badge"
        ) {
            Moin.Badge(count: 0, showZero: true) { sampleBox }
        } code: {
            """
            Moin.Badge(count: 0, showZero: true) {...}
            """
        }
        .scrollAnchor("badge.showZero")
    }
    
    private var overflowCountPropertyCard: some View {
        PropertyCard(
            name: "overflowCount",
            type: "Int",
            defaultValue: "99",
            description: tr("badge.api.overflowCount"),
            sectionId: "badge"
        ) {
            Moin.Badge(count: 1000, overflowCount: 999) { sampleBox }
        } code: {
            """
            Moin.Badge(count: 1000, overflowCount: 999) {...}
            """
        }
        .scrollAnchor("badge.overflowCount")
    }
    
    private var sizePropertyCard: some View {
        PropertyCard(
            name: "size",
            type: "BadgeSize",
            defaultValue: ".default",
            description: tr("badge.api.size"),
            enumValues: ".default | .small",
            sectionId: "badge"
        ) {
            HStack {
                Moin.Badge(count: 5, size: .default) { sampleBox }
                Moin.Badge(count: 5, size: .small) { sampleBox }
            }
        } code: {
            """
            Moin.Badge(size: .default) {...}
            Moin.Badge(size: .small) {...}
            """
        }
        .scrollAnchor("badge.size")
    }
    
    private var colorPropertyCard: some View {
        PropertyCard(
            name: "color",
            type: "BadgeColor",
            defaultValue: ".default",
            description: tr("badge.api.color"),
             enumValues: ".default | .success | .processing | .warning | .error | .custom(Color) | .red | .volcano | .orange | .gold | .yellow | .lime | .green | .cyan | .blue | .geekblue | .purple | .magenta",
            sectionId: "badge"
        ) {
            Moin.Badge(count: 5, color: .success) { sampleBox }
        } code: {
            """
            Moin.Badge(color: .success) {...}
            """
        }
        .scrollAnchor("badge.color")
    }
    
    private var offsetPropertyCard: some View {
        PropertyCard(
            name: "offset",
            type: "(x: CGFloat, y: CGFloat)?",
            defaultValue: "nil",
            description: tr("badge.api.offset"),
            sectionId: "badge"
        ) {
            Moin.Badge(count: 5, offset: (10, -10)) { sampleBox }
        } code: {
            """
            Moin.Badge(offset: (10, -10)) {...}
            """
        }
        .scrollAnchor("badge.offset")
    }
    
    private var contentPropertyCard: some View {
         PropertyCard(
             name: "content",
             type: "() -> Content",
             defaultValue: "-",
             description: tr("badge.api.content"),
             sectionId: "badge"
         ) {
             Moin.Badge(count: 5) {
                 Text("Box")
                     .padding()
                     .background(Color.gray.opacity(0.3))
             }
         } code: {
             """
             Moin.Badge(count: 5) {
                 Text("Box")
             }
             """
         }
         .scrollAnchor("badge.content")
     }
    
    // MARK: - Ribbon Properties
    
    private var ribbonTextPropertyCard: some View {
        PropertyCard(
            name: "text",
            type: "String?",
            defaultValue: "nil",
            description: tr("badge.api.text"),
            sectionId: "ribbon"
        ) {
            Moin.BadgeRibbon(text: "New") { RibbonCard() }
        } code: {
            """
            Moin.BadgeRibbon(text: "New") {...}
            """
        }
        .scrollAnchor("ribbon.ribbonText")
    }
    
    private var ribbonColorPropertyCard: some View {
        PropertyCard(
            name: "color",
            type: "BadgeColor",
            defaultValue: ".processing",
            description: tr("badge.api.color"),
            sectionId: "ribbon"
        ) {
            Moin.BadgeRibbon(text: "Cool", color: .purple) { RibbonCard() }
        } code: {
            """
            Moin.BadgeRibbon(color: .purple) {...}
            """
        }
        .scrollAnchor("ribbon.ribbonColor")
    }
    
    private var ribbonPlacementPropertyCard: some View {
        PropertyCard(
            name: "placement",
            type: "RibbonPlacement",
            defaultValue: ".end",
            description: tr("badge.api.placement"),
            enumValues: ".start | .end",
            sectionId: "ribbon"
        ) {
            HStack {
                Moin.BadgeRibbon(text: "Start", placement: .start) { RibbonCard() }
                Moin.BadgeRibbon(text: "End", placement: .end) { RibbonCard() }
            }
        } code: {
            """
            Moin.BadgeRibbon(placement: .start) {...}
            Moin.BadgeRibbon(placement: .end) {...}
            """
        }
        .scrollAnchor("ribbon.ribbonPlacement")
    }
    
    private var ribbonContentPropertyCard: some View {
         PropertyCard(
             name: "content",
             type: "() -> Content",
             defaultValue: "-",
             description: tr("badge.api.content"),
             sectionId: "ribbon"
         ) {
             Moin.BadgeRibbon(text: "H") { RibbonCard() }
         } code: {
            """
            Moin.BadgeRibbon(text: "H") {...}
            """
        }
        .scrollAnchor("ribbon.ribbonContent")
     }
    
    // MARK: - Status Properties
    
    private var statusPropertyCard: some View {
        PropertyCard(
            name: "status",
            type: "BadgeStatus",
            defaultValue: "-",
            description: tr("badge.api.status"),
            enumValues: ".success | .processing | .default | .error | .warning",
            sectionId: "badge"
        ) {
            Moin.Badge(status: .processing, text: "Success")
        } code: {
            "Moin.Badge(status: .success)"
        }
        .scrollAnchor("badge.status")
    }

    private var textPropertyCard: some View {
         PropertyCard(
             name: "text",
             type: "String?",
             defaultValue: "nil",
             description: tr("badge.api.text"),
             sectionId: "badge"
         ) {
             Moin.Badge(status: .error, text: "Error Occurred")
         } code: {
             "Moin.Badge(status: .error, text: \"Error Occurred\")"
         }
         .scrollAnchor("badge.text")
     }
    
    // MARK: - Helpers
    private var sampleBox: some View {
        Moin.Avatar(icon: "", shape: .square)
    }
    

}
