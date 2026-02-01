import SwiftUI

public extension Moin {
    /// Tooltip 组件 Token
    /// 严格按照 Ant Design 区分：仅包含组件级 Token
    /// 全局 Token 应从 Moin.Token 直接读取
    struct TooltipToken {
        
        // MARK: - Component Token (组件级 Token，仅2个)
        
        /// 文字提示最大宽度
        /// Default: 250
        public var maxWidth: CGFloat
        
        /// 文字提示 z-index
        /// Default: 1070 (zIndexPopupBase + 70)
        public var zIndexPopup: Int
        
        // MARK: - Defaults
        
        public static let `default` = TooltipToken(
            maxWidth: 250,
            zIndexPopup: 1070
        )
        
        // MARK: - Generate from Token
        
        public static func generate(from token: Token) -> TooltipToken {
            TooltipToken(
                maxWidth: 250,
                zIndexPopup: token.zIndexPopupBase + 70
            )
        }
    }
}

// MARK: - Environment Key

private struct MoinTooltipTokenKey: EnvironmentKey {
    static let defaultValue = Moin.TooltipToken.default
}

public extension EnvironmentValues {
    var moinTooltipToken: Moin.TooltipToken {
        get { self[MoinTooltipTokenKey.self] }
        set { self[MoinTooltipTokenKey.self] = newValue }
    }
}
