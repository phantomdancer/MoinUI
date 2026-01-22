import SwiftUI
import MoinUI

struct StatisticAPIView: View {
    @Localized var tr
    
    private var apiSections: [DocSidebarSection] {
        [
            DocSidebarSection(
                title: tr("api.button.section.common"),
                items: ["title", "value", "precision", "loading"],
                sectionId: "api"
            ),
            DocSidebarSection(
                title: tr("api.button.section.style"),
                items: ["valuestyle", "prefix", "suffix"],
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
        case "title": titleCard
        case "value": valueCard
        case "precision": precisionCard
        case "loading": loadingCard
        case "valuestyle": valueStyleCard
        case "prefix": prefixCard
        case "suffix": suffixCard
        default: EmptyView()
        }
    }
    
    // MARK: - Cards
    
    private var titleCard: some View {
        PropertyCard(
            name: "title",
            type: "String | View",
            defaultValue: "-",
            description: tr("api.statistic.title"),
            sectionId: "api"
        ) {
            HStack(spacing: 30) {
                Moin.Statistic(title: tr("statistic.demo.account_balance"), value: 112893)
                
                Moin.Statistic(
                    title: HStack(spacing: 4) {
                        Image(systemName: "star.fill")
                            .foregroundStyle(Color.orange)
                        Text("Rating")
                    },
                    value: "4.8"
                )
            }
        } code: {
            """
            Moin.Statistic(title: "\(tr("statistic.demo.account_balance"))", value: 112893)
            
            Moin.Statistic(
                title: HStack(spacing: 4) {
                    Image(systemName: "star.fill")
                        .foregroundStyle(Color.orange)
                    Text("Rating")
                },
                value: "4.8"
            )
            """
        }
    }
    
    private var valueCard: some View {
        PropertyCard(
            name: "value",
            type: "String | Number",
            defaultValue: "-",
            description: tr("api.statistic.value"),
            sectionId: "api"
        ) {
            HStack(spacing: 20) {
                Moin.Statistic(title: "Number", value: 123456)
                Moin.Statistic(title: "String", value: "98.5%")
            }
        } code: {
            """
            Moin.Statistic(title: "Number", value: 123456)
            Moin.Statistic(title: "String", value: "98.5%")
            """
        }
    }
    
    private var precisionCard: some View {
        PropertyCard(
            name: "precision",
            type: "Int",
            defaultValue: "-",
            description: tr("api.statistic.precision"),
            sectionId: "api"
        ) {
            HStack(spacing: 20) {
                Moin.Statistic(title: "Standard", value: 1128.9388)
                Moin.Statistic(title: "Precision 2", value: 1128.9388, precision: 2)
            }
        } code: {
            """
            Moin.Statistic(title: "Standard", value: 1128.9388)
            Moin.Statistic(title: "Precision 2", value: 1128.9388, precision: 2)
            """
        }
    }
    
    private var loadingCard: some View {
        PropertyCard(
            name: "loading",
            type: "Bool",
            defaultValue: "false",
            description: tr("api.statistic.loading"),
            sectionId: "api"
        ) {
            Moin.Statistic(title: tr("statistic.demo.active_users"), value: 112893, loading: true)
        } code: {
            "Moin.Statistic(title: \"\(tr("statistic.demo.active_users"))\", value: 112893, loading: true)"
        }
    }
    
    private var valueStyleCard: some View {
         PropertyCard(
            name: "valueStyle",
            type: "Font",
            defaultValue: "-",
            description: tr("api.statistic.value_style"),
            sectionId: "api"
        ) {
            Moin.Statistic(title: tr("statistic.demo.active_users"), value: 112893, valueStyle: .system(size: 24, weight: .bold, design: .serif))
                .foregroundStyle(Color.purple)
        } code: {
            "Moin.Statistic(title: \"\(tr("statistic.demo.active_users"))\", value: 112893, valueStyle: .title) // Custom font via valueStyle param or modifiers"
        }
    }
    
    private var prefixCard: some View {
        PropertyCard(
            name: "prefix",
            type: "View",
            defaultValue: "-",
            description: tr("api.statistic.prefix"),
            sectionId: "api"
        ) {
             Moin.Statistic(
                title: tr("statistic.demo.feedback"),
                value: 1128,
                prefix: Image(systemName: "hand.thumbsup.fill").foregroundStyle(Color.blue)
            )
        } code: {
            """
            Moin.Statistic(
                title: "\(tr("statistic.demo.feedback"))",
                value: 1128,
                prefix: Image(systemName: "hand.thumbsup.fill").foregroundStyle(Color.blue)
            )
            """
        }
    }
    
    private var suffixCard: some View {
        PropertyCard(
            name: "suffix",
            type: "View",
            defaultValue: "-",
            description: tr("api.statistic.suffix"),
            sectionId: "api"
        ) {
             Moin.Statistic(
                title: tr("statistic.demo.unmerged"),
                value: 93,
                suffix: Text("/ 100")
            )
        } code: {
            """
            Moin.Statistic(
                title: "\(tr("statistic.demo.unmerged"))",
                value: 93,
                suffix: Text("/ 100")
            )
            """
        }
    }
}
