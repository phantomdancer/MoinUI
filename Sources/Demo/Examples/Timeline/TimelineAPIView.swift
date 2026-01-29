import SwiftUI
import MoinUI

struct TimelineAPIView: View {
    @Localized var tr

    private var apiSections: [DocSidebarSection] {
        [
            DocSidebarSection(
                title: tr("api.timeline.section.timeline"),
                items: [
                    .init(id: "mode"),
                    .init(id: "reverse"),
                    .init(id: "pending")
                ],
                sectionId: "timeline"
            ),
            DocSidebarSection(
                title: tr("api.timeline.section.timeline_item"),
                items: [
                    .init(id: "color"),
                    .init(id: "dot"),
                    .init(id: "label"),
                    .init(id: "position")
                ],
                sectionId: "item"
            )
        ]
    }

    var body: some View {
        ComponentDocBody(
            sections: apiSections,
            initialItemId: "timeline"
        ) { sectionId in
            if sectionId == "timeline" {
                Text("Timeline").font(.title3).fontWeight(.semibold)
            } else if sectionId == "item" {
                Text("Timeline.Item").font(.title3).fontWeight(.semibold)
            }
        } item: { item in
            cardForItem(item)
        }
    }

    @ViewBuilder
    private func cardForItem(_ item: String) -> some View {
        switch item {
        case "mode": modeCard
        case "reverse": reverseCard
        case "pending": pendingCard
        case "color": colorCard
        case "dot": dotCard
        case "label": labelCard
        case "position": positionCard
        default: EmptyView()
        }
    }

    // MARK: - Timeline Cards

    private var modeCard: some View {
        PropertyCard(
            name: "mode",
            type: "_TimelineMode",
            defaultValue: ".start",
            description: tr("api.timeline.mode"),
            sectionId: "timeline"
        ) {
            HStack(alignment: .top, spacing: 32) {
                VStack(alignment: .leading) {
                    Text(".start").font(.caption).foregroundStyle(.secondary)
                    Moin.Timeline(mode: .start) {
                        Moin.Timeline.Item(tr("timeline.demo.event") + " 1")
                        Moin.Timeline.Item(tr("timeline.demo.event") + " 2")
                    }
                }
                VStack(alignment: .leading) {
                    Text(".alternate").font(.caption).foregroundStyle(.secondary)
                    Moin.Timeline(mode: .alternate) {
                        Moin.Timeline.Item(tr("timeline.demo.event") + " 1")
                        Moin.Timeline.Item(tr("timeline.demo.event") + " 2")
                    }
                }
                VStack(alignment: .leading) {
                    Text(".end").font(.caption).foregroundStyle(.secondary)
                    Moin.Timeline(mode: .end) {
                        Moin.Timeline.Item(tr("timeline.demo.event") + " 1")
                        Moin.Timeline.Item(tr("timeline.demo.event") + " 2")
                    }
                }
            }
        } code: {
            """
            Moin.Timeline(mode: .start) { ... }
            Moin.Timeline(mode: .alternate) { ... }
            Moin.Timeline(mode: .end) { ... }
            """
        }
    }

    private var reverseCard: some View {
        PropertyCard(
            name: "reverse",
            type: "Bool",
            defaultValue: "false",
            description: tr("api.timeline.reverse"),
            sectionId: "timeline"
        ) {
            Moin.Timeline(reverse: true) {
                Moin.Timeline.Item(tr("timeline.demo.event") + " 1")
                Moin.Timeline.Item(tr("timeline.demo.event") + " 2")
                Moin.Timeline.Item(tr("timeline.demo.event") + " 3")
            }
        } code: {
            """
            Moin.Timeline(reverse: true) {
                Moin.Timeline.Item("\(tr("timeline.demo.event")) 1")
                Moin.Timeline.Item("\(tr("timeline.demo.event")) 2")
                Moin.Timeline.Item("\(tr("timeline.demo.event")) 3")
            }
            """
        }
    }

