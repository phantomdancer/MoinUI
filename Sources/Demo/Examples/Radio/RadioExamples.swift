import SwiftUI
import MoinUI

enum RadioExamplesTab: String, CaseIterable {
    case examples
    case api
    case token
}

struct RadioExamples: View {
    @Localized var tr
    @Binding var selectedTab: RadioExamplesTab
    
    init(selectedTab: Binding<RadioExamplesTab>) {
        self._selectedTab = selectedTab
    }
    
    // Lazy load states
    @State private var apiReady = false
    @State private var tokenReady = false
    
    private let anchors: [AnchorItem] = [
        AnchorItem(id: "basic", titleKey: "radio.basic"),
        AnchorItem(id: "disabled", titleKey: "radio.disabled"),
        AnchorItem(id: "group", titleKey: "radio.group"),
        AnchorItem(id: "group_optional", titleKey: "radio.group_optional")
    ]
    
    var body: some View {
        Group {
            switch selectedTab {
            case .examples:
                examplesContent
            case .api:
                if apiReady {
                    RadioAPIView()
                } else {
                    loadingView
                }
            case .token:
                if tokenReady {
                    RadioTokenView()
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
    
    private func triggerLazyLoad(for tab: RadioExamplesTab) {
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
        ExamplePageWithAnchor(pageName: "Radio", anchors: anchors) { _ in
            basicExample.id("basic")
            disabledExample.id("disabled")
            groupExample.id("group")
            groupExampleOptional.id("group_optional")
        }
    }
    
    // MARK: - Examples
    
    @State private var basicChecked = false
    
    private var basicExample: some View {
        ExampleSection(
            title: tr("radio.basic"),
            description: tr("radio.basic_desc"),
            content: {
                Moin.Radio("Radio", checked: $basicChecked)
            },
            code: {
                """
                @State private var checked = false
                
                Moin.Radio("Radio", checked: $checked)
                """
            }
        )
    }
    
    private var disabledExample: some View {
        ExampleSection(
            title: tr("radio.disabled"),
            description: tr("radio.disabled_desc"),
            content: {
                HStack(spacing: 20) {
                    Moin.Radio("Disabled", checked: .constant(false), disabled: true)
                    Moin.Radio("Disabled", checked: .constant(true), disabled: true)
                }
            },
            code: {
                """
                Moin.Radio("Disabled", checked: .constant(false), disabled: true)
                Moin.Radio("Disabled", checked: .constant(true), disabled: true)
                """
            }
        )
    }
    
    @State private var groupSelection = 1
    
    private var groupExample: some View {
        ExampleSection(
            title: tr("radio.group"),
            description: tr("radio.group_desc"),
            content: {
                VStack(alignment: .leading, spacing: 20) {
                    Moin.RadioGroup(selection: $groupSelection, options: [1, 2, 3, 4]) { val in
                        switch val {
                        case 1: return "A"
                        case 2: return "B"
                        case 3: return "C"
                        case 4: return "D"
                        default: return ""
                        }
                    }
                    
                    Text("Selected: \(groupSelection)")
                        .foregroundStyle(.secondary)
                }
            },
            code: {
                """
                @State private var selection = 1
                
                Moin.RadioGroup(selection: $selection, options: [1, 2, 3, 4]) { val in
                    ["A", "B", "C", "D"][val - 1]
                }
                """
            }
        )
    }
    
    @State private var optionalSelection: String? = "Apple"
    private var optionsWithDisabled: [Moin.RadioOption<String>] {
        [
            .init(label: tr("radio.apple"), value: "Apple"),
            .init(label: tr("radio.pear"), value: "Pear"),
            .init(label: tr("radio.orange"), value: "Orange", disabled: true)
        ]
    }
    
    private var groupExampleOptional: some View {
        ExampleSection(
            title: tr("radio.group_optional"),
            description: tr("radio.group_desc"),
            content: {
                VStack(alignment: .leading, spacing: 20) {
                    Moin.RadioGroup(selection: Binding(
                        get: { optionalSelection ?? "" },
                        set: { optionalSelection = $0 }
                    ), options: optionsWithDisabled)
                    
                    Text("Selected: \(optionalSelection ?? "nil")")
                        .foregroundStyle(.secondary)
                    
                    Moin.Button("Clear Selection") {
                         optionalSelection = nil // This won't visually deselect nicely unless we handle logic correctly mapping nil to nothing matches
                    }
                }
            },
            code: {
                """
                @State private var selection: String? = "Apple"
                
                Moin.RadioGroup(
                    selection: Binding(get: { selection ?? "" }, set: { selection = $0 }), 
                    options: options
                )
                """
            }
        )
    }
}
