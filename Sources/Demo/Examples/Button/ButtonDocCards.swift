import SwiftUI
import MoinUI

// MARK: - API 属性卡片扩展

extension ButtonAPIView {

    // MARK: - Action 属性卡片

    var actionPropertyCard: some View {
        PropertyCard(
            name: "action",
            type: "(() -> Void)?",
            defaultValue: "nil",
            description: tr("button.api.action"),
            sectionId: "api"
        ) {
            Moin.Button(tr("button.label.click_me"), color: .primary) {
                print("Button clicked!")
            }
        } code: {
            """
Moin.Button("\(tr("button.label.click_me"))", color: .primary) {
    print("Button clicked!")
}
"""
        }
        .scrollAnchor("api.action")
    }

    // MARK: - FontColor 属性卡片

    var fontColorPropertyCard: some View {
        PropertyCard(
            name: "fontColor",
            type: "Color?",
            defaultValue: "nil",
            description: tr("button.api.fontColor"),
            sectionId: "api"
        ) {
            HStack(spacing: Moin.Constants.Spacing.sm) {
                Moin.Button(tr("button.label.orange"), fontColor: .orange) {}
                Moin.Button(tr("button.label.purple"), fontColor: .purple) {}
                Moin.Button(tr("button.label.custom"), color: .primary, fontColor: .yellow) {}
            }
        } code: {
            """
Moin.Button("\(tr("button.label.orange"))", fontColor: .orange) {}
Moin.Button("\(tr("button.label.purple"))", fontColor: .purple) {}
Moin.Button("\(tr("button.label.custom"))", color: .primary, fontColor: .yellow) {}
"""
        }
    }

    // MARK: - Gradient 属性卡片

    var gradientPropertyCard: some View {
        PropertyCard(
            name: "gradient",
            type: "LinearGradient?",
            defaultValue: "nil",
            description: tr("button.api.gradient"),
            sectionId: "api"
        ) {
            HStack(spacing: Moin.Constants.Spacing.md) {
                Moin.Button(tr("button.label.gradient"), gradient: LinearGradient(
                    colors: [Color(hex: "#667eea"), Color(hex: "#764ba2")],
                    startPoint: .leading,
                    endPoint: .trailing
                ), fontColor: .white) {}
                Moin.Button(tr("button.label.pink"), gradient: LinearGradient(
                    colors: [Color(hex: "#f093fb"), Color(hex: "#f5576c")],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ), fontColor: .white) {}
            }
        } code: {
            """
Moin.Button("\(tr("button.label.gradient"))", gradient: LinearGradient(
    colors: [Color(hex: "#667eea"), Color(hex: "#764ba2")],
    startPoint: .leading,
    endPoint: .trailing
), fontColor: .white) {}
"""
        }
    }

    // MARK: - Href 属性卡片

    var hrefPropertyCard: some View {
        PropertyCard(
            name: "href",
            type: "URL?",
            defaultValue: "nil",
            description: tr("button.api.href"),
            sectionId: "api"
        ) {
            HStack(spacing: Moin.Constants.Spacing.md) {
                Moin.Button(tr("button.label.visit_github"), color: .primary, icon: "link", href: URL(string: "https://github.com")) {}
                Moin.Button(tr("button.label.visit_docs"), variant: .link, href: URL(string: "https://developer.apple.com")) {}
            }
        } code: {
            """
Moin.Button("\(tr("button.label.visit_github"))", icon: "link", href: URL(string: "https://github.com")) {}
Moin.Button("\(tr("button.label.visit_docs"))", variant: .link, href: URL(string: "https://apple.com")) {}
"""
        }
    }

    // MARK: - Label 属性卡片

    var labelPropertyCard: some View {
        PropertyCard(
            name: "label",
            type: "@ViewBuilder () -> View",
            defaultValue: "-",
            description: tr("button.api.label"),
            sectionId: "api"
        ) {
            HStack(spacing: Moin.Constants.Spacing.md) {
                Moin.Button(color: .primary) {
                    HStack(spacing: Moin.Constants.Spacing.xs) {
                        Image(systemName: "star.fill")
                            .foregroundStyle(.yellow)
                        Text(tr("button.label.favorite"))
                    }
                }
                Moin.Button(color: .success, variant: .outlined) {
                    HStack(spacing: Moin.Constants.Spacing.xs) {
                        Circle()
                            .fill(.green)
                            .frame(width: 8, height: 8)
                        Text(tr("button.label.online"))
                    }
                }
            }
        } code: {
            """
Moin.Button(color: .primary) {
    HStack {
        Image(systemName: "star.fill")
            .foregroundStyle(.yellow)
        Text("\(tr("button.label.favorite"))")
    }
}
"""
        }
    }

