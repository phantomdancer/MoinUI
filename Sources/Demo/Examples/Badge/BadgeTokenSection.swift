import SwiftUI
import MoinUI

/// Badge Token 文档
struct BadgeTokenSection: View {
    @Localized var tr
    @Environment(\.moinToken) private var token

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.xl) {
                Text(tr("badge.token.title"))
                    .font(.title2)
                    .fontWeight(.semibold)

                Text(tr("badge.token.desc"))
                    .foregroundStyle(.secondary)

                // 全局 Token
                Text(tr("badge.token.global"))
                    .font(.headline)

                Text(tr("badge.token.global_desc"))
                    .foregroundStyle(.secondary)

                APITable(
                    headers: (
                        tr("api.property"),
                        tr("api.type"),
                        tr("api.default"),
                        tr("api.description")
                    ),
                    rows: [
                        ("colorDanger", "Color", "-", tr("badge.token.colorDanger")),
                        ("colorSuccess", "Color", "-", tr("badge.token.colorSuccess")),
                        ("colorPrimary", "Color", "-", tr("badge.token.colorPrimary")),
                        ("colorWarning", "Color", "-", tr("badge.token.colorWarning")),
                        ("colorText", "Color", "-", tr("badge.token.colorText")),
                        ("colorTextSecondary", "Color", "-", tr("badge.token.colorTextSecondary")),
                    ]
                )
            }
            .padding(Moin.Constants.Spacing.xl)
        }
    }
}
