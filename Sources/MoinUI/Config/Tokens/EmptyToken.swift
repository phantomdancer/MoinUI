import SwiftUI

// MARK: - Moin.EmptyToken

public extension Moin {
    /// Empty 组件的设计变量（仅组件专属Token）
    ///
    /// 参考 Ant Design Empty - 没有 ComponentToken
    /// 全局Token直接从全局token读取
    struct EmptyToken {
        // MARK: - Image (组件专属)
        /// 图片高度
        public var imageHeight: CGFloat
        /// 小号图片高度
        public var imageHeightSM: CGFloat
        /// 图片透明度
        public var imageOpacity: Double

        public static func generate(from token: Token) -> EmptyToken {
            EmptyToken(
                imageHeight: 100,   // Ant Design default
                imageHeightSM: 40,  // Ant Design simple
                imageOpacity: 1.0
            )
        }

        public static let light = generate(from: .light)
        public static let dark = generate(from: .dark)
        public static let `default` = light
    }
}
