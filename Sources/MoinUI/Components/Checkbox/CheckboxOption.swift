import SwiftUI

// MARK: - _CheckboxOption (internal name, use Moin.Checkbox.Option)

/// Checkbox 选项
public struct _CheckboxOption<Value: Hashable>: Identifiable, Equatable {
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


