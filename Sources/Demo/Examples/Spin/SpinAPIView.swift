import SwiftUI
import MoinUI

// MARK: - SpinAPIView

struct SpinAPIView: View {
    @Localized var tr
    @State private var delayLoading = false
    @State private var showFullscreen = false
    
    // MARK: - API Sections
    
    private var apiSections: [DocSidebarSection] {
        [
            DocSidebarSection(
                title: "Moin.Spin",
                items: [.init(id: "spinning"), .init(id: "size"), .init(id: "tip"), .init(id: "delay"), .init(id: "fullscreen"), .init(id: "indicator"), .init(id: "content")],
                sectionId: "spin"
            )
        ]
    }
    
    var body: some View {
        ComponentDocBody(
            sections: apiSections,
            initialItemId: "spin"
        ) { sectionId in
            if sectionId == "spin" {
                Text("Moin.Spin").font(.title3).fontWeight(.semibold)
            }
        } item: { item in
            cardForItem(item)
        }
    }
    
    @ViewBuilder
    private func cardForItem(_ item: String) -> some View {
        switch item {
        case "spinning": spinningPropertyCard
        case "size": sizePropertyCard
        case "tip": tipPropertyCard
        case "delay": delayPropertyCard
        case "fullscreen": fullscreenPropertyCard
        case "indicator": indicatorPropertyCard
        case "content": contentPropertyCard
        default: EmptyView()
        }
    }
    
    // MARK: - Property Cards
    
    private var spinningPropertyCard: some View {
        PropertyCard(
            name: "spinning",
            type: "Bool",
            defaultValue: "true",
            description: tr("spin.api.spinning"),
            sectionId: "spin"
        ) {
            Moin.Spin(spinning: true)
        } code: {
            "Moin.Spin(spinning: true)"
        }
        .scrollAnchor("spin.spinning")
    }
    
    private var sizePropertyCard: some View {
        PropertyCard(
            name: "size",
            type: "SpinSize",
            defaultValue: ".default",
            description: tr("spin.api.size"),
            enumValues: ".small | .default | .large",
            sectionId: "spin"
        ) {
            HStack(spacing: 20) {
                Moin.Spin(size: .small)
                Moin.Spin(size: .default)
                Moin.Spin(size: .large)
            }
        } code: {
            """
            Moin.Spin(size: .small)
            Moin.Spin(size: .default)
            Moin.Spin(size: .large)
            """
        }
        .scrollAnchor("spin.size")
    }
    
    private var tipPropertyCard: some View {
        PropertyCard(
            name: "tip",
            type: "String?",
            defaultValue: "nil",
            description: tr("spin.api.tip"),
            sectionId: "spin"
        ) {
            Moin.Spin(tip: tr("spin.loading"))
        } code: {
            "Moin.Spin(tip: \"\(tr("spin.loading"))\")"
        }
        .scrollAnchor("spin.tip")
    }
    
    private var delayPropertyCard: some View {
        PropertyCard(
            name: "delay",
            type: "Int?",
            defaultValue: "nil",
            description: tr("spin.api.delay"),
            sectionId: "spin"
        ) {
            VStack(alignment: .leading, spacing: 12) {
                Moin.Button(tr("spin.start_delay_loading")) {
                    delayLoading = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        delayLoading = false
                    }
                }
                .disabled(delayLoading)

                Text(tr("spin.delay_hint"))
                    .foregroundStyle(.secondary)

                if delayLoading {
                    Moin.Spin(tip: tr("spin.loading"), delay: 500)
                }
            }
            .frame(minHeight: 80)
        } code: {
            "Moin.Spin(spinning: true, delay: 500)"
        }
        .scrollAnchor("spin.delay")
    }
    
    private var fullscreenPropertyCard: some View {
        PropertyCard(
            name: "fullscreen",
            type: "Bool",
            defaultValue: "false",
            description: tr("spin.api.fullscreen"),
            sectionId: "spin"
        ) {
            Moin.Button(tr("spin.show_fullscreen")) {
                showFullscreen = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    showFullscreen = false
                }
            }
        } code: {
            "Moin.Spin(spinning: true, tip: \"\(tr("spin.fullscreen_loading"))\", fullscreen: true)"
        }
        .scrollAnchor("spin.fullscreen")
        .overlay {
            if showFullscreen {
                Moin.Spin(spinning: true, tip: tr("spin.fullscreen_loading"), fullscreen: true)
            }
        }
    }
    
    private var indicatorPropertyCard: some View {
        PropertyCard(
            name: "indicator",
            type: "@ViewBuilder () -> View",
            defaultValue: "nil",
            description: tr("spin.api.indicator"),
            sectionId: "spin"
        ) {
            Moin.Spin(indicator: {
                SpinRotatingImage(systemName: "star.fill")
                    .foregroundStyle(.yellow)
            })
        } code: {
            """
            Moin.Spin(indicator: {
                RotatingImage(systemName: "star.fill")
            })
            """
        }
        .scrollAnchor("spin.indicator")
    }
    
    private var contentPropertyCard: some View {
        PropertyCard(
            name: "content",
            type: "@ViewBuilder () -> Content",
            defaultValue: "nil",
            description: tr("spin.api.content"),
            sectionId: "spin"
        ) {
            Moin.Spin(spinning: true) {
                Text("Content")
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(4)
            }
        } code: {
            """
            Moin.Spin(spinning: isLoading) {
                Text("Content")
            }
            """
        }
        .scrollAnchor("spin.content")
    }
}

// MARK: - SpinRotatingImage

/// 自动旋转的图标
private struct SpinRotatingImage: View {
    let systemName: String
    @State private var isRotating = false

    var body: some View {
        Image(systemName: systemName)
            .rotationEffect(.degrees(isRotating ? 360 : 0))
            .animation(.linear(duration: 1).repeatForever(autoreverses: false), value: isRotating)
            .onAppear { isRotating = true }
    }
}
