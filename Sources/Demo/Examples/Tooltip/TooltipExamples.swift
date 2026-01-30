import SwiftUI
import MoinUI

enum TooltipExamplesTab: String, CaseIterable {
    case examples
    case api
    case token
}

struct TooltipExamples: View {
    @Localized var tr
    @Binding var selectedTab: TooltipExamplesTab
    
    init(selectedTab: Binding<TooltipExamplesTab>) {
        self._selectedTab = selectedTab
    }
    
    // Lazy load states
    @State private var apiReady = false
    @State private var tokenReady = false
    
    private let anchors: [AnchorItem] = [
        AnchorItem(id: "basic", titleKey: "tooltip.basic"),
        AnchorItem(id: "placement", titleKey: "tooltip.placement"),
        AnchorItem(id: "arrow", titleKey: "tooltip.arrow"),
        AnchorItem(id: "color", titleKey: "tooltip.color"),
        AnchorItem(id: "trigger", titleKey: "tooltip.trigger")
    ]
    
    var body: some View {
        Group {
            switch selectedTab {
            case .examples:
                examplesContent
            case .api:
                if apiReady {
                    TooltipAPIView()
                } else {
                    loadingView
                }
            case .token:
                if tokenReady {
                    TooltipTokenView()
                } else {
                    loadingView
                }
            }
        }
        .onAppear { triggerLazyLoad(for: selectedTab) }
        .onChange(of: selectedTab) { newValue in
            triggerLazyLoad(for: newValue)
        }
    }
    
    private var loadingView: some View {
        Moin.Spin()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private func triggerLazyLoad(for tab: TooltipExamplesTab) {
        switch tab {
        case .examples:
            break
        case .api:
            if !apiReady { DispatchQueue.main.async { apiReady = true } }
        case .token:
            if !tokenReady { DispatchQueue.main.async { tokenReady = true } }
        }
    }
    
    // MARK: - Content
    
    private var examplesContent: some View {
        ExamplePageWithAnchor(pageName: "Tooltip", anchors: anchors) { _ in
            basicExample.id("basic")
            placementExample.id("placement")
            arrowExample.id("arrow")
            colorExample.id("color")
            triggerExample.id("trigger")
        }
    }
    
    // MARK: - Basic
    
    private var basicExample: some View {
        ExampleSection(
            title: tr("tooltip.basic"),
            description: tr("tooltip.basic_desc"),
            content: {
                HStack(spacing: 20) {
                    Moin.Tooltip("prompt text", placement: .top) {
                        Text("Tooltip will show on mouse enter.")
                    }
                }
            },
            code: {
                """
                Moin.Tooltip("prompt text", placement: .top) {
                    Text("Tooltip will show on mouse enter.")
                }
                """
            }
        )
    }
    
    // MARK: - Placement
    
    private var placementExample: some View {
        ExampleSection(
            title: tr("tooltip.placement"),
            description: tr("tooltip.placement_desc"),
            content: {
                VStack(spacing: 12) {
                    // Top row
                    HStack(spacing: 8) {
                        Spacer()
                        placementButton(.topLeft)
                        placementButton(.top)
                        placementButton(.topRight)
                        Spacer()
                    }
                    
                    // Middle rows
                    HStack(spacing: 8) {
                        VStack(spacing: 8) {
                            placementButton(.leftTop)
                            placementButton(.left)
                            placementButton(.leftBottom)
                        }
                        Spacer()
                        VStack(spacing: 8) {
                            placementButton(.rightTop)
                            placementButton(.right)
                            placementButton(.rightBottom)
                        }
                    }
                    
                    // Bottom row
                    HStack(spacing: 8) {
                        Spacer()
                        placementButton(.bottomLeft)
                        placementButton(.bottom)
                        placementButton(.bottomRight)
                        Spacer()
                    }
                }
                .frame(maxWidth: 400)
            },
            code: {
                """
                Moin.Tooltip("prompt text", placement: .top) {
                    Moin.Button("Top") {}
                }
                
                Moin.Tooltip("prompt text", placement: .bottomLeft) {
                    Moin.Button("Bottom Left") {}
                }
                """
            }
        )
    }
    
    private func placementButton(_ placement: _TooltipPlacement) -> some View {
        Moin.Tooltip(tr("tooltip.prompt_text"), placement: placement) {
            Moin.Button(placement.rawValue.capitalized) {}
                .frame(minWidth: 80)
        }
    }
    
    // MARK: - Arrow
    
    private var arrowExample: some View {
        ExampleSection(
            title: tr("tooltip.arrow"),
            description: tr("tooltip.arrow_desc"),
            content: {
                HStack(spacing: 20) {
                    Moin.Tooltip(tr("tooltip.with_arrow"), arrow: true) {
                        Moin.Button(tr("tooltip.with_arrow")) {}
                    }
                    
                    Moin.Tooltip(tr("tooltip.no_arrow"), arrow: false) {
                        Moin.Button(tr("tooltip.no_arrow")) {}
                    }
                }
            },
            code: {
                """
                Moin.Tooltip("With Arrow", arrow: true) {
                    Moin.Button("With Arrow") {}
                }
                
                Moin.Tooltip("No Arrow", arrow: false) {
                    Moin.Button("No Arrow") {}
                }
                """
            }
        )
    }
    
    // MARK: - Color
    
    private var colorExample: some View {
        ExampleSection(
            title: tr("tooltip.color"),
            description: tr("tooltip.color_desc"),
            content: {
                HStack(spacing: 16) {
                    Moin.Tooltip(tr("tooltip.pink"), color: .pink) {
                        Moin.Button("Pink") {}
                    }
                    
                    Moin.Tooltip(tr("tooltip.green"), color: .green) {
                        Moin.Button("Green") {}
                    }
                    
                    Moin.Tooltip(tr("tooltip.blue"), color: .blue) {
                        Moin.Button("Blue") {}
                    }
                    
                    Moin.Tooltip(tr("tooltip.custom"), color: Color(hex: 0x722ed1)) {
                        Moin.Button("Purple") {}
                    }
                }
            },
            code: {
                """
                Moin.Tooltip("Pink", color: .pink) {
                    Moin.Button("Pink") {}
                }
                
                Moin.Tooltip("Custom", color: Color(hex: 0x722ed1)) {
                    Moin.Button("Purple") {}
                }
                """
            }
        )
    }
    
    // MARK: - Trigger
    
    @State private var clickOpen = false
    
    private var triggerExample: some View {
        ExampleSection(
            title: tr("tooltip.trigger"),
            description: tr("tooltip.trigger_desc"),
            content: {
                HStack(spacing: 20) {
                    Moin.Tooltip(tr("tooltip.hover_trigger"), trigger: .hover) {
                        Moin.Button(tr("tooltip.hover")) {}
                    }
                    
                    Moin.Tooltip(tr("tooltip.click_trigger"), trigger: .click) {
                        Moin.Button(tr("tooltip.click")) {}
                    }
                }
            },
            code: {
                """
                Moin.Tooltip("Hover to show", trigger: .hover) {
                    Moin.Button("Hover") {}
                }
                
                Moin.Tooltip("Click to show", trigger: .click) {
                    Moin.Button("Click") {}
                }
                """
            }
        )
    }
}
