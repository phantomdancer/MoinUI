import SwiftUI

// MARK: - Component Factories
// 支持 Moin.Component("title") 语法调用

// MARK: - Tag Factory

public struct _MoinTagFactory {

    /// Moin.Tag.Checkable("text", isChecked: $checked)
    public let Checkable = _MoinCheckableTagFactory()

    public init() {}

    public func callAsFunction(
        _ text: String,
        color: _TagColor = .default,
        variant: _TagVariant = .filled,
        size: _TagSize = .medium,
        round: Bool = false,
        icon: String? = nil,
        closable: Bool = false,
        onClose: (() -> Void)? = nil
    ) -> _Tag {
        _Tag(text, color: color, variant: variant, size: size, round: round, icon: icon, closable: closable, onClose: onClose)
    }
}

/// Moin.Tag.Checkable Factory
public struct _MoinCheckableTagFactory {
    public init() {}

    public func callAsFunction(
        _ text: String,
        checked: Binding<Bool>,
        onChange: ((Bool) -> Void)? = nil
    ) -> _CheckableTag {
        _CheckableTag(text, checked: checked, onChange: onChange)
    }
}

// MARK: - Badge Factory

public struct _MoinBadgeFactory {

    /// Moin.Badge.Ribbon(text: "New", content: { ... })
    public let Ribbon = _MoinBadgeRibbonFactory()

    public init() {}

    /// 独立徽标（无子内容）
    public func callAsFunction(
        count: Int? = nil,
        dot: Bool = false,
        showZero: Bool = false,
        overflowCount: Int = 99,
        size: _BadgeSize = .default,
        color: _BadgeColor = .default
    ) -> _Badge<EmptyView, EmptyView> {
        _Badge(count: count, dot: dot, showZero: showZero, overflowCount: overflowCount, size: size, color: color)
    }

    /// 带数字的徽标
    public func callAsFunction<Content: View>(
        count: Int? = nil,
        dot: Bool = false,
        showZero: Bool = false,
        overflowCount: Int = 99,
        size: _BadgeSize = .default,
        color: _BadgeColor = .default,
        offset: (x: CGFloat, y: CGFloat)? = nil,
        @ViewBuilder content: () -> Content
    ) -> _Badge<Content, EmptyView> {
        _Badge(count: count, dot: dot, showZero: showZero, overflowCount: overflowCount, size: size, color: color, offset: offset, content: content)
    }

    /// 带自定义指示器的徽标
    public func callAsFunction<Content: View, CountView: View>(
        count: @escaping () -> CountView,
        size: _BadgeSize = .default,
        offset: (x: CGFloat, y: CGFloat)? = nil,
        @ViewBuilder content: () -> Content
    ) -> _Badge<Content, CountView> {
        _Badge(count: count, size: size, offset: offset, content: content)
    }

    /// 状态徽标
    public func callAsFunction(
        status: _BadgeStatus,
        text: String? = nil
    ) -> _Badge<EmptyView, EmptyView> {
        _Badge(status: status, text: text)
    }
}

/// Moin.Badge.Ribbon Factory
public struct _MoinBadgeRibbonFactory {

    public init() {}

    public func callAsFunction<Content: View>(
        text: String? = nil,
        color: _BadgeColor = .processing,
        placement: _RibbonPlacement = .end,
        @ViewBuilder content: () -> Content
    ) -> _BadgeRibbon<Content> {
        _BadgeRibbon(text: text, color: color, placement: placement, content: content)
    }
}

// MARK: - Avatar Factory

public struct _MoinAvatarFactory {

    /// Moin.Avatar.Group(maxCount: 3) { ... }
    public let Group = _MoinAvatarGroupFactory()

    public init() {}

    public func callAsFunction(
        icon: String,
        size: _AvatarSize = .default,
        shape: _AvatarShape = .circle,
        backgroundColor: _AvatarColor? = nil,
        gap: CGFloat = 4
    ) -> _Avatar {
        _Avatar(icon: icon, size: size, shape: shape, backgroundColor: backgroundColor, gap: gap)
    }

