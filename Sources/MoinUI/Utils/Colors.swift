import SwiftUI
import AppKit

// MARK: - Moin.Colors

public extension Moin {
    /// 颜色集合 - 参考 Ant Design 色彩体系
    /// https://ant.design/docs/spec/colors
    enum Colors {
        // MARK: - 主要颜色 (level 6)

        /// 蓝色 #1677FF
        public static let blue = Color(hex: 0x1677FF)

        /// 紫色 #722ED1
        public static let purple = Color(hex: 0x722ED1)

        /// 青色 #13C2C2
        public static let cyan = Color(hex: 0x13C2C2)

        /// 绿色 #52C41A
        public static let green = Color(hex: 0x52C41A)

        /// 洋红 #EB2F96
        public static let magenta = Color(hex: 0xEB2F96)

        /// 粉色 #EB2F96 (同 magenta, deprecated)
        public static let pink = Color(hex: 0xEB2F96)

        /// 红色 #F5222D
        public static let red = Color(hex: 0xF5222D)

        /// 橙色 #FA8C16
        public static let orange = Color(hex: 0xFA8C16)

        /// 黄色 #FADB14
        public static let yellow = Color(hex: 0xFADB14)

        /// 火山色 #FA541C
        public static let volcano = Color(hex: 0xFA541C)

        /// 极客蓝 #2F54EB
        public static let geekblue = Color(hex: 0x2F54EB)

        /// 金色 #FAAD14
        public static let gold = Color(hex: 0xFAAD14)

        /// 青柠 #A0D911
        public static let lime = Color(hex: 0xA0D911)

        // MARK: - 预生成色板

        /// 蓝色色板 (1-10)
        public static let bluePalette = ColorPalette.generate(from: blue)

        /// 紫色色板
        public static let purplePalette = ColorPalette.generate(from: purple)

        /// 青色色板
        public static let cyanPalette = ColorPalette.generate(from: cyan)

        /// 绿色色板
        public static let greenPalette = ColorPalette.generate(from: green)

        /// 洋红色板
        public static let magentaPalette = ColorPalette.generate(from: magenta)

        /// 红色色板
        public static let redPalette = ColorPalette.generate(from: red)

        /// 橙色色板
        public static let orangePalette = ColorPalette.generate(from: orange)

        /// 黄色色板
        public static let yellowPalette = ColorPalette.generate(from: yellow)

        /// 火山色板
        public static let volcanoPalette = ColorPalette.generate(from: volcano)

        /// 极客蓝色板
        public static let geekbluePalette = ColorPalette.generate(from: geekblue)

        /// 金色色板
        public static let goldPalette = ColorPalette.generate(from: gold)

        /// 青柠色板
        public static let limePalette = ColorPalette.generate(from: lime)

        // MARK: - 色板级别便捷访问 (blue1-blue10, etc.)

        // Blue
        public static var blue1: Color { bluePalette[1] }
        public static var blue2: Color { bluePalette[2] }
        public static var blue3: Color { bluePalette[3] }
        public static var blue4: Color { bluePalette[4] }
        public static var blue5: Color { bluePalette[5] }
        public static var blue6: Color { bluePalette[6] }
        public static var blue7: Color { bluePalette[7] }
        public static var blue8: Color { bluePalette[8] }
        public static var blue9: Color { bluePalette[9] }
        public static var blue10: Color { bluePalette[10] }

        // Purple
        public static var purple1: Color { purplePalette[1] }
        public static var purple2: Color { purplePalette[2] }
        public static var purple3: Color { purplePalette[3] }
        public static var purple4: Color { purplePalette[4] }
        public static var purple5: Color { purplePalette[5] }
        public static var purple6: Color { purplePalette[6] }
        public static var purple7: Color { purplePalette[7] }
        public static var purple8: Color { purplePalette[8] }
        public static var purple9: Color { purplePalette[9] }
        public static var purple10: Color { purplePalette[10] }

