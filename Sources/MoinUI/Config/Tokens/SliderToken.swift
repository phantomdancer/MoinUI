// MARK: - Moin.SliderToken

import SwiftUI

public extension Moin {
    /// Slider 滑动输入条 Token
    ///
    /// 基于 Ant Design Slider Design Token
    struct SliderToken {
        // MARK: - Sizes

        /// 控件高度
        public var controlSize: CGFloat
        /// 轨道高度
        public var railSize: CGFloat
        /// 滑块尺寸
        public var handleSize: CGFloat
        /// 滑块悬停尺寸
        public var handleSizeHover: CGFloat
        /// 滑块边框宽度
        public var handleLineWidth: CGFloat
        /// 滑块边框宽度（悬浮态）
        public var handleLineWidthHover: CGFloat
        /// 刻度点尺寸
        public var dotSize: CGFloat

        // MARK: - Rail Colors

        /// 轨道背景色
        public var railBg: Color
        /// 轨道背景色（悬浮态）
        public var railHoverBg: Color

        // MARK: - Track Colors

        /// 轨道已覆盖部分背景色
        public var trackBg: Color
        /// 轨道已覆盖部分背景色（悬浮态）
        public var trackHoverBg: Color
        /// 轨道禁用态背景色
        public var trackBgDisabled: Color

        // MARK: - Handle Colors

        /// 滑块颜色
        public var handleColor: Color
        /// 滑块悬浮态边框色
        public var handleHoverColor: Color
        /// 滑块激活态边框色
        public var handleActiveColor: Color
        /// 滑块激活态外框色
        public var handleActiveOutlineColor: Color
        /// 滑块禁用颜色
        public var handleColorDisabled: Color

        // MARK: - Dot Colors

        /// 圆点边框颜色
        public var dotBorderColor: Color
        /// 圆点激活态边框颜色
        public var dotActiveBorderColor: Color

        // MARK: - Generate

        public static func generate(from token: Token) -> SliderToken {
            let controlSize = token.controlHeightLG / 4
            let handleLineWidth = token.lineWidth + 1

            return SliderToken(
                controlSize: controlSize,
                railSize: 4,
                handleSize: controlSize,
                handleSizeHover: token.controlHeightSM / 2,
                handleLineWidth: handleLineWidth,
                handleLineWidthHover: handleLineWidth + 0.5,
                dotSize: 8,
                railBg: token.colorFillTertiary,
                railHoverBg: token.colorFillSecondary,
                trackBg: token.colorPrimaryBorder,
                trackHoverBg: token.colorPrimaryBorderHover,
                trackBgDisabled: token.colorBgDisabled,
                handleColor: token.colorPrimaryBorder,
                // hover 整个 slider 时，边框用 colorPrimaryBorderHover
                handleHoverColor: token.colorPrimaryBorderHover,
                // 拖动时边框用 colorPrimary
                handleActiveColor: token.colorPrimary,
                // Ant Design: colorPrimary 20% opacity，调整为 30% 更明显
                handleActiveOutlineColor: token.colorPrimary.opacity(0.3),
                // Ant Design: colorTextDisabled onBackground colorBgContainer -> 接近边框色
                handleColorDisabled: token.colorBorder,
                dotBorderColor: token.colorBorderSecondary,
                dotActiveBorderColor: token.colorPrimaryBorder
            )
        }

        public static let light = generate(from: .light)
        public static let dark = generate(from: .dark)
        public static let `default` = light
    }
}
