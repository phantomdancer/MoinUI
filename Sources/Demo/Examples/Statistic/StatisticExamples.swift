import SwiftUI
import MoinUI

struct StatisticExamples: View {
    @Localized var tr
    @State private var loading = false

    private let anchors: [AnchorItem] = [
        AnchorItem(id: "basic", titleKey: "statistic.basic"),
        AnchorItem(id: "unit", titleKey: "statistic.unit"),
        AnchorItem(id: "loading", titleKey: "statistic.loading")
    ]

    var body: some View {
        ExamplePageWithAnchor(pageName: "Statistic", anchors: anchors) { _ in
            basicExample.id("basic")
            unitExample.id("unit")
            loadingExample.id("loading")
        }
    }
    
    private var basicExample: some View {
        ExampleSection(
            title: tr("statistic.basic"),
            description: tr("statistic.basic_desc")
        ) {
            HStack(spacing: 50) {
                Moin.Statistic(title: tr("statistic.demo.active_users"), value: 112893)
                Moin.Statistic(title: tr("statistic.demo.account_balance"), value: 112893, precision: 2)
            }
        } code: {
            """
            Moin.Statistic(title: "\(tr("statistic.demo.active_users"))", value: 112893)
            Moin.Statistic(title: "\(tr("statistic.demo.account_balance"))", value: 112893, precision: 2)
            """
        }
    }
    
    private var unitExample: some View {
        ExampleSection(
            title: tr("statistic.unit"),
            description: tr("statistic.unit_desc")
        ) {
            HStack(spacing: 50) {
                Moin.Statistic(
                    title: tr("statistic.demo.feedback"),
                    value: 1128,
                    prefix: Image(systemName: "hand.thumbsup.fill").foregroundStyle(Color.blue)
                )
                
                Moin.Statistic(
                    title: tr("statistic.demo.unmerged"),
                    value: 93,
                    suffix: Text("/ 100")
                )
                
                Moin.Statistic(
                    title: tr("statistic.demo.active"),
                    value: 11.28,
                    precision: 2,
                    prefix: Image(systemName: "arrow.up"),
                    suffix: Text("%")
                )
            }
        } code: {
            """
            Moin.Statistic(
                title: "\(tr("statistic.demo.feedback"))",
                value: 1128,
                prefix: Image(systemName: "hand.thumbsup.fill").foregroundStyle(Color.blue)
            )
            
            Moin.Statistic(
                title: "\(tr("statistic.demo.unmerged"))",
                value: 93,
                suffix: Text("/ 100")
            )
            
            Moin.Statistic(
                title: "\(tr("statistic.demo.active"))",
                value: 11.28,
                precision: 2,
                prefix: Image(systemName: "arrow.up"),
                suffix: Text("%")
            )
            """
        }
    }
    
    private var loadingExample: some View {
        ExampleSection(
            title: tr("statistic.loading"),
            description: tr("statistic.loading_desc")
        ) {
             VStack(alignment: .leading) {
                 Moin.Button(tr("statistic.demo.toggle_loading")) {
                     loading.toggle()
                 }
                 .padding(.bottom)

                 Moin.Statistic(title: tr("statistic.demo.active_users"), value: 112893, loading: loading)
             }
        } code: {
            """
            Moin.Button("\(tr("statistic.demo.toggle_loading"))") {
                loading.toggle()
            }
            
            Moin.Statistic(title: "\(tr("statistic.demo.active_users"))", value: 112893, loading: loading)
            """
        }
    }
}
