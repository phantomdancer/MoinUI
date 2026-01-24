import SwiftUI

public extension Moin {
    struct RadioToken: Equatable {
        
        // MARK: - Sizes
        
        /// Radio 尺寸
        /// Default: 16
        public var radioSize: CGFloat
        
        /// 内部圆点尺寸
        /// Default: 8
        public var dotSize: CGFloat
        
        // MARK: - Borders
        
        /// 边框宽度
        /// Default: lineWidth
        public var lineWidth: CGFloat
        
        // MARK: - Colors
        
        /// 开启状态主色 (Border & Dot)
        public var colorPrimary: Color
        
        /// 默认/未选中 边框颜色
        public var colorBorder: Color
        /// 默认/未选中 背景颜色
        public var colorBgContainer: Color
        
        /// 选中状态 内部圆点颜色
        /// Usually same as colorPrimary for Ant Design
        public var colorDot: Color
        
        // MARK: - Disabled
        
        /// 禁用状态背景色
        public var colorBgContainerDisabled: Color
        /// 禁用状态边框色
        public var colorBorderDisabled: Color
        /// 禁用状态文本色
        public var colorTextDisabled: Color
        /// 禁用状态圆点颜色
        public var colorDotDisabled: Color
        
        // MARK: - Layout
        
        /// 文本与选框的间距
        /// Default: paddingXS
        public var paddingXS: CGFloat
        
        /// Radio Group 中各选项的间距 (Horizontal)
        /// Default: paddingXS
        public var wrapperMarginEnd: CGFloat
        
        // MARK: - Motion
        
        /// 动画时长
        public var motionDurationMid: Double
        public var motionDurationSlow: Double
        
        // MARK: - Defaults
        
        public static let `default` = RadioToken(
            radioSize: 16,
            dotSize: 8,
            lineWidth: 1,
            colorPrimary: Moin.Colors.blue6,
            colorBorder: Color(hex: 0xD9D9D9),
            colorBgContainer: .white,
            colorDot: Moin.Colors.blue6,
            colorBgContainerDisabled: Color(hex: 0xF5F5F5),
            colorBorderDisabled: Color(hex: 0xD9D9D9),
            colorTextDisabled: Color(hex: 0x000000, alpha: 0.25),
            colorDotDisabled: Color(hex: 0x000000, alpha: 0.25),
            paddingXS: 8,
            wrapperMarginEnd: 8,
            motionDurationMid: 0.2,
            motionDurationSlow: 0.3
        )
        
        // MARK: - Resolution
        
        public static func resolve(token: Token) -> RadioToken {
            RadioToken(
                radioSize: 16,
                dotSize: 8,
                lineWidth: token.lineWidth,
                colorPrimary: token.colorPrimary,
                colorBorder: token.colorBorder,
                colorBgContainer: token.colorBgContainer,
                colorDot: token.colorPrimary,
                colorBgContainerDisabled: token.colorBgDisabled,
                colorBorderDisabled: token.colorBorder,
                colorTextDisabled: token.colorTextDisabled,
                colorDotDisabled: token.colorTextDisabled,
                paddingXS: token.paddingXS,
                wrapperMarginEnd: token.paddingXS,
                motionDurationMid: token.motionDurationMid,
                motionDurationSlow: token.motionDurationSlow
            )
        }
    }
}
