import SwiftUI

// MARK: - Moin.SpaceToken

public extension Moin {
    /// Space 组件的设计变量
    ///
    /// 参考 Ant Design Space - 没有 ComponentToken (Empty Interface)
    /// Space 直接使用全局 padding token：paddingXS, padding, paddingLG
    struct SpaceToken {
        // 空结构，无组件专属 Token

        public static func generate(from token: Token) -> SpaceToken {
            SpaceToken()
        }

        public static let light = generate(from: .light)
        public static let dark = generate(from: .dark)
        public static let `default` = light
    }
}
