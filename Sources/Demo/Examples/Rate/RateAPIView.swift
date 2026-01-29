import SwiftUI
import MoinUI

// MARK: - RateAPIView

struct RateAPIView: View {
    @Localized var tr
    @State private var basicValue: Double = 3
    @State private var halfValue: Double = 2.5
    @State private var noClearValue: Double = 3

    // MARK: - API Sections

    private var apiSections: [DocSidebarSection] {
        [
            DocSidebarSection(
                title: "Rate",
                items: [
                    .init(id: "value"),
                    .init(id: "count"),
                    .init(id: "allowHalf"),
                    .init(id: "allowClear"),
                    .init(id: "disabled"),
                    .init(id: "size"),
                    .init(id: "character"),
                    .init(id: "onChange"),
                    .init(id: "onHoverChange")
                ],
                sectionId: "rate"
            )
        ]
    }

    var body: some View {
        ComponentDocBody(
            sections: apiSections,
            initialItemId: "rate"
        ) { sectionId in
            switch sectionId {
            case "rate":
                Text("Rate").font(.title3).fontWeight(.semibold)
            default:
                EmptyView()
            }
        } item: { item in
            cardForItem(item)
        }
    }

    @ViewBuilder
    private func cardForItem(_ item: String) -> some View {
        switch item {
        case "value": valuePropertyCard
        case "count": countPropertyCard
        case "allowHalf": allowHalfPropertyCard
        case "allowClear": allowClearPropertyCard
        case "disabled": disabledPropertyCard
        case "size": sizePropertyCard
        case "character": characterPropertyCard
        case "onChange": onChangePropertyCard
        case "onHoverChange": onHoverChangePropertyCard
        default: EmptyView()
        }
    }

    // MARK: - Property Cards