    private var pendingCard: some View {
        PropertyCard(
            name: "pending",
            type: "Bool",
            defaultValue: "false",
            description: tr("api.timeline.pending"),
            sectionId: "timeline"
        ) {
            Moin.Timeline(pending: true) {
                Moin.Timeline.Item(tr("timeline.demo.event") + " 1")
                Moin.Timeline.Item(tr("timeline.demo.event") + " 2")
            }
        } code: {
            """
            Moin.Timeline(pending: true) {
                Moin.Timeline.Item("\(tr("timeline.demo.event")) 1")
                Moin.Timeline.Item("\(tr("timeline.demo.event")) 2")
            }
            """
        }
    }

    // MARK: - Timeline.Item Cards

    private var colorCard: some View {
        PropertyCard(
            name: "color",
            type: "_TimelineColor",
            defaultValue: ".blue",
            description: tr("api.timeline_item.color"),
            sectionId: "item"
        ) {
            Moin.Timeline {
                Moin.Timeline.Item("Blue", color: .blue)
                Moin.Timeline.Item("Green", color: .green)
                Moin.Timeline.Item("Red", color: .red)
                Moin.Timeline.Item("Gray", color: .gray)
            }
        } code: {
            """
            Moin.Timeline {
                Moin.Timeline.Item("Blue", color: .blue)
                Moin.Timeline.Item("Green", color: .green)
                Moin.Timeline.Item("Red", color: .red)
                Moin.Timeline.Item("Gray", color: .gray)
            }
            """
        }
    }

    private var dotCard: some View {
        PropertyCard(
            name: "dot",
            type: "View",
            defaultValue: "-",
            description: tr("api.timeline_item.dot"),
            sectionId: "item"
        ) {
            Moin.Timeline {
                Moin.Timeline.Item(dot: {
                    Image(systemName: "star.fill")
                        .foregroundStyle(.yellow)
                }) {
                    Text(tr("timeline.demo.custom_text"))
                }
                Moin.Timeline.Item(tr("timeline.demo.event") + " 2")
            }
        } code: {
            """
            Moin.Timeline {
                Moin.Timeline.Item(dot: {
                    Image(systemName: "star.fill")
                        .foregroundStyle(.yellow)
                }) {
                    Text("\(tr("timeline.demo.custom_text"))")
                }
                Moin.Timeline.Item("\(tr("timeline.demo.event")) 2")
            }
            """
        }
    }

    private var labelCard: some View {
        PropertyCard(
            name: "label",
            type: "View",
            defaultValue: "-",
            description: tr("api.timeline_item.label"),
            sectionId: "item"
        ) {
            Moin.Timeline(mode: .alternate) {
                Moin.Timeline.Item(label: { Text("09:00") }) {
                    Text(tr("timeline.demo.event") + " 1")
                }
                Moin.Timeline.Item(label: { Text("12:00") }) {
                    Text(tr("timeline.demo.event") + " 2")
                }
            }
        } code: {
            """
            Moin.Timeline(mode: .alternate) {
                Moin.Timeline.Item(label: { Text("09:00") }) {
                    Text("\(tr("timeline.demo.event")) 1")
                }
                Moin.Timeline.Item(label: { Text("12:00") }) {
                    Text("\(tr("timeline.demo.event")) 2")
                }
            }
            """
        }
    }

    private var positionCard: some View {
        PropertyCard(
            name: "position",
            type: "_TimelineItemPosition?",
            defaultValue: "nil",
            description: tr("api.timeline_item.position"),
            sectionId: "item"
        ) {
            Moin.Timeline(mode: .alternate) {
                Moin.Timeline.Item(tr("timeline.demo.event") + " 1")
                Moin.Timeline.Item(position: .start) {
                    Text(tr("timeline.demo.event") + " 2 (position: .start)")
                }
                Moin.Timeline.Item(tr("timeline.demo.event") + " 3")
            }
        } code: {
            """
            Moin.Timeline(mode: .alternate) {
                Moin.Timeline.Item("\(tr("timeline.demo.event")) 1")
                Moin.Timeline.Item(position: .start) {
                    Text("\(tr("timeline.demo.event")) 2 (position: .start)")
                }
                Moin.Timeline.Item("\(tr("timeline.demo.event")) 3")
            }
            """
        }
    }
}
