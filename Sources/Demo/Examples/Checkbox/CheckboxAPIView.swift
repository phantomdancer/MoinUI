import SwiftUI
import MoinUI

struct CheckboxAPIView: View {
    @Localized var tr

    private var apiSections: [DocSidebarSection] {
        [
            DocSidebarSection(
                title: tr("api.section.common"),
                items: ["checked", "indeterminate", "isDisabled", "label"],
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
        case "checked": checkedPropertyCard
        case "indeterminate": indeterminatePropertyCard
        case "isDisabled": disabledPropertyCard
        case "label": labelPropertyCard
        default: EmptyView()
        }
    }

    private var checkedPropertyCard: some View {
        PropertyCard(
            name: "checked",
            type: "Binding<Bool>",
            defaultValue: "-",
            description: tr("checkbox.api.checked"),
            sectionId: "api"
        ) {
            Moin.Checkbox(tr("component.checkbox"), checked: .constant(true))
        } code: {
            "Moin.Checkbox(\"Checkbox\", checked: $checked)"
        }
        .scrollAnchor("api.checked")
    }

    private var indeterminatePropertyCard: some View {
        PropertyCard(
            name: "indeterminate",
            type: "Bool",
            defaultValue: "false",
            description: tr("checkbox.api.indeterminate"),
            sectionId: "api"
        ) {
            Moin.Checkbox(tr("component.checkbox"), checked: .constant(true), indeterminate: true)
        } code: {
            "Moin.Checkbox(\"Checkbox\", checked: $checked, indeterminate: true)"
        }
        .scrollAnchor("api.indeterminate")
    }

    private var disabledPropertyCard: some View {
        PropertyCard(
            name: "isDisabled",
            type: "Bool",
            defaultValue: "false",
            description: tr("checkbox.api.disabled"),
            sectionId: "api"
        ) {
            HStack {
                Moin.Checkbox("Disabled", checked: .constant(false), isDisabled: true)
                Moin.Checkbox("Disabled Checked", checked: .constant(true), isDisabled: true)
            }
        } code: {
            "Moin.Checkbox(\"Checkbox\", checked: $checked, isDisabled: true)"
        }
        .scrollAnchor("api.isDisabled")
    }

    private var labelPropertyCard: some View {
        PropertyCard(
            name: "label",
            type: "View",
            defaultValue: "-",
            description: tr("checkbox.api.label"),
            sectionId: "api"
        ) {
            Moin.Checkbox(checked: .constant(true)) {
                HStack(spacing: 4) {
                    Image(systemName: "star.fill").foregroundColor(.yellow)
                    Text("Custom Label")
                }
            }
        } code: {
            """
            Moin.Checkbox(checked: $checked) {
                HStack {
                    Image(systemName: "star.fill")
                    Text("Custom Label")
                }
            }
            """
        }
        .scrollAnchor("api.label")
    }
}

