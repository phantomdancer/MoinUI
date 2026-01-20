import Foundation

/// 头像尺寸
public enum AvatarSize {
    case large
    case `default`
    case small
    case _custom(CGFloat)
}

// MARK: - ExpressibleByIntegerLiteral
extension AvatarSize: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int) {
        self = ._custom(CGFloat(value))
    }
}

// MARK: - ExpressibleByFloatLiteral
extension AvatarSize: ExpressibleByFloatLiteral {
    public init(floatLiteral value: Double) {
        self = ._custom(CGFloat(value))
    }
}