        // Cyan
        public static var cyan1: Color { cyanPalette[1] }
        public static var cyan2: Color { cyanPalette[2] }
        public static var cyan3: Color { cyanPalette[3] }
        public static var cyan4: Color { cyanPalette[4] }
        public static var cyan5: Color { cyanPalette[5] }
        public static var cyan6: Color { cyanPalette[6] }
        public static var cyan7: Color { cyanPalette[7] }
        public static var cyan8: Color { cyanPalette[8] }
        public static var cyan9: Color { cyanPalette[9] }
        public static var cyan10: Color { cyanPalette[10] }

        // Green
        public static var green1: Color { greenPalette[1] }
        public static var green2: Color { greenPalette[2] }
        public static var green3: Color { greenPalette[3] }
        public static var green4: Color { greenPalette[4] }
        public static var green5: Color { greenPalette[5] }
        public static var green6: Color { greenPalette[6] }
        public static var green7: Color { greenPalette[7] }
        public static var green8: Color { greenPalette[8] }
        public static var green9: Color { greenPalette[9] }
        public static var green10: Color { greenPalette[10] }

        // Magenta
        public static var magenta1: Color { magentaPalette[1] }
        public static var magenta2: Color { magentaPalette[2] }
        public static var magenta3: Color { magentaPalette[3] }
        public static var magenta4: Color { magentaPalette[4] }
        public static var magenta5: Color { magentaPalette[5] }
        public static var magenta6: Color { magentaPalette[6] }
        public static var magenta7: Color { magentaPalette[7] }
        public static var magenta8: Color { magentaPalette[8] }
        public static var magenta9: Color { magentaPalette[9] }
        public static var magenta10: Color { magentaPalette[10] }

        // Red
        public static var red1: Color { redPalette[1] }
        public static var red2: Color { redPalette[2] }
        public static var red3: Color { redPalette[3] }
        public static var red4: Color { redPalette[4] }
        public static var red5: Color { redPalette[5] }
        public static var red6: Color { redPalette[6] }
        public static var red7: Color { redPalette[7] }
        public static var red8: Color { redPalette[8] }
        public static var red9: Color { redPalette[9] }
        public static var red10: Color { redPalette[10] }

        // Orange
        public static var orange1: Color { orangePalette[1] }
        public static var orange2: Color { orangePalette[2] }
        public static var orange3: Color { orangePalette[3] }
        public static var orange4: Color { orangePalette[4] }
        public static var orange5: Color { orangePalette[5] }
        public static var orange6: Color { orangePalette[6] }
        public static var orange7: Color { orangePalette[7] }
        public static var orange8: Color { orangePalette[8] }
        public static var orange9: Color { orangePalette[9] }
        public static var orange10: Color { orangePalette[10] }

        // Yellow
        public static var yellow1: Color { yellowPalette[1] }
        public static var yellow2: Color { yellowPalette[2] }
        public static var yellow3: Color { yellowPalette[3] }
        public static var yellow4: Color { yellowPalette[4] }
        public static var yellow5: Color { yellowPalette[5] }
        public static var yellow6: Color { yellowPalette[6] }
        public static var yellow7: Color { yellowPalette[7] }
        public static var yellow8: Color { yellowPalette[8] }
        public static var yellow9: Color { yellowPalette[9] }
        public static var yellow10: Color { yellowPalette[10] }

        // Volcano
        public static var volcano1: Color { volcanoPalette[1] }
        public static var volcano2: Color { volcanoPalette[2] }
        public static var volcano3: Color { volcanoPalette[3] }
        public static var volcano4: Color { volcanoPalette[4] }
        public static var volcano5: Color { volcanoPalette[5] }
        public static var volcano6: Color { volcanoPalette[6] }
        public static var volcano7: Color { volcanoPalette[7] }
        public static var volcano8: Color { volcanoPalette[8] }
        public static var volcano9: Color { volcanoPalette[9] }
        public static var volcano10: Color { volcanoPalette[10] }

