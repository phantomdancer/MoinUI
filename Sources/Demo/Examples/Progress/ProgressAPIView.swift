import SwiftUI
import MoinUI

struct ProgressAPIView: View {
    @Localized var tr
    
    private var apiSections: [DocSidebarSection] {
        [
            DocSidebarSection(
                title: tr("api.button.section.common"),
                items: [.init(id: "percent"), .init(id: "type"), .init(id: "status"), .init(id: "showInfo"), .init(id: "steps"), .init(id: "strokeColor"), .init(id: "railColor"), .init(id: "size"), .init(id: "format"), .init(id: "strokeLinecap"), .init(id: "strokeWidth"), .init(id: "success"), .init(id: "gapDegree"), .init(id: "gapPosition"), .init(id: "percentPosition")],
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
    
    @ViewBuilder
    private func cardForItem(_ item: String) -> some View {
        switch item {
        case "percent": percentCard
        case "type": typeCard
        case "status": statusCard
        case "showInfo": showInfoCard
        case "steps": stepsCard
        case "strokeColor": strokeColorCard
        case "railColor": railColorCard
        case "size": sizeCard
        case "format": formatCard
        case "strokeLinecap": strokeLinecapCard
        case "success": successCard
        case "strokeWidth": strokeWidthCard
        case "gapDegree": gapDegreeCard
        case "gapPosition": gapPositionCard
        case "percentPosition": percentPositionCard
        default: EmptyView()
        }
    }
    
    // ... existing cards ...
    
    private var percentCard: some View {
        PropertyCard(
            name: "percent",
            type: "Double",
            defaultValue: "0",
            description: tr("api.progress.percent"),
            sectionId: "api"
        ) {
            VStack {
                 Moin.Progress(percent: 30)
                 Moin.Progress(percent: 70)
            }
        } code: {
            """
            Moin.Progress(percent: 30)
            """
        }
    }
    
    private var typeCard: some View {
        PropertyCard(
            name: "type",
            type: "Variant",
            defaultValue: ".line",
            description: tr("api.progress.type"),
            enumValues: ".line | .circle | .dashboard",
            sectionId: "api"
        ) {
             VStack(spacing: 20) {
                 Moin.Progress(percent: 50, type: .line)
                 HStack {
                     Moin.Progress(percent: 50, type: .circle, size: .small)
                     Moin.Progress(percent: 50, type: .dashboard, size: .small)
                 }
             }
        } code: {
            """
            Moin.Progress(percent: 50, type: .line)
            Moin.Progress(percent: 50, type: .circle)
            Moin.Progress(percent: 50, type: .dashboard)
            """
        }
    }
    
    private var statusCard: some View {
        PropertyCard(
            name: "status",
            type: "Status",
            defaultValue: "-",
            description: tr("api.progress.status"),
            enumValues: ".normal | .success | .exception | .active",
            sectionId: "api"
        ) {
            VStack {
                Moin.Progress(percent: 50, status: .active)
                Moin.Progress(percent: 70, status: .exception)
                Moin.Progress(percent: 100, status: .success)
            }
        } code: {
            """
            Moin.Progress(percent: 50, status: .active)
            Moin.Progress(percent: 70, status: .exception)
            Moin.Progress(percent: 100, status: .success)
            """
        }
    }
    
    private var showInfoCard: some View {
         PropertyCard(
            name: "showInfo",
            type: "Bool",
            defaultValue: "true",
            description: tr("api.progress.showInfo"),
            sectionId: "api"
        ) {
             Moin.Progress(percent: 50, showInfo: false)
        } code: {
            """
            Moin.Progress(percent: 50, showInfo: false)
            """
        }
    }
    
    private var stepsCard: some View {
         PropertyCard(
            name: "steps",
            type: "Int",
            defaultValue: "-",
            description: tr("api.progress.steps"),
            sectionId: "api"
        ) {
             Moin.Progress(percent: 50, steps: 3)
        } code: {
            """
            Moin.Progress(percent: 50, steps: 3)
            """
        }
    }
    
    private var strokeColorCard: some View {
         PropertyCard(
            name: "strokeColor",
            type: "Color",
            defaultValue: "-",
            description: tr("api.progress.strokeColor"),
            sectionId: "api"
        ) {
             Moin.Progress(percent: 50, strokeColor: .purple)
        } code: {
            """
            Moin.Progress(percent: 50, strokeColor: .purple)
            """
        }
    }
    
    private var railColorCard: some View {
         PropertyCard(
            name: "railColor",
            type: "Color",
            defaultValue: "-",
            description: tr("api.progress.railColor"),
            sectionId: "api"
        ) {
             Moin.Progress(percent: 50, railColor: .orange.opacity(0.2))
        } code: {
            """
            Moin.Progress(percent: 50, railColor: .orange.opacity(0.2))
            """
        }
    }
    
    private var sizeCard: some View {
         PropertyCard(
            name: "size",
            type: "Size",
            defaultValue: ".default",
            description: tr("api.progress.size"),
            enumValues: ".default | .small | .number(CGFloat) | .size(width: CGFloat, height: CGFloat)",
            sectionId: "api"
        ) {
             VStack {
                Moin.Progress(percent: 50, size: .small)
                Moin.Progress(percent: 50, size: .default)
             }
        } code: {
            """
            Moin.Progress(percent: 50, size: .small)
            """
        }
    }
    
    private var formatCard: some View {
         PropertyCard(
            name: "format",
            type: "(Double) -> View",
            defaultValue: "percent + %",
            description: tr("api.progress.format"),
            sectionId: "api"
        ) {
             Moin.Progress(percent: 50, format: { val in AnyView(Text("Done")) }, type: .circle)
        } code: {
            """
            Moin.Progress(percent: 50, format: { val in AnyView(Text("Done")) })
            """
        }
    }
    
    private var strokeLinecapCard: some View {
        PropertyCard(
            name: "strokeLinecap",
            type: "StrokeLinecap",
            defaultValue: ".round",
            description: tr("api.progress.strokeLinecap"),
            enumValues: ".round | .butt | .square",
            sectionId: "api"
        ) {
            HStack(spacing: 20) {
                VStack {
                    Text("Round").font(.caption)
                    Moin.Progress(percent: 75, strokeLinecap: .round, width: 80, type: .dashboard)
                }
                VStack {
                    Text("Butt").font(.caption)
                    Moin.Progress(percent: 75, strokeLinecap: .butt, width: 80, type: .dashboard)
                }
                VStack {
                    Text("Square").font(.caption)
                    Moin.Progress(percent: 75, strokeLinecap: .square, width: 80, type: .dashboard)
                }
            }
        } code: {
            """
            Moin.Progress(percent: 75, strokeLinecap: .round, width: 80, type: .dashboard)
            Moin.Progress(percent: 75, strokeLinecap: .butt, width: 80, type: .dashboard)
            Moin.Progress(percent: 75, strokeLinecap: .square, width: 80, type: .dashboard)
            """
        }
    }
    
    private var successCard: some View {
        PropertyCard(
            name: "success",
            type: "SuccessProps",
            defaultValue: "-",
            description: tr("api.progress.success"),
            sectionId: "api"
        ) {
            Moin.Progress(percent: 60, success: .init(percent: 30))
        } code: {
            """
            Moin.Progress(percent: 60, success: .init(percent: 30))
            """
        }
    }

    private var strokeWidthCard: some View {
        PropertyCard(
            name: "strokeWidth",
            type: "CGFloat",
            defaultValue: "-",
            description: tr("api.progress.strokeWidth"),
            sectionId: "api"
        ) {
            HStack {
                Moin.Progress(percent: 50, strokeWidth: 20, width: 80, type: .circle)
                Moin.Progress(percent: 50, strokeWidth: 20, width: 80, type: .dashboard)
            }
        } code: {
            """
            Moin.Progress(percent: 50, strokeWidth: 20, type: .circle)
            """
        }
    }

    private var gapDegreeCard: some View {
        PropertyCard(
            name: "gapDegree",
            type: "Double",
            defaultValue: "75",
            description: tr("api.progress.gapDegree"),
            sectionId: "api"
        ) {
            Moin.Progress(percent: 50, gapDegree: 100, type: .dashboard)
        } code: {
            """
            Moin.Progress(percent: 50, gapDegree: 100, type: .dashboard)
            """
        }
    }

    private var gapPositionCard: some View {
        PropertyCard(
            name: "gapPosition",
            type: "GapPosition",
            defaultValue: ".bottom",
            description: tr("api.progress.gapPosition"),
            enumValues: ".top | .bottom | .left | .right",
            sectionId: "api"
        ) {
            Moin.Progress(percent: 50, gapPosition: .left, type: .dashboard)
        } code: {
            """
            Moin.Progress(percent: 50, gapPosition: .left, type: .dashboard)
            """
        }
    }

    private var percentPositionCard: some View {
        PropertyCard(
            name: "percentPosition",
            type: "PercentPosition",
            defaultValue: "{ align: .end, type: .outer }",
            description: tr("api.progress.percentPosition"),
            sectionId: "api"
        ) {
            VStack(spacing: 16) {
                Moin.Progress(percent: 50, percentPosition: .init(align: .center, type: .inner))
                Moin.Progress(percent: 50, percentPosition: .init(align: .start, type: .outer))
            }
        } code: {
            """
            Moin.Progress(percent: 50, percentPosition: .init(align: .center, type: .inner))
            """
        }
    }
}
