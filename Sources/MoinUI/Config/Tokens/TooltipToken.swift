import SwiftUI

public extension Moin {
    struct TooltipToken {
        
        // MARK: - Size & Layout
        
        /// Tooltip z-index
        /// Default: 1070 (zIndexPopupBase + 70)
        public var zIndexPopup: Int
        
        /// 圆角半径
        /// Default: borderRadius (6)
        public var borderRadius: CGFloat
        
        /// 垂直内边距
        /// Default: paddingSM / 2 = 6
        public var paddingVertical: CGFloat
        
        /// 水平内边距
        /// Default: paddingXS = 8
        public var paddingHorizontal: CGFloat
        
        /// 最大宽度
        /// Default: 250
        public var maxWidth: CGFloat
        
        /// 最小高度
        /// Default: controlHeight (32)
        public var minHeight: CGFloat
        
        // MARK: - Arrow
        
        /// 箭头大小
        /// Default: sizePopupArrow (16)
        public var arrowSize: CGFloat
        
        // MARK: - Colors
        
        /// 背景色 (Ant Design: colorBgSpotlight)
        public var colorBg: Color
        
        /// 文字色 (Ant Design: colorTextLightSolid)
        public var colorText: Color
        
        // MARK: - Motion
        
        /// 动画时长
        public var motionDurationMid: Double
        
        /// 鼠标进入延迟（秒）
        public var mouseEnterDelay: Double
        
        /// 鼠标离开延迟（秒）
        public var mouseLeaveDelay: Double
        
        // MARK: - Shadow
        
        /// 阴影
        public var boxShadow: (color: Color, radius: CGFloat, x: CGFloat, y: CGFloat)
        
        // MARK: - Font
        
        /// 字体大小
        public var fontSize: CGFloat
        
        // MARK: - Defaults
        
        public static let `default` = TooltipToken(
            zIndexPopup: 1070,
            borderRadius: 6,
            paddingVertical: 6,
            paddingHorizontal: 8,
            maxWidth: 250,
            minHeight: 32,
            arrowSize: 6,
            colorBg: Color(hex: 0x000000, alpha: 0.85),  // colorBgSpotlight
            colorText: .white,
            motionDurationMid: 0.2,
            mouseEnterDelay: 0.1,
            mouseLeaveDelay: 0.1,
            boxShadow: (Color.black.opacity(0.12), 8, 0, 3),
            fontSize: 14
        )
        
        // MARK: - Generate from Token
        
        public static func generate(from token: Token) -> TooltipToken {
            TooltipToken(
                zIndexPopup: token.zIndexPopupBase + 70,
                borderRadius: token.borderRadius,
                paddingVertical: token.paddingSM / 2,
                paddingHorizontal: token.paddingXS,
                maxWidth: 250,
                minHeight: token.controlHeight,
                arrowSize: 6,  // smaller arrow like Ant Design
                colorBg: token.colorBgSpotlight,
                colorText: token.colorTextLightSolid,
                motionDurationMid: token.motionDurationMid,
                mouseEnterDelay: 0.1,
                mouseLeaveDelay: 0.1,
                boxShadow: (Color.black.opacity(0.12), 8, 0, 3),
                fontSize: token.fontSize
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