        // Geekblue
        public static var geekblue1: Color { geekbluePalette[1] }
        public static var geekblue2: Color { geekbluePalette[2] }
        public static var geekblue3: Color { geekbluePalette[3] }
        public static var geekblue4: Color { geekbluePalette[4] }
        public static var geekblue5: Color { geekbluePalette[5] }
        public static var geekblue6: Color { geekbluePalette[6] }
        public static var geekblue7: Color { geekbluePalette[7] }
        public static var geekblue8: Color { geekbluePalette[8] }
        public static var geekblue9: Color { geekbluePalette[9] }
        public static var geekblue10: Color { geekbluePalette[10] }

        // Gold
        public static var gold1: Color { goldPalette[1] }
        public static var gold2: Color { goldPalette[2] }
        public static var gold3: Color { goldPalette[3] }
        public static var gold4: Color { goldPalette[4] }
        public static var gold5: Color { goldPalette[5] }
        public static var gold6: Color { goldPalette[6] }
        public static var gold7: Color { goldPalette[7] }
        public static var gold8: Color { goldPalette[8] }
        public static var gold9: Color { goldPalette[9] }
        public static var gold10: Color { goldPalette[10] }

        // Lime
        public static var lime1: Color { limePalette[1] }
        public static var lime2: Color { limePalette[2] }
        public static var lime3: Color { limePalette[3] }
        public static var lime4: Color { limePalette[4] }
        public static var lime5: Color { limePalette[5] }
        public static var lime6: Color { limePalette[6] }
        public static var lime7: Color { limePalette[7] }
        public static var lime8: Color { limePalette[8] }
        public static var lime9: Color { limePalette[9] }
        public static var lime10: Color { limePalette[10] }
    }
}


// MARK: - ColorPalette

public extension Moin {
    /// 色板 - 包含 10 级颜色
    struct ColorPalette {
        /// 10 级颜色数组 (索引 0-9 对应 level 1-10)
        public let colors: [Color]

        /// 主色 (level 6)
        public var primary: Color { colors[5] }

        /// 按索引获取颜色 (1-10)
        public subscript(level: Int) -> Color {
            guard level >= 1 && level <= 10 else { return colors[5] }
            return colors[level - 1]
        }

        /// 从主色生成色板
        /// - Parameters:
        ///   - color: 主色
        ///   - theme: 主题 (.light 或 .dark)
        ///   - backgroundColor: 暗黑主题背景色
        public static func generate(
            from color: Color,
            theme: Theme = .light,
            backgroundColor: Color = Color(hex: 0x141414)
        ) -> ColorPalette {
            let colors = ColorGenerator.generate(color: color, theme: theme, backgroundColor: backgroundColor)
            return ColorPalette(colors: colors)
        }

        public enum Theme {
            case light
            case dark
        }
    }
}


// MARK: - ColorGenerator (Ant Design Algorithm)

/// 色阶生成器 - 实现 Ant Design 色彩算法
/// https://github.com/ant-design/ant-design-colors
enum ColorGenerator {
    // MARK: - 常量

    private static let hueStep: Double = 2              // 色相阶梯
    private static let saturationStep: Double = 0.16    // 饱和度阶梯 (浅色)
    private static let saturationStep2: Double = 0.05   // 饱和度阶梯 (深色)
    private static let brightnessStep1: Double = 0.05   // 亮度阶梯 (浅色)
    private static let brightnessStep2: Double = 0.15   // 亮度阶梯 (深色)
    private static let lightColorCount = 5              // 浅色数量
    private static let darkColorCount = 4               // 深色数量

    /// 暗黑主题颜色映射
    private static let darkColorMap: [(index: Int, amount: Double)] = [
        (7, 0.15), (6, 0.25), (5, 0.30), (5, 0.45), (5, 0.65),
        (5, 0.85), (4, 0.90), (3, 0.95), (2, 0.97), (1, 0.98)
    ]

