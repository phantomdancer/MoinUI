import SwiftUI

// MARK: - _ButtonLoading (internal name, use Moin.Button.Loading)

/// Loading 配置 - 支持 delay 和自定义 icon
public struct _ButtonLoading: ExpressibleByBooleanLiteral, Equatable {
    public let isLoading: Bool
    public let delay: TimeInterval?
    public let icon: String?

    public init(_ isLoading: Bool = true, delay: TimeInterval? = nil, icon: String? = nil) {
        self.isLoading = isLoading
        self.delay = delay
        self.icon = icon
    }

    public init(booleanLiteral value: Bool) {
        self.isLoading = value
        self.delay = nil
        self.icon = nil
    }
}