    public func callAsFunction(
        _ text: String,
        size: _AvatarSize = .default,
        shape: _AvatarShape = .circle,
        backgroundColor: _AvatarColor? = nil,
        gap: CGFloat = 4
    ) -> _Avatar {
        _Avatar(text, size: size, shape: shape, backgroundColor: backgroundColor, gap: gap)
    }

    public func callAsFunction(
        image: Image,
        size: _AvatarSize = .default,
        shape: _AvatarShape = .circle
    ) -> _Avatar {
        _Avatar(image: image, size: size, shape: shape)
    }

    public func callAsFunction(
        src: URL?,
        fallbackIcon: String = "person.fill",
        size: _AvatarSize = .default,
        shape: _AvatarShape = .circle
    ) -> _Avatar {
        _Avatar(src: src, fallbackIcon: fallbackIcon, size: size, shape: shape)
    }

    public func callAsFunction(
        src: String,
        fallbackIcon: String = "person.fill",
        size: _AvatarSize = .default,
        shape: _AvatarShape = .circle
    ) -> _Avatar {
        _Avatar(src: src, fallbackIcon: fallbackIcon, size: size, shape: shape)
    }

    public func callAsFunction<Content: View>(
        size: _AvatarSize = .default,
        shape: _AvatarShape = .circle,
        backgroundColor: _AvatarColor? = nil,
        gap: CGFloat = 4,
        @ViewBuilder content: () -> Content
    ) -> _Avatar {
        _Avatar(size: size, shape: shape, backgroundColor: backgroundColor, gap: gap, content: content)
    }
}

/// Moin.Avatar.Group Factory
public struct _MoinAvatarGroupFactory {
    public init() {}

    public func callAsFunction<Content: View>(
        maxCount: Int? = nil,
        size: _AvatarSize = .default,
        shape: _AvatarShape = .circle,
        gap: CGFloat = 4,
        @ViewBuilder content: () -> Content
    ) -> _AvatarGroup<Content> {
        _AvatarGroup(maxCount: maxCount, size: size, shape: shape, gap: gap, content: content)
    }
}

// MARK: - Divider Factory

public struct _MoinDividerFactory {

    // MARK: - Nested Types

    /// Moin.Divider.Orientation
    public typealias Orientation = _DividerOrientation
    /// Moin.Divider.Variant
    public typealias Variant = _DividerVariant
    /// Moin.Divider.TitlePlacement
    public typealias TitlePlacement = _DividerTitlePlacement

    public init() {}

    /// 无内容分割线
    public func callAsFunction(
        orientation: _DividerOrientation = .horizontal,
        variant: _DividerVariant = .solid
    ) -> _Divider<EmptyView> {
        _Divider(orientation: orientation, variant: variant)
    }

    /// 带文字分割线
    public func callAsFunction(
        _ title: String,
        orientation: _DividerOrientation = .horizontal,
        variant: _DividerVariant = .solid,
        titlePlacement: _DividerTitlePlacement = .center,
        plain: Bool = false
    ) -> _Divider<Text> {
        _Divider(title, orientation: orientation, variant: variant, titlePlacement: titlePlacement, plain: plain)
    }

    /// 自定义内容分割线
    public func callAsFunction<Content: View>(
        orientation: _DividerOrientation = .horizontal,
        variant: _DividerVariant = .solid,
        titlePlacement: _DividerTitlePlacement = .center,
        plain: Bool = false,
        @ViewBuilder content: () -> Content
    ) -> _Divider<Content> {
        _Divider(orientation: orientation, variant: variant, titlePlacement: titlePlacement, plain: plain, content: content)
    }
}

// MARK: - Space Factory

public struct _MoinSpaceFactory {

    // MARK: - Nested Types

    /// Moin.Space.Size
    public typealias Size = _SpaceSize
    /// Moin.Space.Direction
    public typealias Direction = _SpaceDirection
    /// Moin.Space.Alignment
    public typealias Alignment = _SpaceAlignment

    /// Moin.Space.Compact(direction: .horizontal) { ... }
    public let Compact = _MoinSpaceCompactFactory()

    public init() {}

