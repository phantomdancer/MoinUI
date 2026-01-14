import SwiftUI
import MoinUI

/// Tag Token 文档
struct TagTokenSection: View {
    @Localized var tr
    @Environment(\.moinToken) private var token
    @Environment(\.moinTagToken) private var tagToken

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.xl) {
                Text(tr("tag.token.title"))
                    .font(.title2)
                    .fontWeight(.semibold)

                Text(tr("tag.token.desc"))
                    .foregroundStyle(.secondary)

                // 组件 Token - 基础
                Text(tr("tag.token.component"))
                    .font(.headline)

                Text(tr("tag.token.component_desc"))
                    .foregroundStyle(.secondary)

                APITable(
                    headers: (
                        tr("api.property"),
                        tr("api.type"),
                        tr("api.default"),
                        tr("api.description")
                    ),
                    rows: [
                        ("defaultBg", "Color", "-", tr("tag.token.defaultBg")),
                        ("defaultColor", "Color", "-", tr("tag.token.defaultColor")),
                        ("solidTextColor", "Color", "#fff", tr("tag.token.solidTextColor")),
                        ("lineWidth", "CGFloat", "\(Int(tagToken.lineWidth))", tr("tag.token.lineWidth")),
                    ]
                )

                // 组件 Token - 尺寸
                Text(tr("tag.token.size"))
                    .font(.headline)

                Text(tr("tag.token.size_desc"))
                    .foregroundStyle(.secondary)

                APITable(
                    headers: (
                        tr("api.property"),
                        tr("api.type"),
                        tr("api.default"),
                        tr("api.description")
                    ),
                    rows: [
                        ("fontSizeLG", "CGFloat", "\(Int(tagToken.fontSizeLG))", tr("tag.token.fontSizeLG")),
                        ("fontSize", "CGFloat", "\(Int(tagToken.fontSize))", tr("tag.token.fontSizeMD")),
                        ("fontSizeSM", "CGFloat", "\(Int(tagToken.fontSizeSM))", tr("tag.token.fontSizeSM")),
                        ("iconSizeLG", "CGFloat", "\(Int(tagToken.iconSizeLG))", tr("tag.token.iconSizeLG")),
                        ("iconSize", "CGFloat", "\(Int(tagToken.iconSize))", tr("tag.token.iconSizeMD")),
                        ("iconSizeSM", "CGFloat", "\(Int(tagToken.iconSizeSM))", tr("tag.token.iconSizeSM")),
                        ("closeIconSizeLG", "CGFloat", "\(Int(tagToken.closeIconSizeLG))", tr("tag.token.closeIconSizeLG")),
                        ("closeIconSize", "CGFloat", "\(Int(tagToken.closeIconSize))", tr("tag.token.closeIconSizeMD")),
                        ("closeIconSizeSM", "CGFloat", "\(Int(tagToken.closeIconSizeSM))", tr("tag.token.closeIconSizeSM")),
                    ]
                )

                // 组件 Token - 间距
                Text(tr("tag.token.spacing"))
                    .font(.headline)

                Text(tr("tag.token.spacing_desc"))
                    .foregroundStyle(.secondary)

                APITable(
                    headers: (
                        tr("api.property"),
                        tr("api.type"),
                        tr("api.default"),
                        tr("api.description")
                    ),
                    rows: [
                        ("iconGapLG", "CGFloat", "\(Int(tagToken.iconGapLG))", tr("tag.token.iconGapLG")),
                        ("iconGap", "CGFloat", "\(Int(tagToken.iconGap))", tr("tag.token.iconGapMD")),
                        ("iconGapSM", "CGFloat", "\(Int(tagToken.iconGapSM))", tr("tag.token.iconGapSM")),
                        ("paddingHLG", "CGFloat", "\(Int(tagToken.paddingHLG))", tr("tag.token.paddingHLG")),
                        ("paddingH", "CGFloat", "\(Int(tagToken.paddingH))", tr("tag.token.paddingHMD")),
                        ("paddingHSM", "CGFloat", "\(Int(tagToken.paddingHSM))", tr("tag.token.paddingHSM")),
                        ("paddingVLG", "CGFloat", "\(Int(tagToken.paddingVLG))", tr("tag.token.paddingVLG")),
                        ("paddingV", "CGFloat", "\(Int(tagToken.paddingV))", tr("tag.token.paddingVMD")),
                        ("paddingVSM", "CGFloat", "\(Int(tagToken.paddingVSM))", tr("tag.token.paddingVSM")),
                    ]
                )

                // 全局 Token
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
                        ("borderRadiusSM", "CGFloat", "\(Int(token.borderRadiusSM))", tr("tag.token.borderRadius")),
                        ("motionDurationFast", "Double", "\(token.motionDurationFast)s", tr("tag.token.animation")),
                        ("colorSuccess", "Color", "-", tr("tag.token.colorSuccess")),
                        ("colorPrimary", "Color", "-", tr("tag.token.colorProcessing")),
                        ("colorWarning", "Color", "-", tr("tag.token.colorWarning")),
                        ("colorDanger", "Color", "-", tr("tag.token.colorDanger")),
                        ("colorBorder", "Color", "-", tr("tag.token.colorBorder")),
                    ]
                )
            }
            .padding(Moin.Constants.Spacing.xl)
        }
    }
}
