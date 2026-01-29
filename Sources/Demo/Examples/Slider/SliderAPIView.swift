import SwiftUI
import MoinUI

// MARK: - SliderAPIView

struct SliderAPIView: View {
    @Localized var tr
    @State private var value: Double = 30
    @State private var rangeValue: ClosedRange<Double> = 20...50
    @State private var markValue: Double = 37

    // MARK: - API Sections

    private var apiSections: [DocSidebarSection] {
        [
            DocSidebarSection(
                title: "Slider",
                items: [
                    .init(id: "value"),
                    .init(id: "min"),
                    .init(id: "max"),
                    .init(id: "step"),
                    .init(id: "disabled"),
                    .init(id: "vertical"),
                    .init(id: "reverse"),
                    .init(id: "marks"),
                    .init(id: "dots"),
                    .init(id: "included"),
                    .init(id: "onChange"),
                    .init(id: "onChangeComplete")
                ],
                sectionId: "slider"
            )
        ]
    }

    var body: some View {
        ComponentDocBody(
            sections: apiSections,
            initialItemId: "slider"
        ) { sectionId in
            switch sectionId {
            case "slider":
                Text("Slider").font(.title3).fontWeight(.semibold)
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
        case "min": minPropertyCard
        case "max": maxPropertyCard
        case "step": stepPropertyCard
        case "disabled": disabledPropertyCard
        case "vertical": verticalPropertyCard
        case "reverse": reversePropertyCard
        case "marks": marksPropertyCard
        case "dots": dotsPropertyCard
        case "included": includedPropertyCard
        case "onChange": onChangePropertyCard
        case "onChangeComplete": onChangeCompletePropertyCard
        default: EmptyView()
        }
    }

    // MARK: - Property Cards

    private var valuePropertyCard: some View {
        PropertyCard(
            name: "value",
            type: "Binding<Double> | Binding<ClosedRange<Double>>",
            defaultValue: "-",
            description: tr("slider.api.value_desc"),
            sectionId: "slider"
        ) {
            VStack(alignment: .leading, spacing: 12) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Double").font(.caption).foregroundStyle(.secondary)
                    Moin.Slider(value: $value)
                    Text("\(tr("slider.current_value")): \(value, specifier: "%.0f")")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                VStack(alignment: .leading, spacing: 4) {
                    Text("ClosedRange<Double>").font(.caption).foregroundStyle(.secondary)
                    Moin.Slider(value: $rangeValue)
                    Text("\(tr("slider.current_value")): \(rangeValue.lowerBound, specifier: "%.0f") - \(rangeValue.upperBound, specifier: "%.0f")")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
        } code: {
            """
            @State private var value: Double = 30
            @State private var range: ClosedRange<Double> = 20...50

            Moin.Slider(value: $value)
            Moin.Slider(value: $range)
            """
        }
        .scrollAnchor("slider.value")
    }

    private var minPropertyCard: some View {
        PropertyCard(
            name: "min",
            type: "Double",
            defaultValue: "0",
            description: tr("slider.api.min_desc"),
            sectionId: "slider"
        ) {
            VStack(alignment: .leading, spacing: 12) {
                HStack(spacing: 24) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("min: 0 (\(tr("slider.default")))").font(.caption).foregroundStyle(.secondary)
                        Moin.Slider(value: .constant(30), min: 0, max: 100)
                    }
                    VStack(alignment: .leading, spacing: 4) {
                        Text("min: 20").font(.caption).foregroundStyle(.secondary)
                        Moin.Slider(value: .constant(30), min: 20, max: 100)
                    }
                }
            }
        } code: {
            """
            Moin.Slider(value: $value, min: 0)   // \(tr("slider.default"))
            Moin.Slider(value: $value, min: 20)
            """
        }
        .scrollAnchor("slider.min")
    }

