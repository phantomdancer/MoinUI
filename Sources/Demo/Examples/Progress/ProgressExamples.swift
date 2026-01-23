import SwiftUI
import MoinUI

struct ProgressExamples: View {
    @Localized var tr
    
    private let anchors: [AnchorItem] = [
        AnchorItem(id: "line", titleKey: "progress.line"),
        AnchorItem(id: "circle", titleKey: "progress.circle"),
        AnchorItem(id: "mini_size", titleKey: "progress.mini_size"),
        AnchorItem(id: "dashboard", titleKey: "progress.dashboard"),
        AnchorItem(id: "dynamic", titleKey: "progress.dynamic"),
        AnchorItem(id: "format", titleKey: "progress.format"),
        AnchorItem(id: "gradient", titleKey: "progress.gradient"),
        AnchorItem(id: "steps", titleKey: "progress.steps"),
        AnchorItem(id: "circle_steps", titleKey: "progress.circle_steps"),
        AnchorItem(id: "info_position", titleKey: "progress.info_position"),
        AnchorItem(id: "segment", titleKey: "progress.segment"),
        AnchorItem(id: "linecap", titleKey: "progress.linecap"),
        AnchorItem(id: "size", titleKey: "progress.size"),
    ]
    
    var body: some View {
        ExamplePageWithAnchor(pageName: "Progress", anchors: anchors) { _ in
            lineExample.id("line")
            circleExample.id("circle")
            miniSizeExample.id("mini_size")
            dashboardExample.id("dashboard")
            dynamicExample.id("dynamic")
            formatExample.id("format")
            gradientExample.id("gradient")
            stepsExample.id("steps")
            circleStepsExample.id("circle_steps")
            infoPositionExample.id("info_position")
            segmentExample.id("segment")
            linecapExample.id("linecap")
            sizeExample.id("size")
        }
    }
    
    // MARK: - Components
    
