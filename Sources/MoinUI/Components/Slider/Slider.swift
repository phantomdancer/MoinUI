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

    @Environment(\.moinSliderToken) private var sliderToken
    @Environment(\.moinToken) private var token
    @Environment(\.isEnabled) private var isEnabled

    @State private var isHovering = false
    @State private var isDragging = false

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

    private var isEffectiveDisabled: Bool {
        !isEnabled || disabled
    }

    private var normalizedValue: Double {
        (value - min) / (max - min)
    }

    private var effectiveValue: Double {
        reverse ? 1 - normalizedValue : normalizedValue
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
                // Rail (背景轨道)
                Capsule()
                    .fill(isHovering && !isEffectiveDisabled ? sliderToken.railHoverBg : sliderToken.railBg)
                    .frame(
                        width: vertical ? sliderToken.railSize : nil,
                        height: vertical ? nil : sliderToken.railSize
                    )

                // Track (已选轨道)
                if included {
                    Capsule()
                        .fill(trackColor)
                        .frame(
                            width: vertical ? sliderToken.railSize : trackLength * effectiveValue,
                            height: vertical ? trackLength * effectiveValue : sliderToken.railSize
                        )
                }

                // Dots (刻度点)
                ForEach(markKeys) { markKey in
                    dotView(for: markKey.id, in: trackLength)
                }

                // Handle (滑块)
                handleView(in: trackLength)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .contentShape(Rectangle())
            .onContinuousHover { phase in
                switch phase {
                case .active:
                    if isEffectiveDisabled {
                        NSCursor.operationNotAllowed.set()
                    } else {
                        if !isHovering {
                            isHovering = true
                        }
                        NSCursor.pointingHand.set()
                    }
                case .ended:
                    if isHovering {
                        isHovering = false
                    }
                    NSCursor.arrow.set()
                }
            }
            .gesture(dragGesture(in: trackLength))
            .overlay(alignment: vertical ? .leading : .bottom) {
                marksView(trackLength: trackLength)
            }
        }
        .frame(
            width: vertical ? sliderToken.controlSize * 3 : nil,
            height: vertical ? nil : sliderToken.controlSize * 3
        )
        .animation(.easeInOut(duration: token.motionDurationMid), value: value)
        .animation(.easeInOut(duration: token.motionDurationFast), value: isHovering)
    }

    private var trackColor: Color {
        if isEffectiveDisabled {
            return sliderToken.trackBgDisabled
        }
        return isHovering ? sliderToken.trackHoverBg : sliderToken.trackBg
    }

    @ViewBuilder
    private func handleView(in trackLength: CGFloat) -> some View {
        let handleSize = (isHovering || isDragging) && !isEffectiveDisabled
            ? sliderToken.handleSizeHover
            : sliderToken.handleSize
        let lineWidth = (isHovering || isDragging) && !isEffectiveDisabled
            ? sliderToken.handleLineWidthHover
            : sliderToken.handleLineWidth
        let position = trackLength * effectiveValue

        Circle()
            .fill(Color.white)
            .overlay(
                Circle()
                    .stroke(handleBorderColor, lineWidth: lineWidth)
            )
            .overlay(
                Circle()
                    .stroke(sliderToken.handleActiveOutlineColor, lineWidth: (isHovering || isDragging) && !isEffectiveDisabled ? 6 : 0)
            )
            .frame(width: handleSize, height: handleSize)
            .offset(
                x: vertical ? 0 : position - handleSize / 2,
                y: vertical ? -(position - handleSize / 2) : 0
            )
            .allowsHitTesting(false)
    }

    private var handleBorderColor: Color {
        if isEffectiveDisabled {
            return sliderToken.handleColorDisabled
        }
        // 拖动时使用 active 颜色
        if isDragging {
            return sliderToken.handleActiveColor
        }
        // hover 时使用 hover 颜色
        if isHovering {
            return sliderToken.handleHoverColor
        }
        return sliderToken.handleColor
    }

    @ViewBuilder
    private func dotView(for markValue: Double, in trackLength: CGFloat) -> some View {
        let normalized = (markValue - min) / (max - min)
        let position = trackLength * (reverse ? 1 - normalized : normalized)
        let isActive = included && (reverse ? markValue >= value : markValue <= value)

        Circle()
            .fill(Color.white)
            .overlay(
                Circle()
                    .stroke(
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
                let normalized = (markKey.id - min) / (max - min)
                let position = trackLength * (reverse ? 1 - normalized : normalized)
                let isActive = included && (reverse ? markKey.id >= value : markKey.id <= value)

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

    private func dragGesture(in trackLength: CGFloat) -> some Gesture {
        DragGesture(minimumDistance: 0)
            .onChanged { gesture in
                guard !isEffectiveDisabled else { return }
                isDragging = true

                let location = vertical ? gesture.location.y : gesture.location.x
                var normalized = vertical
                    ? 1 - (location / trackLength)
                    : location / trackLength

                if reverse {
                    normalized = 1 - normalized
                }

                var newValue = min + normalized * (max - min)
                newValue = Swift.max(min, Swift.min(max, newValue))

                // 构建所有可吸附点：step 点 + marks 位置
                var snapPoints: Set<Double> = []
                
                // 添加 step 点
                if let step = step, step > 0 {
                    var v = min
                    while v <= max {
                        snapPoints.insert(v)
                        v += step
                    }
                }
                
                // 添加 marks 位置
                if let marks = marks {
                    for markValue in marks.keys {
                        snapPoints.insert(markValue)
                    }
                }
                
                // 找最近的吸附点
                if !snapPoints.isEmpty {
                    if let closest = snapPoints.min(by: { abs($0 - newValue) < abs($1 - newValue) }) {
                        newValue = closest
                    }
                }
                
                // dots 模式：只能停在 marks 位置
                if dots, let marks = marks {
                    let markValues = Array(marks.keys)
                    if let closest = markValues.min(by: { abs($0 - newValue) < abs($1 - newValue) }) {
                        newValue = closest
                    }
                }

                if newValue != value {
                    value = newValue
                    onChange?(newValue)
                }
            }
            .onEnded { _ in
                isDragging = false
                onChangeComplete?(value)
            }
    }
}

// MARK: - Range Slider

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
    var onChange: ((ClosedRange<Double>) -> Void)?
    var onChangeComplete: ((ClosedRange<Double>) -> Void)?

    @Environment(\.moinSliderToken) private var sliderToken
    @Environment(\.moinToken) private var token
    @Environment(\.isEnabled) private var isEnabled

    @State private var isHovering = false
    @State private var draggingHandle: DraggingHandle?
    @State private var hoveringHandle: DraggingHandle?
    @State private var anchorValue: Double = 0    // 拖拽时固定的 handle 位置
    @State private var draggingValue: Double = 0  // 拖拽时移动的 handle 位置

    private enum DraggingHandle {
        case lower, upper
    }

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
        self.onChange = onChange
        self.onChangeComplete = onChangeComplete
    }

    private var isEffectiveDisabled: Bool {
        !isEnabled || disabled
    }

    // 归一化辅助
    private func normalized(_ val: Double) -> Double {
        let n = (val - min) / (max - min)
        return reverse ? 1 - n : n
    }

    // handle 位置：拖拽时用 draggingValue/anchorValue，否则用 value
    private var lowerHandlePosition: Double {
        normalized(draggingHandle == .lower ? draggingValue : (draggingHandle != nil ? anchorValue : value.lowerBound))
    }

    private var upperHandlePosition: Double {
        normalized(draggingHandle == .upper ? draggingValue : (draggingHandle != nil ? anchorValue : value.upperBound))
    }

    // track 范围（总是较小到较大）
    private var effectiveLower: Double { Swift.min(lowerHandlePosition, upperHandlePosition) }
    private var effectiveUpper: Double { Swift.max(lowerHandlePosition, upperHandlePosition) }

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

                // Track
                if included {
                    trackView(trackLength: trackLength)
                }

                // Dots
                ForEach(markKeys) { markKey in
                    dotView(for: markKey.id, in: trackLength)
                }

                // Handles - 用独立位置渲染，拖拽时不交换
                handleView(position: trackLength * lowerHandlePosition, handleType: .lower, isActive: draggingHandle == .lower)
                handleView(position: trackLength * upperHandlePosition, handleType: .upper, isActive: draggingHandle == .upper)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .contentShape(Rectangle())
            .onContinuousHover { phase in
                switch phase {
                case .active(let location):
                    if isEffectiveDisabled {
                        NSCursor.operationNotAllowed.set()
                    } else {
                        if !isHovering {
                            isHovering = true
                        }
                        NSCursor.pointingHand.set()
                        
                        // 拖拽中不更新 hover 状态，避免非拖拽 handle 被高亮
                        if draggingHandle == nil {
                            let pos = vertical ? (trackLength - location.y) : location.x
                            let lowerPos = trackLength * effectiveLower
                            let upperPos = trackLength * effectiveUpper
                            let handleRadius = sliderToken.handleSizeHover / 2

                            if abs(pos - lowerPos) <= handleRadius {
                                hoveringHandle = .lower
                            } else if abs(pos - upperPos) <= handleRadius {
                                hoveringHandle = .upper
                            } else {
                                hoveringHandle = nil
                            }
                        }
                    }
                case .ended:
                    if isHovering {
                        isHovering = false
                    }
                    hoveringHandle = nil
                    NSCursor.arrow.set()
                }
            }
            .gesture(dragGesture(in: trackLength))
            .overlay(alignment: vertical ? .leading : .bottom) {
                marksView(trackLength: trackLength)
            }
        }
        .frame(
            width: vertical ? sliderToken.controlSize * 3 : nil,
            height: vertical ? nil : sliderToken.controlSize * 3
        )
        .animation(.easeInOut(duration: token.motionDurationMid), value: value)
        .animation(.easeInOut(duration: token.motionDurationFast), value: isHovering)
    }

    @ViewBuilder
    private func trackView(trackLength: CGFloat) -> some View {
        let startPos = trackLength * effectiveLower
        let endPos = trackLength * effectiveUpper
        let trackWidth = endPos - startPos

        Capsule()
            .fill(trackColor)
            .frame(
                width: vertical ? sliderToken.railSize : trackWidth,
                height: vertical ? trackWidth : sliderToken.railSize
            )
            .offset(
                x: vertical ? 0 : startPos,
                y: vertical ? -startPos : 0
            )
    }

    private var trackColor: Color {
        if isEffectiveDisabled {
            return sliderToken.trackBgDisabled
        }
        return isHovering ? sliderToken.trackHoverBg : sliderToken.trackBg
    }

    @ViewBuilder
    private func handleView(position: CGFloat, handleType: DraggingHandle, isActive: Bool) -> some View {
        // isActive = 当前滑块正在被拖动
        // isThisHandleHovered = 当前滑块被 hover
        let isThisHandleHovered = hoveringHandle == handleType
        let shouldEnlarge = (isHovering || isActive) && !isEffectiveDisabled
        let handleSize = shouldEnlarge ? sliderToken.handleSizeHover : sliderToken.handleSize
        let lineWidth = shouldEnlarge ? sliderToken.handleLineWidthHover : sliderToken.handleLineWidth
        
        // 禁用时使用禁用颜色
        // 拖动或被 hover 的滑块使用 active 颜色（最深）
        // 未被直接 hover 的滑块保持原色（与轨道形成对比）
        let borderColor: Color = {
            if isEffectiveDisabled {
                return sliderToken.handleColorDisabled
            }
            if isActive || isThisHandleHovered {
                return sliderToken.handleActiveColor
            }
            return sliderToken.handleColor
        }()
        
        // 只有被 hover 或拖动的滑块显示光晕
        let showOutline = (isThisHandleHovered || isActive) && !isEffectiveDisabled

        Circle()
            .fill(Color.white)
            .overlay(
                Circle()
                    .stroke(borderColor, lineWidth: lineWidth)
            )
            .overlay(
                Circle()
                    .stroke(sliderToken.handleActiveOutlineColor, lineWidth: showOutline ? 6 : 0)
            )
            .frame(width: handleSize, height: handleSize)
            .offset(
                x: vertical ? 0 : position - handleSize / 2,
                y: vertical ? -(position - handleSize / 2) : 0
            )
            .allowsHitTesting(false)
    }

    @ViewBuilder
    private func dotView(for markValue: Double, in trackLength: CGFloat) -> some View {
        let normalized = (markValue - min) / (max - min)
        let position = trackLength * (reverse ? 1 - normalized : normalized)
        let isActive = included && markValue >= value.lowerBound && markValue <= value.upperBound

        Circle()
            .fill(Color.white)
            .overlay(
                Circle()
                    .stroke(
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
                let normalized = (markKey.id - min) / (max - min)
                let position = trackLength * (reverse ? 1 - normalized : normalized)
                let isActive = included && markKey.id >= value.lowerBound && markKey.id <= value.upperBound

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

    private func dragGesture(in trackLength: CGFloat) -> some Gesture {
        DragGesture(minimumDistance: 0)
            .onChanged { gesture in
                guard !isEffectiveDisabled else { return }

                let location = vertical ? gesture.location.y : gesture.location.x
                var normalized = vertical
                    ? 1 - (location / trackLength)
                    : location / trackLength

                if reverse {
                    normalized = 1 - normalized
                }

                var newValue = min + normalized * (max - min)
                newValue = Swift.max(min, Swift.min(max, newValue))

                // 构建所有可吸附点：step 点 + marks 位置
                var snapPoints: Set<Double> = []
                
                // 添加 step 点
                if let step = step, step > 0 {
                    var v = min
                    while v <= max {
                        snapPoints.insert(v)
                        v += step
                    }
                }
                
                // 添加 marks 位置
                if let marks = marks {
                    for markValue in marks.keys {
                        snapPoints.insert(markValue)
                    }
                }
                
                // 找最近的吸附点
                if !snapPoints.isEmpty {
                    if let closest = snapPoints.min(by: { abs($0 - newValue) < abs($1 - newValue) }) {
                        newValue = closest
                    }
                }
                
                // dots 模式：只能停在 marks 位置
                if dots, let marks = marks {
                    let markValues = Array(marks.keys)
                    if let closest = markValues.min(by: { abs($0 - newValue) < abs($1 - newValue) }) {
                        newValue = closest
                    }
                }

                // Determine which handle to move
                if draggingHandle == nil {
                    let distToLower = abs(newValue - value.lowerBound)
                    let distToUpper = abs(newValue - value.upperBound)
                    if distToLower < distToUpper {
                        draggingHandle = .lower
                        anchorValue = value.upperBound
                        draggingValue = value.lowerBound
                    } else {
                        draggingHandle = .upper
                        anchorValue = value.lowerBound
                        draggingValue = value.upperBound
                    }
                }

                // 更新被拖拽 handle 的位置
                draggingValue = newValue

                // 用 anchorValue 和 draggingValue 构建范围
                let finalLower = Swift.min(draggingValue, anchorValue)
                let finalUpper = Swift.max(draggingValue, anchorValue)
                let newRange = finalLower...finalUpper
                if newRange != value {
                    value = newRange
                    onChange?(newRange)
                }
            }
            .onEnded { _ in
                draggingHandle = nil
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
