import SwiftUI
import MoinUI

struct AlertAPIView: View {
    @Localized var tr
    
    private var apiSections: [DocSidebarSection] {
        [
            DocSidebarSection(
                title: tr("api.button.section.common"),
                items: ["type", "title", "description", "showIcon", "closable", "banner", "onClose"],
                sectionId: "api"
            )
        ]
    }
    
    var body: some View {
        ComponentDocBody(
            sections: apiSections,
            initialItemId: "api"
        ) { sectionId in
            if sectionId == "api" {
                Text("API").font(.title3).fontWeight(.semibold)
            }
        } item: { item in
            cardForItem(item)
        }
    }
    
    @ViewBuilder
    private func cardForItem(_ item: String) -> some View {
        switch item {
        case "type": typeCard
        case "title": titleCard
        case "description": descriptionCard
        case "showIcon": showIconCard
        case "closable": closableCard
        case "banner": bannerCard
        case "onClose": onCloseCard
        default: EmptyView()
        }
    }
    
    // MARK: - Cards
    
    private var typeCard: some View {
        PropertyCard(
            name: "type",
            type: "AlertType",
            defaultValue: ".info",
            description: tr("api.alert.type"),
            sectionId: "api"
        ) {
            VStack(spacing: 8) {
                Moin.Alert(type: .success, title: "Success")
                Moin.Alert(type: .info, title: "Info")
            }
        } code: {
            """
            Moin.Alert(type: .success, title: "Success")
            Moin.Alert(type: .info, title: "Info")
            // .warning, .error
            """
        }
    }
    
    private var titleCard: some View {
        PropertyCard(
            name: "title",
            type: "String",
            defaultValue: "-",
            description: tr("api.alert.title"),
            sectionId: "api"
        ) {
            Moin.Alert(title: "Alert Title")
        } code: {
            "Moin.Alert(title: \"Alert Title\")"
        }
    }
    
    private var descriptionCard: some View {
        PropertyCard(
            name: "description",
            type: "String",
            defaultValue: "-",
            description: tr("api.alert.description"),
            sectionId: "api"
        ) {
            Moin.Alert(
                title: "Title",
                description: "This is a description."
            )
        } code: {
            """
            Moin.Alert(
                title: "Title",
                description: "This is a description."
            )
            """
        }
    }
    
    private var showIconCard: some View {
        PropertyCard(
            name: "showIcon",
            type: "Bool",
            defaultValue: "false",
            description: tr("api.alert.showIcon"),
            sectionId: "api"
        ) {
            Moin.Alert(title: "With Icon", showIcon: true)
        } code: {
            "Moin.Alert(title: \"With Icon\", showIcon: true)"
        }
    }
    
    private var closableCard: some View {
        PropertyCard(
            name: "closable",
            type: "Bool",
            defaultValue: "false",
            description: tr("api.alert.closable"),
            sectionId: "api"
        ) {
            Moin.Alert(title: "Closable Alert", closable: true)
        } code: {
            "Moin.Alert(title: \"Closable Alert\", closable: true)"
        }
    }
    
    private var bannerCard: some View {
        PropertyCard(
            name: "banner",
            type: "Bool",
            defaultValue: "false",
            description: tr("api.alert.banner"),
            sectionId: "api"
        ) {
            Moin.Alert(type: .warning, title: "Banner Alert", banner: true)
        } code: {
            "Moin.Alert(type: .warning, title: \"Banner Alert\", banner: true)"
        }
    }
    
    private var onCloseCard: some View {
        PropertyCard(
            name: "onClose",
            type: "() -> Void",
            defaultValue: "-",
            description: tr("api.alert.onClose"),
            sectionId: "api"
        ) {
            Moin.Alert(title: "Check Console", closable: true, onClose: { print("Closed") })
        } code: {
            "Moin.Alert(title: \"Check Console\", closable: true, onClose: { print(\"Closed\") })"
        }
    }
}