    private var lineExample: some View {
        ExampleSection(title: tr("progress.line"), description: tr("progress.line_desc")) {
            VStack(spacing: 16) {
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
            HStack(spacing: 16) {
                Moin.Progress(percent: 75, type: .circle)
                Moin.Progress(percent: 70, status: .exception, type: .circle)
                Moin.Progress(percent: 100, type: .circle)
            }
        } code: {
            """
            Moin.Progress(percent: 75, type: .circle)
            Moin.Progress(percent: 70, status: .exception, type: .circle)
            Moin.Progress(percent: 100, type: .circle)
            """
        }
    }

    private var miniSizeExample: some View {
        ExampleSection(title: tr("progress.mini_size"), description: tr("progress.mini_size_desc")) {
            HStack(alignment: .top, spacing: 32) {
                // Line Mini
                VStack(spacing: 16) {
                     Moin.Progress(percent: 30, size: .small)
                     Moin.Progress(percent: 50, status: .active, size: .small)
                     Moin.Progress(percent: 70, status: .exception, size: .small)
                     Moin.Progress(percent: 100, size: .small)
                }
                .frame(maxWidth: .infinity)
                
                Divider()

                // Circle Mini
                HStack(spacing: 16) {
                    Moin.Progress(percent: 30, type: .circle, size: .number(80))
                    Moin.Progress(percent: 70, status: .exception, type: .circle, size: .number(80))
                    Moin.Progress(percent: 100, type: .circle, size: .number(80))
                }
                .frame(maxWidth: .infinity)
            }
        } code: {
            """
            // Line Mini
            Moin.Progress(percent: 30, size: .small)
            Moin.Progress(percent: 50, status: .active, size: .small)
            Moin.Progress(percent: 70, status: .exception, size: .small)
            Moin.Progress(percent: 100, size: .small)

            // Circle Mini
            Moin.Progress(percent: 30, type: .circle, size: .number(80))
            Moin.Progress(percent: 70, status: .exception, type: .circle, size: .number(80))
            Moin.Progress(percent: 100, type: .circle, size: .number(80))
            """
        }
    }

    private var dashboardExample: some View {
        ExampleSection(title: tr("progress.dashboard"), description: tr("progress.dashboard_desc")) {
            DashboardDemo()
        } code: {
            """
            Moin.Progress(percent: 30, gapDegree: gapDegree, gapPosition: gapPosition, type: .dashboard)
            """
        }
    }

    private var dynamicExample: some View {
        ExampleSection(title: tr("progress.dynamic"), description: tr("progress.dynamic_desc")) {
            DynamicDemo()
        } code: {
            """
            Moin.Progress(percent: percent, type: .line)
            Moin.Space(size: .medium) {
                Moin.Progress(percent: percent, type: .circle)
                Moin.Progress(percent: percent, type: .dashboard)
            }
            """
        }
    }

    private var formatExample: some View {
        ExampleSection(title: tr("progress.format"), description: tr("progress.format_desc")) {
             HStack(spacing: 16) {
                 Moin.Progress(percent: 75, format: { val in AnyView(Text("\(Int(val)) \(tr("progress.days"))")) }, type: .circle)
                 Moin.Progress(percent: 100, format: { _ in AnyView(Text(tr("progress.done"))) }, type: .circle)
             }
        } code: {
            """
            Moin.Progress(percent: 75, format: { "\\($0) Days" }, type: .circle)
            Moin.Progress(percent: 100, format: { "Done" }, type: .circle)
            """
        }
    }

    private var gradientExample: some View {
        ExampleSection(title: tr("progress.gradient"), description: tr("progress.gradient_desc")) {
            VStack(spacing: 16) {
                Moin.Progress(percent: 99.9, strokeGradient: .init(from: Color(hex: 0x108ee9), to: Color(hex: 0x87d068)))
                Moin.Progress(percent: 50, status: .active, strokeGradient: .init(from: Color(hex: 0x108ee9), to: Color(hex: 0x87d068)))
                
                HStack(spacing: 16) {
                     Moin.Progress(percent: 90, strokeGradient: .init(from: Color(hex: 0x108ee9), to: Color(hex: 0x87d068)), type: .circle)
                     Moin.Progress(percent: 100, strokeGradient: .init(from: Color(hex: 0x108ee9), to: Color(hex: 0x87d068)), type: .circle)
                     Moin.Progress(percent: 93, strokeGradient: .init(colors: [Color(hex: 0x87d068), Color(hex: 0xffe58f), Color(hex: 0xffccc7)]), type: .circle)
                }
                 
                HStack(spacing: 16) {
                     Moin.Progress(percent: 90, strokeGradient: .init(from: Color(hex: 0x108ee9), to: Color(hex: 0x87d068)), type: .dashboard)
                     Moin.Progress(percent: 100, strokeGradient: .init(from: Color(hex: 0x108ee9), to: Color(hex: 0x87d068)), type: .dashboard)
                     Moin.Progress(percent: 93, strokeGradient: .init(colors: [Color(hex: 0x87d068), Color(hex: 0xffe58f), Color(hex: 0xffccc7)]), type: .dashboard)
                }
            }
        } code: {
            """
            Moin.Progress(percent: 99.9, strokeGradient: .init(from: blue, to: green))
            Moin.Progress(percent: 90, strokeGradient: .init(from: blue, to: green), type: .circle)
            Moin.Progress(percent: 93, strokeGradient: .init(colors: [green, yellow, red]), type: .circle)
            """
        }
    }

    private var stepsExample: some View {
        ExampleSection(title: tr("progress.steps"), description: tr("progress.steps_desc")) {
            VStack(spacing: 16) {
                 Moin.Progress(percent: 50, steps: 3)
                 Moin.Progress(percent: 30, steps: 5)
                 Moin.Progress(percent: 100, strokeColor: Color.green, size: .small, steps: 5)
                 Moin.Progress(percent: 60, strokeColors: [.green, .green, .red], steps: 5)
            }
        } code: {
            """
            Moin.Progress(percent: 50, steps: 3)
            Moin.Progress(percent: 30, steps: 5)
            Moin.Progress(percent: 100, strokeColor: .green, size: .small, steps: 5)
            Moin.Progress(percent: 60, strokeColors: [.green, .green, .red], steps: 5)
            """
        }
    }

    private var circleStepsExample: some View {
        ExampleSection(title: tr("progress.circle_steps"), description: tr("progress.circle_steps_desc")) {
            CircleStepsDemo()
        } code: {
            """
            Moin.Progress(
                percent: 50,
                type: .dashboard,
                circleSteps: .init(count: 8)
            )
            Moin.Progress(
                percent: 100,
                type: .circle,
                circleSteps: .init(count: 5, gap: 7)
            )
            """
        }
    }

    private var infoPositionExample: some View {
        ExampleSection(title: tr("progress.info_position"), description: tr("progress.info_position_desc")) {
            VStack(spacing: 12) {
                Moin.Progress(
                    percent: 0,
                    strokeColor: Color(hex: 0xE6F4FF),
                    size: .size(width: 200, height: 20),
                    percentPosition: .init(align: .center, type: .inner)
                )
                Moin.Progress(
                    percent: 10,
                    size: .size(width: 300, height: 20),
                    percentPosition: .init(align: .center, type: .inner)
                )
                Moin.Progress(
                    percent: 50,
                    strokeColor: Color(hex: 0xB7EB8F),
                    size: .size(width: 300, height: 20),
                    percentPosition: .init(align: .start, type: .inner)
                )
                Moin.Progress(
                    percent: 60,
                    strokeColor: Color(hex: 0x001342),
                    size: .size(width: 300, height: 20),
                    percentPosition: .init(align: .end, type: .inner)
                )
                Moin.Progress(
                    percent: 100,
                    size: .size(width: 400, height: 20),
                    percentPosition: .init(align: .center, type: .inner)
                )
                Moin.Progress(percent: 60, percentPosition: .init(align: .start, type: .outer))
                Moin.Progress(percent: 100, percentPosition: .init(align: .start, type: .outer))
                Moin.Progress(percent: 60, size: .small, percentPosition: .init(align: .center, type: .outer))
                Moin.Progress(percent: 100, percentPosition: .init(align: .center, type: .outer))
            }
        } code: {
            """
            Moin.Progress(
                percent: 50,
                size: .size(width: 300, height: 20),
                percentPosition: .init(align: .center, type: .inner)
            )
            Moin.Progress(
                percent: 60,
                percentPosition: .init(align: .start, type: .outer)
            )
            """
        }
    }

    private var segmentExample: some View {
        ExampleSection(title: tr("progress.segment"), description: tr("progress.segment_desc")) {
            VStack(spacing: 16) {
                 Moin.Progress(percent: 60, success: .init(percent: 30))
                 HStack(spacing: 16) {
                     Moin.Progress(percent: 60, success: .init(percent: 30), type: .circle)
                     Moin.Progress(percent: 60, success: .init(percent: 30), type: .dashboard)
                 }
            }
        } code: {
            """
            Moin.Progress(percent: 60, success: .init(percent: 30))
            Moin.Progress(percent: 60, success: .init(percent: 30), type: .circle)
            """
        }
    }

    private var linecapExample: some View {
        ExampleSection(title: tr("progress.linecap"), description: tr("progress.linecap_desc")) {
            VStack(spacing: 16) {
                Moin.Progress(percent: 75, strokeLinecap: .butt)
                HStack(spacing: 16) {
                     Moin.Progress(percent: 75, strokeLinecap: .butt, type: .circle)
                     Moin.Progress(percent: 75, strokeLinecap: .butt, type: .dashboard)
                }
            }
        } code: {
            """
            Moin.Progress(percent: 75, strokeLinecap: .butt)
            """
        }
    }

    private var sizeExample: some View {
        ExampleSection(title: tr("progress.size"), description: tr("progress.size_desc")) {
             VStack(spacing: 32) {
                 VStack(spacing: 16) {
                     Moin.Progress(percent: 50)
                     Moin.Progress(percent: 50, size: .small)
                     Moin.Progress(percent: 50, size: .size(width: 300, height: 20)) 
                 }
                 .frame(width: 300)
                 
                 HStack(spacing: 30) {
                     Moin.Progress(percent: 50, type: .circle)
                     Moin.Progress(percent: 50, type: .circle, size: .small)
                     Moin.Progress(percent: 50, type: .circle, size: .number(20))
                 }
                 
                 HStack(spacing: 30) {
                     Moin.Progress(percent: 50, type: .dashboard)
                     Moin.Progress(percent: 50, type: .dashboard, size: .small)
                     Moin.Progress(percent: 50, type: .dashboard, size: .number(20))
                 }
             }
        } code: {
            """
            Moin.Progress(percent: 50, size: .small)
            Moin.Progress(percent: 50, size: .size(width: 300, height: 20))
            Moin.Progress(percent: 50, type: .circle, size: .number(20))
            """
        }
    }
}

// MARK: - Sub Demos

private struct DashboardDemo: View {
    @Localized var tr
    @Environment(\.moinToken) var token
    @State private var gapDegree: Double = 50
    @State private var gapPosition: Moin.Progress.GapPosition = .bottom
    
