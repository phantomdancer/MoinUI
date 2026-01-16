import SwiftUI
import MoinUI

/// Empty Token 文档
struct EmptyTokenSection: View {
    @Localized var tr
    @Environment(\.moinToken) private var token
    @Environment(\.moinEmptyToken) private var emptyToken

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.xl) {
                Text(tr("empty.token.title"))
                    .font(.title2)
                    .fontWeight(.semibold)

                Text(tr("empty.token.desc"))
                    .foregroundStyle(.secondary)

                // 组件 Token
                Text(tr("empty.token.component"))
                    .font(.headline)

                Text(tr("empty.token.component_desc"))
                    .foregroundStyle(.secondary)

                APITable(
                    headers: (
                        tr("api.property"),
                        tr("api.type"),
                        tr("api.default"),
                        tr("api.description")
                    ),
                    rows: [
                        ("imageHeight", "CGFloat", "\(Int(emptyToken.imageHeight))", tr("empty.token.imageHeight")),
                        ("imageHeightSM", "CGFloat", "\(Int(emptyToken.imageHeightSM))", tr("empty.token.imageHeightSM")),
                        ("imageColor", "Color", "-", tr("empty.token.imageColor")),
                        ("imageOpacity", "Double", "\(emptyToken.imageOpacity)", tr("empty.token.imageOpacity")),
                        ("descriptionColor", "Color", "-", tr("empty.token.descriptionColor")),
                        ("descriptionFontSize", "CGFloat", "\(Int(emptyToken.descriptionFontSize))", tr("empty.token.descriptionFontSize")),
                        ("imageMarginBottom", "CGFloat", "\(Int(emptyToken.imageMarginBottom))", tr("empty.token.imageMarginBottom")),
                        ("contentMarginTop", "CGFloat", "\(Int(emptyToken.contentMarginTop))", tr("empty.token.contentMarginTop")),
                    ]
                )
            }
            .padding(Moin.Constants.Spacing.xl)
        }
    }
}
