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
