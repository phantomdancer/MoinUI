import SwiftUI

// MARK: - Moin.AlertToken

public extension Moin {
    /// Alert 组件的设计变量
    ///
    /// 参考 Ant Design Alert Component Token:
    /// - defaultPadding: 默认内间距 (8px 12px)
    /// - withDescriptionPadding: 带有描述的内间距 (20px 24px)
    /// - withDescriptionIconSize: 带有描述时的图标尺寸 (24)
    struct AlertToken {
        // MARK: - Status Colors
        
        /// 成功状态背景色
        public var colorSuccessBg: Color
        /// 成功状态边框色
        public var colorSuccessBorder: Color
        /// 成功状态图标色
        public var colorSuccess: Color
        
        /// 信息状态背景色
        public var colorInfoBg: Color
        /// 信息状态边框色
        public var colorInfoBorder: Color
        /// 信息状态图标色
        public var colorInfo: Color
        
        /// 警告状态背景色
        public var colorWarningBg: Color
        /// 警告状态边框色
        public var colorWarningBorder: Color
        /// 警告状态图标色
        public var colorWarning: Color
        
        /// 错误状态背景色
        public var colorErrorBg: Color
        /// 错误状态边框色
        public var colorErrorBorder: Color
        /// 错误状态图标色
        public var colorError: Color
        
        // MARK: - Text Colors
        
        /// 标题文本颜色
        public var colorTextHeading: Color
        /// 描述文本颜色
        public var colorText: Color
        /// 关闭图标颜色
        public var colorIcon: Color
        /// 关闭图标悬浮颜色
        public var colorIconHover: Color
        
        // MARK: - Component Token (Ant Design)
        
        /// 默认内间距 (Ant Design: 8px 12px)
        public var defaultPadding: EdgeInsets
        /// 带有描述的内间距 (Ant Design: 20px 24px)
        public var withDescriptionPadding: EdgeInsets
        /// 带有描述时的图标尺寸 (Ant Design: 24)
        public var withDescriptionIconSize: CGFloat
        
        // MARK: - Typography
        
        /// 描述字体大小
        public var fontSize: CGFloat
        /// 标题字体大小（带描述时）
        public var fontSizeLG: CGFloat
        /// 行高
        public var lineHeight: CGFloat
        /// 大行高（标题行高）
        public var lineHeightLG: CGFloat
        /// 关闭图标大小
        public var fontSizeIcon: CGFloat
        
        // MARK: - Layout
        
        /// 图标大小（无描述时）
        public var iconSize: CGFloat
        /// 边框宽度
        public var lineWidth: CGFloat
        /// 圆角大小
        public var borderRadiusLG: CGFloat
        
        // MARK: - Spacing (Ant Design)
        
        /// 超小间距（图标与内容）
        public var marginXS: CGFloat
        /// 小间距（带描述时图标与内容）
        public var marginSM: CGFloat
        
        // MARK: - Factory
        
        public static func generate(from token: Token) -> AlertToken {
            AlertToken(
                // Status Colors
                colorSuccessBg: token.colorSuccessBg,
                colorSuccessBorder: token.colorSuccessBorder,
                colorSuccess: token.colorSuccess,
                
                colorInfoBg: token.colorInfoBg,
                colorInfoBorder: token.colorInfoBorder,
                colorInfo: token.colorInfo,
                
                colorWarningBg: token.colorWarningBg,
                colorWarningBorder: token.colorWarningBorder,
                colorWarning: token.colorWarning,
                
                colorErrorBg: token.colorDangerBg,
                colorErrorBorder: token.colorDangerBorder,
                colorError: token.colorDanger,
                
                // Text Colors (使用现有Token近似)
                colorTextHeading: token.colorText,
                colorText: token.colorText,
                colorIcon: token.colorTextTertiary,
                colorIconHover: token.colorText,
                
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
                withDescriptionIconSize: token.fontSizeHeading3,
                
                // Typography
                fontSize: token.fontSize,
                fontSizeLG: token.fontSizeLG,
                lineHeight: token.lineHeight,
                lineHeightLG: token.lineHeightLG,
                fontSizeIcon: token.fontSizeSM,
                
                // Layout
                iconSize: token.fontSizeLG, // 16
                lineWidth: token.lineWidth,
                borderRadiusLG: token.borderRadiusLG,
                
                // Spacing
                marginXS: token.marginXS,
                marginSM: token.marginSM
            )
        }

        public static let light = generate(from: .light)
        public static let dark = generate(from: .dark)
        public static let `default` = light
    }
}
