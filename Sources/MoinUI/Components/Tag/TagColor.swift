import SwiftUI

public extension Moin {
    /// Tag 颜色
    enum TagColor: Hashable {
        case `default`      // 灰色
        case success        // 绿色
        case processing     // 主色（进行中）
        case warning        // 橙色
        case error          // 红色
        case custom(SwiftUI.Color)

        /// primary 作为 processing 的别名（向后兼容）
        public static var primary: TagColor { .processing }

        // MARK: - 预设颜色便捷访问

        /// 红色
        public static var red: TagColor { .custom(Moin.Colors.red) }
        /// 火山色
        public static var volcano: TagColor { .custom(Moin.Colors.volcano) }
        /// 橙色
        public static var orange: TagColor { .custom(Moin.Colors.orange) }
        /// 金色
        public static var gold: TagColor { .custom(Moin.Colors.gold) }
        /// 黄色
        public static var yellow: TagColor { .custom(Moin.Colors.yellow) }
        /// 青柠色
        public static var lime: TagColor { .custom(Moin.Colors.lime) }
        /// 绿色
        public static var green: TagColor { .custom(Moin.Colors.green) }
        /// 青色
        public static var cyan: TagColor { .custom(Moin.Colors.cyan) }
        /// 蓝色
        public static var blue: TagColor { .custom(Moin.Colors.blue) }
        /// 极客蓝
        public static var geekblue: TagColor { .custom(Moin.Colors.geekblue) }
        /// 紫色
        public static var purple: TagColor { .custom(Moin.Colors.purple) }
        /// 洋红色
        public static var magenta: TagColor { .custom(Moin.Colors.magenta) }

        // MARK: - Properties

        /// 是否为默认颜色
        public var isDefault: Bool {
            if case .default = self { return true }
            return false
        }

        public func hash(into hasher: inout Hasher) {
            switch self {
            case .default: hasher.combine(0)
            case .success: hasher.combine(1)
            case .processing: hasher.combine(2)
            case .warning: hasher.combine(3)
            case .error: hasher.combine(4)
            case .custom(let color): hasher.combine(color.description)
            }
        }
    }
}
