import SwiftUI

// MARK: - Moin.SpaceSize

public extension Moin {
    /// Space size
    enum SpaceSize {
        case small
        case middle
        case large
        /// 内部使用，请直接传数字如 `size: 24`
        case _custom(CGFloat)
    }
}

// MARK: - ExpressibleByIntegerLiteral & ExpressibleByFloatLiteral

extension Moin.SpaceSize: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int) {
        self = ._custom(CGFloat(value))
    }
}

extension Moin.SpaceSize: ExpressibleByFloatLiteral {
    public init(floatLiteral value: Double) {
        self = ._custom(CGFloat(value))
    }
}
