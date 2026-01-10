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

        // MARK: - 调色板级别便捷访问

        // Blue
        public static var blue1: ButtonColor { .custom(Moin.Colors.blue1) }
        public static var blue2: ButtonColor { .custom(Moin.Colors.blue2) }
        public static var blue3: ButtonColor { .custom(Moin.Colors.blue3) }
        public static var blue4: ButtonColor { .custom(Moin.Colors.blue4) }
        public static var blue5: ButtonColor { .custom(Moin.Colors.blue5) }
        public static var blue6: ButtonColor { .custom(Moin.Colors.blue6) }
        public static var blue7: ButtonColor { .custom(Moin.Colors.blue7) }
        public static var blue8: ButtonColor { .custom(Moin.Colors.blue8) }
        public static var blue9: ButtonColor { .custom(Moin.Colors.blue9) }
        public static var blue10: ButtonColor { .custom(Moin.Colors.blue10) }

        // Purple
        public static var purple1: ButtonColor { .custom(Moin.Colors.purple1) }
        public static var purple2: ButtonColor { .custom(Moin.Colors.purple2) }
        public static var purple3: ButtonColor { .custom(Moin.Colors.purple3) }
        public static var purple4: ButtonColor { .custom(Moin.Colors.purple4) }
        public static var purple5: ButtonColor { .custom(Moin.Colors.purple5) }
        public static var purple6: ButtonColor { .custom(Moin.Colors.purple6) }
        public static var purple7: ButtonColor { .custom(Moin.Colors.purple7) }
        public static var purple8: ButtonColor { .custom(Moin.Colors.purple8) }
        public static var purple9: ButtonColor { .custom(Moin.Colors.purple9) }
        public static var purple10: ButtonColor { .custom(Moin.Colors.purple10) }

        // Cyan
        public static var cyan1: ButtonColor { .custom(Moin.Colors.cyan1) }
        public static var cyan2: ButtonColor { .custom(Moin.Colors.cyan2) }
        public static var cyan3: ButtonColor { .custom(Moin.Colors.cyan3) }
        public static var cyan4: ButtonColor { .custom(Moin.Colors.cyan4) }
        public static var cyan5: ButtonColor { .custom(Moin.Colors.cyan5) }
        public static var cyan6: ButtonColor { .custom(Moin.Colors.cyan6) }
        public static var cyan7: ButtonColor { .custom(Moin.Colors.cyan7) }
        public static var cyan8: ButtonColor { .custom(Moin.Colors.cyan8) }
        public static var cyan9: ButtonColor { .custom(Moin.Colors.cyan9) }
        public static var cyan10: ButtonColor { .custom(Moin.Colors.cyan10) }

        // Green
        public static var green1: ButtonColor { .custom(Moin.Colors.green1) }
        public static var green2: ButtonColor { .custom(Moin.Colors.green2) }
        public static var green3: ButtonColor { .custom(Moin.Colors.green3) }
        public static var green4: ButtonColor { .custom(Moin.Colors.green4) }
        public static var green5: ButtonColor { .custom(Moin.Colors.green5) }
        public static var green6: ButtonColor { .custom(Moin.Colors.green6) }
        public static var green7: ButtonColor { .custom(Moin.Colors.green7) }
        public static var green8: ButtonColor { .custom(Moin.Colors.green8) }
        public static var green9: ButtonColor { .custom(Moin.Colors.green9) }
        public static var green10: ButtonColor { .custom(Moin.Colors.green10) }

        // Magenta
        public static var magenta1: ButtonColor { .custom(Moin.Colors.magenta1) }
        public static var magenta2: ButtonColor { .custom(Moin.Colors.magenta2) }
        public static var magenta3: ButtonColor { .custom(Moin.Colors.magenta3) }
        public static var magenta4: ButtonColor { .custom(Moin.Colors.magenta4) }
        public static var magenta5: ButtonColor { .custom(Moin.Colors.magenta5) }
        public static var magenta6: ButtonColor { .custom(Moin.Colors.magenta6) }
        public static var magenta7: ButtonColor { .custom(Moin.Colors.magenta7) }
        public static var magenta8: ButtonColor { .custom(Moin.Colors.magenta8) }
        public static var magenta9: ButtonColor { .custom(Moin.Colors.magenta9) }
        public static var magenta10: ButtonColor { .custom(Moin.Colors.magenta10) }

        // Red
        public static var red1: ButtonColor { .custom(Moin.Colors.red1) }
        public static var red2: ButtonColor { .custom(Moin.Colors.red2) }
        public static var red3: ButtonColor { .custom(Moin.Colors.red3) }
        public static var red4: ButtonColor { .custom(Moin.Colors.red4) }
        public static var red5: ButtonColor { .custom(Moin.Colors.red5) }
        public static var red6: ButtonColor { .custom(Moin.Colors.red6) }
        public static var red7: ButtonColor { .custom(Moin.Colors.red7) }
        public static var red8: ButtonColor { .custom(Moin.Colors.red8) }
        public static var red9: ButtonColor { .custom(Moin.Colors.red9) }
        public static var red10: ButtonColor { .custom(Moin.Colors.red10) }

        // Orange
        public static var orange1: ButtonColor { .custom(Moin.Colors.orange1) }
        public static var orange2: ButtonColor { .custom(Moin.Colors.orange2) }
        public static var orange3: ButtonColor { .custom(Moin.Colors.orange3) }
        public static var orange4: ButtonColor { .custom(Moin.Colors.orange4) }
        public static var orange5: ButtonColor { .custom(Moin.Colors.orange5) }
        public static var orange6: ButtonColor { .custom(Moin.Colors.orange6) }
        public static var orange7: ButtonColor { .custom(Moin.Colors.orange7) }
        public static var orange8: ButtonColor { .custom(Moin.Colors.orange8) }
        public static var orange9: ButtonColor { .custom(Moin.Colors.orange9) }
        public static var orange10: ButtonColor { .custom(Moin.Colors.orange10) }

        // Yellow
        public static var yellow1: ButtonColor { .custom(Moin.Colors.yellow1) }
        public static var yellow2: ButtonColor { .custom(Moin.Colors.yellow2) }
        public static var yellow3: ButtonColor { .custom(Moin.Colors.yellow3) }
        public static var yellow4: ButtonColor { .custom(Moin.Colors.yellow4) }
        public static var yellow5: ButtonColor { .custom(Moin.Colors.yellow5) }
        public static var yellow6: ButtonColor { .custom(Moin.Colors.yellow6) }
        public static var yellow7: ButtonColor { .custom(Moin.Colors.yellow7) }
        public static var yellow8: ButtonColor { .custom(Moin.Colors.yellow8) }
        public static var yellow9: ButtonColor { .custom(Moin.Colors.yellow9) }
        public static var yellow10: ButtonColor { .custom(Moin.Colors.yellow10) }

        // Volcano
        public static var volcano1: ButtonColor { .custom(Moin.Colors.volcano1) }
        public static var volcano2: ButtonColor { .custom(Moin.Colors.volcano2) }
        public static var volcano3: ButtonColor { .custom(Moin.Colors.volcano3) }
        public static var volcano4: ButtonColor { .custom(Moin.Colors.volcano4) }
        public static var volcano5: ButtonColor { .custom(Moin.Colors.volcano5) }
        public static var volcano6: ButtonColor { .custom(Moin.Colors.volcano6) }
        public static var volcano7: ButtonColor { .custom(Moin.Colors.volcano7) }
        public static var volcano8: ButtonColor { .custom(Moin.Colors.volcano8) }
        public static var volcano9: ButtonColor { .custom(Moin.Colors.volcano9) }
        public static var volcano10: ButtonColor { .custom(Moin.Colors.volcano10) }

        // Geekblue
        public static var geekblue1: ButtonColor { .custom(Moin.Colors.geekblue1) }
        public static var geekblue2: ButtonColor { .custom(Moin.Colors.geekblue2) }
        public static var geekblue3: ButtonColor { .custom(Moin.Colors.geekblue3) }
        public static var geekblue4: ButtonColor { .custom(Moin.Colors.geekblue4) }
        public static var geekblue5: ButtonColor { .custom(Moin.Colors.geekblue5) }
        public static var geekblue6: ButtonColor { .custom(Moin.Colors.geekblue6) }
        public static var geekblue7: ButtonColor { .custom(Moin.Colors.geekblue7) }
        public static var geekblue8: ButtonColor { .custom(Moin.Colors.geekblue8) }
        public static var geekblue9: ButtonColor { .custom(Moin.Colors.geekblue9) }
        public static var geekblue10: ButtonColor { .custom(Moin.Colors.geekblue10) }

        // Gold
        public static var gold1: ButtonColor { .custom(Moin.Colors.gold1) }
        public static var gold2: ButtonColor { .custom(Moin.Colors.gold2) }
        public static var gold3: ButtonColor { .custom(Moin.Colors.gold3) }
        public static var gold4: ButtonColor { .custom(Moin.Colors.gold4) }
        public static var gold5: ButtonColor { .custom(Moin.Colors.gold5) }
        public static var gold6: ButtonColor { .custom(Moin.Colors.gold6) }
        public static var gold7: ButtonColor { .custom(Moin.Colors.gold7) }
        public static var gold8: ButtonColor { .custom(Moin.Colors.gold8) }
        public static var gold9: ButtonColor { .custom(Moin.Colors.gold9) }
        public static var gold10: ButtonColor { .custom(Moin.Colors.gold10) }

        // Lime
        public static var lime1: ButtonColor { .custom(Moin.Colors.lime1) }
        public static var lime2: ButtonColor { .custom(Moin.Colors.lime2) }
        public static var lime3: ButtonColor { .custom(Moin.Colors.lime3) }
        public static var lime4: ButtonColor { .custom(Moin.Colors.lime4) }
        public static var lime5: ButtonColor { .custom(Moin.Colors.lime5) }
        public static var lime6: ButtonColor { .custom(Moin.Colors.lime6) }
        public static var lime7: ButtonColor { .custom(Moin.Colors.lime7) }
        public static var lime8: ButtonColor { .custom(Moin.Colors.lime8) }
        public static var lime9: ButtonColor { .custom(Moin.Colors.lime9) }
        public static var lime10: ButtonColor { .custom(Moin.Colors.lime10) }

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

