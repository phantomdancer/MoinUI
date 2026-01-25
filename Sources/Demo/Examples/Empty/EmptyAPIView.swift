import SwiftUI
import MoinUI

// MARK: - EmptyAPIView

struct EmptyAPIView: View {
    @Localized var tr
    
    // MARK: - API Sections
    
    private var apiSections: [DocSidebarSection] {
        [
            DocSidebarSection(
                title: "Moin.Empty",
                items: [.init(id: "image"), .init(id: "description"), .init(id: "content")],
                sectionId: "empty"
            )
        ]
    }

    var body: some View {
        ComponentDocBody(
            sections: apiSections,
            initialItemId: "empty"
        ) { sectionId in
            if sectionId == "empty" {
                Text("Moin.Empty").font(.title3).fontWeight(.semibold)
            }
        } item: { item in
            cardForItem(item)
        }
    }
    
    @ViewBuilder
    private func cardForItem(_ item: String) -> some View {
        switch item {
        case "image": imagePropertyCard
        case "description": descriptionPropertyCard
        case "content": contentPropertyCard
        default: EmptyView()
        }
    }
    
    // MARK: - Property Cards
    
    private var imagePropertyCard: some View {
        PropertyCard(
            name: "image",
            type: "ImageType",
            defaultValue: ".default",
            description: tr("empty.api.image"),
            enumValues: ".default | .simple | .custom(Image) | .systemIcon(String) | .url(String) | .none",
            sectionId: "empty"
        ) {
            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.lg) {
                // .default
                imageTypeRow(
                    name: ".default",
                    desc: tr("empty.api.image_default")
                ) {
                    Moin.Empty(image: .default)
                        .scaleEffect(0.5)
                        .frame(height: 80)
                }
                
                Moin.Divider()
                
                // .simple
                imageTypeRow(
                    name: ".simple",
                    desc: tr("empty.api.image_simple")
                ) {
                    Moin.Empty(image: .simple)
                        .scaleEffect(0.6)
                        .frame(height: 60)
                }
                
                Moin.Divider()
                
                // .systemIcon
                imageTypeRow(
                    name: ".systemIcon(String)",
                    desc: tr("empty.api.image_system")
                ) {
                    Moin.Empty(image: .systemIcon("folder"))
                        .scaleEffect(0.6)
                        .frame(height: 60)
                }
                
                Moin.Divider()
                
                // .url
                imageTypeRow(
                    name: ".url(String)",
                    desc: tr("empty.api.image_url")
                ) {
                    Moin.Empty(image: .url("https://api.dicebear.com/7.x/shapes/png?seed=empty"))
                        .scaleEffect(0.5)
                        .frame(height: 80)
                }
                
                Moin.Divider()
                
                // .custom
                imageTypeRow(
                    name: ".custom(Image)",
                    desc: tr("empty.api.image_custom")
                ) {
                    Moin.Empty(image: .custom(Image(systemName: "star.circle.fill")))
                        .scaleEffect(0.6)
                        .frame(height: 60)
                }
                
                Moin.Divider()
                
                // .none
                imageTypeRow(
                    name: ".none",
                    desc: tr("empty.api.image_none")
                ) {
                    Moin.Empty(image: .none, description: tr("empty.default_description"))
                        .frame(height: 40)
                }
            }
        } code: {
            """
            Moin.Empty(image: .default)
            Moin.Empty(image: .simple)
            Moin.Empty(image: .systemIcon("folder"))
            Moin.Empty(image: .url("https://..."))
            Moin.Empty(image: .custom(Image(...)))
            Moin.Empty(image: .none)
            """
        }
        .scrollAnchor("empty.image")
    }
    
    @ViewBuilder
    private func imageTypeRow<Content: View>(name: String, desc: String, @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: Moin.Constants.Spacing.sm) {
            HStack {
                Text(name)
                    .font(.system(size: 12, design: .monospaced))
                    .fontWeight(.medium)
                Text("-")
                    .foregroundStyle(.secondary)
                Text(desc)
                    .font(.system(size: 12))
                    .foregroundStyle(.secondary)
            }
            content()
        }
    }
    
    private var descriptionPropertyCard: some View {
        PropertyCard(
            name: "description",
            type: "String?",
            defaultValue: "nil",
            description: tr("empty.api.description"),
            sectionId: "empty"
        ) {
            Moin.Empty(image: .simple, description: "Hello")
        } code: {
            "Moin.Empty(description: \"Hello\")"
        }
        .scrollAnchor("empty.description")
    }
    
    private var contentPropertyCard: some View {
        PropertyCard(
            name: "content",
            type: "@ViewBuilder",
            defaultValue: "-",
            description: tr("empty.api.content"),
            sectionId: "empty"
        ) {
            Moin.Empty(image: .simple, description: "No Data") {
                Moin.Button("Retry") {}
            }
        } code: {
            """
            Moin.Empty {
                Moin.Button("Retry") {}
            }
            """
        }
        .scrollAnchor("empty.content")
    }
}
