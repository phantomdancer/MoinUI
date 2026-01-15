import SwiftUI

// MARK: - Line Type

public enum MoinLineType: String {
    case solid = "solid"
    case dashed = "dashed"
}

// MARK: - Motion Ease

public enum MoinMotionEase: String {
    case easeInOut = "easeInOut"
    case easeOut = "easeOut"
    case easeIn = "easeIn"
    case linear = "linear"
}

// MARK: - Moin.SeedToken

public extension Moin {
    struct SeedToken {
        // MARK: - 品牌色 (6个)
        /// 主色
        public var colorPrimary: Color
        /// 成功色
        public var colorSuccess: Color
        /// 警告色
        public var colorWarning: Color
        /// 错误色 (对应 colorDanger)
        public var colorError: Color
        /// 信息色
        public var colorInfo: Color
        /// 链接色
        public var colorLink: Color

        // MARK: - 派生基础色 (2个)
        /// 文字色派生基础
        public var colorTextBase: Color
        /// 背景色派生基础
        public var colorBgBase: Color

        // MARK: - 字体 (3个)
        /// 基础字号
        public var fontSize: CGFloat
        /// 字体族
        public var fontFamily: String
        /// 代码字体族
        public var fontFamilyCode: String

        // MARK: - 线条 (2个)
        /// 线条宽度
        public var lineWidth: CGFloat
        /// 线条样式
        public var lineType: MoinLineType

        // MARK: - 圆角 (1个)
        /// 基础圆角
        public var borderRadius: CGFloat

        // MARK: - 尺寸 (4个)
        /// 尺寸步进单位
        public var sizeUnit: CGFloat
        /// 尺寸步进
        public var sizeStep: CGFloat
        /// 弹出箭头尺寸
        public var sizePopupArrow: CGFloat
        /// 控件基础高度
        public var controlHeight: CGFloat

        // MARK: - 层级 (2个)
        /// Z轴基础值
        public var zIndexBase: Int
        /// 弹层Z轴基础值
        public var zIndexPopupBase: Int

        // MARK: - 动画 (3个)
        /// 动画开关
        public var motion: Bool
        /// 动画时长基础单位 (秒)
        public var motionUnit: Double
        /// 动画基础时长倍数
        public var motionBase: Int
        /// 缓动曲线
        public var motionEase: MoinMotionEase

        // MARK: - 其他 (2个)
        /// 图片透明度
        public var opacityImage: Double
        /// 线框模式
        public var wireframe: Bool

        public init(
            colorPrimary: Color = Moin.Colors.blue,
            colorSuccess: Color = Moin.Colors.green,
            colorWarning: Color = Moin.Colors.gold,
            colorError: Color = Moin.Colors.red,
            colorInfo: Color = Color(red: 0.55, green: 0.55, blue: 0.60),
            colorLink: Color = Moin.Colors.blue,
            colorTextBase: Color = Color(white: 0.0),
            colorBgBase: Color = Color.white,
            fontSize: CGFloat = 14,
            fontFamily: String = "-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial",
            fontFamilyCode: String = "'SFMono-Regular', Consolas, 'Liberation Mono', Menlo, Courier, monospace",
            lineWidth: CGFloat = 1,
            lineType: MoinLineType = .solid,
            borderRadius: CGFloat = 6,
            sizeUnit: CGFloat = 4,
            sizeStep: CGFloat = 4,
            sizePopupArrow: CGFloat = 16,
            controlHeight: CGFloat = 32,
            zIndexBase: Int = 0,
            zIndexPopupBase: Int = 1000,
            motion: Bool = true,
            motionUnit: Double = 0.1,
            motionBase: Int = 2,
            motionEase: MoinMotionEase = .easeInOut,
            opacityImage: Double = 1.0,
            wireframe: Bool = false
        ) {
            self.colorPrimary = colorPrimary
            self.colorSuccess = colorSuccess
            self.colorWarning = colorWarning
            self.colorError = colorError
            self.colorInfo = colorInfo
            self.colorLink = colorLink
            self.colorTextBase = colorTextBase
            self.colorBgBase = colorBgBase
            self.fontSize = fontSize
            self.fontFamily = fontFamily
            self.fontFamilyCode = fontFamilyCode
            self.lineWidth = lineWidth
            self.lineType = lineType
            self.borderRadius = borderRadius
            self.sizeUnit = sizeUnit
            self.sizeStep = sizeStep
            self.sizePopupArrow = sizePopupArrow
            self.controlHeight = controlHeight
            self.zIndexBase = zIndexBase
            self.zIndexPopupBase = zIndexPopupBase
            self.motion = motion
            self.motionUnit = motionUnit
            self.motionBase = motionBase
            self.motionEase = motionEase
            self.opacityImage = opacityImage
            self.wireframe = wireframe
        }

        public static let `default` = SeedToken()
    }
}