    public func callAsFunction<Content: View>(
        size: _SpaceSize = .small,
        direction: _SpaceDirection = .horizontal,
        alignment: _SpaceAlignment = .center,
        wrap: Bool = false,
        @ViewBuilder content: () -> Content
    ) -> _Space<Content, EmptyView> {
        _Space(size: size, direction: direction, alignment: alignment, wrap: wrap, content: content)
    }

    public func callAsFunction<Content: View, Separator: View>(
        size: _SpaceSize = .small,
        direction: _SpaceDirection = .horizontal,
        alignment: _SpaceAlignment = .center,
        wrap: Bool = false,
        @ViewBuilder separator: () -> Separator,
        @ViewBuilder content: () -> Content
    ) -> _Space<Content, Separator> {
        _Space(size: size, direction: direction, alignment: alignment, wrap: wrap, separator: separator, content: content)
    }
}

/// Moin.Space.Compact Factory
public struct _MoinSpaceCompactFactory {
    public init() {}

    /// Two items
    public func callAsFunction<V0: View, V1: View>(
        direction: _SpaceDirection = .horizontal,
        @ViewBuilder content: () -> TupleView<(V0, V1)>
    ) -> _SpaceCompact {
        _SpaceCompact(direction: direction, content: content)
    }

    /// Three items
    public func callAsFunction<V0: View, V1: View, V2: View>(
        direction: _SpaceDirection = .horizontal,
        @ViewBuilder content: () -> TupleView<(V0, V1, V2)>
    ) -> _SpaceCompact {
        _SpaceCompact(direction: direction, content: content)
    }

    /// Four items
    public func callAsFunction<V0: View, V1: View, V2: View, V3: View>(
        direction: _SpaceDirection = .horizontal,
        @ViewBuilder content: () -> TupleView<(V0, V1, V2, V3)>
    ) -> _SpaceCompact {
        _SpaceCompact(direction: direction, content: content)
    }

    /// Five items
    public func callAsFunction<V0: View, V1: View, V2: View, V3: View, V4: View>(
        direction: _SpaceDirection = .horizontal,
        @ViewBuilder content: () -> TupleView<(V0, V1, V2, V3, V4)>
    ) -> _SpaceCompact {
        _SpaceCompact(direction: direction, content: content)
    }
}

// MARK: - Empty Factory

public struct _MoinEmptyFactory {

    public init() {}

    public func callAsFunction(
        image: _Empty<EmptyView>.ImageType = .default,
        description: String? = nil
    ) -> _Empty<EmptyView> {
        _Empty(image: image, description: description)
    }

    public func callAsFunction<Content: View>(
        image: _Empty<Content>.ImageType = .default,
        description: String? = nil,
        @ViewBuilder content: () -> Content
    ) -> _Empty<Content> {
        _Empty(image: image, description: description, content: content)
    }
}

// MARK: - Spin Factory

public struct _MoinSpinFactory {

    /// Moin.Spin.Indicator(size: 24, color: .blue)
    public let Indicator = _MoinSpinIndicatorFactory()

    public init() {}

    public func callAsFunction(
        spinning: Bool = true,
        size: _SpinSize = .default,
        tip: String? = nil,
        delay: Int? = nil,
        fullscreen: Bool = false
    ) -> _Spin<EmptyView> {
        _Spin(spinning: spinning, size: size, tip: tip, delay: delay, fullscreen: fullscreen)
    }

    public func callAsFunction<Content: View>(
        spinning: Bool = true,
        size: _SpinSize = .default,
        tip: String? = nil,
        delay: Int? = nil,
        @ViewBuilder content: () -> Content
    ) -> _Spin<Content> {
        _Spin(spinning: spinning, size: size, tip: tip, delay: delay, content: content)
    }

    public func callAsFunction<IndicatorView: View>(
        spinning: Bool = true,
        size: _SpinSize = .default,
        tip: String? = nil,
        delay: Int? = nil,
        fullscreen: Bool = false,
        @ViewBuilder indicator: () -> IndicatorView
    ) -> _Spin<EmptyView> {
        _Spin(spinning: spinning, size: size, tip: tip, delay: delay, fullscreen: fullscreen, indicator: indicator)
    }
}

