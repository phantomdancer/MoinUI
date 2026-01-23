import SwiftUI

// MARK: - Moin.AlertToken

public extension Moin {
    /// Alert 组件的设计变量（仅组件专属Token）
    ///
    /// 参考 Ant Design Alert Component Token:
    /// - defaultPadding: 默认内间距 (8px 12px)
    /// - withDescriptionPadding: 带有描述的内间距 (20px 24px)
    /// - withDescriptionIconSize: 带有描述时的图标尺寸 (24)
    ///
    /// 注意：其他样式（颜色、字体、圆角等）使用全局Token，
    /// 修改全局Token会影响所有组件。
    struct AlertToken {
        // MARK: - Component Token (Ant Design: 仅3项)
        
        /// 默认内间距 (Ant Design: 8px 12px)
        public var defaultPadding: EdgeInsets
        /// 带有描述的内间距 (Ant Design: 20px 24px)
        public var withDescriptionPadding: EdgeInsets
        /// 带有描述时的图标尺寸 (Ant Design: 24)
        public var withDescriptionIconSize: CGFloat
        
        // MARK: - Factory
        
        public static func generate(from token: Token) -> AlertToken {
            AlertToken(
                // Component Token (Ant Design values)
                // defaultPadding: paddingXS (8) + 12px
                defaultPadding: EdgeInsets(
                    top: token.paddingXS,
                    leading: 12,
                    bottom: token.paddingXS,
                    trailing: 12
                ),
                // withDescriptionPadding: paddingMD (20) + paddingLG (24)
                withDescriptionPadding: EdgeInsets(
                    top: token.paddingMD,
                    leading: token.paddingLG,
                    bottom: token.paddingMD,
                    trailing: token.paddingLG
                ),
                // withDescriptionIconSize: fontSizeHeading3 (24)
                withDescriptionIconSize: token.fontSizeHeading3
            )
        }

        public static let light = generate(from: .light)
        public static let dark = generate(from: .dark)
        public static let `default` = light
    }
}
