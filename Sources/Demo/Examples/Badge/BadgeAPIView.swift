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
                items: ["count", "dot", "showZero", "overflowCount", "size", "color", "offset", "content"],
                sectionId: "badge"
            ),
            DocSidebarSection(
                title: tr("api.badge.section.ribbon"),
                items: ["ribbon.text", "ribbon.color", "ribbon.placement", "ribbon.content"],
                sectionId: "ribbon"
            ),
            DocSidebarSection(
                title: tr("api.badge.section.status"),
                items: ["status.status", "status.text"],
                sectionId: "status"
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
            } else if sectionId == "status" {
                Text("Moin.StatusBadge").font(.title3).fontWeight(.semibold)
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
        
        case "ribbon.text": ribbonTextPropertyCard
        case "ribbon.color": ribbonColorPropertyCard
        case "ribbon.placement": ribbonPlacementPropertyCard
        case "ribbon.content": ribbonContentPropertyCard
        
        case "status.status": statusStatusPropertyCard
        case "status.text": statusTextPropertyCard
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
            "Moin.Badge(count: 5) { ... }"
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
            "Moin.Badge(dot: true) { ... }"
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
            "Moin.Badge(count: 0, showZero: true) { ... }"
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
            "Moin.Badge(count: 1000, overflowCount: 999) { ... }"
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
            Moin.Badge(size: .default) { ... }
            Moin.Badge(size: .small) { ... }
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
             enumValues: ".default | .success | .processing | .warning | .error | .custom(Color)",
            sectionId: "badge"
        ) {
            Moin.Badge(count: 5, color: .success) { sampleBox }
        } code: {
            "Moin.Badge(color: .success) { ... }"
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
            "Moin.Badge(offset: (10, -10)) { ... }"
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
            name: "ribbon.text",
            type: "String?",
            defaultValue: "nil",
            description: tr("badge.api.text"),
            sectionId: "ribbon"
        ) {
            Moin.BadgeRibbon(text: "New") { ribbonCard }
        } code: {
            "Moin.BadgeRibbon(text: \"New\") { ... }"
        }
    }
    
    private var ribbonColorPropertyCard: some View {
        PropertyCard(
            name: "ribbon.color",
            type: "BadgeColor",
            defaultValue: ".processing",
            description: tr("badge.api.color"),
            sectionId: "ribbon"
        ) {
            Moin.BadgeRibbon(text: "Cool", color: .purple) { ribbonCard }
        } code: {
            "Moin.BadgeRibbon(color: .purple) { ... }"
        }
    }
    
    private var ribbonPlacementPropertyCard: some View {
        PropertyCard(
            name: "ribbon.placement",
            type: "RibbonPlacement",
            defaultValue: ".end",
            description: tr("badge.api.placement"),
            enumValues: ".start | .end",
            sectionId: "ribbon"
        ) {
            HStack {
                Moin.BadgeRibbon(text: "Start", placement: .start) { ribbonCard }
                Moin.BadgeRibbon(text: "End", placement: .end) { ribbonCard }
            }
        } code: {
            """
            Moin.BadgeRibbon(placement: .start) { ... }
            Moin.BadgeRibbon(placement: .end) { ... }
            """
        }
    }
    
    private var ribbonContentPropertyCard: some View {
         PropertyCard(
             name: "ribbon.content",
             type: "() -> Content",
             defaultValue: "-",
             description: tr("badge.api.content"),
             sectionId: "ribbon"
         ) {
             Moin.BadgeRibbon(text: "H") { ribbonCard }
         } code: {
             "Moin.BadgeRibbon(...) { ... }"
         }
     }
    
    // MARK: - Statusbadge Properties
    
    private var statusStatusPropertyCard: some View {
        PropertyCard(
            name: "status.status",
            type: "BadgeStatus",
            defaultValue: "-",
            description: tr("badge.api.status"),
            enumValues: ".success | .processing | .default | .error | .warning",
            sectionId: "status"
        ) {
            Moin.Badge(status: .processing, text: "Success")
        } code: {
            "Moin.Badge(status: .success)"
        }
    }
    
    private var statusTextPropertyCard: some View {
         PropertyCard(
             name: "status.text",
             type: "String?",
             defaultValue: "nil",
             description: tr("badge.api.text"),
             sectionId: "status"
         ) {
             Moin.Badge(status: .error, text: "Error Occurred")
         } code: {
             "Moin.Badge(status: .error, text: \"Error Occurred\")"
         }
     }
    
    // MARK: - Helpers
    private var sampleBox: some View {
        RoundedRectangle(cornerRadius: 6)
            .fill(Color.gray.opacity(0.3))
            .frame(width: 40, height: 40)
    }
    
    private var ribbonCard: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(Color.gray.opacity(0.1))
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .strokeBorder(Color.gray.opacity(0.2))
            )
            .frame(width: 80, height: 60)
    }
}
