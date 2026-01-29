// MARK: - Moin.Slider

import SwiftUI
import AppKit

// MARK: - Slider Mark

/// 滑块刻度标记
public struct _SliderMark<Label: View> {
    public let label: Label
    public let style: _SliderMarkStyle?

    public init(@ViewBuilder label: () -> Label, style: _SliderMarkStyle? = nil) {
        self.label = label()
        self.style = style
    }
}

public extension _SliderMark where Label == Text {
    init(_ text: String, style: _SliderMarkStyle? = nil) {
        self.label = Text(text)
        self.style = style
    }
}

public struct _SliderMarkStyle {
    public var color: Color?
    public var fontWeight: Font.Weight?

    public init(color: Color? = nil, fontWeight: Font.Weight? = nil) {
        self.color = color
        self.fontWeight = fontWeight
    }
}

// MARK: - Mark Key for ForEach

private struct MarkKey: Identifiable {
    let id: Double
    let mark: _SliderMark<AnyView>

    init(_ key: Double, _ mark: _SliderMark<AnyView>) {
        self.id = key
        self.mark = mark
    }
}

// MARK: - Single Slider

public struct _Slider: View {
    @Binding var value: Double
    let min: Double
    let max: Double
    let step: Double?
    let disabled: Bool
    let vertical: Bool
    let reverse: Bool
    let marks: [Double: _SliderMark<AnyView>]?
    let dots: Bool
    let included: Bool
    var onChange: ((Double) -> Void)?
    var onChangeComplete: ((Double) -> Void)?

    public init(
        value: Binding<Double>,
        min: Double = 0,
        max: Double = 100,
        step: Double? = 1,
        disabled: Bool = false,
        vertical: Bool = false,
        reverse: Bool = false,
        marks: [Double: _SliderMark<AnyView>]? = nil,
        dots: Bool = false,
        included: Bool = true,
        onChange: ((Double) -> Void)? = nil,
        onChangeComplete: ((Double) -> Void)? = nil
    ) {
        self._value = value
        self.min = min
        self.max = max
        self.step = step
        self.disabled = disabled
        self.vertical = vertical
        self.reverse = reverse
        self.marks = marks
        self.dots = dots
        self.included = included
        self.onChange = onChange
        self.onChangeComplete = onChangeComplete
    }

    // 将 Double 转换为 [Double] 绑定
    private var arrayBinding: Binding<[Double]> {
        Binding(
            get: { [value] },
            set: { arr in
                if let v = arr.first { value = v }
            }
        )
    }

    public var body: some View {
        _MultiSlider(
            value: arrayBinding,
            min: min,
            max: max,
            step: step,
            disabled: disabled,
            vertical: vertical,
            reverse: reverse,
            marks: marks,
            dots: dots,
            included: included,
            editable: false,
            draggableTrack: false,
            minCount: 1,
            maxCount: 1,
            onChange: { arr in
                if let v = arr.first { onChange?(v) }
            },
            onChangeComplete: { arr in
                if let v = arr.first { onChangeComplete?(v) }
            }
        )
    }
}

// MARK: - Range Slider (wrapper over MultiSlider)

public struct _RangeSlider: View {
    @Binding var value: ClosedRange<Double>
    let min: Double
    let max: Double
    let step: Double?
    let disabled: Bool
    let vertical: Bool
    let reverse: Bool
    let marks: [Double: _SliderMark<AnyView>]?
    let dots: Bool
    let included: Bool
    let draggableTrack: Bool
    var onChange: ((ClosedRange<Double>) -> Void)?
    var onChangeComplete: ((ClosedRange<Double>) -> Void)?

    public init(
        value: Binding<ClosedRange<Double>>,
        min: Double = 0,
        max: Double = 100,
        step: Double? = 1,
        disabled: Bool = false,
        vertical: Bool = false,
        reverse: Bool = false,
        marks: [Double: _SliderMark<AnyView>]? = nil,
        dots: Bool = false,
        included: Bool = true,
        draggableTrack: Bool = false,
        onChange: ((ClosedRange<Double>) -> Void)? = nil,
        onChangeComplete: ((ClosedRange<Double>) -> Void)? = nil
    ) {
        self._value = value
        self.min = min
        self.max = max
        self.step = step
        self.disabled = disabled
        self.vertical = vertical
        self.reverse = reverse
        self.marks = marks
        self.dots = dots
        self.included = included
        self.draggableTrack = draggableTrack
        self.onChange = onChange
        self.onChangeComplete = onChangeComplete
    }

