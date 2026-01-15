import SwiftUI
import MoinUI

/// Badge Token 文档
struct BadgeTokenSection: View {
    @Localized var tr
    @Environment(\.moinToken) private var token
    @Environment(\.moinBadgeToken) private var badgeToken

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.xl) {
                Text(tr("badge.token.title"))
                    .font(.title2)
                    .fontWeight(.semibold)

                Text(tr("badge.token.desc"))
                    .foregroundStyle(.secondary)

                // 组件 Token
                Text(tr("badge.token.component"))
                    .font(.headline)

                Text(tr("badge.token.component_desc"))
                    .foregroundStyle(.secondary)

                APITable(
                    headers: (
                        tr("api.property"),
                        tr("api.type"),
                        tr("api.default"),
                        tr("api.description")
                    ),
                    rows: [
                        ("indicatorHeight", "CGFloat", "\(Int(badgeToken.indicatorHeight))", tr("badge.token.indicatorHeight")),
                        ("indicatorHeightSM", "CGFloat", "\(Int(badgeToken.indicatorHeightSM))", tr("badge.token.indicatorHeightSM")),
                        ("dotSize", "CGFloat", "\(Int(badgeToken.dotSize))", tr("badge.token.dotSize")),
                        ("dotSizeSM", "CGFloat", "\(Int(badgeToken.dotSizeSM))", tr("badge.token.dotSizeSM")),
                        ("textFontSize", "CGFloat", "\(Int(badgeToken.textFontSize))", tr("badge.token.textFontSize")),
                        ("textFontSizeSM", "CGFloat", "\(Int(badgeToken.textFontSizeSM))", tr("badge.token.textFontSizeSM")),
                        ("statusSize", "CGFloat", "\(Int(badgeToken.statusSize))", tr("badge.token.statusSize")),
                        ("paddingH", "CGFloat", "\(Int(badgeToken.paddingH))", tr("badge.token.paddingH")),
                        ("paddingHSM", "CGFloat", "\(Int(badgeToken.paddingHSM))", tr("badge.token.paddingHSM")),
                        ("shadowRadius", "CGFloat", "\(Int(badgeToken.shadowRadius))", tr("badge.token.shadowRadius")),
                    ]
                )

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
