import SwiftUI
import MoinUI

struct SwitchAPIView: View {
    @Localized var tr
    
    private var apiSections: [DocSidebarSection] {
        [
            DocSidebarSection(
                title: tr("api.button.section.common"),
                items: ["isOn", "loading", "disabled", "checkedChildren", "unCheckedChildren", "size", "onChange"],
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
        case "isOn": isOnCard
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
    
    private var isOnCard: some View {
        PropertyCard(
            name: "isOn",
            type: "Binding<Bool>",
            defaultValue: "-",
            description: tr("api.switch.isOn"),
            sectionId: "api"
        ) {
            Moin.Switch(isOn: $isOnCheck1)
        } code: {
            """
            Moin.Switch(isOn: $isOn)
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
            Moin.Switch(isOn: .constant(true), loading: true)
        } code: {
            """
            Moin.Switch(isOn: $isOn, loading: true)
            """
        }
    }
    
    private var disabledCard: some View {
        PropertyCard(
            name: "isDisabled",
            type: "Bool",
            defaultValue: "false",
            description: tr("api.switch.disabled"),
            sectionId: "api"
        ) {
            HStack {
                Moin.Switch(isOn: .constant(true), isDisabled: true)
                Moin.Switch(isOn: .constant(false), isDisabled: true)
            }
        } code: {
            """
            Moin.Switch(isOn: .constant(true), isDisabled: true)
            Moin.Switch(isOn: .constant(false), isDisabled: true)
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
                Moin.Switch(isOn: $isOnCheck2, checkedText: "开启", uncheckedText: "关闭")
                
                // ViewBuilder overload
                Moin.Switch(
                    isOn: $isOnCheck2, 
                    checkedChildren: { Text("ON") }, 
                    unCheckedChildren: { Text("OFF") }
                )
            }
        } code: {
            """
            Moin.Switch(isOn: $isOn, checkedText: "开启", uncheckedText: "关闭")
            
            Moin.Switch(isOn: $isOn) {
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
                 Moin.Switch(isOn: $isOnCheck2, checkedText: "1", uncheckedText: "0")
                 
                 Moin.Switch(
                    isOn: $isOnCheck2,
                    checkedChildren: { Text("YES") },
                    unCheckedChildren: { Text("NO") }
                 )
            }
        } code: {
            """
            Moin.Switch(isOn: $isOn, checkedText: "1", uncheckedText: "0")
            
            Moin.Switch(isOn: $isOn) {
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
                Moin.Switch(isOn: $isOnSize)
                Moin.Switch(isOn: $isOnSize, size: .small)
            }
        } code: {
            """
            Moin.Switch(isOn: $isOn)
            Moin.Switch(isOn: $isOn, size: .small)
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
             Moin.Switch(isOn: $isOnCheck1) { value in 
                print("Switch changed: \(value)")
            }
        } code: {
            """
            Moin.Switch(isOn: $isOn) { value in 
                print("Switch changed: \\(value)")
            }
            """
        }
    }
}
