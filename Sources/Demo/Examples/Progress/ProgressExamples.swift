import SwiftUI
import MoinUI

struct ProgressExamples: View {
    @Localized var tr
    
    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                // 1. Line (Standard)
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
                
                // 2. Circle
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
                
                // 3. Line Mini
                ExampleSection(title: tr("progress.line_mini"), description: tr("progress.line_mini_desc")) {
                    VStack(spacing: 16) {
                         Moin.Progress(percent: 30, size: .small)
                         Moin.Progress(percent: 50, status: .active, size: .small)
                         Moin.Progress(percent: 70, status: .exception, size: .small)
                         Moin.Progress(percent: 100, size: .small)
                    }
                    .frame(width: 180) // AntD demo width
                } code: {
                    """
                    Moin.Progress(percent: 30, size: .small)
                    Moin.Progress(percent: 50, status: .active, size: .small)
                    Moin.Progress(percent: 70, status: .exception, size: .small)
                    Moin.Progress(percent: 100, size: .small)
                    """
                }
                
                // 4. Circle Mini
                ExampleSection(title: tr("progress.circle_mini"), description: tr("progress.circle_mini_desc")) {
                    HStack(spacing: 16) {
                        Moin.Progress(percent: 30, type: .circle, size: .number(80))
                        Moin.Progress(percent: 70, status: .exception, type: .circle, size: .number(80))
                        Moin.Progress(percent: 100, type: .circle, size: .number(80))
                    }
                } code: {
                    """
                    Moin.Progress(percent: 30, type: .circle, size: .number(80))
                    Moin.Progress(percent: 70, status: .exception, type: .circle, size: .number(80))
                    Moin.Progress(percent: 100, type: .circle, size: .number(80))
                    """
                }
                
                // 5. Dashboard
                ExampleSection(title: tr("progress.dashboard"), description: tr("progress.dashboard_desc")) {
                    DashboardDemo()
                } code: {
                    """
                    Moin.Progress(percent: 30, gapDegree: gapDegree, type: .dashboard)
                    """
                }
                
                // 6. Dynamic
                ExampleSection(title: tr("progress.dynamic"), description: tr("progress.dynamic_desc")) {
                    DynamicDemo()
                } code: {
                    """
                    Moin.Progress(percent: percent, type: .line)
                    Moin.Button(icon: "minus") { decline() }
                    Moin.Button(icon: "plus") { increase() }
                    """
                }
                
                // 7. Format
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
                
                // 8. GradientLine
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
                
                // 9. Steps
                ExampleSection(title: tr("progress.steps"), description: tr("progress.steps_desc")) {
                    VStack(spacing: 16) {
                         Moin.Progress(percent: 50, steps: 3)
                         Moin.Progress(percent: 30, steps: 5)
                         Moin.Progress(percent: 100, strokeColor: Color.green, size: .small, steps: 5)
                         Moin.Progress(percent: 60, strokeColor: Color.green, steps: 5)
                    }
                } code: {
                    """
                    Moin.Progress(percent: 50, steps: 3)
                    Moin.Progress(percent: 30, steps: 5)
                    Moin.Progress(percent: 100, strokeColor: .green, size: .small, steps: 5)
                    """
                }
                
                // 10. Segment
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
                
                // 11. Linecap
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
                
                // 12. Size
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
            .padding()
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
             
             Moin.Progress(percent: 30, gapDegree: gapDegree, gapPosition: gapPosition, type: .dashboard)
        }
    }
}

private struct DynamicDemo: View {
    @Localized var tr
    @Environment(\.moinToken) var token
    @State private var percent: Double = 0
    
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
        VStack(spacing: 16) {
            VStack(spacing: 16) {
                Moin.Progress(percent: percent, type: .line)
                Moin.Progress(percent: percent, type: .circle)
                Moin.Progress(percent: percent, type: .dashboard)
            }
            HStack(spacing: 8) {
                Moin.Button(icon: "minus") {
                    decline()
                }
                Moin.Button(icon: "plus") {
                    increase()
                }
            }
        }
    }
}