    // MARK: - 生成方法

    static func generate(
        color: Color,
        theme: Moin.ColorPalette.Theme = .light,
        backgroundColor: Color = Color(hex: 0x141414)
    ) -> [Color] {
        let hsv = color.toHSV()
        var patterns: [Color] = []

        // 生成浅色 (5个)
        for i in stride(from: lightColorCount, through: 1, by: -1) {
            let h = getHue(hsv: hsv, i: i, isLight: true)
            let s = getSaturation(hsv: hsv, i: i, isLight: true)
            let v = getValue(hsv: hsv, i: i, isLight: true)
            patterns.append(Color(hue: h / 360, saturation: s, brightness: v))
        }

        // 主色
        patterns.append(color)

        // 生成深色 (4个)
        for i in 1...darkColorCount {
            let h = getHue(hsv: hsv, i: i, isLight: false)
            let s = getSaturation(hsv: hsv, i: i, isLight: false)
            let v = getValue(hsv: hsv, i: i, isLight: false)
            patterns.append(Color(hue: h / 360, saturation: s, brightness: v))
        }

        // 暗黑主题处理
        if theme == .dark {
            return darkColorMap.enumerated().map { _, mapping in
                backgroundColor.mix(with: patterns[mapping.index - 1], amount: mapping.amount)
            }
        }

        return patterns
    }

    // MARK: - 私有方法

    /// 计算色相
    private static func getHue(hsv: HSV, i: Int, isLight: Bool) -> Double {
        var hue: Double
        let roundedH = hsv.h.rounded()

        // 根据色相范围决定转向
        if roundedH >= 60 && roundedH <= 240 {
            hue = isLight ? roundedH - hueStep * Double(i) : roundedH + hueStep * Double(i)
        } else {
            hue = isLight ? roundedH + hueStep * Double(i) : roundedH - hueStep * Double(i)
        }

        // 边界处理
        if hue < 0 {
            hue += 360
        } else if hue >= 360 {
            hue -= 360
        }

        return hue
    }

    /// 计算饱和度
    private static func getSaturation(hsv: HSV, i: Int, isLight: Bool) -> Double {
        // 灰色不调整饱和度
        if hsv.h == 0 && hsv.s == 0 {
            return hsv.s
        }

        var saturation: Double
        if isLight {
            saturation = hsv.s - saturationStep * Double(i)
        } else if i == darkColorCount {
            saturation = hsv.s + saturationStep
        } else {
            saturation = hsv.s + saturationStep2 * Double(i)
        }

        // 边界修正
        saturation = min(1, saturation)

        // 第一格 (最浅色) 的饱和度限制在 0.06-0.1
        if isLight && i == lightColorCount && saturation > 0.1 {
            saturation = 0.1
        }
        if saturation < 0.06 {
            saturation = 0.06
        }

        return (saturation * 100).rounded() / 100
    }

    /// 计算明度
    private static func getValue(hsv: HSV, i: Int, isLight: Bool) -> Double {
        var value: Double
        if isLight {
            value = hsv.v + brightnessStep1 * Double(i)
        } else {
            value = hsv.v - brightnessStep2 * Double(i)
        }

        return max(0, min(1, (value * 100).rounded() / 100))
    }
}


// MARK: - HSV Support

/// HSV 颜色模型
struct HSV {
    var h: Double  // 0-360
    var s: Double  // 0-1
    var v: Double  // 0-1
}

extension Color {
    /// 转换为 HSV (内部使用)
    func toHSV() -> HSV {
        let nsColor = NSColor(self).usingColorSpace(.sRGB) ?? NSColor(self)
        var h: CGFloat = 0
        var s: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        nsColor.getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        return HSV(h: Double(h) * 360, s: Double(s), v: Double(b))
    }

