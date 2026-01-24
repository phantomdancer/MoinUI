import SwiftUI

public extension Moin {
    struct RadioOption<Value: Hashable>: Identifiable, Equatable {
        public let id: Value
        public let label: String
        public let value: Value
        public let disabled: Bool

        public init(label: String, value: Value, disabled: Bool = false) {
            self.id = value
            self.label = label
            self.value = value
            self.disabled = disabled
        }
    }

    struct RadioGroup<Value: Hashable>: View {
        @Binding var selection: Value
        let options: [RadioOption<Value>]
        let direction: Axis
        let disabled: Bool

        @Environment(\.moinRadioToken) private var radioToken

        public init(
            selection: Binding<Value>,
            options: [RadioOption<Value>],
            direction: Axis = .horizontal,
            disabled: Bool = false
        ) {
            self._selection = selection
            self.options = options
            self.direction = direction
            self.disabled = disabled
        }

        public init(
            selection: Binding<Value>,
            options: [Value],
            labelProvider: (Value) -> String = { "\($0)" },
            direction: Axis = .horizontal,
            disabled: Bool = false
        ) {
            self._selection = selection
            self.options = options.map { RadioOption(label: labelProvider($0), value: $0) }
            self.direction = direction
            self.disabled = disabled
        }

        /// Map-based initializer for complex configurations (similar to Ant Design options prop)
        /// Supported keys: "label" (String), "value" (Value), "disabled" (Bool)
        public init(
            selection: Binding<Value>,
            mapOptions: [[String: Any]],
            direction: Axis = .horizontal,
            disabled: Bool = false
        ) {
            self._selection = selection
            self.direction = direction
            self.disabled = disabled
            self.options = mapOptions.compactMap { dict in
                guard let label = dict["label"] as? String,
                      let value = dict["value"] as? Value else {
                    return nil
                }
                let disabled = dict["disabled"] as? Bool ?? false
                return RadioOption(label: label, value: value, disabled: disabled)
            }
        }
        
        /// String-only Map initializer (specifically for when Value is String, avoiding Any casting issues)
        public init(
            selection: Binding<Value>,
            stringMapOptions: [[String: String]],
            direction: Axis = .horizontal,
            disabled: Bool = false
        ) where Value == String {
            self._selection = selection
            self.direction = direction
            self.disabled = disabled
            self.options = stringMapOptions.compactMap { dict in
                guard let label = dict["label"],
                      let value = dict["value"] else {
                    return nil
                }
                let disabled = dict["disabled"] == "true"
                return RadioOption(label: label, value: value, disabled: disabled)
            }
        }

        public var body: some View {
            let layout = direction == .horizontal ? AnyLayout(HStackLayout(spacing: radioToken.wrapperMarginEnd)) : AnyLayout(VStackLayout(alignment: .leading, spacing: radioToken.wrapperMarginEnd))

            layout {
                ForEach(options) { option in
                    Radio(
                        checked: Binding(
                            get: { selection == option.value },
                            set: { isChecked in
                                if isChecked {
                                    selection = option.value
                                }
                            }
                        ),
                        disabled: disabled || option.disabled
                    ) {
                        Text(option.label)
                    }
                }
            }
        }
    }

    /// Flexible RadioGroup that supports arbitrary content views
    /// Flexible RadioGroup that supports arbitrary content views with custom data models
    struct RadioGroupView<Item: Identifiable, SelectionValue: Hashable, Content: View>: View {
        @Binding var selection: SelectionValue
        let data: [Item]
        let valuePath: KeyPath<Item, SelectionValue>
        let direction: Axis
        let content: (Item) -> Content
        let disabled: Bool
        
        @Environment(\.moinRadioToken) private var radioToken
        
        public init(
            selection: Binding<SelectionValue>,
            data: [Item],
            value valuePath: KeyPath<Item, SelectionValue>,
            direction: Axis = .horizontal,
            disabled: Bool = false,
            @ViewBuilder content: @escaping (Item) -> Content
        ) {
            self._selection = selection
            self.data = data
            self.valuePath = valuePath
            self.direction = direction
            self.disabled = disabled
            self.content = content
        }
        
        public var body: some View {
             let layout = direction == .horizontal ? AnyLayout(HStackLayout(spacing: radioToken.wrapperMarginEnd)) : AnyLayout(VStackLayout(alignment: .leading, spacing: radioToken.wrapperMarginEnd))
            
            layout {
                ForEach(data) { item in
                    let itemValue = item[keyPath: valuePath]
                    Radio(
                        checked: Binding(
                            get: { selection == itemValue },
                            set: { isChecked in
                                if isChecked {
                                    selection = itemValue
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
}

