import SwiftUI
import MoinUI

enum CheckboxExamplesTab: String, CaseIterable {
    case examples
    case api
    case token
}

struct CheckboxExamples: View {
    @Localized var tr
    @Binding var selectedTab: CheckboxExamplesTab
    
    init(selectedTab: Binding<CheckboxExamplesTab>) {
        self._selectedTab = selectedTab
    }
    
    // Lazy load states
    @State private var apiReady = false
    @State private var tokenReady = false
    
    private let anchors: [AnchorItem] = [
        AnchorItem(id: "basic", titleKey: "checkbox.basic"),
        AnchorItem(id: "disabled", titleKey: "checkbox.disabled"),
        AnchorItem(id: "indeterminate", titleKey: "checkbox.indeterminate"),
        AnchorItem(id: "group_plain", titleKey: "checkbox.group_plain"),
        AnchorItem(id: "group_object", titleKey: "checkbox.group_object"),
        AnchorItem(id: "group_disabled", titleKey: "checkbox.group_disabled"),
        AnchorItem(id: "direction", titleKey: "checkbox.direction")
    ]
    
    var body: some View {
        Group {
            switch selectedTab {
            case .examples:
                examplesContent
            case .api:
                if apiReady {
                    CheckboxAPIView()
                } else {
                    loadingView
                }
            case .token:
                if tokenReady {
                    CheckboxTokenView()
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
    
    private func triggerLazyLoad(for tab: CheckboxExamplesTab) {
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
        ExamplePageWithAnchor(pageName: "Checkbox", anchors: anchors) { _ in
            basicExample.id("basic")
            disabledExample.id("disabled")
            indeterminateExample.id("indeterminate")
            groupExamplePlain.id("group_plain")
            groupExampleObject.id("group_object")
            groupExampleDisabled.id("group_disabled")
            directionExample.id("direction")
        }
    }
    
    // MARK: - Examples
    
    @State private var checked = false
    
    private var basicExample: some View {
        ExampleSection(
            title: tr("checkbox.basic"),
            description: tr("checkbox.basic_desc"),
            content: {
                Moin.Checkbox(tr("component.checkbox"), checked: $checked)
            },
            code: {
                """
                @State private var checked = false
                
                Moin.Checkbox("\(tr("component.checkbox"))", checked: $checked)
                """
            }
        )
    }
    
    private var disabledExample: some View {
        ExampleSection(
            title: tr("checkbox.disabled"),
            description: tr("checkbox.disabled_desc"),
            content: {
                HStack(spacing: 20) {
                    Moin.Checkbox(tr("component.checkbox"), checked: .constant(false), disabled: true)
                    Moin.Checkbox(tr("component.checkbox"), checked: .constant(true), disabled: true)
                    Moin.Checkbox(tr("component.checkbox"), checked: .constant(true), indeterminate: true, disabled: true)
                }
            },
            code: {
                """
                Moin.Checkbox("\(tr("component.checkbox"))", checked: .constant(false), disabled: true)
                    
                Moin.Checkbox("\(tr("component.checkbox"))", checked: .constant(true), disabled: true)

                Moin.Checkbox("\(tr("component.checkbox"))", checked: .constant(true), indeterminate: true, disabled: true)
                """
            }
        )
    }
    
    @State private var options = [true, false, false]
    
    private var isAllChecked: Bool {
        options.allSatisfy { $0 }
    }
    
    private var isIndeterminate: Bool {
        options.contains(true) && options.contains(false)
    }
    
    private var indeterminateExample: some View {
        ExampleSection(
            title: tr("checkbox.indeterminate"),
            description: tr("checkbox.indeterminate_desc"),
            content: {
                VStack(alignment: .leading, spacing: 10) {
                    // 全选 Checkbox
                    Moin.Checkbox(tr("checkbox.check_all"), checked: Binding(
                        get: { isAllChecked },
                        set: { newValue in
                            // 点击全选：设置所有选项
                            for i in options.indices {
                                options[i] = newValue
                            }
                        }
                    ), indeterminate: isIndeterminate)
                    
                    Moin.Divider()
                    
                    // 子选项
                    HStack(spacing: 20) {
                        Moin.Checkbox(tr("checkbox.apple"), checked: $options[0])
                        Moin.Checkbox(tr("checkbox.pear"), checked: $options[1])
                        Moin.Checkbox(tr("checkbox.orange"), checked: $options[2])
                    }
                }
            },
            code: {
                """
                @State private var options = [true, false, false]
                
                var isAllChecked: Bool {
                    options.allSatisfy { $0 }
                }
                
                var isIndeterminate: Bool {
                    options.contains(true) && options.contains(false)
                }
                
                // Check All
                Moin.Checkbox("\(tr("checkbox.check_all"))", checked: Binding(
                    get: { isAllChecked },
                    set: { val in options = options.map { _ in val } }
                ), indeterminate: isIndeterminate)
                
                Moin.Divider()
                
                HStack(spacing: 20) {
                    Moin.Checkbox("\(tr("checkbox.apple"))", checked: $options[0])
                    Moin.Checkbox("\(tr("checkbox.pear"))", checked: $options[1])
                    Moin.Checkbox("\(tr("checkbox.orange"))", checked: $options[2])
                }
                """
            }
        )
    }
    
    // MARK: - Group Example 1: Numeric IDs (Plain Options)
    @State private var groupSelection1: Set<String> = ["Apple"]
    private let plainOptions = ["Apple", "Pear", "Orange"]
    
    // MARK: - Group Example 2: City Options (Object)
    @State private var groupSelection2: Set<String> = ["London"]
    private var groupOptions: [Moin.CheckboxOption<String>] {
        [
            .init(label: tr("checkbox.london"), value: "London"),
            .init(label: tr("checkbox.paris"), value: "Paris"),
            .init(label: tr("checkbox.new_york"), value: "New York")
        ]
    }
    
    // MARK: - Group Example 3: Celestial Options (With Disabled)
    @State private var groupSelection3: Set<String> = ["Sun"]
    
    private var optionsWithDisabled: [Moin.CheckboxOption<String>] {
        [
            .init(label: tr("checkbox.sun"), value: "Sun"),
            .init(label: tr("checkbox.moon"), value: "Moon"),
            .init(label: tr("checkbox.star"), value: "Star", disabled: false)
        ]
    }
    
    private var groupExamplePlain: some View {
        ExampleSection(
            title: tr("checkbox.group_plain"),
            description: tr("checkbox.group_desc"),
            content: {
                // Example 1: Plain Options
                VStack(alignment: .leading, spacing: 10) {
                    Moin.CheckboxGroup(
                        selection: $groupSelection1,
                        options: plainOptions
                    )
                }
            },
            code: {
                """
                // 1. Plain Options
                @State private var selection1: Set<String> = ["Apple"]
                let plainOptions = ["Apple", "Pear", "Orange"]
                
                Moin.CheckboxGroup(
                    selection: $selection1,
                    options: plainOptions
                )
                """
            }
        )
    }
    
    private var groupExampleObject: some View {
        ExampleSection(
            title: tr("checkbox.group_object"),
            description: tr("checkbox.group_desc"),
            content: {
                // Example 2: Object Options (Cities)
                VStack(alignment: .leading, spacing: 10) {
                    Moin.CheckboxGroup(
                        selection: $groupSelection2,
                        options: groupOptions
                    )
                }
            },
            code: {
                """
                // 2. Object Options
                @State private var selection2: Set<String> = ["London"]
                let groupOptions: [Moin.CheckboxOption<String>] = [
                    .init(label: "\(tr("checkbox.london"))", value: "London"),
                    .init(label: "\(tr("checkbox.paris"))", value: "Paris"),
                    .init(label: "\(tr("checkbox.new_york"))", value: "New York")
                ]
                
                Moin.CheckboxGroup(selection: $selection2, options: groupOptions)
                """
            }
        )
    }
    
    private var groupExampleDisabled: some View {
        ExampleSection(
            title: tr("checkbox.group_disabled"),
            description: tr("checkbox.group_desc"),
            content: {
                // Example 3: Disabled Group (Celestial)
                VStack(alignment: .leading, spacing: 10) {
                    Moin.CheckboxGroup(
                        selection: $groupSelection3,
                        options: optionsWithDisabled,
                        disabled: true
                    )
                }
            },
            code: {
                """
                // 3. Disabled Group
                @State private var selection3: Set<String> = ["Sun"]
                let optionsWithDisabled: [Moin.CheckboxOption<String>] = [
                    .init(label: "\(tr("checkbox.sun"))", value: "Sun"),
                    .init(label: "\(tr("checkbox.moon"))", value: "Moon"),
                    .init(label: "\(tr("checkbox.star"))", value: "Star", disabled: false)
                ]
                
                Moin.CheckboxGroup(
                    selection: $selection3,
                    options: optionsWithDisabled,
                    disabled: true
                )
                """
            }
        )
    }
    
    // MARK: - Direction Example
    @State private var directionSelection = Set<String>(["Apple"])
    @State private var layoutDirection: Axis = .vertical
    
    private var directionExample: some View {
        ExampleSection(
            title: tr("checkbox.direction"),
            description: tr("checkbox.direction_desc"),
            content: {
                VStack(alignment: .leading, spacing: 20) {
                    Text(tr("checkbox.direction_horizontal") + ":")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    
                    Moin.CheckboxGroup(
                        selection: $directionSelection,
                        options: plainOptions,
                        direction: .horizontal
                    )
                    
                    Moin.Divider()
                    
                    Text(tr("checkbox.direction_vertical") + ":")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    
                    Moin.CheckboxGroup(
                        selection: $directionSelection,
                        options: plainOptions,
                        direction: .vertical
                    )
                }
            },
            code: {
                """
                @State private var selection: Set<String> = ["Apple"]
                
                // Horizontal (Default)
                Moin.CheckboxGroup(
                    selection: $selection,
                    options: options,
                    direction: .horizontal
                )
                
                Moin.Divider()
                
                // Vertical
                Moin.CheckboxGroup(
                    selection: $selection,
                    options: options,
                    direction: .vertical
                )
                """
            }
        )
    }
}
