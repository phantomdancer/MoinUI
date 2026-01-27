import SwiftUI
import MoinUI

enum SwitchExamplesTab: String, CaseIterable {
    case examples
    case api
    case token
}

struct SwitchExamples: View {
    @Localized var tr
    @Binding var selectedTab: SwitchExamplesTab
    
    // Lazy load states
    @State private var apiReady = false
    @State private var tokenReady = false
    
    private let anchors: [AnchorItem] = [
        AnchorItem(id: "basic", titleKey: "switch.basic"),
        AnchorItem(id: "disabled", titleKey: "switch.disabled"),
        AnchorItem(id: "text_icon", titleKey: "switch.text_icon"),
        AnchorItem(id: "loading", titleKey: "switch.loading"),
        AnchorItem(id: "size", titleKey: "switch.size")
    ]
    
    var body: some View {
        Group {
            switch selectedTab {
            case .examples:
                examplesContent
            case .api:
                if apiReady {
                    apiContent
                } else {
                    loadingView
                }
            case .token:
                if tokenReady {
                    tokenContent
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
    
    private func triggerLazyLoad(for tab: SwitchExamplesTab) {
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
        ExamplePageWithAnchor(pageName: "Switch", anchors: anchors) { _ in
            basicExample.id("basic")
            disabledExample.id("disabled")
            textIconExample.id("text_icon")
            loadingExample.id("loading")
            sizeExample.id("size")
        }
    }
    
    private var apiContent: some View {
        SwitchAPIView()
    }
    
    private var tokenContent: some View {
        SwitchTokenView()
    }
    
    // MARK: - Examples
    
    @State private var isOn1 = true
    @State private var isOn2 = false
    @State private var isOn3 = true
    @State private var isOn4 = false
    
    private var basicExample: some View {
        ExampleSection(
            title: tr("switch.basic"),
            description: tr("switch.basic_desc"),
            content: {
                Moin.Switch(checked: $isOn1, onChange: { value in
                    print("Switch 1 changed: \(value)")
                })
            },
            code: {
                """
                Moin.Switch(checked: $isOn, onChange: { value in
                    print("Switch changed: \\(value)")
                })
                """
            }
        )
    }
    
    private var disabledExample: some View {
        ExampleSection(
            title: tr("switch.disabled"),
            description: tr("switch.disabled_desc"),
            content: {
                HStack(spacing: 20) {
                    Moin.Switch(checked: .constant(true), disabled: true)
                    
                    Moin.Switch(checked: .constant(false), disabled: true)
                }
            },
            code: {
                """
                Moin.Switch(checked: .constant(true), disabled: true)
                
                Moin.Switch(checked: .constant(false), disabled: true)
                """
            }
        )
    }
    
    private var textIconExample: some View {
        ExampleSection(
            title: tr("switch.text_icon"),
            description: tr("switch.text_icon_desc"),
            content: {
                HStack(spacing: 16) {
                    Moin.Switch(
                        checked: $isOn2,
                        checkedText: "开启",
                        uncheckedText: "关闭"
                    )
                    
                    Moin.Switch(
                        checked: $isOn3,
                        checkedText: "1",
                        uncheckedText: "0"
                    )
                    
                    Moin.Switch(
                        checked: $isOn2,
                        checkedChildren: { Image(systemName: "checkmark") },
                        unCheckedChildren: { Image(systemName: "xmark") }
                    )
                    
                    Moin.Switch(
                        checked: $isOn3,
                        checkedChildren: { Text("YES") },
                        unCheckedChildren: { Text("NO") }
                    )
                }
            },
            code: {
                """
                Moin.Switch(checked: $isOn, checkedText: "开启", uncheckedText: "关闭")
                Moin.Switch(checked: $isOn, checkedText: "1", uncheckedText: "0")
                Moin.Switch(checked: $isOn, checkedChildren: { Image(systemName: "checkmark") }, unCheckedChildren: { Image(systemName: "xmark") })
                Moin.Switch(checked: $isOn, checkedChildren: { Text("YES") }, unCheckedChildren: { Text("NO") })
                """
            }
        )
    }
    
    private var loadingExample: some View {
        ExampleSection(
            title: tr("switch.loading"),
            description: tr("switch.loading_desc"),
            content: {
                HStack(spacing: 16) {
                    Moin.Switch(checked: .constant(true), loading: true)
                    Moin.Switch(checked: .constant(true), loading: true, size: .small)
                }
            },
            code: {
                """
                Moin.Switch(checked: .constant(true), loading: true)
                Moin.Switch(checked: .constant(true), loading: true, size: .small)
                """
            }
        )
    }
    
    private var sizeExample: some View {
        ExampleSection(
            title: tr("switch.size"),
            description: tr("switch.size_desc"),
            content: {
                HStack(spacing: 16) {
                    Moin.Switch(checked: $isOn4)
                    Moin.Switch(checked: $isOn4, size: .small)
                }
            },
            code: {
                """
                Moin.Switch(checked: $isOn)
                Moin.Switch(checked: $isOn, size: .small)
                """
            }
        )
    }
}
