import SwiftUI

// MARK: - _SpaceSize (internal name, use Moin.Space.Size)

/// Space size
public enum _SpaceSize {
    case small
    case medium
    case large
    /// 内部使用，请直接传数字如 `size: 24`
    case _custom(CGFloat)
}

// MARK: - ExpressibleByIntegerLiteral & ExpressibleByFloatLiteral

extension _SpaceSize: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int) {
        self = ._custom(CGFloat(value))
    }
}

extension _SpaceSize: ExpressibleByFloatLiteral {
    public init(floatLiteral value: Double) {
        self = ._custom(CGFloat(value))
    }
}


