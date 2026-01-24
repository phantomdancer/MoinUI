import SwiftUI

public extension Moin {
    struct CheckboxToken: Equatable {
        
        // MARK: - Sizes
        
        /// Checkbox 尺寸
        /// Default: 16
        public var checkboxSize: CGFloat
        
        // MARK: - Borders
        
        /// 圆角
        /// Default: borderRadiusSM
        public var borderRadius: CGFloat
        /// 边框宽度
        /// Default: lineWidth
        public var lineWidth: CGFloat
        /// 粗边框宽度 (for checkmark)
        public var lineWidthBold: CGFloat
        
        // MARK: - Colors
        
        /// 开启状态背景色
        public var colorPrimary: Color
        /// 开启状态悬停背景色
        public var colorPrimaryHover: Color
        
        /// 默认/未选中 边框颜色
        public var colorBorder: Color
        /// 默认/未选中 背景颜色
        public var colorBgContainer: Color
        
        /// 选中状态 钩子颜色
        public var colorWhite: Color
        
        // MARK: - Disabled
        
        /// 禁用状态背景色
        public var colorBgContainerDisabled: Color
        /// 禁用状态边框色
        public var colorBorderDisabled: Color
        /// 禁用状态文本色 (及钩子颜色)
        public var colorTextDisabled: Color
        
        // MARK: - Layout
        
        /// 文本与选框的间距
        /// Default: paddingXS
        public var paddingXS: CGFloat
        
        // MARK: - Motion
        
        public var motionDurationSlow: Double
        
        // MARK: - Defaults
        
        public static let `default` = CheckboxToken(
            checkboxSize: 16,
            borderRadius: 2,
            lineWidth: 1,
            lineWidthBold: 2,
            colorPrimary: Moin.Colors.blue6,
            colorPrimaryHover: Moin.Colors.blue5,
            colorBorder: Color(hex: 0xD9D9D9),
            colorBgContainer: .white,
            colorWhite: .white,
            colorBgContainerDisabled: Color(hex: 0xF5F5F5),
            colorBorderDisabled: Color(hex: 0xD9D9D9),
            colorTextDisabled: Color(hex: 0x000000, alpha: 0.25),
            paddingXS: 8,
            motionDurationSlow: 0.3
        )
        
        // MARK: - Resolution
        
        public static func resolve(token: Token) -> CheckboxToken {
            CheckboxToken(
                checkboxSize: 16,
                borderRadius: token.borderRadiusSM,
                lineWidth: token.lineWidth,
                lineWidthBold: token.lineWidthBold,
                colorPrimary: token.colorPrimary,
                colorPrimaryHover: token.colorPrimaryHover,
                colorBorder: token.colorBorder,
                colorBgContainer: token.colorBgContainer,
                colorWhite: .white,
                colorBgContainerDisabled: token.colorBgDisabled,
                colorBorderDisabled: token.colorBorder,
                colorTextDisabled: token.colorTextDisabled,
                paddingXS: token.paddingXS,
                motionDurationSlow: token.motionDurationSlow
            )
        }
    }
}
