import SwiftUI

// MARK: - _CheckboxGroup (internal name, use Moin.Checkbox.Group)

public struct _CheckboxGroup<Value: Hashable>: View {
    @Binding var selection: Set<Value>
    let options: [_CheckboxOption<Value>]
    let direction: Axis
    let disabled: Bool

    @Environment(\.moinCheckboxToken) private var checkboxToken

    public init(
        selection: Binding<Set<Value>>,
        options: [_CheckboxOption<Value>],
        direction: Axis = .horizontal,
        disabled: Bool = false
    ) {
        self._selection = selection
        self.options = options
        self.direction = direction
        self.disabled = disabled
    }

    public init(
        selection: Binding<Set<Value>>,
        options: [Value],
        labelProvider: (Value) -> String = { "\($0)" },
        direction: Axis = .horizontal,
        disabled: Bool = false
    ) {
        self._selection = selection
        self.options = options.map { _CheckboxOption(label: labelProvider($0), value: $0) }
        self.direction = direction
        self.disabled = disabled
    }

    /// Dictionary-based initializer for convenience (e.g. JSON-like structure).
    /// Supports `[[String: Any]]` where "value" is `Value`, "label" is `String`, "disabled" is `Bool`.
    public init(
        selection: Binding<Set<Value>>,
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
            return _CheckboxOption(label: label, value: value, disabled: disabled)
        }
    }

    /// String-only Dictionary initializer to avoid type inference issues with `[[String: String]]`.
    public init(
        selection: Binding<Set<Value>>,
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
            return _CheckboxOption(label: label, value: value, disabled: disabled)
        }
    }

    public var body: some View {
        let layout = direction == .horizontal
            ? AnyLayout(HStackLayout(spacing: checkboxToken.paddingXS))
            : AnyLayout(VStackLayout(alignment: .leading, spacing: checkboxToken.paddingXS))

        layout {
            ForEach(options) { option in
                _Checkbox(
                    checked: Binding(
                        get: { selection.contains(option.value) },
                        set: { isChecked in
                            if isChecked {
                                selection.insert(option.value)
                            } else {
                                selection.remove(option.value)
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


