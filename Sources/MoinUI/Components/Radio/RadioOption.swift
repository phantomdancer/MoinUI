import SwiftUI

// MARK: - _RadioOption (internal name, use Moin.Radio.Option)

/// Radio 选项
public struct _RadioOption<Value: Hashable>: Identifiable, Equatable {
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


