import SwiftUI

public extension Moin {
    struct TimelineToken {
        // MARK: - Component Token (Ant Design)

        /// 轨迹颜色 (Ant Design: colorSplit → colorBorderSecondary)
        public var tailColor: Color
        /// 轨迹宽度 (Ant Design: lineWidthBold)
        public var tailWidth: CGFloat

        /// 节点尺寸 (Ant Design: dotBorderWidth * 2 + controlHeightXS / 4)
        public var dotSize: CGFloat
        /// 节点边框宽度 (Ant Design: lineWidthBold)
        public var dotBorderWidth: CGFloat
        /// 节点背景色 (Ant Design: colorBgContainer)
        public var dotBg: Color

        /// 节点底部间距 (Ant Design: paddingLG + paddingSM)
        public var itemPaddingBottom: CGFloat
        /// 内容左侧间距 (Ant Design: paddingMD)
        public var contentInsetStart: CGFloat

        // MARK: - Factory

        public static func generate(from token: Token) -> TimelineToken {
            TimelineToken(
                tailColor: token.colorBorderSecondary,
                tailWidth: token.lineWidthBold,
                dotSize: token.lineWidthBold * 2 + token.controlHeightXS / 4,
                dotBorderWidth: token.lineWidthBold,
                dotBg: token.colorBgContainer,
                itemPaddingBottom: token.paddingLG + token.paddingSM,
                contentInsetStart: token.paddingMD
            )
        }

        public static let light = generate(from: .light)
        public static let dark = generate(from: .dark)
        public static let `default` = light
    }
}
