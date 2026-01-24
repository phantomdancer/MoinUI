import SwiftUI
import MoinUI

struct CheckboxGroupAPIView: View {
    @Localized var tr

    // MARK: - State Variables

    @State private var selection1: Set<String> = ["Apple"]
    @State private var selection2: Set<String> = ["London"]

    private let options1 = ["Apple", "Pear", "Orange"]

    private var options2: [Moin.CheckboxOption<String>] {
        [
            .init(label: tr("checkbox.london"), value: "London"),
            .init(label: tr("checkbox.paris"), value: "Paris"),
            .init(label: tr("checkbox.new_york"), value: "New York")
        ]
    }

    private var apiSections: [DocSidebarSection] {
        [
            DocSidebarSection(
                title: tr("api.section.common"),
                items: ["selection", "options", "direction", "isDisabled"],
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
        case "selection": selectionPropertyCard
        case "options": optionsPropertyCard
        case "direction": directionPropertyCard
        case "isDisabled": disabledPropertyCard
        default: EmptyView()
        }
    }

    private var selectionPropertyCard: some View {
        PropertyCard(
            name: "selection",
            type: "Binding<Set<Value>>",
            defaultValue: "-",
            description: tr("checkboxgroup.api.selection"),
            sectionId: "api"
        ) {
            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.sm) {
                Moin.CheckboxGroup(selection: $selection1, options: options1)
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
        .scrollAnchor("api.selection")
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
                Moin.CheckboxGroup(selection: $selection2, options: options2)
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
        .scrollAnchor("api.options")
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
                    options: options1,
                    direction: .vertical
                )

                Divider()
                    .padding(.vertical, Moin.Constants.Spacing.sm)

                Text("Horizontal")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Moin.CheckboxGroup(
                    selection: .constant(Set(["Apple", "Pear"])),
                    options: options1,
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
        .scrollAnchor("api.direction")
    }

    private var disabledPropertyCard: some View {
        PropertyCard(
            name: "isDisabled",
            type: "Bool",
            defaultValue: "false",
            description: tr("checkboxgroup.api.isDisabled"),
            sectionId: "api"
        ) {
            Moin.CheckboxGroup(
                selection: .constant(Set(["Apple"])),
                options: options1,
                isDisabled: true
            )
        } code: {
            "Moin.CheckboxGroup(selection: $selection, options: options, isDisabled: true)"
        }
        .scrollAnchor("api.isDisabled")
    }
}
