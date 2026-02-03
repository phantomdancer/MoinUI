import SwiftUI
import MoinUI

enum PopoverExamplesTab: String, CaseIterable {
    case examples
    case api
    case token
}

struct PopoverExamples: View {
    @Localized var tr
    @Binding var selectedTab: PopoverExamplesTab
    
    init(selectedTab: Binding<PopoverExamplesTab>) {
        self._selectedTab = selectedTab
    }
    
    @State private var apiReady = false
    @State private var tokenReady = false
    
    private let anchors: [AnchorItem] = [
        AnchorItem(id: "basic", titleKey: "popover.basic"),
        AnchorItem(id: "triggerType", titleKey: "popover.trigger_type"),
        AnchorItem(id: "placement", titleKey: "popover.placement"),
        AnchorItem(id: "arrow", titleKey: "popover.arrow"),
        AnchorItem(id: "control", titleKey: "popover.control")
    ]
    
    var body: some View {
        Group {
            switch selectedTab {
            case .examples:
                examplesContent
            case .api:
                if apiReady {
                    PopoverAPIView()
                } else {
                    loadingView
                }
            case .token:
                if tokenReady {
                    PopoverTokenView()
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
    
    private func triggerLazyLoad(for tab: PopoverExamplesTab) {
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
        ExamplePageWithAnchor(pageName: "Popover", anchors: anchors) { _ in
            basicExample.id("basic")
            triggerTypeExample.id("triggerType")
            placementExample.id("placement")
            arrowExample.id("arrow")
            controlExample.id("control")
        }
    }
    
    // MARK: - Basic
    
    private var basicExample: some View {
        ExampleSection(
            title: tr("popover.basic"),
            description: tr("popover.basic_desc"),
            content: {
                Moin.Popover("Title", content: {
                    Moin.Button("Hover me", color: .primary) {}
                }, popoverContent: {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Content")
                        Text("Content")
                    }
                })
            },
            code: {
                """
                Moin.Popover("Title", content: {
                    Moin.Button("Hover me", color: .primary) {}
                }, popoverContent: {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Content")
                        Text("Content")
                    }
                })
                """
            }
        )
    }
    
    // MARK: - Trigger Type
    
    private var triggerTypeExample: some View {
        ExampleSection(
            title: tr("popover.trigger_type"),
            description: tr("popover.trigger_type_desc"),
            content: {
                HStack(spacing: 16) {
                    Moin.Popover("Title", content: {
                        Moin.Button("Hover me") {}
                    }, popoverContent: {
                        popoverContentView
                    }, trigger: .hover)
                    
                    Moin.Popover("Title", content: {
                        Moin.Button("Click me") {}
                    }, popoverContent: {
                        popoverContentView
                    }, trigger: .click)
                }
            },
            code: {
                """
                Moin.Popover("Title", content: {
                    Moin.Button("Hover me") {}
                }, popoverContent: {
                    VStack { Text("Content") }
                }, trigger: .hover)

                Moin.Popover("Title", content: {
                    Moin.Button("Click me") {}
                }, popoverContent: {
                    VStack { Text("Content") }
                }, trigger: .click)
                """
            }
        )
    }
    
    private var popoverContentView: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Content")
            Text("Content")
        }
    }
    
    // MARK: - Placement
    
    private var placementExample: some View {
        ExampleSection(
            title: tr("popover.placement"),
            description: tr("popover.placement_desc"),
            content: {
                VStack(spacing: 12) {
                    // Top row
                    HStack(spacing: 8) {
                        Spacer()
                        placementButton(.topLeft, "TL")
                        placementButton(.top, "Top")
                        placementButton(.topRight, "TR")
                        Spacer()
                    }
                    
                    // Middle rows
                    HStack(spacing: 8) {
                        VStack(spacing: 8) {
                            placementButton(.leftTop, "LT")
                            placementButton(.left, "Left")
                            placementButton(.leftBottom, "LB")
                        }
                        Spacer()
                        VStack(spacing: 8) {
                            placementButton(.rightTop, "RT")
                            placementButton(.right, "Right")
                            placementButton(.rightBottom, "RB")
                        }
                    }
                    
                    // Bottom row
                    HStack(spacing: 8) {
                        Spacer()
                        placementButton(.bottomLeft, "BL")
                        placementButton(.bottom, "Bottom")
                        placementButton(.bottomRight, "BR")
                        Spacer()
                    }
                }
                .frame(maxWidth: 400)
            },
            code: {
                """
                Moin.Popover("Title", content: {
                    Moin.Button("Top") {}
                }, popoverContent: {
                    VStack { Text("Content") }
                }, placement: .top)
                """
            }
        )
    }
    
    private func placementButton(_ placement: _TooltipPlacement, _ label: String) -> some View {
        Moin.Popover("Title", content: {
            Moin.Button(label) {}
                .frame(minWidth: 70)
        }, popoverContent: {
            popoverContentView
        }, placement: placement)
    }
    
    // MARK: - Arrow
    
    @State private var arrowState: String = "Show"
    
    private var arrowExample: some View {
        ExampleSection(
            title: tr("popover.arrow"),
            description: tr("popover.arrow_desc"),
            content: {
                VStack(spacing: 16) {
                    Picker("Arrow", selection: $arrowState) {
                        Text("Show").tag("Show")
                        Text("Hide").tag("Hide")
                        Text("Center").tag("Center")
                    }
                    .pickerStyle(.segmented)
                    .frame(width: 240)
                    
                    HStack(spacing: 16) {
                        Moin.Popover("Title", content: {
                            Moin.Button("TL") {}
                        }, popoverContent: {
                            popoverContentView
                        }, placement: .topLeft, arrow: currentArrowConfig)
                        
                        Moin.Popover("Title", content: {
                            Moin.Button("Top") {}
                        }, popoverContent: {
                            popoverContentView
                        }, placement: .top, arrow: currentArrowConfig)
                        
                        Moin.Popover("Title", content: {
                            Moin.Button("TR") {}
                        }, popoverContent: {
                            popoverContentView
                        }, placement: .topRight, arrow: currentArrowConfig)
                    }
                }
            },
            code: {
                """
                // arrow: .true (show), .false (hide), .center (pointAtCenter)
                Moin.Popover("Title", content: {
                    Moin.Button("TL") {}
                }, popoverContent: {
                    VStack { Text("Content") }
                }, placement: .topLeft, arrow: \(arrowCodeString))
                """
            }
        )
    }
    
    private var currentArrowConfig: _TooltipArrowConfig {
        switch arrowState {
        case "Hide": return .false
        case "Center": return .center
        default: return .true
        }
    }
    
    private var arrowCodeString: String {
        switch arrowState {
        case "Hide": return ".false"
        case "Center": return ".center"
        default: return ".true"
        }
    }
    
    // MARK: - Control
    
    @State private var controlOpen = false
    
    private var controlExample: some View {
        ExampleSection(
            title: tr("popover.control"),
            description: tr("popover.control_desc"),
            content: {
                Moin.Popover("Title", content: {
                    Moin.Button("Click me", color: .primary) {}
                }, popoverContent: {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Content")
                        Button("Close") {
                            controlOpen = false
                        }
                        .buttonStyle(.link)
                    }
                }, trigger: .click, open: $controlOpen)
            },
            code: {
                """
                @State private var open = false

                Moin.Popover("Title", content: {
                    Moin.Button("Click me", color: .primary) {}
                }, popoverContent: {
                    VStack {
                        Text("Content")
                        Button("Close") { open = false }
                    }
                }, trigger: .click, open: $open)
                """
            }
        )
    }
}
