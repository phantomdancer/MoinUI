import SwiftUI
import MoinUI

struct AlertAPIView: View {
    @Localized var tr
    
    private var apiSections: [DocSidebarSection] {
        [
            DocSidebarSection(
                title: tr("api.button.section.common"),
                items: [.init(id: "type"), .init(id: "title"), .init(id: "description"), .init(id: "showIcon"), .init(id: "closable"), .init(id: "banner"), .init(id: "action"), .init(id: "onClose")],
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
        case "action": actionCard
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
                Moin.Alert(type: .success, title: tr("alert.demo.api_demo.success"))
                Moin.Alert(type: .info, title: tr("alert.demo.api_demo.info"))
            }
        } code: {
            """
            Moin.Alert(type: .success, title: "\(tr("alert.demo.api_demo.success"))")
            Moin.Alert(type: .info, title: "\(tr("alert.demo.api_demo.info"))")
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
            Moin.Alert(title: tr("alert.demo.api_demo.title"))
        } code: {
            """
            Moin.Alert(title: "\(tr("alert.demo.api_demo.title"))")
            """
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
                title: tr("alert.demo.api_demo.desc_title"),
                description: tr("alert.demo.api_demo.desc_content")
            )
        } code: {
            """
            Moin.Alert(
                title: "\(tr("alert.demo.api_demo.desc_title"))",
                description: "\(tr("alert.demo.api_demo.desc_content"))"
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
            Moin.Alert(title: tr("alert.demo.api_demo.with_icon"), showIcon: true)
        } code: {
            """
            Moin.Alert(title: "\(tr("alert.demo.api_demo.with_icon"))", showIcon: true)
            """
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
            Moin.Alert(title: tr("alert.demo.api_demo.closable"), closable: true)
        } code: {
            """
            Moin.Alert(title: "\(tr("alert.demo.api_demo.closable"))", closable: true)
            """
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
            Moin.Alert(type: .warning, title: tr("alert.demo.api_demo.banner"), banner: true)
        } code: {
            """
            Moin.Alert(type: .warning, title: "\(tr("alert.demo.api_demo.banner"))", banner: true)
            """
        }
    }
    
    private var actionCard: some View {
        PropertyCard(
            name: "action",
            type: "View",
            defaultValue: "-",
            description: tr("api.alert.action"),
            sectionId: "api"
        ) {
            Moin.Alert(type: .success, title: tr("alert.demo.action.success_title"), showIcon: true) {
                Moin.Button(tr("alert.demo.action.undo"), size: .small, variant: .text)
            }
        } code: {
            """
            Moin.Alert(type: .success, title: "Success", showIcon: true) {
                Moin.Button("UNDO", size: .small, variant: .text)
            }
            """
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
            Moin.Alert(title: tr("alert.demo.api_demo.check_console"), closable: true, onClose: { print("Closed") })
        } code: {
            """
            Moin.Alert(title: "\(tr("alert.demo.api_demo.check_console"))", closable: true, onClose: { print("Closed") })
            """
        }
    }
}
