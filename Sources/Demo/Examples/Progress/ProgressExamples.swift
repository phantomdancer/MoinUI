import SwiftUI
import MoinUI

struct ProgressExamples: View {
    @Localized var tr
    
    private let anchors: [AnchorItem] = [
        AnchorItem(id: "line", titleKey: "progress.line"),
        AnchorItem(id: "circle", titleKey: "progress.circle"),
        AnchorItem(id: "dashboard", titleKey: "progress.dashboard"),
        AnchorItem(id: "steps", titleKey: "progress.steps"),
        AnchorItem(id: "size", titleKey: "progress.size"),
        AnchorItem(id: "status", titleKey: "progress.status")
    ]
    
    var body: some View {
        ExamplePageWithAnchor(pageName: "Progress", anchors: anchors) { _ in
            lineExample.id("line")
            circleExample.id("circle")
            dashboardExample.id("dashboard")
            stepsExample.id("steps")
            sizeExample.id("size")
            statusExample.id("status")
        }
    }
    
    private var lineExample: some View {
        ExampleSection(title: tr("progress.line"), description: tr("progress.line_desc")) {
            VStack(spacing: 20) {
                Moin.Progress(percent: 30)
                Moin.Progress(percent: 50, status: .active)
                Moin.Progress(percent: 70, status: .exception)
                Moin.Progress(percent: 100)
                Moin.Progress(percent: 50, showInfo: false)
            }
        } code: {
            """
            Moin.Progress(percent: 30)
            Moin.Progress(percent: 50, status: .active)
            Moin.Progress(percent: 70, status: .exception)
            Moin.Progress(percent: 100)
            Moin.Progress(percent: 50, showInfo: false)
            """
        }
    }
    
    private var circleExample: some View {
        ExampleSection(title: tr("progress.circle"), description: tr("progress.circle_desc")) {
            HStack(spacing: 20) {
                Moin.Progress(percent: 75, type: .circle)
                Moin.Progress(percent: 70, status: .exception, type: .circle)
                Moin.Progress(percent: 100, type: .circle)
            }
        } code: {
            """
            Moin.Progress(percent: 75, type: .circle)
            Moin.Progress(percent: 70, type: .circle, status: .exception)
            Moin.Progress(percent: 100, type: .circle)
            """
        }
    }
    
    private var dashboardExample: some View {
        ExampleSection(title: tr("progress.dashboard"), description: tr("progress.dashboard_desc")) {
            HStack(spacing: 20) {
                Moin.Progress(percent: 75, type: .dashboard)
                Moin.Progress(percent: 75, status: .exception, type: .dashboard)
            }
        } code: {
            """
            Moin.Progress(percent: 75, type: .dashboard)
            Moin.Progress(percent: 75, type: .dashboard, status: .exception)
            """
        }
    }
    
    private var stepsExample: some View {
         ExampleSection(title: tr("progress.steps"), description: tr("progress.steps_desc")) {
            VStack(spacing: 20) {
                Moin.Progress(percent: 50, steps: 3)
                Moin.Progress(percent: 30, steps: 5)
                Moin.Progress(percent: 100, strokeColor: .green, steps: 5)
            }
         } code: {
            """
            Moin.Progress(percent: 50, steps: 3)
            Moin.Progress(percent: 30, steps: 5)
            Moin.Progress(percent: 100, steps: 5, strokeColor: .green)
            """
         }
    }
    
    private var sizeExample: some View {
        ExampleSection(title: tr("progress.size"), description: tr("progress.size_desc")) {
             VStack(spacing: 20) {
                Moin.Progress(percent: 50, size: .small)
                Moin.Progress(percent: 50, size: .default)
                Moin.Progress(percent: 50, type: .circle, size: .small)
                Moin.Progress(percent: 50, type: .circle, size: .default)
                Moin.Progress(percent: 50, type: .dashboard, size: .small)
            }
        } code: {
            """
            Moin.Progress(percent: 50, size: .small)
            """
        }
    }
    
    private var statusExample: some View {
        ExampleSection(title: tr("progress.status"), description: tr("progress.status_desc")) {
             VStack(spacing: 20) {
                Moin.Progress(percent: 100, format: { _ in AnyView(Text("Done")) })
                Moin.Progress(percent: 99.9, format: { _ in AnyView(Text("Loading")) }, type: .circle)
             }
        } code: {
            """
            Moin.Progress(percent: 100, format: { _ in AnyView(Text("Done")) })
            """
        }
    }
}
