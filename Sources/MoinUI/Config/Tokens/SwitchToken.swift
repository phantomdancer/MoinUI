import SwiftUI

public extension Moin {
    struct SwitchToken: Equatable {
        // MARK: - Sizes
        
        /// 轨道高度
        public var trackHeight: CGFloat
        /// 轨道内边距 (Visual padding around handle)
        public var trackPadding: CGFloat
        /// 最小宽度
        public var trackMinWidth: CGFloat
        
        /// 把手大小
        public var handleSize: CGFloat
        /// 把手阴影
        public var handleShadow: Color
        
        /// 内容最小间距 (Ant Design: innerMinMargin)
        public var innerMinMargin: CGFloat
        /// 内容最大间距 (Ant Design: innerMaxMargin)
        /// 用于避让 Handle
        public var innerMaxMargin: CGFloat

        // MARK: - Small Size
        
        /// 小号轨道高度
        public var trackHeightSM: CGFloat
        /// 小号最小宽度
        public var trackMinWidthSM: CGFloat
        /// 小号把手大小
        public var handleSizeSM: CGFloat
        /// 小号内容最小间距 (Ant Design: innerMinMarginSM)
        public var innerMinMarginSM: CGFloat
        /// 小号内容最大间距 (Ant Design: innerMaxMarginSM)
        public var innerMaxMarginSM: CGFloat
        
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
        
        /// 加载状态透明度
        public var opacityLoading: CGFloat
        /// 动效时长
        public var motionDuration: TimeInterval
        
        // MARK: - Defaults
        
        public static let `default` = SwitchToken(
            trackHeight: 22,
            trackPadding: 2,
            trackMinWidth: 44,
            handleSize: 18,
            handleShadow: Color.black.opacity(0.12),
            innerMinMargin: 9,
            innerMaxMargin: 24,
            trackHeightSM: 16,
            trackMinWidthSM: 28,
            handleSizeSM: 12,
            innerMinMarginSM: 6,
            innerMaxMarginSM: 18,
            colorPrimary: Moin.Colors.blue6,
            colorPrimaryHover: Moin.Colors.blue5,
            colorTextQuaternary: Color(hex: 0x000000, alpha: 0.25),
            colorTextTertiary: Color(hex: 0x000000, alpha: 0.45),
            colorTextDisabled: Color(hex: 0x000000, alpha: 0.25),
            colorBgDisabled: Color(hex: 0x000000, alpha: 0.15),
            handleBg: .white,
            opacityLoading: 0.65,
            motionDuration: 0.2
        )
        
        // MARK: - Resolution
        
        public static func resolve(token: Token, isDark: Bool) -> SwitchToken {
            // Ant Design Logic
            // height = fontSize * lineHeight (Approx controlHeightSM for default size in AntD context usually)
            // But here we rely on incoming token.controlHeightSM or similar guidance.
            // Using standard AntD values derived from typical 14px font * 1.5715 line height ~= 22px
            
            let trackHeight = token.controlHeightSM - 2 // Usually 24 - 2 = 22
            let trackPadding: CGFloat = 2
            let handleSize = trackHeight - trackPadding * 2 // 18
            let trackMinWidth = handleSize * 2 + trackPadding * 4 // 36 + 8 = 44
            
            let innerMinMargin = handleSize / 2 // 9
            let innerMaxMargin = handleSize + trackPadding + trackPadding * 2 // 18 + 2 + 4 = 24
            
            // SM
            let trackHeightSM: CGFloat = 16
            let handleSizeSM = trackHeightSM - trackPadding * 2 // 12
            // AntD source: trackMinWidthSM = handleSizeSM * 2 + padding * 2;
            // 12 * 2 + 2 * 2 = 24 + 4 = 28
            let trackMinWidthSM = handleSizeSM * 2 + trackPadding * 2
            
            let innerMinMarginSM = handleSizeSM / 2 // 6
            let innerMaxMarginSM = handleSizeSM + trackPadding + trackPadding * 2 // 12 + 2 + 4 = 18
            
            let common = SwitchToken(
                trackHeight: trackHeight,
                trackPadding: trackPadding,
                trackMinWidth: trackMinWidth,
                handleSize: handleSize,
                handleShadow: isDark ? .black.opacity(0.4) : Color.black.opacity(0.12),
                innerMinMargin: innerMinMargin,
                innerMaxMargin: innerMaxMargin,
                trackHeightSM: trackHeightSM,
                trackMinWidthSM: trackMinWidthSM,
                handleSizeSM: handleSizeSM,
                innerMinMarginSM: innerMinMarginSM,
                innerMaxMarginSM: innerMaxMarginSM,
                colorPrimary: token.colorPrimary,
                colorPrimaryHover: token.colorPrimaryHover,
                colorTextQuaternary: token.colorTextQuaternary,
                colorTextTertiary: token.colorTextTertiary,
                colorTextDisabled: token.colorTextDisabled,
                colorBgDisabled: isDark ? Color(hex: 0xFFFFFF, alpha: 0.15) : token.colorBgDisabled,
                handleBg: isDark ? Color(hex: 0x141414) : .white,
                opacityLoading: 0.65, // Standard AntD default
                motionDuration: 0.2   // Standard motionDurationMid
            )
            
            return common
        }
    }
}
