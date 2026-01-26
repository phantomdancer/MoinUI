import SwiftUI
import MoinUI

// MARK: - ButtonAPIView

/// Button 组件 API 文档视图
struct ButtonAPIView: View {
    @Localized var tr
    
    // MARK: - API Sections
    
    private var apiSections: [DocSidebarSection] {
        [
            DocSidebarSection(
                title: tr("api.button.section.common"),
                items: [.init(id: "action"), .init(id: "label"), .init(id: "isDisabled"), .init(id: "loading"), .init(id: "isBlock"), .init(id: "isGhost")],
                sectionId: "api"
            ),
            DocSidebarSection(
                title: tr("api.button.section.style"),
                items: [.init(id: "variant"), .init(id: "size"), .init(id: "shape"), .init(id: "color"), .init(id: "fontColor"), .init(id: "gradient")],
                sectionId: "api"
            ),
            DocSidebarSection(
                title: tr("api.button.section.icon"),
                items: [.init(id: "icon"), .init(id: "iconPlacement")],
                sectionId: "api"
            ),
            DocSidebarSection(
                title: tr("api.button.section.link"),
                items: [.init(id: "href")],
                sectionId: "api"
            )
        ]
    }
    
    var body: some View {
        ComponentDocBody(
            sections: apiSections,
            initialItemId: "api"
        ) { sectionId in
            if sectionId == "api" {
                Text("API").font(.title3).fontWeight(.semibold)
            }
        } item: { item in
            cardForItem(item)
        }
    }
    
    // MARK: - Item -> Card 映射
    
    @ViewBuilder
    private func cardForItem(_ item: String) -> some View {
        switch item {
        case "action": actionPropertyCard
        case "label": labelPropertyCard
        case "isDisabled": disabledPropertyCard
        case "loading": loadingPropertyCard
        case "isBlock": blockPropertyCard
        case "isGhost": ghostPropertyCard
        case "variant": variantPropertyCard
        case "size": sizePropertyCard
        case "shape": shapePropertyCard
        case "color": colorPropertyCard
        case "fontColor": fontColorPropertyCard
        case "gradient": gradientPropertyCard
        case "icon": iconPropertyCard
        case "iconPlacement": iconPlacementPropertyCard
        case "href": hrefPropertyCard
        default: EmptyView()
        }
    }
    
    // MARK: - Color 属性卡片
    