    private var valuePropertyCard: some View {
        PropertyCard(
            name: "value",
            type: "Binding<Double>",
            defaultValue: "-",
            description: tr("rate.prop_value"),
            sectionId: "rate"
        ) {
            VStack(alignment: .leading, spacing: 8) {
                Moin.Rate(value: $basicValue)
                Text("\(tr("rate.current_value")): \(basicValue, specifier: "%.1f")")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        } code: {
            """
            @State private var value: Double = 3

            Moin.Rate(value: $value)
            """
        }
        .scrollAnchor("rate.value")
    }

    private var countPropertyCard: some View {
        PropertyCard(
            name: "count",
            type: "Int",
            defaultValue: "5",
            description: tr("rate.prop_count"),
            sectionId: "rate"
        ) {
            VStack(alignment: .leading, spacing: 12) {
                HStack(spacing: 24) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("count: 3").font(.caption).foregroundStyle(.secondary)
                        Moin.Rate(value: .constant(2), count: 3)
                    }
                    VStack(alignment: .leading, spacing: 4) {
                        Text("count: 5 (\(tr("rate.default")))").font(.caption).foregroundStyle(.secondary)
                        Moin.Rate(value: .constant(3), count: 5)
                    }
                    VStack(alignment: .leading, spacing: 4) {
                        Text("count: 10").font(.caption).foregroundStyle(.secondary)
                        Moin.Rate(value: .constant(5), count: 10)
                    }
                }
            }
        } code: {
            """
            Moin.Rate(value: $value, count: 3)
            Moin.Rate(value: $value, count: 5)  // \(tr("rate.default"))
            Moin.Rate(value: $value, count: 10)
            """
        }
        .scrollAnchor("rate.count")
    }

    private var allowHalfPropertyCard: some View {
        PropertyCard(
            name: "allowHalf",
            type: "Bool",
            defaultValue: "false",
            description: tr("rate.prop_allowHalf"),
            sectionId: "rate"
        ) {
            VStack(alignment: .leading, spacing: 12) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("allowHalf: false (\(tr("rate.default")))").font(.caption).foregroundStyle(.secondary)
                    Moin.Rate(value: .constant(3), allowHalf: false)
                }
                VStack(alignment: .leading, spacing: 4) {
                    Text("allowHalf: true").font(.caption).foregroundStyle(.secondary)
                    Moin.Rate(value: $halfValue, allowHalf: true)
                    Text("\(tr("rate.current_value")): \(halfValue, specifier: "%.1f")")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
        } code: {
            """
            Moin.Rate(value: $value, allowHalf: false)  // \(tr("rate.default"))
            Moin.Rate(value: $value, allowHalf: true)
            """
        }
        .scrollAnchor("rate.allowHalf")
    }

    private var allowClearPropertyCard: some View {
        PropertyCard(
            name: "allowClear",
            type: "Bool",
            defaultValue: "true",
            description: tr("rate.prop_allowClear"),
            sectionId: "rate"
        ) {
            VStack(alignment: .leading, spacing: 12) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("allowClear: true (\(tr("rate.default")))").font(.caption).foregroundStyle(.secondary)
                    Moin.Rate(value: $basicValue, allowClear: true)
                }
                VStack(alignment: .leading, spacing: 4) {
                    Text("allowClear: false").font(.caption).foregroundStyle(.secondary)
                    Moin.Rate(value: $noClearValue, allowClear: false)
                }
            }
        } code: {
            """
            Moin.Rate(value: $value, allowClear: true)  // \(tr("rate.default"))
            Moin.Rate(value: $value, allowClear: false)
            """
        }
        .scrollAnchor("rate.allowClear")
    }

    private var disabledPropertyCard: some View {
        PropertyCard(
            name: "disabled",
            type: "Bool",
            defaultValue: "false",
            description: tr("rate.prop_disabled"),
            sectionId: "rate"
        ) {
            VStack(alignment: .leading, spacing: 12) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("disabled: false (\(tr("rate.default")))").font(.caption).foregroundStyle(.secondary)
                    Moin.Rate(value: .constant(3), disabled: false)
                }
                VStack(alignment: .leading, spacing: 4) {
                    Text("disabled: true").font(.caption).foregroundStyle(.secondary)
                    Moin.Rate(value: .constant(3), disabled: true)
                }
            }
        } code: {
            """
            Moin.Rate(value: $value, disabled: false)  // \(tr("rate.default"))
            Moin.Rate(value: $value, disabled: true)
            """
        }
        .scrollAnchor("rate.disabled")
    }

    private var sizePropertyCard: some View {
        PropertyCard(
            name: "size",
            type: "Size",
            defaultValue: ".medium",
            description: tr("rate.prop_size"),
            sectionId: "rate"
        ) {
            VStack(alignment: .leading, spacing: 16) {
                HStack(spacing: 24) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(".small").font(.caption).foregroundStyle(.secondary)
                        Moin.Rate(value: .constant(3), size: .small)
                    }
                    VStack(alignment: .leading, spacing: 4) {
                        Text(".medium (\(tr("rate.default")))").font(.caption).foregroundStyle(.secondary)
                        Moin.Rate(value: .constant(3), size: .medium)
                    }
                    VStack(alignment: .leading, spacing: 4) {
                        Text(".large").font(.caption).foregroundStyle(.secondary)
                        Moin.Rate(value: .constant(3), size: .large)
                    }
                }
                VStack(alignment: .leading, spacing: 4) {
                    Text("32").font(.caption).foregroundStyle(.secondary)
                    Moin.Rate(value: .constant(3), size: 32)
                }
            }
        } code: {
            """
            Moin.Rate(value: $value, size: .small)
            Moin.Rate(value: $value, size: .medium)  // \(tr("rate.default"))
            Moin.Rate(value: $value, size: .large)
            Moin.Rate(value: $value, size: 32)
            """
        }
        .scrollAnchor("rate.size")
    }

    private var characterPropertyCard: some View {
        PropertyCard(
            name: "character",
            type: "View",
            defaultValue: "star.fill",
            description: tr("rate.prop_character"),
            sectionId: "rate"
        ) {
            VStack(alignment: .leading, spacing: 16) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(tr("rate.heart_icon")).font(.caption).foregroundStyle(.secondary)
                    Moin.Rate(value: .constant(3)) {
                        Image(systemName: "heart.fill")
                    }
                }
                VStack(alignment: .leading, spacing: 4) {
                    Text(tr("rate.letter_character")).font(.caption).foregroundStyle(.secondary)
                    Moin.Rate(value: .constant(3)) {
                        Text("A").fontWeight(.bold)
                    }
                }
            }
        } code: {
            """
            // \(tr("rate.heart_icon"))
            Moin.Rate(value: $value) {
                Image(systemName: "heart.fill")
            }

            // \(tr("rate.letter_character"))
            Moin.Rate(value: $value) {
                Text("A").fontWeight(.bold)
            }
            """
        }
        .scrollAnchor("rate.character")
    }

    private var onChangePropertyCard: some View {
        PropertyCard(
            name: "onChange",
            type: "((Double) -> Void)?",
            defaultValue: "nil",
            description: tr("rate.prop_onChange"),
            sectionId: "rate"
        ) {
            Moin.Rate(value: $basicValue, onChange: { newValue in
                print("Rate changed to: \(newValue)")
            })
        } code: {
            """
            Moin.Rate(value: $value, onChange: { newValue in
                print("Rate changed to: \\(newValue)")
            })
            """
        }
        .scrollAnchor("rate.onChange")
    }

    private var onHoverChangePropertyCard: some View {
        PropertyCard(
            name: "onHoverChange",
            type: "((Double?) -> Void)?",
            defaultValue: "nil",
            description: tr("rate.prop_onHoverChange"),
            sectionId: "rate"
        ) {
            Moin.Rate(value: $basicValue, onHoverChange: { hoverValue in
                if let hv = hoverValue {
                    print("Hovering: \(hv)")
                } else {
                    print("Hover ended")
                }
            })
        } code: {
            """
            Moin.Rate(value: $value, onHoverChange: { hoverValue in
                if let hv = hoverValue {
                    print("Hovering: \\(hv)")
                } else {
                    print("Hover ended")
                }
            })
            """
        }
        .scrollAnchor("rate.onHoverChange")
    }
}
