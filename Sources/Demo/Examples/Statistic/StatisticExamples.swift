import SwiftUI
import MoinUI

struct StatisticExamples: View {
    @Localized var tr
    @State private var loading = false

    private let anchors: [AnchorItem] = [
        AnchorItem(id: "basic", titleKey: "statistic.basic"),
        AnchorItem(id: "unit", titleKey: "statistic.card"),
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
            title: tr("statistic.card"),
            description: tr("statistic.card_desc")
        ) {
            HStack(spacing: 30) {
                VStack {
                    Moin.Statistic(
                        title: tr("statistic.demo.feedback"),
                        value: 1128,
                        prefix: Image(systemName: "hand.thumbsup.fill").foregroundStyle(Color.blue)
                    )
                }
                .padding()
                .background(Color(nsColor: .controlBackgroundColor))
                .cornerRadius(8)
                .shadow(radius: 2)
                
                VStack {
                    Moin.Statistic(
                        title: tr("statistic.demo.unmerged"),
                        value: 93,
                        suffix: Text("/ 100")
                    )
                }
                .padding()
                .background(Color(nsColor: .controlBackgroundColor))
                .cornerRadius(8)
                .shadow(radius: 2)
            }
        } code: {
            """
            // \(tr("statistic.demo.feedback"))
            VStack {
                Moin.Statistic(
                    title: "\(tr("statistic.demo.feedback"))",
                    value: 1128,
                    prefix: Image(systemName: "hand.thumbsup.fill").foregroundStyle(Color.blue)
                )
            }
            .padding()
            .background(Color(nsColor: .controlBackgroundColor))
            .cornerRadius(8)
            .shadow(radius: 2)
            
            // \(tr("statistic.demo.unmerged"))
            VStack {
                Moin.Statistic(
                    title: "\(tr("statistic.demo.unmerged"))",
                    value: 93,
                    suffix: Text("/ 100")
                )
            }
            .padding()
            .background(Color(nsColor: .controlBackgroundColor))
            .cornerRadius(8)
            .shadow(radius: 2)
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
