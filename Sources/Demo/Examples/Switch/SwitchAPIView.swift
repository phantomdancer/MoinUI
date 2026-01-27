import SwiftUI
import MoinUI

struct SwitchAPIView: View {
    @Localized var tr
    
    private var apiSections: [DocSidebarSection] {
        [
            DocSidebarSection(
                title: tr("api.button.section.common"),
                items: [.init(id: "checked"), .init(id: "loading"), .init(id: "disabled"), .init(id: "checkedChildren"), .init(id: "unCheckedChildren"), .init(id: "size"), .init(id: "onChange")],
                sectionId: "api"
            )
        ]
    }
    
    var body: some View {
        ComponentDocBody(
            sections: apiSections,
            initialItemId: "api"
        ) { sectionId in
            if sectionId == "api" {
                Text("API").font(.title3).fontWeight(.semibold)
            }
        } item: { item in
            cardForItem(item)
        }
    }
    
    @ViewBuilder
    private func cardForItem(_ item: String) -> some View {
        switch item {
        case "checked": checkedCard
        case "loading": loadingCard
        case "disabled": disabledCard
        case "checkedChildren": checkedChildrenCard
        case "unCheckedChildren": unCheckedChildrenCard
        case "size": sizeCard
        case "onChange": onChangeCard
        default: EmptyView()
        }
    }
    
    // MARK: - Cards
    
    @State private var isOnCheck1 = true
    @State private var isOnCheck2 = true
    
    private var checkedCard: some View {
        PropertyCard(
            name: "checked",
            type: "Binding<Bool>",
            defaultValue: "-",
            description: tr("api.switch.checked"),
            sectionId: "api"
        ) {
            Moin.Switch(checked: $isOnCheck1)
        } code: {
            """
            Moin.Switch(checked: $checked)
            """
        }
    }
    
    private var loadingCard: some View {
        PropertyCard(
            name: "loading",
            type: "Bool",
            defaultValue: "false",
            description: tr("api.switch.loading"),
            sectionId: "api"
        ) {
            Moin.Switch(checked: .constant(true), loading: true)
        } code: {
            """
            Moin.Switch(checked: $isOn, loading: true)
            """
        }
    }
    
    private var disabledCard: some View {
        PropertyCard(
            name: "disabled",
            type: "Bool",
            defaultValue: "false",
            description: tr("api.switch.disabled"),
            sectionId: "api"
        ) {
            HStack {
                Moin.Switch(checked: .constant(true), disabled: true)
                Moin.Switch(checked: .constant(false), disabled: true)
            }
        } code: {
            """
            Moin.Switch(checked: .constant(true), disabled: true)
            Moin.Switch(checked: .constant(false), disabled: true)
            """
        }
    }
    
    private var checkedChildrenCard: some View {
        PropertyCard(
            name: "checkedChildren",
            type: "View | String",
            defaultValue: "-",
            description: tr("api.switch.checkedChildren"),
            sectionId: "api"
        ) {
            VStack(spacing: 16) {
                // String overload
                Moin.Switch(checked: $isOnCheck2, checkedText: "开启", uncheckedText: "关闭")
                
                // ViewBuilder overload
                Moin.Switch(
                    checked: $isOnCheck2, 
                    checkedChildren: { Text("ON") }, 
                    unCheckedChildren: { Text("OFF") }
                )
            }
        } code: {
            """
            Moin.Switch(checked: $isOn, checkedText: "开启", uncheckedText: "关闭")
            
            Moin.Switch(checked: $isOn) {
                Text("ON")
            } unCheckedChildren: {
                Text("OFF")
            }
            """
        }
    }
    
    private var unCheckedChildrenCard: some View {
        PropertyCard(
            name: "unCheckedChildren",
            type: "View | String",
            defaultValue: "-",
            description: tr("api.switch.unCheckedChildren"),
            sectionId: "api"
        ) {
            VStack(spacing: 16) {
                 Moin.Switch(checked: $isOnCheck2, checkedText: "1", uncheckedText: "0")
                 
                 Moin.Switch(
                    checked: $isOnCheck2,
                    checkedChildren: { Text("YES") },
                    unCheckedChildren: { Text("NO") }
                 )
            }
        } code: {
            """
            Moin.Switch(checked: $isOn, checkedText: "1", uncheckedText: "0")
            
            Moin.Switch(checked: $isOn) {
                Text("YES")
            } unCheckedChildren: {
                Text("NO")
            }
            """
        }
    }
    
    @State private var isOnSize = true
    
    private var sizeCard: some View {
        PropertyCard(
            name: "size",
            type: "ControlSize",
            defaultValue: ".regular",
            description: tr("api.switch.size"),
            enumValues: ".regular | .small",
            sectionId: "api"
        ) {
            HStack {
                Moin.Switch(checked: $isOnSize)
                Moin.Switch(checked: $isOnSize, size: .small)
            }
        } code: {
            """
            Moin.Switch(checked: $isOn)
            Moin.Switch(checked: $isOn, size: .small)
            """
        }
    }
    
    private var onChangeCard: some View {
        PropertyCard(
            name: "onChange",
            type: "(Bool) -> Void",
            defaultValue: "-",
            description: tr("api.switch.onChange"),
            sectionId: "api"
        ) {
             Moin.Switch(checked: $isOnCheck1) { value in 
                print("Switch changed: \(value)")
            }
        } code: {
            """
            Moin.Switch(checked: $isOn) { value in 
                print("Switch changed: \\(value)")
            }
            """
        }
    }
}