    internal var colorPropertyCard: some View {
        PropertyCard(
            name: "color",
            type: "Moin.ButtonColor",
            defaultValue: ".default",
            description: tr("button.api.type"),
            enumValues: ".primary | .success | .warning | .danger | .info | .default | .custom(Color) | .red | .blue | .green | .cyan | .purple | .magenta | .orange | .yellow | .lime | .gold | .volcano | .geekblue",
            sectionId: "api"
        ) {
            // 预览：展示所有颜色
            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.sm) {
                // Semantic Colors
                Text(tr("button.semantic_colors"))
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundStyle(.secondary)
                HStack(alignment: .center, spacing: Moin.Constants.Spacing.sm) {
                    Moin.Button(tr("button.label.primary"), color: .primary) {}
                    Moin.Button(tr("button.label.success"), color: .success) {}
                    Moin.Button(tr("button.label.warning"), color: .warning) {}
                    Moin.Button(tr("button.label.danger"), color: .danger) {}
                    Moin.Button(tr("button.label.info"), color: .info) {}
                    Moin.Button(tr("button.label.default"), color: .default) {}
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                // Preset Colors
                Text(tr("button.preset_colors"))
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundStyle(.secondary)
                    .padding(.top, Moin.Constants.Spacing.sm)
                HStack(alignment: .center, spacing: Moin.Constants.Spacing.sm) {
                    Moin.Button(tr("button.label.cyan"), color: .cyan) {}
                    Moin.Button(tr("button.label.purple"), color: .purple) {}
                    Moin.Button(tr("button.label.magenta"), color: .magenta) {}
                    Moin.Button(tr("button.label.orange"), color: .orange) {}
                    Moin.Button(tr("button.label.yellow"), color: .yellow) {}
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                // Custom Colors
                Text(tr("button.custom_colors"))
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundStyle(.secondary)
                    .padding(.top, Moin.Constants.Spacing.sm)
                HStack(alignment: .center, spacing: Moin.Constants.Spacing.sm) {
                    Moin.Button(tr("button.label.brown"), color: .custom(Color(red: 0.6, green: 0.3, blue: 0.1))) {}
                    Moin.Button(tr("button.label.custom"), color: .custom(Color(red: 0.6, green: 0.2, blue: 0.8))) {}
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        } code: {
            """
            Moin.Button("\(tr("button.label.primary"))", color: .primary) {}
            Moin.Button("\(tr("button.label.cyan"))", color: .cyan) {}
            Moin.Button("\(tr("button.label.brown"))", color: .custom(Color(red: 0.6, green: 0.3, blue: 0.1))) {}
            Moin.Button("\(tr("button.label.custom"))", color: .custom(Color(red: 0.6, green: 0.2, blue: 0.8))) {}
            """
        }
        .scrollAnchor("api.color")
    }
    
    // MARK: - Variant 属性卡片
    
    internal var variantPropertyCard: some View {
        PropertyCard(
            name: "variant",
            type: "Moin.Button.Variant",
            defaultValue: ".solid",
            description: tr("button.api.variant"),
            enumValues: ".solid | .outlined | .dashed | .filled | .text | .link",
            sectionId: "api"
        ) {
            HStack(spacing: Moin.Constants.Spacing.sm) {
                Moin.Button(tr("button.label.solid"), color: .primary, variant: .solid) {}
                Moin.Button(tr("button.label.outlined"), color: .primary, variant: .outlined) {}
                Moin.Button(tr("button.label.dashed"), color: .primary, variant: .dashed) {}
                Moin.Button(tr("button.label.filled"), color: .primary, variant: .filled) {}
                Moin.Button(tr("button.label.text"), color: .primary, variant: .text) {}
                Moin.Button(tr("button.label.link"), color: .primary, variant: .link) {}
            }
        } code: {
            "Moin.Button(\"\(tr("button.label.solid"))\", variant: .solid) {}"
        }
        .scrollAnchor("api.variant")
    }

    // MARK: - Size 属性卡片

    internal var sizePropertyCard: some View {
        PropertyCard(
            name: "size",
            type: "Moin.Button.Size",
            defaultValue: ".medium",
            description: tr("button.api.size"),
            enumValues: ".small | .medium | .large",
            sectionId: "api"
        ) {
            HStack(alignment: .center, spacing: Moin.Constants.Spacing.md) {
                Moin.Button(tr("button.label.small"), color: .primary, size: .small) {}
                Moin.Button(tr("button.label.medium"), color: .primary, size: .medium) {}
                Moin.Button(tr("button.label.large"), color: .primary, size: .large) {}
            }
        } code: {
            "Moin.Button(\"\(tr("button.label.medium"))\", size: .medium) {}"
        }
        .scrollAnchor("api.size")
    }

    // MARK: - Shape 属性卡片

    internal var shapePropertyCard: some View {
        PropertyCard(
            name: "shape",
            type: "Moin.Button.Shape",
            defaultValue: ".default",
            description: tr("button.api.shape"),
            enumValues: ".default | .round | .circle",
            sectionId: "api"
        ) {
            HStack(spacing: Moin.Constants.Spacing.md) {
                Moin.Button(tr("button.label.normal"), color: .primary, shape: .default) {}
                Moin.Button(tr("button.label.round"), color: .primary, shape: .round) {}
                Moin.Button(icon: "plus", color: .primary, shape: .circle) {}
            }
        } code: {
            "Moin.Button(\"\(tr("button.label.normal"))\", shape: .default) {}"
        }
        .scrollAnchor("api.shape")
    }
}
