import SwiftUI
import MoinUI

// MARK: - TagAPIView

/// Tag 组件 API 文档视图
struct TagAPIView: View {
    @Localized var tr
    @ObservedObject var config = Moin.ConfigProvider.shared
    
    // MARK: - API Sections
    
    private var apiSections: [DocSidebarSection] {
        [
            DocSidebarSection(
                title: tr("api.tag.section.style"),
                items: [.init(id: "variant"), .init(id: "size"), .init(id: "color"), .init(id: "round")],
                sectionId: "api"
            ),
            DocSidebarSection(
                title: tr("api.tag.section.feature"),
                items: [.init(id: "icon"), .init(id: "closable"), .init(id: "checkable")],
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
        case "color": colorPropertyCard
        case "variant": variantPropertyCard
        case "size": sizePropertyCard
        case "round": roundPropertyCard
        case "icon": iconPropertyCard
        case "closable": closablePropertyCard
        case "checkable": checkablePropertyCard
        default: EmptyView()
        }
    }
    
    // MARK: - Property Cards
    
    private var colorPropertyCard: some View {
        PropertyCard(
            name: "color",
            type: "Moin.Tag.Color",
            defaultValue: ".default",
            description: tr("tag.api.color"),
            enumValues: ".default | .success | .processing | .warning | .error | Color | .magenta | .red | ...",
            sectionId: "api"
        ) {
            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.sm) {
                Text(tr("tag.semantic_colors")).font(.caption).foregroundStyle(.secondary)
                HStack {
                    Moin.Tag(tr("tag.example.default"), color: .default)
                    Moin.Tag(tr("tag.example.success"), color: .success)
                    Moin.Tag(tr("tag.example.processing"), color: .processing)
                    Moin.Tag(tr("tag.example.warning"), color: .warning)
                    Moin.Tag(tr("tag.example.error"), color: .error)
                }
                
                Text(tr("tag.preset_colors")).font(.caption).foregroundStyle(.secondary)
                HStack {
                    Moin.Tag(tr("tag.example.custom3"), color: .magenta)
                    Moin.Tag(tr("tag.example.custom1"), color: .purple) // mapped to violet/custom1 for variety
                    Moin.Tag(tr("tag.example.custom2"), color: .cyan) // mapped to teal/custom2
                    Moin.Tag(tr("tag.label.orange"), color: .orange)
                    Moin.Tag(tr("tag.label.gold"), color: .gold)
                }

                Text(tr("tag.custom_colors")).font(.caption).foregroundStyle(.secondary)
                HStack {
                    Moin.Tag(tr("tag.label.cyan"), color: .cyan)
                    Moin.Tag(tr("tag.label.brown"), color: .custom(Color(red: 0.6, green: 0.3, blue: 0.1)))
                    Moin.Tag(tr("tag.label.custom"), color: .custom(Color(red: 0.6, green: 0.2, blue: 0.8)))
                }
            }
        } code: {
            let cyan = tr("tag.label.cyan")
            let brown = tr("tag.label.brown")
            let custom = tr("tag.label.custom")
            return """
            Moin.Tag("\(cyan)", color: .cyan)
            Moin.Tag("\(brown)", color: .custom(Color(red: 0.6, green: 0.3, blue: 0.1)))
            Moin.Tag("\(custom)", color: .custom(Color(red: 0.6, green: 0.2, blue: 0.8)))
            """
        }
        .scrollAnchor("api.color")
    }
    
    private var variantPropertyCard: some View {
        PropertyCard(
            name: "variant",
            type: "Moin.Tag.Variant",
            defaultValue: ".filled",
            description: tr("tag.api.variant"),
            enumValues: ".filled | .outlined | .solid | .borderless",
            sectionId: "api"
        ) {
            HStack {
                Moin.Tag(tr("tag.example.filled"), variant: .filled)
                Moin.Tag(tr("tag.example.outlined"), variant: .outlined)
                Moin.Tag(tr("tag.example.solid"), variant: .solid)
                Moin.Tag(tr("tag.example.borderless"), variant: .borderless)
            }
        } code: {
            let label = tr("tag.example.filled")
            return "Moin.Tag(\"\(label)\", variant: .filled)"
        }
        .scrollAnchor("api.variant")
    }
    
    private var sizePropertyCard: some View {
        PropertyCard(
            name: "size",
            type: "Moin.Tag.Size",
            defaultValue: ".medium",
            description: tr("tag.api.size"),
            enumValues: ".small | .medium | .large",
            sectionId: "api"
        ) {
            HStack(alignment: .center) {
                Moin.Tag(tr("tag.example.small"), size: .small)
                Moin.Tag(tr("tag.example.medium"), size: .medium)
                Moin.Tag(tr("tag.example.large"), size: .large)
            }
        } code: {
            let label = tr("tag.example.medium")
            return "Moin.Tag(\"\(label)\", size: .medium)"
        }
        .scrollAnchor("api.size")
    }
    
    private var roundPropertyCard: some View {
        PropertyCard(
            name: "round",
            type: "Bool",
            defaultValue: "false",
            description: tr("tag.api.round"),
            sectionId: "api"
        ) {
            HStack {
                Moin.Tag(tr("tag.label.normal"), round: false)
                Moin.Tag(tr("tag.label.round"), round: true)
            }
        } code: {
            let label = tr("tag.label.round")
            return "Moin.Tag(\"\(label)\", round: true)"
        }
        .scrollAnchor("api.round")
    }
    
    private var iconPropertyCard: some View {
        PropertyCard(
            name: "icon",
            type: "String?",
            defaultValue: "nil",
            description: tr("tag.api.icon"),
            sectionId: "api"
        ) {
            HStack {
                Moin.Tag(tr("tag.example.apple"), icon: "apple.logo")
                Moin.Tag(tr("tag.example.star"), color: .gold, icon: "star.fill")
            }
        } code: {
            let label = tr("tag.example.apple")
            return "Moin.Tag(\"\(label)\", icon: \"apple.logo\")"
        }
        .scrollAnchor("api.icon")
    }
    
    private var closablePropertyCard: some View {
        PropertyCard(
            name: "closable",
            type: "Bool",
            defaultValue: "false",
            description: tr("tag.api.closable"),
            sectionId: "api"
        ) {
            HStack {
                Moin.Tag(tr("tag.label.closable"), closable: true) { print("Closed") }
            }
        } code: {
            let label = tr("tag.label.closable")
            return "Moin.Tag(\"\(label)\", closable: true)"
        }
        .scrollAnchor("api.closable")
    }
    
    private var checkablePropertyCard: some View {
        PropertyCard(
            name: "checkable",
            type: "Moin.Tag.Checkable",
            defaultValue: "-",
            description: tr("tag.api.checkable"),
            sectionId: "api"
        ) {
            CheckableTagDemo()
        } code: {
            let label = tr("tag.label.check_me")
            return """
            @State var checked = false
            Moin.Tag.Checkable("\(label)", isChecked: $checked)
            """
        }
        .scrollAnchor("api.checkable")
    }
}

// 辅助 View 解决闭包中 State 问题
private struct CheckableTagDemo: View {
    @State private var checked = false
    @Localized var tr
    var body: some View {
        Moin.Tag.Checkable(tr("tag.label.check_me"), isChecked: $checked)
    }
}
