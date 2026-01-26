import SwiftUI

// MARK: - _SpinSize (internal name, use Spin.Size)

/// Spin 组件尺寸
public enum _SpinSize: String, CaseIterable, CustomStringConvertible {
    case small
    case `default`
    case large

    public var description: String { rawValue }

    /// 获取对应的 dotSize
    public func dotSize(from token: Moin.SpinToken) -> CGFloat {
        switch self {
        case .small:
            return token.dotSizeSM
        case .default:
            return token.dotSize
        case .large:
            return token.dotSizeLG
        }
    }
}

// MARK: - Spin.Size typealias

public extension Spin {
    typealias Size = _SpinSize
}
