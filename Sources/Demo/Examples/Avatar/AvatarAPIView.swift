import SwiftUI
import MoinUI

// MARK: - AvatarAPIView

/// Avatar 组件 API 文档视图
struct AvatarAPIView: View {
    @Localized var tr
    
    // MARK: - API Sections
    
    private var apiSections: [DocSidebarSection] {
        [
            DocSidebarSection(
                title: tr("api.avatar.section.basic"),
                items: ["icon", "text", "image", "src", "fallbackIcon"],
                sectionId: "api"
            ),
            DocSidebarSection(
                title: tr("api.avatar.section.style"),
                items: ["size", "shape", "backgroundColor"],
                sectionId: "api"
            ),
            DocSidebarSection(
                title: tr("api.avatar.section.advanced"),
                items: ["gap", "content"],
                sectionId: "api"
            ),
            DocSidebarSection(
                title: tr("api.avatar.section.group"),
                items: ["group.maxCount", "group.content"],
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
    
    // MARK: - Item -> Card Mapping
    
    @ViewBuilder
    private func cardForItem(_ item: String) -> some View {
        switch item {
        case "icon": iconPropertyCard
        case "text": textPropertyCard
        case "image": imagePropertyCard
        case "src": srcPropertyCard
        case "fallbackIcon": fallbackIconPropertyCard
        case "size": sizePropertyCard
        case "shape": shapePropertyCard
        case "backgroundColor": backgroundColorPropertyCard
        case "gap": gapPropertyCard
        case "content": contentPropertyCard
        case "group.maxCount": groupMaxCountPropertyCard
        case "group.content": groupContentPropertyCard
        default: EmptyView()
        }
    }
    
    // MARK: - Property Cards
    
    private var iconPropertyCard: some View {
        PropertyCard(
            name: "icon",
            type: "String?",
            defaultValue: "nil",
            description: tr("avatar.api.icon"),
            sectionId: "api"
        ) {
            Moin.Avatar(icon: "person.fill")
        } code: {
            "Moin.Avatar(icon: \"person.fill\")"
        }
        .scrollAnchor("api.icon")
    }
    
    private var textPropertyCard: some View {
        PropertyCard(
            name: "text",
            type: "String?",
            defaultValue: "nil",
            description: tr("avatar.api.text"),
            sectionId: "api"
        ) {
            Moin.Avatar("U")
        } code: {
            "Moin.Avatar(\"U\")"
        }
        .scrollAnchor("api.text")
    }
    
    private var imagePropertyCard: some View {
        PropertyCard(
            name: "image",
            type: "Image?",
            defaultValue: "nil",
            description: tr("avatar.api.image"),
            sectionId: "api"
        ) {
            Moin.Avatar(image: Image(systemName: "photo"))
        } code: {
            "Moin.Avatar(image: Image(systemName: \"photo\"))"
        }
        .scrollAnchor("api.image")
    }
    
    private var srcPropertyCard: some View {
        PropertyCard(
            name: "src",
            type: "URL? | String",
            defaultValue: "nil",
            description: tr("avatar.api.src"),
            sectionId: "api"
        ) {
            Moin.Avatar(src: "https://api.dicebear.com/7.x/avataaars/png?seed=Felix")
        } code: {
            "Moin.Avatar(src: \"https://...\")"
        }
        .scrollAnchor("api.src")
    }
    
    private var fallbackIconPropertyCard: some View {
        PropertyCard(
            name: "fallbackIcon",
            type: "String",
            defaultValue: "\"person.fill\"",
            description: tr("avatar.api.fallback_icon"),
            sectionId: "api"
        ) {
            Moin.Avatar(src: "invalid", fallbackIcon: "exclamationmark.triangle")
        } code: {
            "Moin.Avatar(src: \"...\", fallbackIcon: \"exclamationmark.triangle\")"
        }
        .scrollAnchor("api.fallbackIcon")
    }
    
    private var sizePropertyCard: some View {
        PropertyCard(
            name: "size",
            type: "AvatarSize",
            defaultValue: ".default",
            description: tr("avatar.api.size"),
            enumValues: ".small | .default | .large | CGFloat",
            sectionId: "api"
        ) {
            HStack {
                Moin.Avatar(icon: "person", size: .small)
                Moin.Avatar(icon: "person", size: .default)
                Moin.Avatar(icon: "person", size: .large)
            }
        } code: {
            """
            Moin.Avatar(size: .small)
            Moin.Avatar(size: .default)
            Moin.Avatar(size: .large)
            Moin.Avatar(size: 64)
            """
        }
        .scrollAnchor("api.size")
    }
    
    private var shapePropertyCard: some View {
        PropertyCard(
            name: "shape",
            type: "AvatarShape",
            defaultValue: ".circle",
            description: tr("avatar.api.shape"),
            enumValues: ".circle | .square",
            sectionId: "api"
        ) {
            HStack {
                Moin.Avatar(icon: "person", shape: .circle)
                Moin.Avatar(icon: "person", shape: .square)
            }
        } code: {
            """
            Moin.Avatar(shape: .circle)
            Moin.Avatar(shape: .square)
            """
        }
        .scrollAnchor("api.shape")
    }
    
    private var backgroundColorPropertyCard: some View {
        PropertyCard(
            name: "backgroundColor",
            type: "AvatarColor?",
            defaultValue: "nil",
            description: tr("avatar.api.background_color"),
            enumValues: ".custom(Color) | .red | .orange | .yellow | .green | .cyan | .blue | .purple | .pink | .magenta | .volcano | .geekblue | .gold | .lime",
            sectionId: "api"
        ) {
            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.sm) {
                // Preset Colors
                Text("Preset Colors").font(.caption).foregroundStyle(.secondary)
                HStack {
                    Moin.Avatar("W", backgroundColor: .orange)
                    Moin.Avatar("V", backgroundColor: .volcano)
                }

                // Custom Colors
                Text(tr("tag.custom_colors")).font(.caption).foregroundStyle(.secondary)
                HStack {
                    Moin.Avatar("C", backgroundColor: .custom(Color(red: 0.8, green: 0.2, blue: 0.5)))
                    Moin.Avatar("H", backgroundColor: .custom(Color(hex: 0x722ED1)))
                }
            }
        } code: {
            """
            // \(tr("avatar.color_preset"))
            Moin.Avatar("W", backgroundColor: .orange)
            Moin.Avatar("V", backgroundColor: .volcano)
            
            // \(tr("tag.custom_colors"))
            Moin.Avatar("C", backgroundColor: .custom(Color(hex: 0x722ED1)))
            """
        }
        .scrollAnchor("api.backgroundColor")
    }
    
    private var gapPropertyCard: some View {
        PropertyCard(
            name: "gap",
            type: "CGFloat",
            defaultValue: "4",
            description: tr("avatar.api.gap"),
            sectionId: "api"
        ) {
             Moin.Avatar("LongText", size: .large, gap: 2)
        } code: {
            "Moin.Avatar(\"LongText\", gap: 2)"
        }
        .scrollAnchor("api.gap")
    }
    
    private var contentPropertyCard: some View {
        PropertyCard(
            name: "content",
            type: "@ViewBuilder",
            defaultValue: "-",
            description: tr("avatar.api.content"),
            sectionId: "api"
        ) {
            Moin.Avatar(content: {
                Text("C")
            })
        } code: {
            """
            Moin.Avatar {
                Text("C")
            }
            """
        }
        .scrollAnchor("api.content")
    }

    private var groupMaxCountPropertyCard: some View {
        PropertyCard(
            name: "maxCount",
            type: "Int?",
            defaultValue: "nil",
            description: tr("avatar.api.max_count"),
            sectionId: "api"
        ) {
            Moin.AvatarGroup(maxCount: 2) {
                Moin.Avatar("A")
                Moin.Avatar("B")
                Moin.Avatar("C")
            }
        } code: {
            """
            Moin.AvatarGroup(maxCount: 2) {
                Moin.Avatar("A")
                Moin.Avatar("B")
                Moin.Avatar("C")
            }
            """
        }
        .scrollAnchor("api.group.maxCount")
    }
    
    private var groupContentPropertyCard: some View {
        PropertyCard(
            name: "content",
            type: "@ViewBuilder",
            defaultValue: "-",
            description: tr("avatar.api.group_content"),
            sectionId: "api"
        ) {
            Moin.AvatarGroup {
                Moin.Avatar("A")
                Moin.Avatar("B")
            }
        } code: {
            """
            Moin.AvatarGroup {
                Moin.Avatar("A")
                Moin.Avatar("B")
            }
            """
        }
         .scrollAnchor("api.group.content")
    }
}
