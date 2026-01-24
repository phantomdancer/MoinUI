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

        /// Dictionary-based initializer
        public init(
            selection: Binding<Value>,
            dictionaryOptions: [[String: Any]],
            direction: Axis = .horizontal,
            disabled: Bool = false
        ) {
            self._selection = selection
            self.direction = direction
            self.disabled = disabled
            self.options = dictionaryOptions.compactMap { dict in
                guard let label = dict["label"] as? String,
                      let value = dict["value"] as? Value else {
                    return nil
                }
                let disabled = dict["disabled"] as? Bool ?? false
                return RadioOption(label: label, value: value, disabled: disabled)
            }
        }
        
        /// String-only Dictionary initializer
        public init(
            selection: Binding<Value>,
            stringDictionaryOptions: [[String: String]],
            direction: Axis = .horizontal,
            disabled: Bool = false
        ) where Value == String {
            self._selection = selection
            self.direction = direction
            self.disabled = disabled
            self.options = stringDictionaryOptions.compactMap { dict in
                guard let label = dict["label"],
                      let value = dict["value"] else {
                    return nil
                }
                let disabledStr = dict["disabled"]
                let disabled = disabledStr == "true"
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
}
