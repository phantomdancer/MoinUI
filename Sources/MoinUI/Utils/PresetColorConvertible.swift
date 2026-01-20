import SwiftUI

public extension Moin {
    /// 预设颜色转换协议 - 让组件颜色枚举支持标准预设色
    protocol PresetColorConvertible {
        static func custom(_ color: SwiftUI.Color) -> Self
    }
}

public extension Moin.PresetColorConvertible {
    // MARK: - 预设颜色便捷访问
    
    static var red: Self { .custom(Moin.Colors.red) }
    static var volcano: Self { .custom(Moin.Colors.volcano) }
    static var orange: Self { .custom(Moin.Colors.orange) }
    static var gold: Self { .custom(Moin.Colors.gold) }
    static var yellow: Self { .custom(Moin.Colors.yellow) }
    static var lime: Self { .custom(Moin.Colors.lime) }
    static var green: Self { .custom(Moin.Colors.green) }
    static var cyan: Self { .custom(Moin.Colors.cyan) }
    static var blue: Self { .custom(Moin.Colors.blue) }
    static var geekblue: Self { .custom(Moin.Colors.geekblue) }
    static var purple: Self { .custom(Moin.Colors.purple) }
    static var magenta: Self { .custom(Moin.Colors.magenta) }
    
    // MARK: - 调色板级别便捷访问
    
    // Blue
    static var blue1: Self { .custom(Moin.Colors.blue1) }
    static var blue2: Self { .custom(Moin.Colors.blue2) }
    static var blue3: Self { .custom(Moin.Colors.blue3) }
    static var blue4: Self { .custom(Moin.Colors.blue4) }
    static var blue5: Self { .custom(Moin.Colors.blue5) }
    static var blue6: Self { .custom(Moin.Colors.blue6) }
    static var blue7: Self { .custom(Moin.Colors.blue7) }
    static var blue8: Self { .custom(Moin.Colors.blue8) }
    static var blue9: Self { .custom(Moin.Colors.blue9) }
    static var blue10: Self { .custom(Moin.Colors.blue10) }
    
    // Purple
    static var purple1: Self { .custom(Moin.Colors.purple1) }
    static var purple2: Self { .custom(Moin.Colors.purple2) }
    static var purple3: Self { .custom(Moin.Colors.purple3) }
    static var purple4: Self { .custom(Moin.Colors.purple4) }
    static var purple5: Self { .custom(Moin.Colors.purple5) }
    static var purple6: Self { .custom(Moin.Colors.purple6) }
    static var purple7: Self { .custom(Moin.Colors.purple7) }
    static var purple8: Self { .custom(Moin.Colors.purple8) }
    static var purple9: Self { .custom(Moin.Colors.purple9) }
    static var purple10: Self { .custom(Moin.Colors.purple10) }
    
    // Cyan
    static var cyan1: Self { .custom(Moin.Colors.cyan1) }
    static var cyan2: Self { .custom(Moin.Colors.cyan2) }
    static var cyan3: Self { .custom(Moin.Colors.cyan3) }
    static var cyan4: Self { .custom(Moin.Colors.cyan4) }
    static var cyan5: Self { .custom(Moin.Colors.cyan5) }
    static var cyan6: Self { .custom(Moin.Colors.cyan6) }
    static var cyan7: Self { .custom(Moin.Colors.cyan7) }
    static var cyan8: Self { .custom(Moin.Colors.cyan8) }
    static var cyan9: Self { .custom(Moin.Colors.cyan9) }
    static var cyan10: Self { .custom(Moin.Colors.cyan10) }
    
    // Green
    static var green1: Self { .custom(Moin.Colors.green1) }
    static var green2: Self { .custom(Moin.Colors.green2) }
    static var green3: Self { .custom(Moin.Colors.green3) }
    static var green4: Self { .custom(Moin.Colors.green4) }
    static var green5: Self { .custom(Moin.Colors.green5) }
    static var green6: Self { .custom(Moin.Colors.green6) }
    static var green7: Self { .custom(Moin.Colors.green7) }
    static var green8: Self { .custom(Moin.Colors.green8) }
    static var green9: Self { .custom(Moin.Colors.green9) }
    static var green10: Self { .custom(Moin.Colors.green10) }
    
    // Magenta
    static var magenta1: Self { .custom(Moin.Colors.magenta1) }
    static var magenta2: Self { .custom(Moin.Colors.magenta2) }
    static var magenta3: Self { .custom(Moin.Colors.magenta3) }
    static var magenta4: Self { .custom(Moin.Colors.magenta4) }
    static var magenta5: Self { .custom(Moin.Colors.magenta5) }
    static var magenta6: Self { .custom(Moin.Colors.magenta6) }
    static var magenta7: Self { .custom(Moin.Colors.magenta7) }
    static var magenta8: Self { .custom(Moin.Colors.magenta8) }
    static var magenta9: Self { .custom(Moin.Colors.magenta9) }
    static var magenta10: Self { .custom(Moin.Colors.magenta10) }
    
