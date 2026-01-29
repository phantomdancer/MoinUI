import SwiftUI
import MoinUI

/// Slider Tab
enum SliderExamplesTab: String, CaseIterable {
    case examples
    case api
    case token
}

struct SliderExamples: View {
    @Localized var tr
    @Binding var selectedTab: SliderExamplesTab

    // 状态 - 基础
    @State private var basicValue: Double = 30
    @State private var basicRangeValue: ClosedRange<Double> = 20...50
    @State private var basicDisabled = false

    // 状态 - 图标
    @State private var iconValue: Double = 0

    // 状态 - 事件
    @State private var eventValue: Double = 30
    @State private var eventRangeValue: ClosedRange<Double> = 20...50

    // 状态 - 刻度
    @State private var markValue: Double = 37
    @State private var markRangeValue: ClosedRange<Double> = 26...37
    @State private var markIncludedValue: Double = 37
    @State private var markStepValue: Double = 37
    @State private var markStepNullValue: Double = 37

    // 状态 - 垂直
    @State private var verticalValue: Double = 30
    @State private var verticalRangeValue: ClosedRange<Double> = 20...50
    @State private var verticalMarkRangeValue: ClosedRange<Double> = 26...37

    // 状态 - 反向
    @State private var reverseValue: Double = 30
    @State private var reverseRangeValue: ClosedRange<Double> = 20...50
    @State private var reversed = true

    // 懒加载
    @State private var apiReady = false
    @State private var tokenReady = false

    /// 锚点列表
    private let anchors: [AnchorItem] = [
        AnchorItem(id: "basic", titleKey: "slider.basic"),
        AnchorItem(id: "icon", titleKey: "slider.icon"),
        AnchorItem(id: "event", titleKey: "slider.event"),
        AnchorItem(id: "mark", titleKey: "slider.mark"),
        AnchorItem(id: "vertical", titleKey: "slider.vertical"),
        AnchorItem(id: "reverse", titleKey: "slider.reverse"),
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
        .onChange(of: selectedTab) { newValue in triggerLazyLoad(for: newValue) }
    }

