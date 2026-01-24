import SwiftUI
import MoinUI

struct RadioAPIView: View {
    @Localized var tr

    // MARK: - State Variables

    @State private var checkedState = false
    @State private var labelState = false
    @State private var selection1: Int = 1
    @State private var selection2: String = "London"

    private let plainOptions = [1, 2, 3]
    
    private var objectOptions: [Moin.RadioOption<String>] {
        [
            .init(label: tr("radio.london"), value: "London"),
            .init(label: tr("radio.paris"), value: "Paris"),
            .init(label: tr("radio.new_york"), value: "New York")
        ]
    }

    private var apiSections: [DocSidebarSection] {
        [
            DocSidebarSection(
                title: tr("component.radio"),
                items: ["checked", "isDisabled", "label"],
                sectionId: "radio"
            ),
            DocSidebarSection(
                title: tr("radio.group"),
                items: ["selection", "options", "direction", "groupDisabled"],
                sectionId: "radiogroup"
            )
        ]
    }

    var body: some View {
        ComponentDocBody(
            sections: apiSections,
            initialItemId: "radio"
        ) { sectionId in
            if sectionId == "radio" {
                Text(tr("component.radio")).font(.title3).fontWeight(.semibold)
            } else if sectionId == "radiogroup" {
                Text(tr("radio.group")).font(.title3).fontWeight(.semibold)
            }
        } item: { item in
            cardForItem(item)
        }
    }

    @ViewBuilder
    private func cardForItem(_ item: String) -> some View {
        switch item {
        case "checked": checkedPropertyCard
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
            description: tr("radio.api.checked"),
            sectionId: "api"
        ) {
            Moin.Radio("Radio", checked: $checkedState)
        } code: {
            "Moin.Radio(\"Radio\", checked: $checked)"
        }
        .scrollAnchor("api.checked")
    }

    private var disabledPropertyCard: some View {
        PropertyCard(
            name: "isDisabled",
            type: "Bool",
            defaultValue: "false",
            description: tr("radio.api.disabled"),
            sectionId: "api"
        ) {
            HStack {
                Moin.Radio("Disabled", checked: .constant(false), disabled: true)
                Moin.Radio("Checked Disabled", checked: .constant(true), disabled: true)
            }
        } code: {
            "Moin.Radio(\"Radio\", checked: $checked, disabled: true)"
        }
        .scrollAnchor("api.isDisabled")
    }

    private var labelPropertyCard: some View {
        PropertyCard(
            name: "label",
            type: "View",
            defaultValue: "-",
            description: tr("radio.api.label"),
            sectionId: "api"
        ) {
            Moin.Radio(checked: $labelState) {
                HStack(spacing: 4) {
                    Image(systemName: "star.fill").foregroundColor(.yellow)
                    Text("Custom Label")
                }
            }
        } code: {
            """
            Moin.Radio(checked: $checked) {
                HStack {
                    Image(systemName: "star.fill")
                    Text("Custom Label")
                }
            }
            """
        }
        .scrollAnchor("api.label")
    }

    // MARK: - RadioGroup API Cards

    private var selectionPropertyCard: some View {
        PropertyCard(
            name: "selection",
            type: "Binding<Value>",
            defaultValue: "-",
            description: tr("radiogroup.api.selection"),
            sectionId: "api"
        ) {
            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.sm) {
                Moin.RadioGroup(selection: $selection1, options: plainOptions)
                Text("Selected: \(selection1)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        } code: {
            """
            @State private var selection: Int = 1
            let options = [1, 2, 3]

            Moin.RadioGroup(selection: $selection, options: options)
            """
        }
        .scrollAnchor("radiogroup.selection")
    }

    private var optionsPropertyCard: some View {
        PropertyCard(
            name: "options",
            type: "[RadioOption<Value>]",
            defaultValue: "-",
            description: tr("radiogroup.api.options"),
            sectionId: "api"
        ) {
            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.sm) {
                Moin.RadioGroup(selection: $selection2, options: objectOptions)
                Text("Selected: \(selection2)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        } code: {
            """
            let options: [Moin.RadioOption<String>] = [
                .init(label: "London", value: "London"),
                .init(label: "Paris", value: "Paris")
            ]

            Moin.RadioGroup(selection: $selection, options: options)
            """
        }
        .scrollAnchor("radiogroup.options")
    }

    private var directionPropertyCard: some View {
        PropertyCard(
            name: "direction",
            type: "Axis",
            defaultValue: ".horizontal",
            description: tr("radiogroup.api.direction"),
            enumValues: ".vertical | .horizontal",
            sectionId: "api"
        ) {
            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.md) {
                Text("Vertical")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Moin.RadioGroup(
                    selection: .constant(1),
                    options: plainOptions,
                    direction: .vertical
                )

                Divider()
                    .padding(.vertical, Moin.Constants.Spacing.sm)

                Text("Horizontal")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Moin.RadioGroup(
                    selection: .constant(1),
                    options: plainOptions,
                    direction: .horizontal
                )
            }
        } code: {
            """
            Moin.RadioGroup(
                selection: $selection,
                options: options,
                direction: .vertical
            )
            """
        }
        .scrollAnchor("radiogroup.direction")
    }

    private var groupDisabledPropertyCard: some View {
        PropertyCard(
            name: "isDisabled",
            type: "Bool",
            defaultValue: "false",
            description: tr("radiogroup.api.isDisabled"),
            sectionId: "api"
        ) {
            Moin.RadioGroup(
                selection: .constant(1),
                options: plainOptions,
                disabled: true
            )
        } code: {
            "Moin.RadioGroup(selection: $selection, options: options, disabled: true)"
        }
        .scrollAnchor("radiogroup.isDisabled")
    }
}
