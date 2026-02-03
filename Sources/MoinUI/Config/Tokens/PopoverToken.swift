import SwiftUI

public extension Moin {
    /// Popover 组件 Token
    /// 参照 Ant Design Popover Token
    struct PopoverToken {
        
        // MARK: - Component Token
        
        /// 标题最小宽度
        /// Default: 177
        public var titleMinWidth: CGFloat
        
        /// z-index
        /// Default: zIndexPopupBase + 30 = 1030
        public var zIndexPopup: Int
        
        /// 内边距
        /// Default: 12
        public var innerPadding: CGFloat
        
        /// 标题下边距
        /// Default: 8 (marginXS)
        public var titleMarginBottom: CGFloat
        
        // MARK: - Defaults
        
        public static let `default` = PopoverToken(
            titleMinWidth: 177,
            zIndexPopup: 1030,
            innerPadding: 12,
            titleMarginBottom: 8
        )
        
        // MARK: - Generate from Token
        
        public static func generate(from token: Token) -> PopoverToken {
            PopoverToken(
                titleMinWidth: 177,
                zIndexPopup: token.zIndexPopupBase + 30,
                innerPadding: 12,
                titleMarginBottom: token.marginXS
            )
        }
    }
}