/// Moin.Spin.Indicator Factory
public struct _MoinSpinIndicatorFactory {
    public init() {}

    public func callAsFunction(
        size: CGFloat,
        color: SwiftUI.Color,
        duration: Double = 1.2
    ) -> _SpinIndicator {
        _SpinIndicator(size: size, color: color, duration: duration)
    }
}

// MARK: - Statistic Factory

public struct _MoinStatisticFactory {
    public init() {}

    /// String 值统计
    public func callAsFunction(
        title: String? = nil,
        value: String,
        prefix: (any View)? = nil,
        suffix: (any View)? = nil,
        loading: Bool = false
    ) -> _Statistic {
        _Statistic(title: title, value: value, prefix: prefix, suffix: suffix, loading: loading)
    }

    /// View 类型 title + String 值
    public func callAsFunction<T: View>(
        title: T,
        value: String,
        prefix: (any View)? = nil,
        suffix: (any View)? = nil,
        loading: Bool = false
    ) -> _Statistic {
        _Statistic(title: title, value: value, prefix: prefix, suffix: suffix, loading: loading)
    }

    /// String title + View 值
    public func callAsFunction<V: View>(
        title: String? = nil,
        value: V,
        prefix: (any View)? = nil,
        suffix: (any View)? = nil,
        loading: Bool = false
    ) -> _Statistic {
        _Statistic(title: title, value: value, prefix: prefix, suffix: suffix, loading: loading)
    }

    /// 浮点数值统计
    public func callAsFunction<N: BinaryFloatingPoint>(
        title: String? = nil,
        value: N,
        precision: Int? = 0,
        prefix: (any View)? = nil,
        suffix: (any View)? = nil,
        loading: Bool = false
    ) -> _Statistic {
        _Statistic(title: title, value: value, precision: precision, prefix: prefix, suffix: suffix, loading: loading)
    }

    /// 整数值统计
    public func callAsFunction<N: BinaryInteger>(
        title: String? = nil,
        value: N,
        prefix: (any View)? = nil,
        suffix: (any View)? = nil,
        loading: Bool = false
    ) -> _Statistic {
        _Statistic(title: title, value: value, prefix: prefix, suffix: suffix, loading: loading)
    }
}

// MARK: - Alert Factory

public struct _MoinAlertFactory {

    public init() {}

    public func callAsFunction(
        type: _Alert<EmptyView>.AlertType = .info,
        title: String,
        description: String? = nil,
        showIcon: Bool = false,
        closable: Bool = false,
        banner: Bool = false,
        onClose: (() -> Void)? = nil
    ) -> _Alert<EmptyView> {
        _Alert(type: type, title: title, description: description, showIcon: showIcon, closable: closable, banner: banner, onClose: onClose)
    }

    public func callAsFunction<Action: View>(
        type: _Alert<Action>.AlertType = .info,
        title: String,
        description: String? = nil,
        showIcon: Bool = false,
        closable: Bool = false,
        banner: Bool = false,
        onClose: (() -> Void)? = nil,
        @ViewBuilder action: () -> Action
    ) -> _Alert<Action> {
        _Alert(type: type, title: title, description: description, showIcon: showIcon, closable: closable, banner: banner, onClose: onClose, action: action)
    }
}

// MARK: - Progress Factory

public struct _MoinProgressFactory {

    // MARK: - Nested Types (Moin.Progress.Status, etc.)

    /// Moin.Progress.Variant
    public typealias Variant = _Progress.Variant
    /// Moin.Progress.Status
    public typealias Status = _Progress.Status
    /// Moin.Progress.Size
    public typealias Size = _Progress.Size
    /// Moin.Progress.StrokeLinecap
    public typealias StrokeLinecap = _Progress.StrokeLinecap
    /// Moin.Progress.GapPosition
    public typealias GapPosition = _Progress.GapPosition
    /// Moin.Progress.GapPlacement
    public typealias GapPlacement = _Progress.GapPlacement
    /// Moin.Progress.SuccessProps
    public typealias SuccessProps = _Progress.SuccessProps
    /// Moin.Progress.GradientColor
    public typealias GradientColor = _Progress.GradientColor
    /// Moin.Progress.PercentPosition
    public typealias PercentPosition = _Progress.PercentPosition
    /// Moin.Progress.CircleStepsConfig
    public typealias CircleStepsConfig = _Progress.CircleStepsConfig

