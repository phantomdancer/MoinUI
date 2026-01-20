import SwiftUI
import MoinUI

// MARK: - EmptyTokenView

struct EmptyTokenView: View {
    @Localized var tr
    @Environment(\.moinToken) var token
    @ObservedObject var config = Moin.ConfigProvider.shared
    
    // MARK: - Token Sections
    
    private var tokenSections: [DocSidebarSection] {
        [
            DocSidebarSection(
                title: tr("empty.token.component"),
                items: [
                    "imageHeight", "imageHeightSM",
                    "imageColor", "imageOpacity",
                    "descriptionColor", "descriptionFontSize",
                    "imageMarginBottom", "contentMarginTop"
                ],
                sectionId: "token"
            )
        ]
    }
    
    var body: some View {
        ComponentDocBody(
            sections: tokenSections,
            initialItemId: "token"
        ) { sectionId in
            if sectionId == "token" {
                Text(tr("empty.token.component"))
                    .font(.title3)
                    .fontWeight(.semibold)
            }
        } item: { item in
            cardForItem(item)
        }
    }
    
    @ViewBuilder
    private func cardForItem(_ item: String) -> some View {
        switch item {
        // Height
        case "imageHeight": imageHeightCard
        case "imageHeightSM": imageHeightSMCard
        // Image Style
        case "imageColor": imageColorCard
        case "imageOpacity": imageOpacityCard
        // Description
        case "descriptionColor": descriptionColorCard
        case "descriptionFontSize": descriptionFontSizeCard
        // Spacing
        case "imageMarginBottom": imageMarginBottomCard
        case "contentMarginTop": contentMarginTopCard
        default: EmptyView()
        }
    }
    
    // MARK: - Cards
    
    private var imageHeightCard: some View {
        TokenCard(
            name: "imageHeight",
            type: "CGFloat",
            defaultValue: "100",
            description: tr("empty.token.imageHeight"),
            sectionId: "token"
        ) {
            Moin.Empty(image: .default)
        } editor: {
            TokenValueRow(label: "imageHeight", value: Binding(
                 get: { Moin.ConfigProvider.shared.components.empty.imageHeight },
                 set: { Moin.ConfigProvider.shared.components.empty.imageHeight = $0 }
            ))
        } code: {
            "config.components.empty.imageHeight = \(Int(config.components.empty.imageHeight))"
        }
        .scrollAnchor("token.imageHeight")
    }
    
    private var imageHeightSMCard: some View {
        TokenCard(
            name: "imageHeightSM",
            type: "CGFloat",
            defaultValue: "35",
            description: tr("empty.token.imageHeightSM"),
            sectionId: "token"
        ) {
            Moin.Empty(image: .simple)
        } editor: {
            TokenValueRow(label: "imageHeightSM", value: Binding(
                 get: { Moin.ConfigProvider.shared.components.empty.imageHeightSM },
                 set: { Moin.ConfigProvider.shared.components.empty.imageHeightSM = $0 }
            ))
        } code: {
            "config.components.empty.imageHeightSM = \(Int(config.components.empty.imageHeightSM))"
        }
        .scrollAnchor("token.imageHeightSM")
    }
    
    private var imageColorCard: some View {
        TokenCard(
           name: "imageColor",
           type: "Color",
           defaultValue: "token.colorBorder",
           description: tr("empty.token.imageColor"),
           sectionId: "token"
       ) {
           Moin.Empty(image: .simple)
       } editor: {
           ColorPresetRow(label: "imageColor", color: Binding(
                get: { Moin.ConfigProvider.shared.components.empty.imageColor },
                set: { Moin.ConfigProvider.shared.components.empty.imageColor = $0 }
           ))
       } code: {
           "config.components.empty.imageColor = Color(...)"
       }
       .scrollAnchor("token.imageColor")
   }

    private var imageOpacityCard: some View {
        TokenCard(
            name: "imageOpacity",
            type: "Double",
            defaultValue: "1.0",
            description: tr("empty.token.imageOpacity"),
            sectionId: "token"
        ) {
            Moin.Empty(image: .simple)
        } editor: {
            TokenValueRow(label: "imageOpacity", value: Binding(
                 get: { CGFloat(Moin.ConfigProvider.shared.components.empty.imageOpacity) },
                 set: { Moin.ConfigProvider.shared.components.empty.imageOpacity = Double($0) }
            ), range: 0...1)
        } code: {
            "config.components.empty.imageOpacity = \(config.components.empty.imageOpacity)"
        }
        .scrollAnchor("token.imageOpacity")
    }
    
    private var descriptionColorCard: some View {
         TokenCard(
            name: "descriptionColor",
            type: "Color",
            defaultValue: "token.colorTextSecondary",
            description: tr("empty.token.descriptionColor"),
            sectionId: "token"
        ) {
            Moin.Empty(description: "Description Text")
        } editor: {
            ColorPresetRow(label: "descriptionColor", color: Binding(
                 get: { Moin.ConfigProvider.shared.components.empty.descriptionColor },
                 set: { Moin.ConfigProvider.shared.components.empty.descriptionColor = $0 }
            ))
        } code: {
            "config.components.empty.descriptionColor = Color(...)"
        }
        .scrollAnchor("token.descriptionColor")
    }
    
    private var descriptionFontSizeCard: some View {
        TokenCard(
            name: "descriptionFontSize",
            type: "CGFloat",
            defaultValue: "14",
            description: tr("empty.token.descriptionFontSize"),
            sectionId: "token"
        ) {
            Moin.Empty(description: "Description Text")
        } editor: {
            TokenValueRow(label: "descriptionFontSize", value: Binding(
                 get: { Moin.ConfigProvider.shared.components.empty.descriptionFontSize },
                 set: { Moin.ConfigProvider.shared.components.empty.descriptionFontSize = $0 }
            ))
        } code: {
            "config.components.empty.descriptionFontSize = \(Int(config.components.empty.descriptionFontSize))"
        }
        .scrollAnchor("token.descriptionFontSize")
    }
    
    private var imageMarginBottomCard: some View {
        TokenCard(
            name: "imageMarginBottom",
            type: "CGFloat",
            defaultValue: "8",
            description: tr("empty.token.imageMarginBottom"),
            sectionId: "token"
        ) {
            Moin.Empty(description: "Description")
                .border(Color.red.opacity(0.3)) // visualize margin?
        } editor: {
            TokenValueRow(label: "imageMarginBottom", value: Binding(
                 get: { Moin.ConfigProvider.shared.components.empty.imageMarginBottom },
                 set: { Moin.ConfigProvider.shared.components.empty.imageMarginBottom = $0 }
            ))
        } code: {
            "config.components.empty.imageMarginBottom = \(Int(config.components.empty.imageMarginBottom))"
        }
        .scrollAnchor("token.imageMarginBottom")
    }
    
    private var contentMarginTopCard: some View {
         TokenCard(
             name: "contentMarginTop",
             type: "CGFloat",
             defaultValue: "16",
             description: tr("empty.token.contentMarginTop"),
             sectionId: "token"
         ) {
             Moin.Empty(description: "Description") {
                 Moin.Button("Action") {}
             }
         } editor: {
             TokenValueRow(label: "contentMarginTop", value: Binding(
                  get: { Moin.ConfigProvider.shared.components.empty.contentMarginTop },
                  set: { Moin.ConfigProvider.shared.components.empty.contentMarginTop = $0 }
             ))
         } code: {
             "config.components.empty.contentMarginTop = \(Int(config.components.empty.contentMarginTop))"
         }
         .scrollAnchor("token.contentMarginTop")
     }
}
