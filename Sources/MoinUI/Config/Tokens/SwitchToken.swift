import SwiftUI

public extension Moin {
    struct SwitchToken: Equatable {
        // MARK: - Sizes
        
        /// 轨道高度
        public var trackHeight: CGFloat
        /// 最小宽度
        public var trackMinWidth: CGFloat
        /// 把手大小
        public var handleSize: CGFloat
        /// 把手阴影
        public var handleShadow: Color
        
        // MARK: - Colors
        
        /// 开启状态背景色
        public var colorPrimary: Color
        /// 开启状态悬停背景色
        public var colorPrimaryHover: Color
        
        /// 关闭状态背景色
        public var colorTextQuaternary: Color
        /// 关闭状态悬停背景色
        public var colorTextTertiary: Color
        
        /// 禁用状态相关
        public var colorTextDisabled: Color
        public var colorBgDisabled: Color
        
        /// Handle 颜色
        public var handleBg: Color
        
        /// 内间距 (Handle 到边框的距离)
        public var innerMargin: CGFloat
        
        // MARK: - Defaults
        
        public static let `default` = SwitchToken(
            trackHeight: 22,
            trackMinWidth: 44,
            handleSize: 18,
            handleShadow: Color.black.opacity(0.12),
            colorPrimary: Moin.Colors.blue6,
            colorPrimaryHover: Moin.Colors.blue5,
            colorTextQuaternary: Color(hex: 0x000000, alpha: 0.25), // close bg
            colorTextTertiary: Color(hex: 0x000000, alpha: 0.45), // close hover
            colorTextDisabled: Color(hex: 0x000000, alpha: 0.25),
            colorBgDisabled: Color(hex: 0x000000, alpha: 0.15),
            handleBg: .white,
            innerMargin: 2
        )
        
        // MARK: - Resolution
        
        public static func resolve(token: Token, isDark: Bool) -> SwitchToken {
            let handleSize = token.controlHeightSM - 6 // 24 - 6 = 18
            
            if isDark {
                return SwitchToken(
                    trackHeight: token.controlHeightSM - 2, // 22
                    trackMinWidth: 44,
                    handleSize: handleSize,
                    handleShadow: .black.opacity(0.4),
                    colorPrimary: token.colorPrimary,
                    colorPrimaryHover: token.colorPrimaryHover,
                    colorTextQuaternary: Color(hex: 0xFFFFFF, alpha: 0.25), // close bg dark
                    colorTextTertiary: Color(hex: 0xFFFFFF, alpha: 0.35), // close hover dark
                    colorTextDisabled: token.colorTextDisabled,
                    colorBgDisabled: Color(hex: 0xFFFFFF, alpha: 0.15),
                    handleBg: Color(hex: 0x141414),
                    innerMargin: 2
                )
            }
            
            return SwitchToken(
                trackHeight: token.controlHeightSM - 2, // 22
                trackMinWidth: 44,
                handleSize: handleSize,
                handleShadow: Color.black.opacity(0.12),
                colorPrimary: token.colorPrimary,
                colorPrimaryHover: token.colorPrimaryHover,
                colorTextQuaternary: Color(hex: 0x000000, alpha: 0.25),
                colorTextTertiary: Color(hex: 0x000000, alpha: 0.45),
                colorTextDisabled: token.colorTextDisabled,
                colorBgDisabled: token.colorBgDisabled,
                handleBg: .white,
                innerMargin: 2
            )
        }
    }
}
