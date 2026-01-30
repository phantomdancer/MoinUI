import SwiftUI
import MoinUI

struct ResultAPIView: View {
    @Localized var tr

    private var apiSections: [DocSidebarSection] {
        [
            DocSidebarSection(
                title: tr("api.button.section.common"),
                items: [
                    .init(id: "status"),
                    .init(id: "title"),
                    .init(id: "subTitle"),
                    .init(id: "icon"),
                    .init(id: "extra")
                ],
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
        case "status": statusCard
        case "title": titleCard
        case "subTitle": subTitleCard
        case "icon": iconCard
        case "extra": extraCard
        default: EmptyView()
        }
    }

    // MARK: - Cards

    private var statusCard: some View {
        PropertyCard(
            name: "status",
            type: "_ResultStatus",
            defaultValue: ".info",
            description: tr("api.result.status"),
            sectionId: "api"
        ) {
            HStack(spacing: 16) {
                VStack {
                    Moin.Result(status: .success, title: tr("api.result.demo.success"))
                        .frame(maxWidth: 200)
                }
                VStack {
                    Moin.Result(status: .error, title: tr("api.result.demo.error"))
                        .frame(maxWidth: 200)
                }
            }
        } code: {
            """
            Moin.Result(status: .success, title: "\(tr("api.result.demo.success"))")
            Moin.Result(status: .error, title: "\(tr("api.result.demo.error"))")
            // .info, .warning, .notFound, .unauthorized, .serverError
            """
        }
    }

    private var titleCard: some View {
        PropertyCard(
            name: "title",
            type: "String / View",
            defaultValue: "-",
            description: tr("api.result.title"),
            sectionId: "api"
        ) {
            Moin.Result(status: .info, title: tr("api.result.demo.title"))
                .frame(maxWidth: 300)
        } code: {
            """
            Moin.Result(status: .info, title: "\(tr("api.result.demo.title"))")
            """
        }
    }

    private var subTitleCard: some View {
        PropertyCard(
            name: "subTitle",
            type: "String / View",
            defaultValue: "-",
            description: tr("api.result.subTitle"),
            sectionId: "api"
        ) {
            Moin.Result(
                status: .info,
                title: tr("api.result.demo.title"),
                subTitle: tr("api.result.demo.subtitle")
            )
            .frame(maxWidth: 300)
        } code: {
            """
            Moin.Result(
                status: .info,
                title: "\(tr("api.result.demo.title"))",
                subTitle: "\(tr("api.result.demo.subtitle"))"
            )
            """
        }
    }

    private var iconCard: some View {
        PropertyCard(
            name: "icon",
            type: "View",
            defaultValue: "-",
            description: tr("api.result.icon"),
            sectionId: "api"
        ) {
            Moin.Result(
                status: .info,
                title: tr("api.result.demo.title"),
                icon: {
                    Image(systemName: "heart.fill")
                        .foregroundStyle(.pink)
                }
            )
            .frame(maxWidth: 300)
        } code: {
            """
            Moin.Result(
                status: .info,
                title: "\(tr("api.result.demo.title"))",
                icon: {
                    Image(systemName: "heart.fill")
                        .foregroundStyle(.pink)
                }
            )
            """
        }
    }

    private var extraCard: some View {
        PropertyCard(
            name: "extra",
            type: "View",
            defaultValue: "-",
            description: tr("api.result.extra"),
            sectionId: "api"
        ) {
            Moin.Result(
                status: .success,
                title: tr("api.result.demo.title"),
                subTitle: tr("api.result.demo.subtitle"),
                extra: {
                    HStack(spacing: 8) {
                        Moin.Button(tr("api.result.demo.primary"), color: .primary) {}
                        Moin.Button(tr("api.result.demo.default")) {}
                    }
                }
            )
            .frame(maxWidth: 400)
        } code: {
            """
            Moin.Result(
                status: .success,
                title: "\(tr("api.result.demo.title"))",
                subTitle: "\(tr("api.result.demo.subtitle"))",
                extra: {
                    HStack(spacing: 8) {
                        Moin.Button("\(tr("api.result.demo.primary"))", color: .primary) {}
                        Moin.Button("\(tr("api.result.demo.default"))") {}
                    }
                }
            )
            """
        }
    }
}
