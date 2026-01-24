import SwiftUI
import MoinUI

struct CheckboxAPIView: View {
    @Localized var tr

    // MARK: - State Variables

    @State private var checkedState = true
    @State private var indeterminateState = true
    @State private var labelState = true
    @State private var selection1: Set<String> = ["Apple"]
    @State private var selection2: Set<String> = ["London"]

    private let plainOptions = ["Apple", "Pear", "Orange"]

    private var objectOptions: [Moin.CheckboxOption<String>] {
        [
            .init(label: tr("checkbox.london"), value: "London"),
            .init(label: tr("checkbox.paris"), value: "Paris"),
            .init(label: tr("checkbox.new_york"), value: "New York")
        ]
    }

    private var apiSections: [DocSidebarSection] {
        [
            DocSidebarSection(
                title: tr("component.checkbox"),
                items: ["checked", "indeterminate", "isDisabled", "label"],
                sectionId: "checkbox"
            ),
            DocSidebarSection(
                title: tr("checkbox.group"),
                items: ["selection", "options", "direction", "groupDisabled"],
                sectionId: "checkboxgroup"
            )
        ]
    }

    var body: some View {
        ComponentDocBody(
            sections: apiSections,
            initialItemId: "checkbox"
        ) { sectionId in
            if sectionId == "checkbox" {
                Text(tr("component.checkbox")).font(.title3).fontWeight(.semibold)
            } else if sectionId == "checkboxgroup" {
                Text(tr("checkbox.group")).font(.title3).fontWeight(.semibold)
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
        case "selection": selectionPropertyCard
        case "options": optionsPropertyCard
        case "direction": directionPropertyCard
        case "groupDisabled": groupDisabledPropertyCard
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
            Moin.Checkbox(tr("component.checkbox"), checked: $checkedState)
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
            Moin.Checkbox(tr("component.checkbox"), checked: $indeterminateState, indeterminate: true)
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
                Moin.Checkbox("Disabled", checked: .constant(false), disabled: true)
                Moin.Checkbox("Disabled Checked", checked: .constant(true), disabled: true)
            }
        } code: {
            "Moin.Checkbox(\"Checkbox\", checked: $checked, disabled: true)"
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
            Moin.Checkbox(checked: $labelState) {
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

    // MARK: - CheckboxGroup API Cards

    private var selectionPropertyCard: some View {
        PropertyCard(
            name: "selection",
            type: "Binding<Set<Value>>",
            defaultValue: "-",
            description: tr("checkboxgroup.api.selection"),
            sectionId: "api"
        ) {
            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.sm) {
                Moin.CheckboxGroup(selection: $selection1, options: plainOptions)
                Text("Selected: \(selection1.sorted().joined(separator: ", "))")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        } code: {
            """
            @State private var selection: Set<String> = ["Apple"]
            let options = ["Apple", "Pear", "Orange"]

            Moin.CheckboxGroup(selection: $selection, options: options)
            """
        }
        .scrollAnchor("checkboxgroup.selection")
    }

    private var optionsPropertyCard: some View {
        PropertyCard(
            name: "options",
            type: "[CheckboxOption<Value>]",
            defaultValue: "-",
            description: tr("checkboxgroup.api.options"),
            sectionId: "api"
        ) {
            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.sm) {
                Moin.CheckboxGroup(selection: $selection2, options: objectOptions)
                Text("Selected: \(selection2.sorted().joined(separator: ", "))")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        } code: {
            """
            let options: [Moin.CheckboxOption<String>] = [
                .init(label: "London", value: "London"),
                .init(label: "Paris", value: "Paris"),
                .init(label: "New York", value: "New York")
            ]

            Moin.CheckboxGroup(selection: $selection, options: options)
            """
        }
        .scrollAnchor("checkboxgroup.options")
    }

    private var directionPropertyCard: some View {
        PropertyCard(
            name: "direction",
            type: "Axis",
            defaultValue: ".horizontal",
            description: tr("checkboxgroup.api.direction"),
            enumValues: ".vertical | .horizontal",
            sectionId: "api"
        ) {
            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.md) {
                Text("Vertical")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Moin.CheckboxGroup(
                    selection: .constant(Set(["Apple", "Pear"])),
                    options: plainOptions,
                    direction: .vertical
                )

                Divider()
                    .padding(.vertical, Moin.Constants.Spacing.sm)

                Text("Horizontal")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Moin.CheckboxGroup(
                    selection: .constant(Set(["Apple", "Pear"])),
                    options: plainOptions,
                    direction: .horizontal
                )
            }
        } code: {
            """
            Moin.CheckboxGroup(
                selection: $selection,
                options: options,
                direction: .vertical
            )

            Moin.CheckboxGroup(
                selection: $selection,
                options: options,
                direction: .horizontal
            )
            """
        }
        .scrollAnchor("checkboxgroup.direction")
    }

    private var groupDisabledPropertyCard: some View {
        PropertyCard(
            name: "isDisabled",
            type: "Bool",
            defaultValue: "false",
            description: tr("checkboxgroup.api.isDisabled"),
            sectionId: "api"
        ) {
            Moin.CheckboxGroup(
                selection: .constant(Set(["Apple"])),
                options: plainOptions,
                disabled: true
            )
        } code: {
            "Moin.CheckboxGroup(selection: $selection, options: options, disabled: true)"
        }
        .scrollAnchor("checkboxgroup.isDisabled")
    }
}