    private var maxPropertyCard: some View {
        PropertyCard(
            name: "max",
            type: "Double",
            defaultValue: "100",
            description: tr("slider.api.max_desc"),
            sectionId: "slider"
        ) {
            VStack(alignment: .leading, spacing: 12) {
                HStack(spacing: 24) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("max: 100 (\(tr("slider.default")))").font(.caption).foregroundStyle(.secondary)
                        Moin.Slider(value: .constant(30), min: 0, max: 100)
                    }
                    VStack(alignment: .leading, spacing: 4) {
                        Text("max: 50").font(.caption).foregroundStyle(.secondary)
                        Moin.Slider(value: .constant(30), min: 0, max: 50)
                    }
                }
            }
        } code: {
            """
            Moin.Slider(value: $value, max: 100)  // \(tr("slider.default"))
            Moin.Slider(value: $value, max: 50)
            """
        }
        .scrollAnchor("slider.max")
    }

    private var stepPropertyCard: some View {
        PropertyCard(
            name: "step",
            type: "Double?",
            defaultValue: "1",
            description: tr("slider.api.step_desc"),
            sectionId: "slider"
        ) {
            VStack(alignment: .leading, spacing: 12) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("step: 1 (\(tr("slider.default")))").font(.caption).foregroundStyle(.secondary)
                    Moin.Slider(value: $value, step: 1)
                }
                VStack(alignment: .leading, spacing: 4) {
                    Text("step: 10").font(.caption).foregroundStyle(.secondary)
                    Moin.Slider(value: $value, step: 10)
                }
                VStack(alignment: .leading, spacing: 4) {
                    Text("step: nil (marks only)").font(.caption).foregroundStyle(.secondary)
                    Moin.Slider(value: $markValue, step: nil, marks: [0: "0", 25: "25", 50: "50", 100: "100"], dots: true)
                        .frame(height: 60)
                }
            }
        } code: {
            """
            Moin.Slider(value: $value, step: 1)    // \(tr("slider.default"))
            Moin.Slider(value: $value, step: 10)
            Moin.Slider(value: $value, step: nil, marks: [...], dots: true)
            """
        }
        .scrollAnchor("slider.step")
    }

    private var disabledPropertyCard: some View {
        PropertyCard(
            name: "disabled",
            type: "Bool",
            defaultValue: "false",
            description: tr("slider.api.disabled_desc"),
            sectionId: "slider"
        ) {
            VStack(alignment: .leading, spacing: 12) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("disabled: false (\(tr("slider.default")))").font(.caption).foregroundStyle(.secondary)
                    Moin.Slider(value: .constant(30), disabled: false)
                }
                VStack(alignment: .leading, spacing: 4) {
                    Text("disabled: true").font(.caption).foregroundStyle(.secondary)
                    Moin.Slider(value: .constant(30), disabled: true)
                }
            }
        } code: {
            """
            Moin.Slider(value: $value, disabled: false)  // \(tr("slider.default"))
            Moin.Slider(value: $value, disabled: true)
            """
        }
        .scrollAnchor("slider.disabled")
    }

    private var verticalPropertyCard: some View {
        PropertyCard(
            name: "vertical",
            type: "Bool",
            defaultValue: "false",
            description: tr("slider.api.vertical_desc"),
            sectionId: "slider"
        ) {
            HStack(alignment: .top, spacing: 48) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("vertical: false (\(tr("slider.default")))").font(.caption).foregroundStyle(.secondary)
                    Moin.Slider(value: $value, vertical: false)
                        .frame(width: 200)
                }
                VStack(alignment: .leading, spacing: 4) {
                    Text("vertical: true").font(.caption).foregroundStyle(.secondary)
                    Moin.Slider(value: $value, vertical: true)
                        .frame(height: 150)
                }
            }
        } code: {
            """
            Moin.Slider(value: $value, vertical: false)  // \(tr("slider.default"))
            Moin.Slider(value: $value, vertical: true)
                .frame(height: 150)
            """
        }
        .scrollAnchor("slider.vertical")
    }

    private var reversePropertyCard: some View {
        PropertyCard(
            name: "reverse",
            type: "Bool",
            defaultValue: "false",
            description: tr("slider.api.reverse_desc"),
            sectionId: "slider"
        ) {
            VStack(alignment: .leading, spacing: 12) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("reverse: false (\(tr("slider.default")))").font(.caption).foregroundStyle(.secondary)
                    Moin.Slider(value: $value, reverse: false)
                }
                VStack(alignment: .leading, spacing: 4) {
                    Text("reverse: true").font(.caption).foregroundStyle(.secondary)
                    Moin.Slider(value: $value, reverse: true)
                }
            }
        } code: {
            """
            Moin.Slider(value: $value, reverse: false)  // \(tr("slider.default"))
            Moin.Slider(value: $value, reverse: true)
            """
        }
        .scrollAnchor("slider.reverse")
    }

    private let temperatureMarks: [Double: String] = [
        0: "0°C", 26: "26°C", 37: "37°C", 100: "100°C"
    ]

    private var marksPropertyCard: some View {
        PropertyCard(
            name: "marks",
            type: "[Double: String]?",
            defaultValue: "nil",
            description: tr("slider.api.marks_desc"),
            sectionId: "slider"
        ) {
            VStack(alignment: .leading, spacing: 12) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("marks: nil (\(tr("slider.default")))").font(.caption).foregroundStyle(.secondary)
                    Moin.Slider(value: $value)
                }
                VStack(alignment: .leading, spacing: 4) {
                    Text("marks: [...]").font(.caption).foregroundStyle(.secondary)
                    Moin.Slider(value: $markValue, marks: temperatureMarks)
                        .frame(height: 60)
                }
            }
        } code: {
            """
            let marks: [Double: String] = [
                0: "0°C", 26: "26°C", 37: "37°C", 100: "100°C"
            ]

            Moin.Slider(value: $value)               // \(tr("slider.default"))
            Moin.Slider(value: $value, marks: marks)
            """
        }
        .scrollAnchor("slider.marks")
    }

    private var dotsPropertyCard: some View {
        PropertyCard(
            name: "dots",
            type: "Bool",
            defaultValue: "false",
            description: tr("slider.api.dots_desc"),
            sectionId: "slider"
        ) {
            VStack(alignment: .leading, spacing: 12) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("dots: false (\(tr("slider.default")))").font(.caption).foregroundStyle(.secondary)
                    Moin.Slider(value: $markValue, step: nil, marks: temperatureMarks, dots: false)
                        .frame(height: 60)
                }
                VStack(alignment: .leading, spacing: 4) {
                    Text("dots: true").font(.caption).foregroundStyle(.secondary)
                    Moin.Slider(value: $markValue, step: nil, marks: temperatureMarks, dots: true)
                        .frame(height: 60)
                }
            }
        } code: {
            """
            Moin.Slider(value: $value, marks: marks, dots: false)  // \(tr("slider.default"))
            Moin.Slider(value: $value, marks: marks, dots: true)
            """
        }
        .scrollAnchor("slider.dots")
    }

    private var includedPropertyCard: some View {
        PropertyCard(
            name: "included",
            type: "Bool",
            defaultValue: "true",
            description: tr("slider.api.included_desc"),
            sectionId: "slider"
        ) {
            VStack(alignment: .leading, spacing: 12) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("included: true (\(tr("slider.default")))").font(.caption).foregroundStyle(.secondary)
                    Moin.Slider(value: $markValue, marks: temperatureMarks, included: true)
                        .frame(height: 60)
                }
                VStack(alignment: .leading, spacing: 4) {
                    Text("included: false").font(.caption).foregroundStyle(.secondary)
                    Moin.Slider(value: $markValue, marks: temperatureMarks, included: false)
                        .frame(height: 60)
                }
            }
        } code: {
            """
            Moin.Slider(value: $value, marks: marks, included: true)   // \(tr("slider.default"))
            Moin.Slider(value: $value, marks: marks, included: false)
            """
        }
        .scrollAnchor("slider.included")
    }

    private var onChangePropertyCard: some View {
        PropertyCard(
            name: "onChange",
            type: "((Double) -> Void)?",
            defaultValue: "nil",
            description: tr("slider.api.onChange_desc"),
            sectionId: "slider"
        ) {
            Moin.Slider(value: $value, onChange: { newValue in
                print("onChange: \(newValue)")
            })
        } code: {
            """
            Moin.Slider(value: $value, onChange: { newValue in
                print("onChange: \\(newValue)")
            })
            """
        }
        .scrollAnchor("slider.onChange")
    }

    private var onChangeCompletePropertyCard: some View {
        PropertyCard(
            name: "onChangeComplete",
            type: "((Double) -> Void)?",
            defaultValue: "nil",
            description: tr("slider.api.onChangeComplete_desc"),
            sectionId: "slider"
        ) {
            Moin.Slider(value: $value, onChangeComplete: { newValue in
                print("onChangeComplete: \(newValue)")
            })
        } code: {
            """
            Moin.Slider(value: $value, onChangeComplete: { newValue in
                print("onChangeComplete: \\(newValue)")
            })
            """
        }
        .scrollAnchor("slider.onChangeComplete")
    }
}
