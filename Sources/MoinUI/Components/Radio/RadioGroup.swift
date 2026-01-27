import SwiftUI

// MARK: - _RadioGroup (internal name, use Moin.Radio.Group)

public struct _RadioGroup<Value: Hashable>: View {
    @Binding var value: Value
    let options: [_RadioOption<Value>]
    let orientation: Axis
    let disabled: Bool
    let optionType: _RadioOptionType
    let buttonStyle: _RadioButtonStyle
    let block: Bool
    let size: _RadioSize

    @State private var hoveredValue: Value?

    @Environment(\.moinRadioToken) private var radioToken
    @Environment(\.moinToken) private var token

    public init(
        value: Binding<Value>,
        options: [_RadioOption<Value>],
        orientation: Axis = .horizontal,
        disabled: Bool = false,
        optionType: _RadioOptionType = .default,
        buttonStyle: _RadioButtonStyle = .outline,
        block: Bool = false,
        size: _RadioSize = .middle
    ) {
        self._value = value
        self.options = options
        self.orientation = orientation
        self.disabled = disabled
        self.optionType = optionType
        self.buttonStyle = buttonStyle
        self.block = block
        self.size = size
    }

    public init(
        value: Binding<Value>,
        options: [Value],
        labelProvider: (Value) -> String = { "\($0)" },
        orientation: Axis = .horizontal,
        disabled: Bool = false,
        optionType: _RadioOptionType = .default,
        buttonStyle: _RadioButtonStyle = .outline,
        block: Bool = false,
        size: _RadioSize = .middle
    ) {
        self._value = value
        self.options = options.map { _RadioOption(label: labelProvider($0), value: $0) }
        self.orientation = orientation
        self.disabled = disabled
        self.optionType = optionType
        self.buttonStyle = buttonStyle
        self.block = block
        self.size = size
    }

    /// Map-based initializer for complex configurations (similar to Ant Design options prop)
    /// Supported keys: "label" (String), "value" (Value), "disabled" (Bool)
    public init(
        value: Binding<Value>,
        mapOptions: [[String: Any]],
        orientation: Axis = .horizontal,
        disabled: Bool = false,
        optionType: _RadioOptionType = .default,
        buttonStyle: _RadioButtonStyle = .outline,
        block: Bool = false,
        size: _RadioSize = .middle
    ) {
        self._value = value
        self.orientation = orientation
        self.disabled = disabled
        self.optionType = optionType
        self.buttonStyle = buttonStyle
        self.block = block
        self.size = size
        self.options = mapOptions.compactMap { dict in
            guard let label = dict["label"] as? String,
                  let value = dict["value"] as? Value else {
                return nil
            }
            let disabled = dict["disabled"] as? Bool ?? false
            return _RadioOption(label: label, value: value, disabled: disabled)
        }
    }

    /// String-only Map initializer (specifically for when Value is String, avoiding Any casting issues)
    public init(
        value: Binding<Value>,
        stringMapOptions: [[String: String]],
        orientation: Axis = .horizontal,
        disabled: Bool = false,
        optionType: _RadioOptionType = .default,
        buttonStyle: _RadioButtonStyle = .outline,
        block: Bool = false,
        size: _RadioSize = .middle
    ) where Value == String {
        self._value = value
        self.orientation = orientation
        self.disabled = disabled
        self.optionType = optionType
        self.buttonStyle = buttonStyle
        self.block = block
        self.size = size
        self.options = stringMapOptions.compactMap { dict in
            guard let label = dict["label"],
                  let value = dict["value"] else {
                return nil
            }
            let disabled = dict["disabled"] == "true"
            return _RadioOption(label: label, value: value, disabled: disabled)
        }
    }

    /// Vertical convenience initializer (Ant Design: vertical prop)
    public init(
        value: Binding<Value>,
        options: [_RadioOption<Value>],
        vertical: Bool,
        disabled: Bool = false,
        optionType: _RadioOptionType = .default,
        buttonStyle: _RadioButtonStyle = .outline,
        block: Bool = false,
        size: _RadioSize = .middle
    ) {
        self._value = value
        self.options = options
        self.orientation = vertical ? .vertical : .horizontal
        self.disabled = disabled
        self.optionType = optionType
        self.buttonStyle = buttonStyle
        self.block = block
        self.size = size
    }