    private var loadingView: some View {
        Moin.Spin()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private func triggerLazyLoad(for tab: SliderExamplesTab) {
        switch tab {
        case .examples:
            break
        case .api:
            if !apiReady {
                DispatchQueue.main.async { apiReady = true }
            }
        case .token:
            if !tokenReady {
                DispatchQueue.main.async { tokenReady = true }
            }
        }
    }

    // MARK: - Examples Content

    private var examplesContent: some View {
        ExamplePageWithAnchor(pageName: "Slider", anchors: anchors) { _ in
            basicExample.id("basic")
            iconExample.id("icon")
            eventExample.id("event")
            markExample.id("mark")
            verticalExample.id("vertical")
            reverseExample.id("reverse")
        }
    }

    // MARK: - API Content

    private var apiContent: some View {
        SliderAPIView()
    }

    // MARK: - Token Content

    private var tokenContent: some View {
        SliderTokenView()
    }

    // MARK: - Basic Example

    private var basicExample: some View {
        ExampleSection(
            title: tr("slider.basic"),
            description: tr("slider.basic_desc"),
            content: {
                VStack(alignment: .leading, spacing: 16) {
                    Moin.Slider(value: $basicValue, disabled: basicDisabled)
                    Moin.Slider(value: $basicRangeValue, disabled: basicDisabled)

                    HStack {
                        Text("Disabled:")
                            .foregroundStyle(.secondary)
                        Moin.Switch(checked: $basicDisabled, size: .small)
                    }
                }
            },
            code: {
                """
                @State private var value: Double = 30
                @State private var range: ClosedRange<Double> = 20...50
                @State private var disabled = false

                Moin.Slider(value: $value, disabled: disabled)
                Moin.Slider(value: $range, disabled: disabled)
                """
            }
        )
    }

    // MARK: - Icon Example

    private var iconExample: some View {
        ExampleSection(
            title: tr("slider.icon"),
            description: tr("slider.icon_desc"),
            content: {
                HStack(spacing: 12) {
                    Image(systemName: iconValue < 10 ? "face.dashed" : "face.smiling")
                        .foregroundStyle(iconValue < 10 ? .secondary : token.colorPrimary)
                    Moin.Slider(value: $iconValue, min: 0, max: 20)
                    Image(systemName: iconValue >= 10 ? "face.smiling.inverse" : "face.smiling")
                        .foregroundStyle(iconValue >= 10 ? token.colorPrimary : .secondary)
                }
            },
            code: {
                """
                @State private var value: Double = 0

                HStack {
                    Image(systemName: value < 10 ? "face.dashed" : "face.smiling")
                    Moin.Slider(value: $value, min: 0, max: 20)
                    Image(systemName: value >= 10 ? "face.smiling.inverse" : "face.smiling")
                }
                """
            }
        )
    }

    @Environment(\.moinToken) private var token

    // MARK: - Event Example

    private var eventExample: some View {
        ExampleSection(
            title: tr("slider.event"),
            description: tr("slider.event_desc"),
            content: {
                VStack(alignment: .leading, spacing: 16) {
                    Moin.Slider(
                        value: $eventValue,
                        onChange: { value in
                            print("onChange: \(value)")
                        },
                        onChangeComplete: { value in
                            print("onChangeComplete: \(value)")
                        }
                    )

                    Moin.Slider(
                        value: $eventRangeValue,
                        step: 10,
                        onChange: { range in
                            print("onChange: \(range)")
                        },
                        onChangeComplete: { range in
                            print("onChangeComplete: \(range)")
                        }
                    )
                }
            },
            code: {
                """
                Moin.Slider(
                    value: $value,
                    onChange: { print("onChange: \\($0)") },
                    onChangeComplete: { print("onChangeComplete: \\($0)") }
                )

                Moin.Slider(
                    value: $range,
                    step: 10,
                    onChange: { print("onChange: \\($0)") },
                    onChangeComplete: { print("onChangeComplete: \\($0)") }
                )
                """
            }
        )
    }

    // MARK: - Mark Example

    private let temperatureMarks: [Double: String] = [
        0: "0°C",
        26: "26°C",
        37: "37°C",
        100: "100°C"
    ]

    private var markExample: some View {
        ExampleSection(
            title: tr("slider.mark"),
            description: tr("slider.mark_desc"),
            content: {
                VStack(alignment: .leading, spacing: 32) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("included=true").font(.caption).foregroundStyle(.secondary)
                        Moin.Slider(value: $markValue, marks: temperatureMarks)
                            .frame(height: 60)
                        Moin.Slider(value: $markRangeValue, marks: temperatureMarks)
                            .frame(height: 60)
                    }

                    VStack(alignment: .leading, spacing: 4) {
                        Text("included=false").font(.caption).foregroundStyle(.secondary)
                        Moin.Slider(value: $markIncludedValue, marks: temperatureMarks, included: false)
                            .frame(height: 60)
                    }

                    VStack(alignment: .leading, spacing: 4) {
                        Text("marks & step").font(.caption).foregroundStyle(.secondary)
                        Moin.Slider(value: $markStepValue, step: 10, marks: temperatureMarks)
                            .frame(height: 60)
                    }

                    VStack(alignment: .leading, spacing: 4) {
                        Text("step=nil (dots)").font(.caption).foregroundStyle(.secondary)
                        Moin.Slider(value: $markStepNullValue, step: nil, marks: temperatureMarks, dots: true)
                            .frame(height: 60)
                    }
                }
            },
            code: {
                """
                let marks: [Double: String] = [
                    0: "0°C", 26: "26°C", 37: "37°C", 100: "100°C"
                ]

                // included=true (\(tr("slider.default")))
                Moin.Slider(value: $value, marks: marks)
                Moin.Slider(value: $range, marks: marks)

                // included=false
                Moin.Slider(value: $value, marks: marks, included: false)

                // marks & step
                Moin.Slider(value: $value, step: 10, marks: marks)

                // step=nil (dots: true)
                Moin.Slider(value: $value, step: nil, marks: marks, dots: true)
                """
            }
        )
    }

    // MARK: - Vertical Example

    private var verticalExample: some View {
        ExampleSection(
            title: tr("slider.vertical"),
            description: tr("slider.vertical_desc"),
            content: {
                HStack(alignment: .top, spacing: 48) {
                    Moin.Slider(value: $verticalValue, vertical: true)
                        .frame(height: 200)

                    Moin.Slider(value: $verticalRangeValue, step: 10, vertical: true)
                        .frame(height: 200)

                    Moin.Slider(value: $verticalMarkRangeValue, vertical: true, marks: temperatureMarks)
                        .frame(width: 100, height: 200)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            },
            code: {
                """
                Moin.Slider(value: $value, vertical: true)
                    .frame(height: 200)

                Moin.Slider(value: $range, step: 10, vertical: true)
                    .frame(height: 200)

                Moin.Slider(value: $range, vertical: true, marks: marks)
                    .frame(width: 100, height: 200)
                """
            }
        )
    }

    // MARK: - Reverse Example

    private var reverseExample: some View {
        ExampleSection(
            title: tr("slider.reverse"),
            description: tr("slider.reverse_desc"),
            content: {
                VStack(alignment: .leading, spacing: 16) {
                    Moin.Slider(value: $reverseValue, reverse: reversed)
                    Moin.Slider(value: $reverseRangeValue, reverse: reversed)

                    HStack {
                        Text("Reversed:")
                            .foregroundStyle(.secondary)
                        Moin.Switch(checked: $reversed, size: .small)
                    }
                }
            },
            code: {
                """
                @State private var reversed = true

                Moin.Slider(value: $value, reverse: reversed)
                Moin.Slider(value: $range, reverse: reversed)
                """
            }
        )
    }
}