    // MARK: - Icon 属性卡片

    var iconPropertyCard: some View {
        PropertyCard(
            name: "icon",
            type: "String?",
            defaultValue: "nil",
            description: tr("button.api.icon"),
            sectionId: "api"
        ) {
            HStack(spacing: Moin.Constants.Spacing.sm) {
                Moin.Button(tr("button.label.search"), color: .primary, icon: "magnifyingglass") {}
                Moin.Button(tr("button.label.add"), color: .success, icon: "plus") {}
                Moin.Button(icon: "heart.fill", color: .danger, shape: .circle) {}
            }
        } code: {
            """
Moin.Button("\(tr("button.label.search"))", icon: "magnifyingglass") {}
Moin.Button("\(tr("button.label.add"))", icon: "plus") {}
Moin.Button(icon: "heart.fill", shape: .circle) {}
"""
        }
    }

    // MARK: - Loading 属性卡片

    var loadingPropertyCard: some View {
        PropertyCard(
            name: "loading",
            type: "Moin.Button.Loading",
            defaultValue: "false",
            description: tr("button.api.loading"),
            sectionId: "api"
        ) {
            Moin.Button(tr("button.label.loading"), color: .primary, loading: true) {}
        } code: {
            "Moin.Button(\"\(tr("button.label.loading"))\", loading: true) {}"
        }
        .scrollAnchor("api.loading")
    }

    // MARK: - Disabled 属性卡片

    var disabledPropertyCard: some View {
        PropertyCard(
            name: "disabled",
            type: "Bool",
            defaultValue: "false",
            description: tr("button.api.disabled"),
            sectionId: "api"
        ) {
            Moin.Button(tr("button.label.disabled"), color: .primary, disabled: true) {}
        } code: {
            "Moin.Button(\"\(tr("button.label.disabled"))\", disabled: true) {}"
        }
        .scrollAnchor("api.disabled")
    }

    // MARK: - Block 属性卡片

    var blockPropertyCard: some View {
        PropertyCard(
            name: "block",
            type: "Bool",
            defaultValue: "false",
            description: tr("button.api.block"),
            sectionId: "api"
        ) {
            Moin.Button(tr("button.label.block"), color: .primary, block: true) {}
        } code: {
            "Moin.Button(\"\(tr("button.label.block"))\", block: true) {}"
        }
        .scrollAnchor("api.block")
    }

    // MARK: - Ghost 属性卡片

    var ghostPropertyCard: some View {
        PropertyCard(
            name: "ghost",
            type: "Bool",
            defaultValue: "false",
            description: tr("button.api.ghost"),
            sectionId: "api"
        ) {
            ZStack {
                Color(white: 0.8)
                    .frame(height: 60)
                    .cornerRadius(8)
                Moin.Button(tr("button.label.button"), color: .primary, ghost: true) {}
            }
        } code: {
            "Moin.Button(\"\(tr("button.label.button"))\", ghost: true) {}"
        }
        .scrollAnchor("api.ghost")
    }

    // MARK: - IconPlacement 属性卡片

    var iconPlacementPropertyCard: some View {
        PropertyCard(
            name: "iconPlacement",
            type: "Moin.Button.IconPlacement",
            defaultValue: ".start",
            description: tr("button.api.iconPlacement"),
            enumValues: ".start | .end",
            sectionId: "api"
        ) {
            HStack(spacing: Moin.Constants.Spacing.md) {
                Moin.Button(tr("button.label.start"), color: .primary, icon: "arrow.left", iconPlacement: .start) {}
                Moin.Button(tr("button.label.end"), color: .primary, icon: "arrow.right", iconPlacement: .end) {}
            }
        } code: {
            """
Moin.Button("\(tr("button.label.start"))", icon: "arrow.left", iconPlacement: .start) {}
Moin.Button("\(tr("button.label.end"))", icon: "arrow.right", iconPlacement: .end) {}
"""
        }
        .scrollAnchor("api.iconPlacement")
    }
}
