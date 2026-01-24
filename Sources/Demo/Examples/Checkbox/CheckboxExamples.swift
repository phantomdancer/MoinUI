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
    
    // Lazy load states
    @State private var apiReady = false
    @State private var tokenReady = false
    
    private let anchors: [AnchorItem] = [
        AnchorItem(id: "basic", titleKey: "checkbox.basic"),
        AnchorItem(id: "disabled", titleKey: "checkbox.disabled"),
        AnchorItem(id: "indeterminate", titleKey: "checkbox.indeterminate")
    ]
    
    var body: some View {
        Group {
            switch selectedTab {
            case .examples:
                examplesContent
            case .api:
                if apiReady {
                    // CheckboxAPIView()
                    Text("API View Coming Soon")
                } else {
                    loadingView
                }
            case .token:
                if tokenReady {
                    // CheckboxTokenView()
                    Text("Token View Coming Soon")
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
                HStack(spacing: 20) {
                    Moin.Checkbox(tr("component.checkbox"), checked: .constant(false), isDisabled: true)
                    Moin.Checkbox(tr("component.checkbox"), checked: .constant(true), isDisabled: true)
                    Moin.Checkbox(tr("component.checkbox"), checked: .constant(true), indeterminate: true, isDisabled: true)
                }
                }
            },
            code: {
                """
                Moin.Checkbox("\(tr("component.checkbox"))", checked: .constant(false), isDisabled: true)
                    
                Moin.Checkbox("\(tr("component.checkbox"))", checked: .constant(true), isDisabled: true)

                Moin.Checkbox("\(tr("component.checkbox"))", checked: .constant(true), indeterminate: true, isDisabled: true)
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
}
