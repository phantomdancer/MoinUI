import SwiftUI
import MoinUI

/// Tag Token 文档
struct TagTokenSection: View {
    @Localized var tr
    @Environment(\.moinToken) private var token

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.xl) {
                Text(tr("tag.token.title"))
                    .font(.title2)
                    .fontWeight(.semibold)

                Text(tr("tag.token.desc"))
                    .foregroundStyle(.secondary)

                // Token 使用说明
                Text(tr("tag.token.usage"))
                    .font(.headline)

                Text(tr("tag.token.usage_desc"))
                    .foregroundStyle(.secondary)

                APITable(
                    headers: (
                        tr("api.property"),
                        tr("api.type"),
                        tr("api.default"),
                        tr("api.description")
                    ),
                    rows: [
                        ("fontSize - 2", "CGFloat", "\(Int(token.fontSize - 2))", tr("tag.token.fontSize")),
                        ("paddingXXS", "CGFloat", "\(Int(token.paddingXXS))", tr("tag.token.paddingV")),
                        ("Spacing.xs", "CGFloat", "4", tr("tag.token.paddingH")),
                        ("borderRadiusSM", "CGFloat", "\(Int(token.borderRadiusSM))", tr("tag.token.borderRadius")),
                        ("motionDurationFast", "Double", "\(token.motionDurationFast)s", tr("tag.token.animation")),
                    ]
                )

                Moin.Divider()

                // 颜色 Token
                Text(tr("tag.token.colors"))
                    .font(.headline)

                Text(tr("tag.token.colors_desc"))
                    .foregroundStyle(.secondary)

                APITable(
                    headers: (
                        tr("api.property"),
                        tr("api.type"),
                        tr("api.default"),
                        tr("api.description")
                    ),
                    rows: [
                        ("colorSuccess", "Color", "-", tr("tag.token.colorSuccess")),
                        ("colorPrimary", "Color", "-", tr("tag.token.colorProcessing")),
                        ("colorWarning", "Color", "-", tr("tag.token.colorWarning")),
                        ("colorDanger", "Color", "-", tr("tag.token.colorDanger")),
                        ("colorFillSecondary", "Color", "-", tr("tag.token.colorDefault")),
                        ("colorBorder", "Color", "-", tr("tag.token.colorBorder")),
                    ]
                )
            }
            .padding(Moin.Constants.Spacing.xl)
        }
    }
}
