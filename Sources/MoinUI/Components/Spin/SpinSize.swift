import SwiftUI

// MARK: - SpinSize

/// Spin 组件尺寸
public enum SpinSize: String, CaseIterable {
    case small
    case `default`
    case large

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
