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
                items: ["image", "description", "content"],
                sectionId: "empty"
            ),
            DocSidebarSection(
                title: "ImageType",
                items: ["image_type"], // This seems to be an Enum description, not a property list?
                sectionId: "type"
            )
        ]
    }
    
    // Note: older API content had a table for ImageType values.
    // I should probably represent ImageType as a PropertyCard for "image" property with enumValues description, 
    // OR a separate section describing the Enum values.
    // The previous implementation had a separate table.
    // I can put `image` property card in "Moin.Empty" section.
    // And for "ImageType" section, maybe just one card explaining values? 
    // Or I can integrate the Enum values into the `image` property card description?
    // Let's integrate it into `image` property card `enumValues`.
    
    // But wait, `ImageType` has detailed descriptions for each case in the old table.
    // `PropertyCard` `enumValues` usually is just a string list.
    
    // I will drop the separate "ImageType" section and just make `image` property card comprehensive.
    // OR create a special card for it?
    // Let's stick to standard `PropertyCard`. I can list enum values there.
    
    private var refinedApiSections: [DocSidebarSection] {
        [
             DocSidebarSection(
                title: "Moin.Empty",
                items: ["image", "description", "content"],
                sectionId: "empty"
            )
        ]
    }

    var body: some View {
        ComponentDocBody(
            sections: refinedApiSections,
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
            HStack(spacing: 20) {
                Moin.Empty(image: .simple)
                Moin.Empty(image: .default)
            }
            .scaleEffect(0.5)
            .frame(height: 100)
        } code: {
            """
            Moin.Empty(image: .simple)
            Moin.Empty(image: .default)
            """
        }
        .scrollAnchor("empty.image")
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