    var body: some View {
        HStack(alignment: .center, spacing: 32) {
            VStack(alignment: .leading, spacing: 16) {
                 HStack {
                     Text(tr("progress.gap_degree"))
                     Picker("", selection: $gapDegree) {
                         Text("50").tag(50.0)
                         Text("100").tag(100.0)
                     }
                     .pickerStyle(.segmented)
                     .fixedSize()
                 }
                
                HStack {
                    Text(tr("progress.gap_position"))
                    Picker("", selection: $gapPosition) {
                        Text("Top").tag(Moin.Progress.GapPosition.top)
                        Text("Bottom").tag(Moin.Progress.GapPosition.bottom)
                        Text("Left").tag(Moin.Progress.GapPosition.left)
                        Text("Right").tag(Moin.Progress.GapPosition.right)
                    }
                    .pickerStyle(.segmented)
                    .fixedSize()
                }
            }
            .frame(minWidth: 350, maxWidth: .infinity, alignment: .leading)
            
            Divider()
            
            VStack {
                Moin.Progress(percent: 30, gapDegree: gapDegree, gapPosition: gapPosition, type: .dashboard)
            }
            .frame(maxWidth: .infinity)
        }
    }
}

private struct DynamicDemo: View {
    @Localized var tr
    @Environment(\.moinToken) var token
    @State private var percent: Double = 90
    