    public init() {}

    public func callAsFunction(
        percent: Double = 0,
        format: ((Double) -> AnyView)? = nil,
        status: _Progress.Status? = nil,
        showInfo: Bool = true,
        strokeWidth: CGFloat? = nil,
        strokeLinecap: _Progress.StrokeLinecap = .round,
        strokeColor: SwiftUI.Color? = nil,
        strokeColors: [SwiftUI.Color]? = nil,
        strokeGradient: _Progress.GradientColor? = nil,
        railColor: SwiftUI.Color? = nil,
        width: CGFloat? = nil,
        success: _Progress.SuccessProps? = nil,
        gapDegree: Double? = nil,
        gapPosition: _Progress.GapPosition = .bottom,
        gapPlacement: _Progress.GapPlacement? = nil,
        type: _Progress.Variant = .line,
        size: _Progress.Size = .default,
        steps: Int? = nil,
        circleSteps: _Progress.CircleStepsConfig? = nil,
        percentPosition: _Progress.PercentPosition = _Progress.PercentPosition()
    ) -> _Progress {
        _Progress(
            percent: percent,
            format: format,
            status: status,
            showInfo: showInfo,
            strokeWidth: strokeWidth,
            strokeLinecap: strokeLinecap,
            strokeColor: strokeColor,
            strokeColors: strokeColors,
            strokeGradient: strokeGradient,
            railColor: railColor,
            width: width,
            success: success,
            gapDegree: gapDegree,
            gapPosition: gapPosition,
            gapPlacement: gapPlacement,
            type: type,
            size: size,
            steps: steps,
            circleSteps: circleSteps,
            percentPosition: percentPosition
        )
    }
}

// MARK: - Switch Factory

public struct _MoinSwitchFactory {
    public init() {}

    public func callAsFunction(
        checked: Binding<Bool>,
        loading: Bool = false,
        disabled: Bool = false,
        size: ControlSize = .regular,
        onChange: ((Bool) -> Void)? = nil
    ) -> _Switch<EmptyView, EmptyView> {
        _Switch(checked: checked, loading: loading, disabled: disabled, size: size, onChange: onChange)
    }

    public func callAsFunction(
        checked: Binding<Bool>,
        loading: Bool = false,
        disabled: Bool = false,
        size: ControlSize = .regular,
        checkedText: String,
        uncheckedText: String,
        onChange: ((Bool) -> Void)? = nil
    ) -> _Switch<Text, Text> {
        _Switch(checked: checked, loading: loading, disabled: disabled, size: size, checkedText: checkedText, uncheckedText: uncheckedText, onChange: onChange)
    }

    public func callAsFunction<CheckedContent: View, UncheckedContent: View>(
        checked: Binding<Bool>,
        loading: Bool = false,
        disabled: Bool = false,
        size: ControlSize = .regular,
        @ViewBuilder checkedChildren: () -> CheckedContent,
        @ViewBuilder unCheckedChildren: () -> UncheckedContent,
        onChange: ((Bool) -> Void)? = nil
    ) -> _Switch<CheckedContent, UncheckedContent> {
        _Switch(checked: checked, loading: loading, disabled: disabled, size: size, checkedChildren: checkedChildren, unCheckedChildren: unCheckedChildren, onChange: onChange)
    }
}

// MARK: - Checkbox Factory

public struct _MoinCheckboxFactory {

    /// Moin.Checkbox.Option - 选项类型
    public typealias Option<T: Hashable> = _CheckboxOption<T>

    /// Moin.Checkbox.Group(selection: $selection, options: options)
    public let Group = _MoinCheckboxGroupFactory()

    public init() {}

    public func callAsFunction(
        _ label: String,
        checked: Binding<Bool>,
        indeterminate: Bool = false,
        disabled: Bool = false
    ) -> _Checkbox<Text> {
        _Checkbox(label, checked: checked, indeterminate: indeterminate, disabled: disabled)
    }

