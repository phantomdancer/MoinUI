import SwiftUI

public extension Moin {
    enum RadioSize {
        case small
        case middle
        case large
    }

    struct RadioToken: Equatable {

        // MARK: - Sizes

        /// Radio 尺寸
        /// Default: 16
        public var radioSize: CGFloat

        /// 内部圆点尺寸
        /// Default: 8
        public var dotSize: CGFloat

        // MARK: - Button Sizes

        /// Button 样式 - 小号 padding 水平
        /// Default: 11
        public var buttonPaddingXSHorizontal: CGFloat
        /// Button 样式 - 小号 padding 竖直
        /// Default: 3
        public var buttonPaddingXSVertical: CGFloat

        /// Button 样式 - 默认 padding 水平
        /// Default: 15
        public var buttonPaddingDefaultHorizontal: CGFloat
        /// Button 样式 - 默认 padding 竖直
        /// Default: 5
        public var buttonPaddingDefaultVertical: CGFloat

        /// Button 样式 - 大号 padding 水平
        /// Default: 23
        public var buttonPaddingLargeHorizontal: CGFloat
        /// Button 样式 - 大号 padding 竖直
        /// Default: 7
        public var buttonPaddingLargeVertical: CGFloat

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

        /// 选中状态 内部圆点颜色 (Ant Design: radioColor)
        public var radioColor: Color

        /// Radio 背景颜色 (Ant Design: radioBgColor)
        public var radioBgColor: Color

        // MARK: - Disabled

        /// 禁用状态背景色
        public var colorBgContainerDisabled: Color
        /// 禁用状态边框色
        public var colorBorderDisabled: Color
        /// 禁用状态文本色
        public var colorTextDisabled: Color
        /// 禁用状态圆点颜色 (Ant Design: dotColorDisabled)
        public var dotColorDisabled: Color

        // MARK: - Layout

        /// 文本与选框的间距
        /// Default: paddingXS
        public var paddingXS: CGFloat

        /// Radio Group 中各选项的间距 (Horizontal) - Ant Design: wrapperMarginInlineEnd
        /// Default: paddingXS
        public var wrapperMarginInlineEnd: CGFloat

        // MARK: - Motion

        /// 动画时长
        public var motionDurationMid: Double
        public var motionDurationSlow: Double

        // MARK: - Button Style Tokens (Ant Design)

        /// 按钮背景色
        public var buttonBg: Color
        /// 按钮选中背景色
        public var buttonCheckedBg: Color
        /// 按钮选中禁用背景色
        public var buttonCheckedBgDisabled: Color
        /// 按钮选中禁用颜色
        public var buttonCheckedColorDisabled: Color
        /// 按钮文字颜色
        public var buttonColor: Color
        /// 按钮内边距
        public var buttonPaddingInline: CGFloat
        /// 填色按钮选中激活背景色
        public var buttonSolidCheckedActiveBg: Color
        /// 填色按钮选中背景色
        public var buttonSolidCheckedBg: Color
        /// 填色按钮选中文字颜色
        public var buttonSolidCheckedColor: Color
        /// 填色按钮选中悬停背景色
        public var buttonSolidCheckedHoverBg: Color

        // MARK: - Defaults

        public static let `default` = RadioToken(
            radioSize: 16,
            dotSize: 8,
            buttonPaddingXSHorizontal: 11,
            buttonPaddingXSVertical: 3,
            buttonPaddingDefaultHorizontal: 15,
            buttonPaddingDefaultVertical: 5,
            buttonPaddingLargeHorizontal: 23,
            buttonPaddingLargeVertical: 7,
            lineWidth: 1,
            colorPrimary: Moin.Colors.blue6,
            colorBorder: Color(hex: 0xD9D9D9),
            colorBgContainer: .white,
            radioColor: Moin.Colors.blue6,
            radioBgColor: .white,
            colorBgContainerDisabled: Color(hex: 0xF5F5F5),
            colorBorderDisabled: Color(hex: 0xD9D9D9),
            colorTextDisabled: Color(hex: 0x000000, alpha: 0.25),
            dotColorDisabled: Color(hex: 0x000000, alpha: 0.25),
            paddingXS: 8,
            wrapperMarginInlineEnd: 8,
            motionDurationMid: 0.2,
            motionDurationSlow: 0.3,
            buttonBg: .white,
            buttonCheckedBg: .white,
            buttonCheckedBgDisabled: Color(hex: 0xF5F5F5),
            buttonCheckedColorDisabled: Color(hex: 0x000000, alpha: 0.25),
            buttonColor: Color(hex: 0x000000, alpha: 0.88),
            buttonPaddingInline: 15,
            buttonSolidCheckedActiveBg: Moin.Colors.blue7,
            buttonSolidCheckedBg: Moin.Colors.blue6,
            buttonSolidCheckedColor: .white,
            buttonSolidCheckedHoverBg: Moin.Colors.blue5
        )

        // MARK: - Resolution

        public static func resolve(token: Token) -> RadioToken {
            RadioToken(
                radioSize: 16,
                dotSize: 8,
                buttonPaddingXSHorizontal: 11,
                buttonPaddingXSVertical: 3,
                buttonPaddingDefaultHorizontal: 15,
                buttonPaddingDefaultVertical: 5,
                buttonPaddingLargeHorizontal: 23,
                buttonPaddingLargeVertical: 7,
                lineWidth: token.lineWidth,
                colorPrimary: token.colorPrimary,
                colorBorder: token.colorBorder,
                colorBgContainer: token.colorBgContainer,
                radioColor: token.colorPrimary,
                radioBgColor: token.colorBgContainer,
                colorBgContainerDisabled: token.colorBgDisabled,
                colorBorderDisabled: token.colorBorder,
                colorTextDisabled: token.colorTextDisabled,
                dotColorDisabled: token.colorTextDisabled,
                paddingXS: token.paddingXS,
                wrapperMarginInlineEnd: token.paddingXS,
                motionDurationMid: token.motionDurationMid,
                motionDurationSlow: token.motionDurationSlow,
                buttonBg: token.colorBgContainer,
                buttonCheckedBg: token.colorBgContainer,
                buttonCheckedBgDisabled: token.colorBgDisabled,
                buttonCheckedColorDisabled: token.colorTextDisabled,
                buttonColor: token.colorText,
                buttonPaddingInline: token.paddingMD,
                buttonSolidCheckedActiveBg: token.colorPrimaryActive,
                buttonSolidCheckedBg: token.colorPrimary,
                buttonSolidCheckedColor: token.colorTextLightSolid,
                buttonSolidCheckedHoverBg: token.colorPrimaryHover
            )
        }
    }
}