    // 将 ClosedRange 转换为 [Double] 绑定
    private var arrayBinding: Binding<[Double]> {
        Binding(
            get: { [value.lowerBound, value.upperBound] },
            set: { arr in
                guard arr.count >= 2 else { return }
                let sorted = arr.sorted()
                value = sorted[0]...sorted[arr.count - 1]
            }
        )
    }

    public var body: some View {
        _MultiSlider(
            value: arrayBinding,
            min: min,
            max: max,
            step: step,
            disabled: disabled,
            vertical: vertical,
            reverse: reverse,
            marks: marks,
            dots: dots,
            included: included,
            editable: false,
            draggableTrack: draggableTrack,
            minCount: 2,
            maxCount: 2,
            onChange: { arr in
                guard arr.count >= 2 else { return }
                let sorted = arr.sorted()
                onChange?(sorted[0]...sorted[sorted.count - 1])
            },
            onChangeComplete: { arr in
                guard arr.count >= 2 else { return }
                let sorted = arr.sorted()
                onChangeComplete?(sorted[0]...sorted[sorted.count - 1])
            }
        )
    }
}

// MARK: - Multi Slider (Editable)

public struct _MultiSlider: View {
    @Binding var value: [Double]
    let min: Double
    let max: Double
    let step: Double?
    let disabled: Bool
    let vertical: Bool
    let reverse: Bool
    let marks: [Double: _SliderMark<AnyView>]?
    let dots: Bool
    let included: Bool
    let editable: Bool
    let draggableTrack: Bool
    let minCount: Int
    let maxCount: Int
    var onChange: (([Double]) -> Void)?
    var onChangeComplete: (([Double]) -> Void)?

    @Environment(\.moinSliderToken) private var sliderToken
    @Environment(\.moinToken) private var token
    @Environment(\.isEnabled) private var isEnabled

    @State private var isHovering = false
    @State private var draggingIndex: Int?
    @State private var hoveringIndex: Int?
    @State private var draggingValue: Double = 0
    @State private var isDraggingOut = false
    @State private var trackDragStart: [Double]?
    @State private var trackDragAnchor: Double = 0
    @State private var trackDragDelta: Double = 0

    public init(
        value: Binding<[Double]>,
        min: Double = 0,
        max: Double = 100,
        step: Double? = 1,
        disabled: Bool = false,
        vertical: Bool = false,
        reverse: Bool = false,
        marks: [Double: _SliderMark<AnyView>]? = nil,
        dots: Bool = false,
        included: Bool = true,
        editable: Bool = true,
        draggableTrack: Bool = false,
        minCount: Int = 1,
        maxCount: Int = 5,
        onChange: (([Double]) -> Void)? = nil,
        onChangeComplete: (([Double]) -> Void)? = nil
    ) {
        self._value = value
        self.min = min
        self.max = max
        self.step = step
        self.disabled = disabled
        self.vertical = vertical
        self.reverse = reverse
        self.marks = marks
        self.dots = dots
        self.included = included
        self.editable = editable
        self.draggableTrack = draggableTrack
        self.minCount = Swift.max(1, minCount)
        self.maxCount = Swift.max(minCount, maxCount)
        self.onChange = onChange
        self.onChangeComplete = onChangeComplete
    }

    private var isEffectiveDisabled: Bool {
        !isEnabled || disabled
    }

    private func normalized(_ val: Double) -> Double {
        let n = (val - min) / (max - min)
        return reverse ? 1 - n : n
    }

    private var sortedValue: [Double] {
        value.sorted()
    }

    // 拖拽过程中的显示值（不触发外部 binding 更新）
    private var displayValues: [Double] {
        if let start = trackDragStart {
            var result = start.map { $0 + trackDragDelta }
            let sorted = result.sorted()
            if sorted.first! < min {
                result = result.map { $0 + (min - sorted.first!) }
            }
            if sorted.last! > max {
                result = result.map { $0 - (sorted.last! - max) }
            }
            return result
        }
        var result = value
        if let index = draggingIndex, index < result.count {
            result[index] = draggingValue
        }
        return result
    }

    private var displaySorted: [Double] {
        displayValues.sorted()
    }

    private var markKeys: [MarkKey] {
        guard let marks = marks else { return [] }
        return marks.keys.sorted().map { MarkKey($0, marks[$0]!) }
    }

