import SwiftUI

// MARK: - _AvatarSize (internal name, use Moin.Avatar.Size)

/// 头像尺寸
public enum _AvatarSize {
    case large
    case `default`
    case small
    case _custom(CGFloat)
}

extension _AvatarSize: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int) {
        self = ._custom(CGFloat(value))
    }
}

extension _AvatarSize: ExpressibleByFloatLiteral {
    public init(floatLiteral value: Double) {
        self = ._custom(CGFloat(value))
    }
}