    public func callAsFunction<Label: View>(
        checked: Binding<Bool>,
        indeterminate: Bool = false,
        disabled: Bool = false,
        @ViewBuilder label: () -> Label
    ) -> _Checkbox<Label> {
        _Checkbox(checked: checked, indeterminate: indeterminate, disabled: disabled, label: label)
    }
}

/// Moin.Checkbox.Group Factory
public struct _MoinCheckboxGroupFactory {
    public init() {}

    public func callAsFunction<Value: Hashable>(
        selection: Binding<Set<Value>>,
        options: [_CheckboxOption<Value>],
        direction: Axis = .horizontal,
        disabled: Bool = false
    ) -> _CheckboxGroup<Value> {
        _CheckboxGroup(selection: selection, options: options, direction: direction, disabled: disabled)
    }

    public func callAsFunction<Value: Hashable>(
        selection: Binding<Set<Value>>,
        options: [Value],
        labelProvider: @escaping (Value) -> String = { "\($0)" },
        direction: Axis = .horizontal,
        disabled: Bool = false
    ) -> _CheckboxGroup<Value> {
        _CheckboxGroup(selection: selection, options: options, labelProvider: labelProvider, direction: direction, disabled: disabled)
    }
}

// MARK: - Radio Factory

public struct _MoinRadioFactory {

    /// Moin.Radio.Option - 选项类型
    public typealias Option<T: Hashable> = _RadioOption<T>

    /// Moin.Radio.Group(value: $value, options: options)
    public let Group = _MoinRadioGroupFactory()

    /// Moin.Radio.GroupView(value: $value, data: items) { item in ... }
    public let GroupView = _MoinRadioGroupViewFactory()

    public init() {}

    public func callAsFunction(
        _ label: String,
        checked: Binding<Bool>,
        disabled: Bool = false
    ) -> _Radio<Text> {
        _Radio(label, checked: checked, disabled: disabled)
    }

    public func callAsFunction<Label: View>(
        checked: Binding<Bool>,
        disabled: Bool = false,
        @ViewBuilder label: () -> Label
    ) -> _Radio<Label> {
        _Radio(checked: checked, disabled: disabled, label: label)
    }
}

/// Moin.Radio.Group Factory
public struct _MoinRadioGroupFactory {
    public init() {}

    public func callAsFunction<Value: Hashable>(
        value: Binding<Value>,
        options: [_RadioOption<Value>],
        orientation: Axis = .horizontal,
        disabled: Bool = false,
        optionType: _RadioOptionType = .default,
        buttonStyle: _RadioButtonStyle = .outline,
        block: Bool = false,
        size: _RadioSize = .middle
    ) -> _RadioGroup<Value> {
        _RadioGroup(value: value, options: options, orientation: orientation, disabled: disabled, optionType: optionType, buttonStyle: buttonStyle, block: block, size: size)
    }

    public func callAsFunction<Value: Hashable>(
        value: Binding<Value>,
        options: [Value],
        labelProvider: @escaping (Value) -> String = { "\($0)" },
        orientation: Axis = .horizontal,
        disabled: Bool = false,
        optionType: _RadioOptionType = .default,
        buttonStyle: _RadioButtonStyle = .outline,
        block: Bool = false,
        size: _RadioSize = .middle
    ) -> _RadioGroup<Value> {
        _RadioGroup(value: value, options: options, labelProvider: labelProvider, orientation: orientation, disabled: disabled, optionType: optionType, buttonStyle: buttonStyle, block: block, size: size)
    }
}

/// Moin.Radio.GroupView Factory
public struct _MoinRadioGroupViewFactory {
    public init() {}

    public func callAsFunction<Item: Identifiable, SelectionValue: Hashable, Content: View>(
        value: Binding<SelectionValue>,
        data: [Item],
        valuePath: KeyPath<Item, SelectionValue>,
        orientation: Axis = .horizontal,
        disabled: Bool = false,
        @ViewBuilder content: @escaping (Item) -> Content
    ) -> _RadioGroupView<Item, SelectionValue, Content> {
        _RadioGroupView(value: value, data: data, valuePath: valuePath, orientation: orientation, disabled: disabled, content: content)
    }
}

