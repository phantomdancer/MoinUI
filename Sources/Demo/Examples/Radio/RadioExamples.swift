import SwiftUI
import MoinUI

// MARK: - Icons for Custom Chart Example
// MARK: - Model for Custom Chart Example
private struct ChartOption: Identifiable {
    let id: String
    let icon: String
    let label: String
}

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
    
    // Anchors for sidebar navigation
    private let anchors: [AnchorItem] = [
        AnchorItem(id: "basic", titleKey: "radio.basic"),
        AnchorItem(id: "disabled", titleKey: "radio.disabled"),
        AnchorItem(id: "group_plain", titleKey: "radio.group_plain"),
        AnchorItem(id: "group_object", titleKey: "radio.group_object"),
        AnchorItem(id: "group_disabled", titleKey: "radio.group_disabled"),
        AnchorItem(id: "group_optional", titleKey: "radio.group_optional"),
        AnchorItem(id: "custom_view", titleKey: "radio.custom_view"),
        AnchorItem(id: "direction", titleKey: "radio.direction"),
        AnchorItem(id: "button_style", titleKey: "radio.button_style"),
        AnchorItem(id: "button_size", titleKey: "radio.button_size"),
        AnchorItem(id: "block", titleKey: "radio.block")
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
            groupExamplePlain.id("group_plain")
            groupExampleObject.id("group_object")
            groupExampleDisabled.id("group_disabled")
            groupExampleOptional.id("group_optional")
            customLabelExample.id("custom_view")
            directionExample.id("direction")
            buttonStyleExample.id("button_style")
            buttonSizeExample.id("button_size")
            blockExample.id("block")
        }
    }
    
    // MARK: - Examples
    
    @State private var basicChecked = false
    
    private var basicExample: some View {
        ExampleSection(
            title: tr("radio.basic"),
            description: tr("radio.basic_desc"),
            content: {
                Moin.Radio(tr("component.radio"), checked: $basicChecked)
            },
            code: {
                """
                @State private var checked = false
                
                Moin.Radio("\(tr("component.radio"))", checked: $checked)
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
                    Moin.Radio(tr("radio.disabled"), checked: .constant(false), disabled: true)
                    Moin.Radio(tr("radio.disabled"), checked: .constant(true), disabled: true)
                }
            },
            code: {
                """
                Moin.Radio("\(tr("radio.disabled"))", checked: .constant(false), disabled: true)
                Moin.Radio("\(tr("radio.disabled"))", checked: .constant(true), disabled: true)
                """
            }
        )
    }
    
    // MARK: - Group Example 1: Plain Options
    @State private var groupSelectionPlain = ""
    private var plainOptions: [String] {
        [tr("radio.apple"), tr("radio.pear"), tr("radio.orange")]
    }
    
    private var groupExamplePlain: some View {
        ExampleSection(
            title: tr("radio.group_plain"),
            description: tr("radio.group_desc"),
            content: {
                VStack(alignment: .leading, spacing: 10) {
                    Moin.RadioGroup(
                        value: $groupSelectionPlain,
                        options: plainOptions
                    )
                    
                    Text("Selected: \(groupSelectionPlain)")
                        .foregroundStyle(.secondary)
                }
                .onAppear {
                    if groupSelectionPlain.isEmpty {
                        groupSelectionPlain = plainOptions.first ?? ""
                    }
                }
            },
            code: {
                """
                @State private var selection = ""
                let options = ["\(tr("radio.apple"))", "\(tr("radio.pear"))", "\(tr("radio.orange"))"]
                
                Moin.RadioGroup(value: $selection, options: options)
                    .onAppear {
                        selection = options.first ?? ""
                    }
                """
            }
        )
    }
    
    // MARK: - Group Example 2: Object Options
    @State private var groupSelectionObject = "London"
    private var objectOptions: [Moin.RadioOption<String>] {
        [
            .init(label: tr("radio.london"), value: "London"),
            .init(label: tr("radio.paris"), value: "Paris"),
            .init(label: tr("radio.new_york"), value: "New York")
        ]
    }
    
    private var groupExampleObject: some View {
        ExampleSection(
            title: tr("radio.group_object"),
            description: tr("radio.group_desc"),
            content: {
                VStack(alignment: .leading, spacing: 10) {
                    Moin.RadioGroup(
                        value: $groupSelectionObject,
                        options: objectOptions
                    )
                    
                    Text("Selected: \(groupSelectionObject)")
                        .foregroundStyle(.secondary)
                }
            },
            code: {
                """
                @State private var selection = "London"
                
                private var options: [Moin.RadioOption<String>] {
                    [
                        .init(label: "\(tr("radio.london"))", value: "London"),
                        .init(label: "\(tr("radio.paris"))", value: "Paris"),
                        .init(label: "\(tr("radio.new_york"))", value: "New York")
                    ]
                }
                
                Moin.RadioGroup(value: $selection, options: options)
                """
            }
        )
    }
    
    // MARK: - Group Example 3: Disabled Group
    @State private var groupSelectionDisabled = "Apple"
    
    private var groupExampleDisabled: some View {
        ExampleSection(
            title: tr("radio.group_disabled"),
            description: tr("radio.group_desc"),
            content: {
                VStack(alignment: .leading, spacing: 10) {
                    Moin.RadioGroup(
                        value: $groupSelectionDisabled,
                        options: objectOptions, // Reuse options from above
                        disabled: true
                    )
                }
            },
            code: {
                """
                Moin.RadioGroup(value: $selection, options: options, disabled: true)
                """
            }
        )
    }
    
    // MARK: - Group Example 4: Optional Selection with Disabled Items
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
                    HStack(spacing: 10) {
                        Moin.RadioGroup(value: Binding(
                            get: { optionalSelection ?? "" },
                            set: { optionalSelection = $0 }
                        ), options: optionsWithDisabled)
                        
                        Moin.Button(tr("radio.clear_selection")) {
                            optionalSelection = nil
                        }
                    }
                }
            },
            code: {
                """
                @State private var selection: String? = "Apple"
                
                private var options: [Moin.RadioOption<String>] {
                    [
                        .init(label: "\(tr("radio.apple"))", value: "Apple"),
                        .init(label: "\(tr("radio.pear"))", value: "Pear"),
                        .init(label: "\(tr("radio.orange"))", value: "Orange", disabled: true)
                    ]
                }
                
                Moin.RadioGroup(
                    value: Binding(get: { selection ?? "" }, set: { selection = $0 }),
                    options: options
                )
                
                Moin.Button("\(tr("radio.clear_selection"))") {
                     selection = nil
                }
                """
            }
        )
    }
    
    // MARK: - Custom Label Example (Chart)
    @State private var customSelection = "Line"
    
    private var chartOptionsData: [ChartOption] {
        [
            ChartOption(id: "Line", icon: "chart.xyaxis.line", label: tr("radio.line_chart")),
            ChartOption(id: "Bar", icon: "chart.bar", label: tr("radio.bar_chart")),
            ChartOption(id: "Pie", icon: "chart.pie", label: tr("radio.pie_chart")),
            ChartOption(id: "Dot", icon: "circle.grid.2x2", label: tr("radio.dot_chart"))
        ]
    }
    
    private var customLabelExample: some View {
        ExampleSection(
            title: tr("radio.custom_view"),
            description: tr("radio.custom_view_desc"),
            content: {
                Moin.RadioGroupView(
                    value: $customSelection,
                    data: chartOptionsData,
                    valuePath: \.id // Use 'id' property as the selection value
                ) { option in
                    VStack(spacing: 4) {
                        Image(systemName: option.icon)
                            .font(.system(size: 18))
                        Text(option.label)
                    }
                    .padding(.vertical, 4)
                    .padding(.horizontal, 8)
                }
            },
            code: {
                """
                struct ChartOption: Identifiable {
                    let id: String
                    let icon: String
                    let label: String
                }
                
                @State private var selection = "Line"
                let options = [
                    ChartOption(id: "Line", icon: "chart.xyaxis.line", label: "\(tr("radio.line_chart"))"),
                    ChartOption(id: "Bar", icon: "chart.bar", label: "\(tr("radio.bar_chart"))"),
                    ...
                ]
                
                Moin.RadioGroupView(
                    value: $selection,
                    data: options,
                    valuePath: \\.id
                ) { option in
                    VStack(spacing: 4) {
                        Image(systemName: option.icon)
                        Text(option.label)
                    }
                }
                """
            }
        )
    }
    
    // MARK: - Direction Example
    @State private var directionSelection = "Apple"
    @State private var layoutDirection: Axis = .vertical
    
    private var directionExample: some View {
        ExampleSection(
            title: tr("radio.direction"),
            description: tr("radio.direction_desc"),
            content: {
                HStack(alignment: .top, spacing: 40) {
                    // Horizontal Column
                    VStack(alignment: .leading, spacing: 10) {
                        Text(tr("radio.direction_horizontal"))
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        
                        Moin.RadioGroup(
                            value: $directionSelection,
                            options: plainOptions,
                            orientation: .horizontal
                        )
                    }
                    
                    // Vertical Column
                    VStack(alignment: .leading, spacing: 10) {
                        Text(tr("radio.direction_vertical"))
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        
                        Moin.RadioGroup(
                            value: $directionSelection,
                            options: plainOptions,
                            orientation: .vertical
                        )
                    }
                }
            },
            code: {
                """
                Moin.RadioGroup(value: $selection, options: options, orientation: .horizontal)
                Moin.RadioGroup(value: $selection, options: options, orientation: .vertical)
                """
            }
        )
    }
    
    // MARK: - Button Style Example
    @State private var buttonStyleSelection = "Apple"
    
    private var buttonStyleExample: some View {
        ExampleSection(
            title: tr("radio.button_style"),
            description: tr("radio.button_style_desc"),
            content: {
                HStack(alignment: .top, spacing: 40) {
                    VStack(alignment: .leading, spacing: 10) {
                        Text(tr("radio.button_outline"))
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        
                        Moin.RadioGroup(
                            value: $buttonStyleSelection,
                            options: buttonOptions,
                            optionType: .button // Default buttonStyle is .outline
                        )
                    }
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text(tr("radio.button_solid"))
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        
                        Moin.RadioGroup(
                            value: $buttonStyleSelection,
                            options: buttonOptions,
                            optionType: .button,
                            buttonStyle: .solid
                        )
                    }
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                }
            },
            code: {
                """
                @State private var selection = "Apple"

                let options: [Moin.RadioOption<String>] = [
                    .init(label: "\(tr("radio.apple"))", value: "Apple"),
                    .init(label: "\(tr("radio.pear"))", value: "Pear"),
                    .init(label: "\(tr("radio.orange"))", value: "Orange", disabled: true)
                ]

                // Outline (Default Button Style)
                Moin.RadioGroup(
                    value: $selection,
                    options: options,
                    optionType: .button
                )

                // Solid
                Moin.RadioGroup(
                    value: $selection,
                    options: options,
                    optionType: .button,
                    buttonStyle: .solid
                )
                """
            }
        )
    }

    // MARK: - Button Size Example
    @State private var buttonSizeSelection = "Apple"
    
    private var buttonSizeExample: some View {
        ExampleSection(
            title: tr("radio.button_size"),
            description: tr("radio.button_size_desc"),
            content: {
                VStack(alignment: .leading, spacing: 20) {
                    Moin.RadioGroup(
                        value: $buttonSizeSelection,
                        options: plainOptions,
                        optionType: .button,
                        size: .large
                    )

                    Moin.RadioGroup(
                        value: $buttonSizeSelection,
                        options: plainOptions,
                        optionType: .button,
                        size: .middle
                    )

                    Moin.RadioGroup(
                        value: $buttonSizeSelection,
                        options: plainOptions,
                        optionType: .button,
                        size: .small
                    )
                }
            },
            code: {
                """
                @State private var selection = "Apple"

                // Large
                Moin.RadioGroup(
                    value: $selection,
                    options: options,
                    optionType: .button,
                    size: .large
                )

                // Middle (Default)
                Moin.RadioGroup(
                    value: $selection,
                    options: options,
                    optionType: .button,
                    size: .middle
                )

                // Small
                Moin.RadioGroup(
                    value: $selection,
                    options: options,
                    optionType: .button,
                    size: .small
                )
                """
            }
        )
    }
    
    private var buttonOptions: [Moin.RadioOption<String>] {
        [
            .init(label: tr("radio.apple"), value: "Apple"),
            .init(label: tr("radio.pear"), value: "Pear"),
            .init(label: tr("radio.orange"), value: "Orange", disabled: true)
        ]
    }
    
    // MARK: - Block Example
    @State private var blockSelection = "Apple"
    
    private var blockExample: some View {
        ExampleSection(
            title: tr("radio.block"),
            description: tr("radio.block_desc"),
            content: {
                VStack(alignment: .leading, spacing: 20) {
                    Moin.RadioGroup(
                        value: $blockSelection,
                        options: plainOptions,
                        block: true
                    )

                    Moin.RadioGroup(
                        value: $blockSelection,
                        options: plainOptions,
                        optionType: .button,
                        block: true
                    )

                    Moin.RadioGroup(
                        value: $blockSelection,
                        options: plainOptions,
                        optionType: .button,
                        buttonStyle: .solid,
                        block: true
                    )
                }
            },
            code: {
                """
                @State private var selection = "Apple"

                Moin.RadioGroup(
                    value: $selection,
                    options: options,
                    block: true
                )

                Moin.RadioGroup(
                    value: $selection,
                    options: options,
                    optionType: .button,
                    block: true
                )

                Moin.RadioGroup(
                    value: $selection,
                    options: options,
                    optionType: .button,
                    buttonStyle: .solid,
                    block: true
                )
                """
            }
        )
    }
}
