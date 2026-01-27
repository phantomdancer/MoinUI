import SwiftUI
import MoinUI

struct RadioAPIView: View {
    @Localized var tr

    // MARK: - State Variables

    @State private var checkedState = false
    @State private var labelState = false
    @State private var valueState1: Int = 1
    @State private var valueState2: String = "London"
    @State private var blockState: String = "A"
    @State private var buttonStyleState: String = "A"
    @State private var optionTypeState: String = "A"
    @State private var sizeState: String = "A"
    @State private var verticalState: String = "A"

    private let plainOptions = [1, 2, 3]
    private let stringOptions = ["A", "B", "C"]

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
                items: [.init(id: "checked"), .init(id: "disabled"), .init(id: "label")],
                sectionId: "radio"
            ),
            DocSidebarSection(
                title: tr("radio.group"),
                items: [
                    DocSidebarItem(id: "value"),
                    DocSidebarItem(id: "options"),
                    DocSidebarItem(id: "block"),
                    DocSidebarItem(id: "buttonStyle"),
                    DocSidebarItem(id: "optionType"),
                    DocSidebarItem(id: "orientation"),
                    DocSidebarItem(id: "size"),
                    DocSidebarItem(id: "vertical"),
                    DocSidebarItem(id: "groupDisabled", displayName: "disabled")
                ],
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
        // Radio
        case "checked": checkedPropertyCard
        case "disabled": disabledPropertyCard
        case "label": labelPropertyCard
        // RadioGroup
        case "value": valuePropertyCard
        case "options": optionsPropertyCard
        case "block": blockPropertyCard
        case "buttonStyle": buttonStylePropertyCard
        case "optionType": optionTypePropertyCard
        case "orientation": orientationPropertyCard
        case "size": sizePropertyCard
        case "vertical": verticalPropertyCard
        case "groupDisabled": groupDisabledPropertyCard
        default: EmptyView()
        }
    }

    // MARK: - Radio API Cards

    private var checkedPropertyCard: some View {
        PropertyCard(
            name: "checked",
            type: "Binding<Bool>",
            defaultValue: "false",
            description: tr("radio.api.checked"),
            sectionId: "radio"
        ) {
            Moin.Radio("Radio", checked: $checkedState)
        } code: {
            "Moin.Radio(\"Radio\", checked: $checked)"
        }
        .scrollAnchor("radio.checked")
    }

    private var disabledPropertyCard: some View {
        PropertyCard(
            name: "disabled",
            type: "Bool",
            defaultValue: "false",
            description: tr("radio.api.disabled"),
            sectionId: "radio"
        ) {
            HStack(spacing: 16) {
                Moin.Radio("Disabled", checked: .constant(false), disabled: true)
                Moin.Radio("Checked", checked: .constant(true), disabled: true)
            }
        } code: {
            "Moin.Radio(\"Radio\", checked: $checked, disabled: true)"
        }
        .scrollAnchor("radio.disabled")
    }

    private var labelPropertyCard: some View {
        PropertyCard(
            name: "label",
            type: "View",
            defaultValue: "-",
            description: tr("radio.api.label"),
            sectionId: "radio"
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
        .scrollAnchor("radio.label")
    }

    // MARK: - RadioGroup API Cards

    private var valuePropertyCard: some View {
        PropertyCard(
            name: "value",
            type: "Binding<Value>",
            defaultValue: "-",
            description: tr("radiogroup.api.value"),
            sectionId: "radiogroup"
        ) {
            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.sm) {
                Moin.Radio.Group(value: $valueState1, options: plainOptions)
                Text("value: \(valueState1)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        } code: {
            """
            @State private var value: Int = 1

            Moin.Radio.Group(value: $value, options: [1, 2, 3])
            """
        }
        .scrollAnchor("radiogroup.value")
    }

    private var optionsPropertyCard: some View {
        PropertyCard(
            name: "options",
            type: "[RadioOption<Value>] | [Value]",
            defaultValue: "-",
            description: tr("radiogroup.api.options"),
            sectionId: "radiogroup"
        ) {
            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.sm) {
                Moin.Radio.Group(value: $valueState2, options: objectOptions)
                Text("value: \(valueState2)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        } code: {
            """
            let options: [Moin.RadioOption<String>] = [
                .init(label: "\(tr("radio.london"))", value: "London"),
                .init(label: "\(tr("radio.paris"))", value: "Paris"),
                .init(label: "\(tr("radio.new_york"))", value: "New York")
            ]

            Moin.Radio.Group(value: $value, options: options)
            """
        }
        .scrollAnchor("radiogroup.options")
    }

    private var blockPropertyCard: some View {
        PropertyCard(
            name: "block",
            type: "Bool",
            defaultValue: "false",
            description: tr("radiogroup.api.block"),
            sectionId: "radiogroup"
        ) {
            VStack(alignment: .leading, spacing: 12) {
                Moin.Radio.Group(
                    value: $blockState,
                    options: stringOptions,
                    optionType: .button,
                    block: true
                )
            }
        } code: {
            """
            Moin.Radio.Group(
                value: $value,
                options: options,
                optionType: .button,
                block: true
            )
            """
        }
        .scrollAnchor("radiogroup.block")
    }

    private var buttonStylePropertyCard: some View {
        PropertyCard(
            name: "buttonStyle",
            type: "RadioButtonStyle",
            defaultValue: ".outline",
            description: tr("radiogroup.api.buttonStyle"),
            enumValues: ".outline | .solid",
            sectionId: "radiogroup"
        ) {
            VStack(alignment: .leading, spacing: 12) {
                Text("outline").font(.caption).foregroundStyle(.secondary)
                Moin.Radio.Group(
                    value: $buttonStyleState,
                    options: stringOptions,
                    optionType: .button,
                    buttonStyle: .outline
                )
                Text("solid").font(.caption).foregroundStyle(.secondary)
                Moin.Radio.Group(
                    value: $buttonStyleState,
                    options: stringOptions,
                    optionType: .button,
                    buttonStyle: .solid
                )
            }
        } code: {
            """
            // outline (default)
            Moin.Radio.Group(
                value: $value,
                options: options,
                optionType: .button,
                buttonStyle: .outline
            )

            // solid
            Moin.Radio.Group(
                value: $value,
                options: options,
                optionType: .button,
                buttonStyle: .solid
            )
            """
        }
        .scrollAnchor("radiogroup.buttonStyle")
    }

    private var optionTypePropertyCard: some View {
        PropertyCard(
            name: "optionType",
            type: "RadioOptionType",
            defaultValue: ".default",
            description: tr("radiogroup.api.optionType"),
            enumValues: ".default | .button",
            sectionId: "radiogroup"
        ) {
            VStack(alignment: .leading, spacing: 12) {
                Text("default").font(.caption).foregroundStyle(.secondary)
                Moin.Radio.Group(
                    value: $optionTypeState,
                    options: stringOptions,
                    optionType: .default
                )
                Text("button").font(.caption).foregroundStyle(.secondary)
                Moin.Radio.Group(
                    value: $optionTypeState,
                    options: stringOptions,
                    optionType: .button
                )
            }
        } code: {
            """
            // default
            Moin.Radio.Group(value: $value, options: options)

            // button
            Moin.Radio.Group(
                value: $value,
                options: options,
                optionType: .button
            )
            """
        }
        .scrollAnchor("radiogroup.optionType")
    }

    private var orientationPropertyCard: some View {
        PropertyCard(
            name: "orientation",
            type: "Axis",
            defaultValue: ".horizontal",
            description: tr("radiogroup.api.orientation"),
            enumValues: ".horizontal | .vertical",
            sectionId: "radiogroup"
        ) {
            HStack(alignment: .top, spacing: 32) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("horizontal").font(.caption).foregroundStyle(.secondary)
                    Moin.Radio.Group(
                        value: Binding.constant(1),
                        options: plainOptions,
                        orientation: .horizontal
                    )
                }
                VStack(alignment: .leading, spacing: 8) {
                    Text("vertical").font(.caption).foregroundStyle(.secondary)
                    Moin.Radio.Group(
                        value: Binding.constant(1),
                        options: plainOptions,
                        orientation: .vertical
                    )
                }
            }
        } code: {
            """
            Moin.Radio.Group(
                value: $value,
                options: options,
                orientation: .vertical
            )
            """
        }
        .scrollAnchor("radiogroup.orientation")
    }

    private var sizePropertyCard: some View {
        PropertyCard(
            name: "size",
            type: "RadioSize",
            defaultValue: ".middle",
            description: tr("radiogroup.api.size"),
            enumValues: ".large | .middle | .small",
            sectionId: "radiogroup"
        ) {
            VStack(alignment: .leading, spacing: 12) {
                HStack(spacing: 8) {
                    Text("large").font(.caption).foregroundStyle(.secondary).frame(width: 50, alignment: .leading)
                    Moin.Radio.Group(
                        value: $sizeState,
                        options: stringOptions,
                        optionType: .button,
                        size: .large
                    )
                }
                HStack(spacing: 8) {
                    Text("middle").font(.caption).foregroundStyle(.secondary).frame(width: 50, alignment: .leading)
                    Moin.Radio.Group(
                        value: $sizeState,
                        options: stringOptions,
                        optionType: .button,
                        size: .middle
                    )
                }
                HStack(spacing: 8) {
                    Text("small").font(.caption).foregroundStyle(.secondary).frame(width: 50, alignment: .leading)
                    Moin.Radio.Group(
                        value: $sizeState,
                        options: stringOptions,
                        optionType: .button,
                        size: .small
                    )
                }
            }
        } code: {
            """
            Moin.Radio.Group(
                value: $value,
                options: options,
                optionType: .button,
                size: .large  // .middle | .small
            )
            """
        }
        .scrollAnchor("radiogroup.size")
    }

    private var verticalPropertyCard: some View {
        PropertyCard(
            name: "vertical",
            type: "Bool",
            defaultValue: "false",
            description: tr("radiogroup.api.vertical"),
            sectionId: "radiogroup"
        ) {
            Moin.Radio.Group(
                value: $verticalState,
                options: [
                    .init(label: "A", value: "A"),
                    .init(label: "B", value: "B"),
                    .init(label: "C", value: "C")
                ],
                orientation: .vertical
            )
        } code: {
            """
            Moin.Radio.Group(
                value: $value,
                options: options,
                orientation: .vertical
            )
            """
        }
        .scrollAnchor("radiogroup.vertical")
    }

    private var groupDisabledPropertyCard: some View {
        PropertyCard(
            name: "disabled",
            type: "Bool",
            defaultValue: "false",
            description: tr("radiogroup.api.isDisabled"),
            sectionId: "radiogroup"
        ) {
            Moin.Radio.Group(
                value: Binding.constant(1),
                options: plainOptions,
                disabled: true
            )
        } code: {
            "Moin.Radio.Group(value: $value, options: options, disabled: true)"
        }
        .scrollAnchor("radiogroup.groupDisabled")
    }
}
