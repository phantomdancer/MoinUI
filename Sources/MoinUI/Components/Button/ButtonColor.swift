import SwiftUI

// MARK: - Moin.ButtonColor

public extension Moin {
    /// Button color - 支持预设色和自定义 Color
    enum ButtonColor: Hashable {
        case `default`
        case primary
        case success
        case warning
        case danger
        case info
        case custom(SwiftUI.Color)

        // MARK: - 预设颜色便捷访问

        /// 红色
        public static var red: ButtonColor { .custom(Moin.Colors.red) }
        /// 火山色
        public static var volcano: ButtonColor { .custom(Moin.Colors.volcano) }
        /// 橙色
        public static var orange: ButtonColor { .custom(Moin.Colors.orange) }
        /// 金色
        public static var gold: ButtonColor { .custom(Moin.Colors.gold) }
        /// 黄色
        public static var yellow: ButtonColor { .custom(Moin.Colors.yellow) }
        /// 青柠色
        public static var lime: ButtonColor { .custom(Moin.Colors.lime) }
        /// 绿色
        public static var green: ButtonColor { .custom(Moin.Colors.green) }
        /// 青色
        public static var cyan: ButtonColor { .custom(Moin.Colors.cyan) }
        /// 蓝色
        public static var blue: ButtonColor { .custom(Moin.Colors.blue) }
        /// 极客蓝
        public static var geekblue: ButtonColor { .custom(Moin.Colors.geekblue) }
        /// 紫色
        public static var purple: ButtonColor { .custom(Moin.Colors.purple) }
        /// 洋红色
        public static var magenta: ButtonColor { .custom(Moin.Colors.magenta) }

        // MARK: - Properties

        /// 是否为默认颜色
        public var isDefault: Bool {
            if case .default = self { return true }
            return false
        }

        public func hash(into hasher: inout Hasher) {
            switch self {
            case .default: hasher.combine(0)
            case .primary: hasher.combine(1)
            case .success: hasher.combine(2)
            case .warning: hasher.combine(3)
            case .danger: hasher.combine(4)
            case .info: hasher.combine(5)
            case .custom(let color): hasher.combine(color.description)
            }
        }
    }
}