    /// 混合两种颜色 (内部使用)
    func mix(with other: Color, amount: Double) -> Color {
        let c1 = NSColor(self).usingColorSpace(.sRGB) ?? NSColor(self)
        let c2 = NSColor(other).usingColorSpace(.sRGB) ?? NSColor(other)

        var r1: CGFloat = 0, g1: CGFloat = 0, b1: CGFloat = 0, a1: CGFloat = 0
        var r2: CGFloat = 0, g2: CGFloat = 0, b2: CGFloat = 0, a2: CGFloat = 0

        c1.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
        c2.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)

        let r = r1 + (r2 - r1) * amount
        let g = g1 + (g2 - g1) * amount
        let b = b1 + (b2 - b1) * amount
        let a = a1 + (a2 - a1) * amount

        return Color(red: r, green: g, blue: b, opacity: a)
    }
}

public extension Color {
    /// 转换为 Hex 字符串
    func toHex() -> String {
        let nsColor = NSColor(self).usingColorSpace(.sRGB) ?? NSColor(self)
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        nsColor.getRed(&r, green: &g, blue: &b, alpha: &a)
        return String(format: "#%02X%02X%02X", Int(r * 255), Int(g * 255), Int(b * 255))
    }
}


// MARK: - Color Hex Extension

public extension Color {
    /// 从 16 进制整数创建颜色
    init(hex: UInt32, alpha: Double = 1.0) {
        let red = Double((hex >> 16) & 0xFF) / 255.0
        let green = Double((hex >> 8) & 0xFF) / 255.0
        let blue = Double(hex & 0xFF) / 255.0
        self.init(red: red, green: green, blue: blue, opacity: alpha)
    }

    /// 从 16 进制字符串创建颜色
    /// 支持格式：#RGB, #RRGGBB, #RRGGBBAA
    init(hex: String, alpha: Double = 1.0) {
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        if hexString.hasPrefix("#") {
            hexString.removeFirst()
        }

        var hexValue: UInt64 = 0
        guard Scanner(string: hexString).scanHexInt64(&hexValue) else {
            self.init(red: 0, green: 0, blue: 0, opacity: alpha)
            return
        }

        switch hexString.count {
        case 3: // RGB
            let r = Double((hexValue >> 8) & 0xF) / 15.0
            let g = Double((hexValue >> 4) & 0xF) / 15.0
            let b = Double(hexValue & 0xF) / 15.0
            self.init(red: r, green: g, blue: b, opacity: alpha)
        case 6: // RRGGBB
            self.init(hex: UInt32(hexValue), alpha: alpha)
        case 8: // RRGGBBAA
            let r = Double((hexValue >> 24) & 0xFF) / 255.0
            let g = Double((hexValue >> 16) & 0xFF) / 255.0
            let b = Double((hexValue >> 8) & 0xFF) / 255.0
            let a = Double(hexValue & 0xFF) / 255.0
            self.init(red: r, green: g, blue: b, opacity: a)
        default:
            self.init(red: 0, green: 0, blue: 0, opacity: alpha)
        }
    }
}


// MARK: - Color Utils Extension

public extension Color {
    /// 加深颜色
    func darkened(by amount: CGFloat = 0.1) -> Color {
        let nsColor = NSColor(self).usingColorSpace(.sRGB) ?? NSColor(self)
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        nsColor.getRed(&r, green: &g, blue: &b, alpha: &a)
        return Color(
            red: max(0, r - amount),
            green: max(0, g - amount),
            blue: max(0, b - amount),
            opacity: a
        )
    }

    /// 变浅颜色
    func lightened(by amount: CGFloat = 0.1) -> Color {
        let nsColor = NSColor(self).usingColorSpace(.sRGB) ?? NSColor(self)
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        nsColor.getRed(&r, green: &g, blue: &b, alpha: &a)
        return Color(
            red: min(1, r + amount),
            green: min(1, g + amount),
            blue: min(1, b + amount),
            opacity: a
        )
    }
}