    public var body: some View {
        if optionType == .button {
            buttonGroupBody
        } else {
            defaultBody
        }
    }

    private var defaultBody: some View {
        let layoutSpacing = block ? 0 : radioToken.wrapperMarginInlineEnd
        let layout = orientation == .horizontal
            ? AnyLayout(HStackLayout(spacing: layoutSpacing))
            : AnyLayout(VStackLayout(alignment: .leading, spacing: layoutSpacing))

        return layout {
            ForEach(options) { option in
                _Radio(
                    checked: Binding(
                        get: { value == option.value },
                        set: { isChecked in
                            if isChecked {
                                value = option.value
                            }
                        }
                    ),
                    disabled: disabled || option.disabled
                ) {
                    Text(option.label)
                }
                .frame(maxWidth: block ? .infinity : nil)
            }
        }
    }

    private var buttonGroupBody: some View {
        // Button style: use negative spacing to overlap borders (margin-left: -1px equivalent)
        let spacing = -radioToken.lineWidth
        let layout = orientation == .horizontal
            ? AnyLayout(HStackLayout(spacing: spacing))
            : AnyLayout(VStackLayout(spacing: spacing))

        return layout {
            ForEach(Array(options.enumerated()), id: \.element.id) { index, option in
                let position = getPosition(index: index, count: options.count)

                _RadioButton(
                    checked: Binding(
                        get: { value == option.value },
                        set: { isChecked in
                            if isChecked {
                                value = option.value
                            }
                        }
                    ),
                    disabled: disabled || option.disabled,
                    buttonStyle: buttonStyle,
                    position: position,
                    direction: orientation,
                    onHover: { isHovering in
                        hoveredValue = isHovering ? option.value : nil
                    },
                    block: block,
                    size: size
                ) {
                    Text(option.label)
                }
                .zIndex(value == option.value || hoveredValue == option.value ? 1 : 0)
            }
        }
    }

    private func getPosition(index: Int, count: Int) -> _RadioButtonPosition {
        if count == 1 {
            return .single
        }
        if index == 0 {
            return .first
        }
        if index == count - 1 {
            return .last
        }
        return .middle
    }
}

// MARK: - _RadioGroupView (internal name, use Moin.Radio.GroupView)

/// Flexible RadioGroup that supports arbitrary content views with custom data models
public struct _RadioGroupView<Item: Identifiable, SelectionValue: Hashable, Content: View>: View {
    @Binding var value: SelectionValue
    let data: [Item]
    let valuePath: KeyPath<Item, SelectionValue>
    let orientation: Axis
    let content: (Item) -> Content
    let disabled: Bool

    @Environment(\.moinRadioToken) private var radioToken

    public init(
        value: Binding<SelectionValue>,
        data: [Item],
        valuePath: KeyPath<Item, SelectionValue>,
        orientation: Axis = .horizontal,
        disabled: Bool = false,
        @ViewBuilder content: @escaping (Item) -> Content
    ) {
        self._value = value
        self.data = data
        self.valuePath = valuePath
        self.orientation = orientation
        self.disabled = disabled
        self.content = content
    }

    public var body: some View {
        let layout = orientation == .horizontal
            ? AnyLayout(HStackLayout(spacing: radioToken.wrapperMarginInlineEnd))
            : AnyLayout(VStackLayout(alignment: .leading, spacing: radioToken.wrapperMarginInlineEnd))

        layout {
            ForEach(data) { item in
                let itemValue = item[keyPath: valuePath]
                _Radio(
                    checked: Binding(
                        get: { value == itemValue },
                        set: { isChecked in
                            if isChecked {
                                value = itemValue
                            }
                        }
                    ),
                    disabled: disabled
                ) {
                    content(item)
                }
            }
        }
    }
}


