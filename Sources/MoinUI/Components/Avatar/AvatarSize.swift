import SwiftUI

// MARK: - Moin.Avatar.Size

public extension Moin.Avatar {
    /// 头像尺寸
    enum Size {
        case large
        case `default`
        case small
        case _custom(CGFloat)
    }
}

extension Moin.Avatar.Size: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int) {
        self = ._custom(CGFloat(value))
    }
}

extension Moin.Avatar.Size: ExpressibleByFloatLiteral {
    public init(floatLiteral value: Double) {
        self = ._custom(CGFloat(value))
    }
}