// MARK: - Skeleton Factory

public struct _MoinSkeletonFactory {

    // MARK: - Nested Types (Moin.Skeleton.Avatar, etc.)

    /// Moin.Skeleton.Avatar
    public typealias Avatar = _Skeleton.Avatar
    /// Moin.Skeleton.Button
    public typealias Button = _Skeleton.Button
    /// Moin.Skeleton.Input
    public typealias Input = _Skeleton.Input
    /// Moin.Skeleton.Image
    public typealias Image = _Skeleton.SkeletonImage
    /// Moin.Skeleton.Block
    public typealias Block = _Skeleton.Block
    /// Moin.Skeleton.Node
    public typealias Node = _Skeleton.Node
    /// Moin.Skeleton.AvatarConfig
    public typealias AvatarConfig = _Skeleton.AvatarConfig
    /// Moin.Skeleton.TitleConfig
    public typealias TitleConfig = _Skeleton.TitleProps
    /// Moin.Skeleton.ParagraphConfig
    public typealias ParagraphConfig = _Skeleton.ParagraphProps
    /// Moin.Skeleton.Size
    public typealias Size = _Skeleton.Size
    /// Moin.Skeleton.AvatarShape
    public typealias AvatarShape = _Skeleton.AvatarShape
    /// Moin.Skeleton.ButtonShape
    public typealias ButtonShape = _Skeleton.ButtonShape

    public init() {}

    /// 基础骨架屏（Bool 参数）
    public func callAsFunction(
        active: Bool = false,
        avatar: Bool = false,
        title: Bool = true,
        paragraph: Bool = true,
        round: Bool = false
    ) -> _Skeleton {
        _Skeleton(active: active, avatar: avatar, title: title, paragraph: paragraph, round: round)
    }

    /// 详细配置骨架屏
    public func callAsFunction(
        active: Bool = false,
        avatar: _Skeleton.AvatarConfig?,
        title: _Skeleton.TitleProps?,
        paragraph: _Skeleton.ParagraphProps?,
        round: Bool = false
    ) -> _Skeleton {
        _Skeleton(active: active, avatar: avatar, title: title, paragraph: paragraph, round: round)
    }

    /// 条件渲染骨架屏
    public func callAsFunction<Content: View>(
        loading: Bool,
        active: Bool = false,
        avatar: Bool = false,
        title: Bool = true,
        paragraph: Bool = true,
        round: Bool = false,
        @ViewBuilder content: () -> Content
    ) -> _Skeleton {
        _Skeleton(loading: loading, active: active, avatar: avatar, title: title, paragraph: paragraph, round: round, content: content)
    }
}

// MARK: - Tooltip Factory

public struct _MoinTooltipFactory {
    
    // MARK: - Nested Types
    
    /// Moin.Tooltip.Placement
    public typealias Placement = _TooltipPlacement
    /// Moin.Tooltip.Trigger
    public typealias Trigger = _TooltipTrigger
    
    public init() {}
    
    /// 文字 Tooltip
    public func callAsFunction<Content: View>(
        _ title: String,
        placement: _TooltipPlacement = .top,
        arrow: Bool = true,
        color: Color? = nil,
        trigger: _TooltipTrigger = .hover,
        isOpen: Binding<Bool>? = nil,
        @ViewBuilder content: () -> Content
    ) -> _Tooltip<Content, Text> {
        _Tooltip(title, placement: placement, arrow: arrow, color: color, trigger: trigger, isOpen: isOpen, content: content)
    }
    
    /// 自定义内容 Tooltip
    public func callAsFunction<Content: View, TooltipContent: View>(
        placement: _TooltipPlacement = .top,
        arrow: Bool = true,
        color: Color? = nil,
        trigger: _TooltipTrigger = .hover,
        isOpen: Binding<Bool>? = nil,
        @ViewBuilder tooltip: () -> TooltipContent,
        @ViewBuilder content: () -> Content
    ) -> _Tooltip<Content, TooltipContent> {
        _Tooltip(content: content, tooltip: tooltip, placement: placement, arrow: arrow, color: color, trigger: trigger, isOpen: isOpen)
    }
}