    public var body: some View {
        GeometryReader { geo in
            let size = vertical ? geo.size.height : geo.size.width
            let trackLength = size

            ZStack(alignment: vertical ? .bottom : .leading) {
                // Rail
                Capsule()
                    .fill(isHovering && !isEffectiveDisabled ? sliderToken.railHoverBg : sliderToken.railBg)
                    .frame(
                        width: vertical ? sliderToken.railSize : nil,
                        height: vertical ? nil : sliderToken.railSize
                    )

                // Track segments
                if included && !displaySorted.isEmpty {
                    trackView(trackLength: trackLength)
                }

                // Dots
                ForEach(markKeys) { markKey in
                    dotView(for: markKey.id, in: trackLength)
                }

                // Handles
                ForEach(Array(displayValues.enumerated()), id: \.offset) { index, val in
                    handleView(
                        position: trackLength * normalized(val),
                        index: index,
                        isActive: draggingIndex == index,
                        isDraggingOut: draggingIndex == index && isDraggingOut
                    )
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .contentShape(Rectangle())
            .onContinuousHover { phase in
                switch phase {
                case .active(let location):
                    if isEffectiveDisabled {
                        NSCursor.operationNotAllowed.set()
                    } else {
                        if !isHovering { isHovering = true }
                        NSCursor.pointingHand.set()

                        if draggingIndex == nil {
                            let pos = vertical ? (trackLength - location.y) : location.x
                            hoveringIndex = findNearestHandleIndex(at: pos, trackLength: trackLength)
                        }
                    }
                case .ended:
                    if isHovering { isHovering = false }
                    hoveringIndex = nil
                    NSCursor.arrow.set()
                }
            }
            .gesture(dragGesture(in: trackLength, geoSize: geo.size))
            .overlay(alignment: vertical ? .leading : .bottom) {
                marksView(trackLength: trackLength)
            }
        }
        .frame(
            width: vertical ? sliderToken.controlSize * 3 : nil,
            height: vertical ? nil : sliderToken.controlSize * 3
        )
        .animation(.easeInOut(duration: token.motionDurationFast), value: isHovering)
    }

    private func findNearestHandleIndex(at pos: CGFloat, trackLength: CGFloat) -> Int? {
        let handleRadius = sliderToken.handleSizeHover / 2
        for (index, val) in value.enumerated() {
            let handlePos = trackLength * normalized(val)
            if abs(pos - handlePos) <= handleRadius {
                return index
            }
        }
        return nil
    }

    @ViewBuilder
    private func trackView(trackLength: CGFloat) -> some View {
        let sorted = displaySorted
        // 单值：从起点到当前值；多值：从第一个到最后一个
        let startNorm: CGFloat = sorted.count >= 2 ? normalized(sorted.first!) : (reverse ? normalized(sorted.first!) : 0)
        let endNorm: CGFloat = sorted.count >= 2 ? normalized(sorted.last!) : (reverse ? 1 : normalized(sorted.last!))
        let startPos = trackLength * startNorm
        let endPos = trackLength * endNorm
        let trackWidth = abs(endPos - startPos)
        let offset = Swift.min(startPos, endPos)

        Capsule()
            .fill(trackColor)
            .frame(
                width: vertical ? sliderToken.railSize : trackWidth,
                height: vertical ? trackWidth : sliderToken.railSize
            )
            .offset(
                x: vertical ? 0 : offset,
                y: vertical ? -offset : 0
            )
    }

    private var trackColor: Color {
        if isEffectiveDisabled { return sliderToken.trackBgDisabled }
        return isHovering ? sliderToken.trackHoverBg : sliderToken.trackBg
    }

    @ViewBuilder
    private func handleView(position: CGFloat, index: Int, isActive: Bool, isDraggingOut: Bool) -> some View {
        let isThisHandleHovered = hoveringIndex == index
        let shouldEnlarge = (isHovering || isActive) && !isEffectiveDisabled
        let handleSize = shouldEnlarge ? sliderToken.handleSizeHover : sliderToken.handleSize
        let lineWidth = shouldEnlarge ? sliderToken.handleLineWidthHover : sliderToken.handleLineWidth

        let borderColor: Color = {
            if isEffectiveDisabled { return sliderToken.handleColorDisabled }
            if isDraggingOut { return token.colorDanger }
            if isActive || isThisHandleHovered { return sliderToken.handleActiveColor }
            return sliderToken.handleColor
        }()

        let showOutline = (isThisHandleHovered || isActive) && !isEffectiveDisabled

        Circle()
            .fill(Color.white)
            .overlay(Circle().stroke(borderColor, lineWidth: lineWidth))
            .overlay(
                Circle().stroke(
                    isDraggingOut ? token.colorDanger.opacity(0.2) : sliderToken.handleActiveOutlineColor,
                    lineWidth: showOutline ? 6 : 0
                )
            )
            .frame(width: handleSize, height: handleSize)
            .scaleEffect(isDraggingOut ? 0.8 : 1.0)
            .opacity(isDraggingOut ? 0.6 : 1.0)
            .offset(
                x: vertical ? 0 : position - handleSize / 2,
                y: vertical ? -(position - handleSize / 2) : 0
            )
            .allowsHitTesting(false)
    }

    @ViewBuilder
    private func dotView(for markValue: Double, in trackLength: CGFloat) -> some View {
        let normalizedVal = (markValue - min) / (max - min)
        let position = trackLength * (reverse ? 1 - normalizedVal : normalizedVal)
        let sorted = displaySorted
        let isActive = included && sorted.count >= 2 && markValue >= sorted.first! && markValue <= sorted.last!

        Circle()
            .fill(Color.white)
            .overlay(
                Circle().stroke(
                    isActive ? sliderToken.dotActiveBorderColor : sliderToken.dotBorderColor,
                    lineWidth: sliderToken.handleLineWidth
                )
            )
            .frame(width: sliderToken.dotSize, height: sliderToken.dotSize)
            .offset(
                x: vertical ? 0 : position - sliderToken.dotSize / 2,
                y: vertical ? -(position - sliderToken.dotSize / 2) : 0
            )
    }

    @ViewBuilder
    private func marksView(trackLength: CGFloat) -> some View {
        ZStack(alignment: .topLeading) {
            ForEach(markKeys) { markKey in
                let normalizedVal = (markKey.id - min) / (max - min)
                let position = trackLength * (reverse ? 1 - normalizedVal : normalizedVal)
                let sorted = displaySorted
                let isActive = included && sorted.count >= 2 && markKey.id >= sorted.first! && markKey.id <= sorted.last!

                markKey.mark.label
                    .font(.system(size: token.fontSize))
                    .foregroundStyle(
                        markKey.mark.style?.color ?? (isActive ? token.colorText : token.colorTextSecondary)
                    )
                    .fontWeight(markKey.mark.style?.fontWeight)
                    .offset(
                        x: vertical ? sliderToken.controlSize * 3 + 8 : position,
                        y: vertical ? trackLength - position : sliderToken.controlSize * 3 + 4
                    )
                    .fixedSize()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }

    private func snap(_ val: Double) -> Double {
        var result = val
        var snapPoints: Set<Double> = []

        // step 点
        if let step = step, step > 0 {
            var v = min
            while v <= max {
                snapPoints.insert(v)
                v += step
            }
        }

        // marks 只在有 step 时也加入吸附点（step + marks 组合）
        if step != nil, let marks = marks {
            for markValue in marks.keys {
                snapPoints.insert(markValue)
            }
        }

        // 吸附到 step 点或 step+marks 点
        if !snapPoints.isEmpty,
           let closest = snapPoints.min(by: { abs($0 - result) < abs($1 - result) }) {
            result = closest
        }

        // dots=true 时，只能停在 marks 位置
        if dots, let marks = marks {
            let markValues = Array(marks.keys)
            if let closest = markValues.min(by: { abs($0 - result) < abs($1 - result) }) {
                result = closest
            }
        }

        return result
    }

    private func dragGesture(in trackLength: CGFloat, geoSize: CGSize) -> some Gesture {
        DragGesture(minimumDistance: 0)
            .onChanged { gesture in
                guard !isEffectiveDisabled else { return }

                let location = vertical ? gesture.location.y : gesture.location.x
                var normalizedPos = vertical ? 1 - (location / trackLength) : location / trackLength
                if reverse { normalizedPos = 1 - normalizedPos }

                var newValue = min + normalizedPos * (max - min)
                newValue = Swift.max(min, Swift.min(max, newValue))

                // 确定拖拽模式（handle 还是 track）
                if draggingIndex == nil && trackDragStart == nil {
                    let pos = vertical ? (trackLength - gesture.startLocation.y) : gesture.startLocation.x
                    if let index = findNearestHandleIndex(at: pos, trackLength: trackLength) {
                        draggingIndex = index
                        draggingValue = value[index]
                    } else if draggableTrack && value.count >= 2 {
                        // 检查是否点击在轨道范围内
                        let sorted = sortedValue
                        var startNormalizedPos = vertical ? 1 - (gesture.startLocation.y / trackLength) : gesture.startLocation.x / trackLength
                        if reverse { startNormalizedPos = 1 - startNormalizedPos }
                        let startVal = min + startNormalizedPos * (max - min)
                        if startVal > sorted.first! && startVal < sorted.last! {
                            trackDragStart = value
                            trackDragAnchor = startVal
                            trackDragDelta = 0
                        }
                    }
                }

                // 处理轨道拖拽 - 只更新 delta，不修改 value
                if trackDragStart != nil {
                    trackDragDelta = newValue - trackDragAnchor
                    onChange?(displayValues)
                    return
                }

                // 处理 handle 拖拽 - 只更新 draggingValue，不修改 value
                guard let index = draggingIndex, index < value.count else { return }

                draggingValue = snap(newValue)

                // editable 时检测是否拖出边界（垂直于轨道方向拖出）
                if editable {
                    let crossAxis = vertical ? gesture.location.x : gesture.location.y
                    let crossSize = vertical ? geoSize.width : geoSize.height
                    let outOfBounds = crossAxis < -20 || crossAxis > crossSize + 20
                    isDraggingOut = outOfBounds && value.count > minCount
                }

                onChange?(displayValues)
            }
            .onEnded { gesture in
                let dist = hypot(gesture.translation.width, gesture.translation.height)

                // 没有拖拽任何 handle 或 track，且移动距离极小，视为点击添加节点
                if draggingIndex == nil && trackDragStart == nil && dist < 3 {
                    if editable && !isEffectiveDisabled && value.count < maxCount {
                        let location = vertical ? gesture.location.y : gesture.location.x
                        var normalizedPos = vertical ? 1 - (location / trackLength) : location / trackLength
                        if reverse { normalizedPos = 1 - normalizedPos }
                        var newVal = min + normalizedPos * (max - min)
                        newVal = snap(newVal)
                        var newArray = value
                        newArray.append(newVal)
                        value = newArray.sorted()
                        onChange?(value)
                    }
                    return
                }

                // editable 时，拖出删除节点
                if editable && isDraggingOut, let index = draggingIndex, value.count > minCount {
                    var newArray = value
                    newArray.remove(at: index)
                    value = newArray
                } else {
                    // 将 displayValues 写回 value
                    value = displayValues
                }

                draggingIndex = nil
                trackDragStart = nil
                trackDragDelta = 0
                isDraggingOut = false
                onChangeComplete?(value)
            }
    }
}

// MARK: - Factory

public struct _MoinSliderFactory {
    public init() {}

    /// 单值滑块
    public func callAsFunction(
        value: Binding<Double>,
        min: Double = 0,
        max: Double = 100,
        step: Double? = 1,
        disabled: Bool = false,
        vertical: Bool = false,
        reverse: Bool = false,
        marks: [Double: String]? = nil,
        dots: Bool = false,
        included: Bool = true,
        onChange: ((Double) -> Void)? = nil,
        onChangeComplete: ((Double) -> Void)? = nil
    ) -> _Slider {
        let convertedMarks: [Double: _SliderMark<AnyView>]? = marks?.mapValues { text in
            _SliderMark(label: { AnyView(Text(text)) })
        }

        return _Slider(
            value: value,
            min: min,
            max: max,
            step: step,
            disabled: disabled,
            vertical: vertical,
            reverse: reverse,
            marks: convertedMarks,
            dots: dots,
            included: included,
            onChange: onChange,
            onChangeComplete: onChangeComplete
        )
    }

    /// 单值滑块 (自定义 marks)
    public func callAsFunction<Label: View>(
        value: Binding<Double>,
        min: Double = 0,
        max: Double = 100,
        step: Double? = 1,
        disabled: Bool = false,
        vertical: Bool = false,
        reverse: Bool = false,
        marks: [Double: _SliderMark<Label>],
        dots: Bool = false,
        included: Bool = true,
        onChange: ((Double) -> Void)? = nil,
        onChangeComplete: ((Double) -> Void)? = nil
    ) -> _Slider {
        let convertedMarks: [Double: _SliderMark<AnyView>] = marks.mapValues { mark in
            _SliderMark(label: { AnyView(mark.label) }, style: mark.style)
        }

        return _Slider(
            value: value,
            min: min,
            max: max,
            step: step,
            disabled: disabled,
            vertical: vertical,
            reverse: reverse,
            marks: convertedMarks,
            dots: dots,
            included: included,
            onChange: onChange,
            onChangeComplete: onChangeComplete
        )
    }

    /// 范围滑块
    public func callAsFunction(
        value: Binding<ClosedRange<Double>>,
        min: Double = 0,
        max: Double = 100,
        step: Double? = 1,
        disabled: Bool = false,
        vertical: Bool = false,
        reverse: Bool = false,
        marks: [Double: String]? = nil,
        dots: Bool = false,
        included: Bool = true,
        draggableTrack: Bool = false,
        onChange: ((ClosedRange<Double>) -> Void)? = nil,
        onChangeComplete: ((ClosedRange<Double>) -> Void)? = nil
    ) -> _RangeSlider {
        let convertedMarks: [Double: _SliderMark<AnyView>]? = marks?.mapValues { text in
            _SliderMark(label: { AnyView(Text(text)) })
        }

        return _RangeSlider(
            value: value,
            min: min,
            max: max,
            step: step,
            disabled: disabled,
            vertical: vertical,
            reverse: reverse,
            marks: convertedMarks,
            dots: dots,
            included: included,
            draggableTrack: draggableTrack,
            onChange: onChange,
            onChangeComplete: onChangeComplete
        )
    }

    /// 范围滑块 (自定义 marks)
    public func callAsFunction<Label: View>(
        value: Binding<ClosedRange<Double>>,
        min: Double = 0,
        max: Double = 100,
        step: Double? = 1,
        disabled: Bool = false,
        vertical: Bool = false,
        reverse: Bool = false,
        marks: [Double: _SliderMark<Label>],
        dots: Bool = false,
        included: Bool = true,
        draggableTrack: Bool = false,
        onChange: ((ClosedRange<Double>) -> Void)? = nil,
        onChangeComplete: ((ClosedRange<Double>) -> Void)? = nil
    ) -> _RangeSlider {
        let convertedMarks: [Double: _SliderMark<AnyView>] = marks.mapValues { mark in
            _SliderMark(label: { AnyView(mark.label) }, style: mark.style)
        }

        return _RangeSlider(
            value: value,
            min: min,
            max: max,
            step: step,
            disabled: disabled,
            vertical: vertical,
            reverse: reverse,
            marks: convertedMarks,
            dots: dots,
            included: included,
            draggableTrack: draggableTrack,
            onChange: onChange,
            onChangeComplete: onChangeComplete
        )
    }

    /// 多节点可编辑滑块
    public func callAsFunction(
        value: Binding<[Double]>,
        min: Double = 0,
        max: Double = 100,
        step: Double? = 1,
        disabled: Bool = false,
        vertical: Bool = false,
        reverse: Bool = false,
        marks: [Double: String]? = nil,
        dots: Bool = false,
        included: Bool = true,
        editable: Bool = true,
        minCount: Int = 1,
        maxCount: Int = 5,
        onChange: (([Double]) -> Void)? = nil,
        onChangeComplete: (([Double]) -> Void)? = nil
    ) -> _MultiSlider {
        let convertedMarks: [Double: _SliderMark<AnyView>]? = marks?.mapValues { text in
            _SliderMark(label: { AnyView(Text(text)) })
        }

        return _MultiSlider(
            value: value,
            min: min,
            max: max,
            step: step,
            disabled: disabled,
            vertical: vertical,
            reverse: reverse,
            marks: convertedMarks,
            dots: dots,
            included: included,
            editable: editable,
            draggableTrack: false,
            minCount: minCount,
            maxCount: maxCount,
            onChange: onChange,
            onChangeComplete: onChangeComplete
        )
    }
}

// MARK: - Environment Key

private struct MoinSliderTokenKey: EnvironmentKey {
    static let defaultValue = Moin.SliderToken.default
}

public extension EnvironmentValues {
    var moinSliderToken: Moin.SliderToken {
        get { self[MoinSliderTokenKey.self] }
        set { self[MoinSliderTokenKey.self] = newValue }
    }
}
