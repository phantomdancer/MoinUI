import SwiftUI

/// Moin - 墨影UI macOS组件库命名空间
public enum Moin {
    public static var version: String { MoinUIVersion }
}

/// MoinUI - 保留旧名作为别名（已弃用）
@available(*, deprecated, renamed: "Moin")
public typealias MoinUI = Moin
