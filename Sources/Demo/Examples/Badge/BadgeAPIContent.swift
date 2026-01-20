import SwiftUI
import MoinUI

/// Badge API 文档
struct BadgeAPIContent: View {
    @Localized var tr

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.xl) {
                // Badge API
                Text("Moin.Badge")
                    .font(.title2)
                    .fontWeight(.semibold)

                Text(tr("badge.api.badge_desc"))
                    .foregroundStyle(.secondary)

                APITable(
                    headers: (
                        tr("api.property"),
                        tr("api.type"),
                        tr("api.default"),
                        tr("api.description")
                    ),
                    rows: [
                        ("count", "Int?", "nil", tr("badge.api.count")),
                        ("dot", "Bool", "false", tr("badge.api.dot")),
                        ("showZero", "Bool", "false", tr("badge.api.showZero")),
                        ("overflowCount", "Int", "99", tr("badge.api.overflowCount")),
                        ("size", "BadgeSize", ".default", tr("badge.api.size")),
                        ("color", "BadgeColor", ".default", tr("badge.api.color")),
                        ("offset", "(x: CGFloat, y: CGFloat)?", "nil", tr("badge.api.offset")),
                        ("content", "() -> Content", "-", tr("badge.api.content")),
                    ]
                )

                // BadgeRibbon API
                Text("Moin.BadgeRibbon")
                    .font(.title2)
                    .fontWeight(.semibold)

                Text(tr("badge.api.ribbon_desc"))
                    .foregroundStyle(.secondary)

                APITable(
                    headers: (
                        tr("api.property"),
                        tr("api.type"),
                        tr("api.default"),
                        tr("api.description")
                    ),
                    rows: [
                        ("text", "String?", "nil", tr("badge.api.text")),
                        ("color", "BadgeColor", ".processing", tr("badge.api.color")),
                        ("placement", "RibbonPlacement", ".end", tr("badge.api.placement")),
                        ("content", "() -> Content", "-", tr("badge.api.content")),
                    ]
                )

                // StatusBadge API
                Text("Moin.StatusBadge")
                    .font(.title2)
                    .fontWeight(.semibold)

                Text(tr("badge.api.statusbadge_desc"))
                    .foregroundStyle(.secondary)

                APITable(
                    headers: (
                        tr("api.property"),
                        tr("api.type"),
                        tr("api.default"),
                        tr("api.description")
                    ),
                    rows: [
                        ("status", "BadgeStatus", "-", tr("badge.api.status")),
                        ("text", "String?", "nil", tr("badge.api.text")),
                    ]
                )

                // BadgeSize
                Text("BadgeSize")
                    .font(.title2)
                    .fontWeight(.semibold)

                Text(tr("badge.api.badgesize_desc"))
                    .foregroundStyle(.secondary)

                APITable(
                    headers: (
                        tr("api.value"),
                        tr("api.type"),
                        tr("api.default"),
                        tr("api.description")
                    ),
                    rows: [
                        (".default", "-", "-", tr("badge.enum.size.default")),
                        (".small", "-", "-", tr("badge.enum.size.small")),
                    ]
                )

                // BadgeColor
                Text("BadgeColor")
                    .font(.title2)
                    .fontWeight(.semibold)

                Text(tr("badge.api.badgecolor_desc"))
                    .foregroundStyle(.secondary)

                APITable(
                    headers: (
                        tr("api.value"),
                        tr("api.type"),
                        tr("api.default"),
                        tr("api.description")
                    ),
                    rows: [
                        (".default", "-", "-", tr("badge.enum.color.default")),
                        (".success", "-", "-", tr("badge.enum.color.success")),
                        (".processing", "-", "-", tr("badge.enum.color.processing")),
                        (".warning", "-", "-", tr("badge.enum.color.warning")),
                        (".error", "-", "-", tr("badge.enum.color.error")),
                        (".custom(Color)", "-", "-", tr("badge.enum.color.custom")),
                        ("Presets", "BadgeColor", "-", tr("badge.enum.color.presets")),
                    ]
                )

                // BadgeStatus
                Text("BadgeStatus")
                    .font(.title2)
                    .fontWeight(.semibold)

                Text(tr("badge.api.badgestatus_desc"))
                    .foregroundStyle(.secondary)

                APITable(
                    headers: (
                        tr("api.value"),
                        tr("api.type"),
                        tr("api.default"),
                        tr("api.description")
                    ),
                    rows: [
                        (".success", "-", "-", tr("badge.enum.status.success")),
                        (".processing", "-", "-", tr("badge.enum.status.processing")),
                        (".default", "-", "-", tr("badge.enum.status.default")),
                        (".error", "-", "-", tr("badge.enum.status.error")),
                        (".warning", "-", "-", tr("badge.enum.status.warning")),
                    ]
                )
            }
            .padding(Moin.Constants.Spacing.xl)
        }
    }
}