    // Red
    static var red1: Self { .custom(Moin.Colors.red1) }
    static var red2: Self { .custom(Moin.Colors.red2) }
    static var red3: Self { .custom(Moin.Colors.red3) }
    static var red4: Self { .custom(Moin.Colors.red4) }
    static var red5: Self { .custom(Moin.Colors.red5) }
    static var red6: Self { .custom(Moin.Colors.red6) }
    static var red7: Self { .custom(Moin.Colors.red7) }
    static var red8: Self { .custom(Moin.Colors.red8) }
    static var red9: Self { .custom(Moin.Colors.red9) }
    static var red10: Self { .custom(Moin.Colors.red10) }
    
    // Orange
    static var orange1: Self { .custom(Moin.Colors.orange1) }
    static var orange2: Self { .custom(Moin.Colors.orange2) }
    static var orange3: Self { .custom(Moin.Colors.orange3) }
    static var orange4: Self { .custom(Moin.Colors.orange4) }
    static var orange5: Self { .custom(Moin.Colors.orange5) }
    static var orange6: Self { .custom(Moin.Colors.orange6) }
    static var orange7: Self { .custom(Moin.Colors.orange7) }
    static var orange8: Self { .custom(Moin.Colors.orange8) }
    static var orange9: Self { .custom(Moin.Colors.orange9) }
    static var orange10: Self { .custom(Moin.Colors.orange10) }
    
    // Yellow
    static var yellow1: Self { .custom(Moin.Colors.yellow1) }
    static var yellow2: Self { .custom(Moin.Colors.yellow2) }
    static var yellow3: Self { .custom(Moin.Colors.yellow3) }
    static var yellow4: Self { .custom(Moin.Colors.yellow4) }
    static var yellow5: Self { .custom(Moin.Colors.yellow5) }
    static var yellow6: Self { .custom(Moin.Colors.yellow6) }
    static var yellow7: Self { .custom(Moin.Colors.yellow7) }
    static var yellow8: Self { .custom(Moin.Colors.yellow8) }
    static var yellow9: Self { .custom(Moin.Colors.yellow9) }
    static var yellow10: Self { .custom(Moin.Colors.yellow10) }
    
    // Volcano
    static var volcano1: Self { .custom(Moin.Colors.volcano1) }
    static var volcano2: Self { .custom(Moin.Colors.volcano2) }
    static var volcano3: Self { .custom(Moin.Colors.volcano3) }
    static var volcano4: Self { .custom(Moin.Colors.volcano4) }
    static var volcano5: Self { .custom(Moin.Colors.volcano5) }
    static var volcano6: Self { .custom(Moin.Colors.volcano6) }
    static var volcano7: Self { .custom(Moin.Colors.volcano7) }
    static var volcano8: Self { .custom(Moin.Colors.volcano8) }
    static var volcano9: Self { .custom(Moin.Colors.volcano9) }
    static var volcano10: Self { .custom(Moin.Colors.volcano10) }
    
    // Geekblue
    static var geekblue1: Self { .custom(Moin.Colors.geekblue1) }
    static var geekblue2: Self { .custom(Moin.Colors.geekblue2) }
    static var geekblue3: Self { .custom(Moin.Colors.geekblue3) }
    static var geekblue4: Self { .custom(Moin.Colors.geekblue4) }
    static var geekblue5: Self { .custom(Moin.Colors.geekblue5) }
    static var geekblue6: Self { .custom(Moin.Colors.geekblue6) }
    static var geekblue7: Self { .custom(Moin.Colors.geekblue7) }
    static var geekblue8: Self { .custom(Moin.Colors.geekblue8) }
    static var geekblue9: Self { .custom(Moin.Colors.geekblue9) }
    static var geekblue10: Self { .custom(Moin.Colors.geekblue10) }
    
    // Gold
    static var gold1: Self { .custom(Moin.Colors.gold1) }
    static var gold2: Self { .custom(Moin.Colors.gold2) }
    static var gold3: Self { .custom(Moin.Colors.gold3) }
    static var gold4: Self { .custom(Moin.Colors.gold4) }
    static var gold5: Self { .custom(Moin.Colors.gold5) }
    static var gold6: Self { .custom(Moin.Colors.gold6) }
    static var gold7: Self { .custom(Moin.Colors.gold7) }
    static var gold8: Self { .custom(Moin.Colors.gold8) }
    static var gold9: Self { .custom(Moin.Colors.gold9) }
    static var gold10: Self { .custom(Moin.Colors.gold10) }
    
    // Lime
    static var lime1: Self { .custom(Moin.Colors.lime1) }
    static var lime2: Self { .custom(Moin.Colors.lime2) }
    static var lime3: Self { .custom(Moin.Colors.lime3) }
    static var lime4: Self { .custom(Moin.Colors.lime4) }
    static var lime5: Self { .custom(Moin.Colors.lime5) }
    static var lime6: Self { .custom(Moin.Colors.lime6) }
    static var lime7: Self { .custom(Moin.Colors.lime7) }
    static var lime8: Self { .custom(Moin.Colors.lime8) }
    static var lime9: Self { .custom(Moin.Colors.lime9) }
    static var lime10: Self { .custom(Moin.Colors.lime10) }
}
