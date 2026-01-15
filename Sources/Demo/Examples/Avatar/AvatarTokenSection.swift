import SwiftUI
import MoinUI

/// Avatar Token 文档
struct AvatarTokenSection: View {
    @Localized var tr
    @Environment(\.moinToken) private var token
    @Environment(\EnvironmentValues.moinAvatarToken) private var avatarToken

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.xl) {
                Text(tr("avatar.token.title"))
                    .font(.title2)
                    .fontWeight(.semibold)

                Text(tr("avatar.token.desc"))
                    .foregroundStyle(.secondary)

                // 组件 Token
                Text(tr("avatar.token.component"))
                    .font(.headline)

                Text(tr("avatar.token.component_desc"))
                    .foregroundStyle(.secondary)

                APITable(
                    headers: (
                        tr("api.property"),
                        tr("api.type"),
                        tr("api.default"),
                        tr("api.description")
                    ),
                    rows: [
                        ("size", "CGFloat", "\(Int(avatarToken.size))", tr("avatar.token.size")),
                        ("sizeLG", "CGFloat", "\(Int(avatarToken.sizeLG))", tr("avatar.token.sizeLG")),
                        ("sizeSM", "CGFloat", "\(Int(avatarToken.sizeSM))", tr("avatar.token.sizeSM")),
                        ("fontSize", "CGFloat", "\(Int(avatarToken.fontSize))", tr("avatar.token.fontSize")),
                        ("fontSizeLG", "CGFloat", "\(Int(avatarToken.fontSizeLG))", tr("avatar.token.fontSizeLG")),
                        ("fontSizeSM", "CGFloat", "\(Int(avatarToken.fontSizeSM))", tr("avatar.token.fontSizeSM")),
                        ("borderRadius", "CGFloat", "\(Int(avatarToken.borderRadius))", tr("avatar.token.borderRadius")),
                        ("borderRadiusLG", "CGFloat", "\(Int(avatarToken.borderRadiusLG))", tr("avatar.token.borderRadiusLG")),
                        ("borderRadiusSM", "CGFloat", "\(Int(avatarToken.borderRadiusSM))", tr("avatar.token.borderRadiusSM")),
                        ("groupSpacing", "CGFloat", "\(Int(avatarToken.groupSpacing))", tr("avatar.token.groupSpacing")),
                        ("groupBorderWidth", "CGFloat", "\(Int(avatarToken.groupBorderWidth))", tr("avatar.token.groupBorderWidth")),
                    ]
                )

                // 全局 Token
                Text(tr("avatar.token.global"))
                    .font(.headline)

                Text(tr("avatar.token.global_desc"))
                    .foregroundStyle(.secondary)

                APITable(
                    headers: (
                        tr("api.property"),
                        tr("api.type"),
                        tr("api.default"),
                        tr("api.description")
                    ),
                    rows: [
                        ("colorTextSecondary", "Color", "-", tr("avatar.token.colorTextSecondary")),
                        ("colorFillTertiary", "Color", "-", tr("avatar.token.colorFillTertiary")),
                        ("controlHeight", "CGFloat", "-", tr("avatar.token.controlHeight")),
                    ]
                )
            }
            .padding(Moin.Constants.Spacing.xl)
        }
    }
}
