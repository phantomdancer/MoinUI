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
                Text(tr("doc.section.component_token"))
                    .font(.headline)

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
                        ("imageOpacity", "Double", "\(emptyToken.imageOpacity)", tr("empty.token.imageOpacity")),
                    ]
                )
                
                // 全局 Token
                Text(tr("doc.section.global_token"))
                    .font(.headline)
                
                APITable(
                    headers: (
                        tr("api.property"),
                        tr("api.type"),
                        tr("api.default"),
                        tr("api.description")
                    ),
                    rows: [
                        ("colorTextQuaternary", "Color", "-", tr("empty.token.imageColor")),
                        ("colorTextSecondary", "Color", "-", tr("empty.token.descriptionColor")),
                        ("fontSize", "CGFloat", "\(Int(token.fontSize))", tr("empty.token.descriptionFontSize")),
                        ("marginXS", "CGFloat", "\(Int(token.marginXS))", tr("empty.token.imageMarginBottom")),
                        ("marginSM", "CGFloat", "\(Int(token.marginSM))", tr("empty.token.contentMarginTop")),
                    ]
                )
            }
            .padding(Moin.Constants.Spacing.xl)
        }
    }
}
