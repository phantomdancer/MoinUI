import SwiftUI

/// 徽标颜色
public enum BadgeColor {
    case `default`
    case success
    case processing
    case warning
    case error
    case custom(Color)

    // MARK: - 预设颜色便捷访问

    /// 红色
    public static var red: BadgeColor { .custom(Moin.Colors.red) }
    /// 火山色
    public static var volcano: BadgeColor { .custom(Moin.Colors.volcano) }
    /// 橙色
    public static var orange: BadgeColor { .custom(Moin.Colors.orange) }
    /// 金色
    public static var gold: BadgeColor { .custom(Moin.Colors.gold) }
    /// 黄色
    public static var yellow: BadgeColor { .custom(Moin.Colors.yellow) }
    /// 青柠色
    public static var lime: BadgeColor { .custom(Moin.Colors.lime) }
    /// 绿色
    public static var green: BadgeColor { .custom(Moin.Colors.green) }
    /// 青色
    public static var cyan: BadgeColor { .custom(Moin.Colors.cyan) }
    /// 蓝色
    public static var blue: BadgeColor { .custom(Moin.Colors.blue) }
    /// 极客蓝
    public static var geekblue: BadgeColor { .custom(Moin.Colors.geekblue) }
    /// 紫色
    public static var purple: BadgeColor { .custom(Moin.Colors.purple) }
    /// 洋红色
    public static var magenta: BadgeColor { .custom(Moin.Colors.magenta) }
}