    func increase() {
        var newPercent = percent + 10
        if newPercent > 100 { newPercent = 100 }
        withAnimation {
             percent = newPercent
        }
    }
    
    func decline() {
        var newPercent = percent - 10
        if newPercent < 0 { newPercent = 0 }
        withAnimation {
             percent = newPercent
        }
    }
    
    var body: some View {
        Moin.Space(size: .medium) {
            Moin.Progress(percent: percent, type: .line)
            Moin.Progress(percent: percent, type: .circle)
            Moin.Progress(percent: percent, type: .dashboard)
            
            Moin.Button(icon: "minus") {
                decline()
            }
            Moin.Button(icon: "plus") {
                increase()
            }
        }
    }
}

private struct CircleStepsDemo: View {
    @Localized var tr
    @State private var stepsCount: Int = 5
    @State private var stepsGap: CGFloat = 7

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text(tr("progress.custom_count"))
                Slider(value: Binding(
                    get: { Double(stepsCount) },
                    set: { stepsCount = Int($0) }
                ), in: 2...10, step: 1)
                Text("\(stepsCount)")
            }

            HStack {
                Text(tr("progress.custom_gap"))
                Slider(value: $stepsGap, in: 0...40, step: 4)
                Text("\(Int(stepsGap))")
            }

            HStack(spacing: 16) {
                Moin.Progress(
                    percent: 50,
                    strokeWidth: 20,
                    railColor: Color.black.opacity(0.06),
                    type: .dashboard,
                    circleSteps: .init(count: 8)
                )
                Moin.Progress(
                    percent: 100,
                    strokeWidth: 20,
                    railColor: Color.black.opacity(0.06),
                    type: .circle,
                    circleSteps: .init(count: stepsCount, gap: stepsGap)
                )
            }
        }
    }
}
