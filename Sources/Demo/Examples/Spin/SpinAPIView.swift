import SwiftUI
import MoinUI

// MARK: - SpinAPIView

struct SpinAPIView: View {
    @Localized var tr
    
    // MARK: - API Sections
    
    private var apiSections: [DocSidebarSection] {
        [
            DocSidebarSection(
                title: "Moin.Spin",
                items: ["spinning", "size", "tip", "delay", "percent", "fullscreen", "indicator", "content"],
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
        case "percent": percentPropertyCard
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
            Moin.Spin(tip: "Loading...")
        } code: {
            "Moin.Spin(tip: \"Loading...\")"
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
            // Delay is hard to visualize static, just show code
            Text("Delay 500ms")
        } code: {
            "Moin.Spin(delay: 500)"
        }
        .scrollAnchor("spin.delay")
    }
    
    private var percentPropertyCard: some View {
        PropertyCard(
            name: "percent",
            type: "SpinPercent?",
            defaultValue: "nil",
            description: tr("spin.api.percent"),
            enumValues: ".value(Double) | .auto",
            sectionId: "spin"
        ) {
            // Percent usually implies progress?
            Moin.Spin(percent: .value(0.7))
        } code: {
            "Moin.Spin(percent: .value(0.7))"
        }
        .scrollAnchor("spin.percent")
    }
    
    private var fullscreenPropertyCard: some View {
        PropertyCard(
            name: "fullscreen",
            type: "Bool",
            defaultValue: "false",
            description: tr("spin.api.fullscreen"),
            sectionId: "spin"
        ) {
            // Can't show fullscreen in card, use dummy or text
            Text("Fullscreen Mode")
                .foregroundStyle(.secondary)
        } code: {
            "Moin.Spin(fullscreen: true)"
        }
        .scrollAnchor("spin.fullscreen")
    }
    
    private var indicatorPropertyCard: some View {
        PropertyCard(
            name: "indicator",
            type: "View?",
            defaultValue: "nil",
            description: tr("spin.api.indicator"),
            sectionId: "spin"
        ) {
            Moin.Spin {
                Image(systemName: "star.fill").foregroundStyle(.yellow)
            }
        } code: {
            """
            Moin.Spin {
                Image(systemName: "star.fill")
            }
            """
        }
        .scrollAnchor("spin.indicator")
    }
    
    private var contentPropertyCard: some View {
        PropertyCard(
            name: "content",
            type: "View?",
            defaultValue: "nil",
            description: tr("spin.api.content"),
            sectionId: "spin"
        ) {
            Moin.Spin(spinning: true) {
                Text("Content").padding()
            }
        } code: {
            """
            Moin.Spin {
                Text("Content")
            }
            """
        }
        .scrollAnchor("spin.content")
    }
}
