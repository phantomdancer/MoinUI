import SwiftUI

/// 预设颜色 - 参考 Ant Design 色彩体系
/// https://ant.design/docs/spec/colors
public enum PresetColors {
    // MARK: - 主要颜色

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

    /// 粉色 #EB2F96 (同 magenta)
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
}

// MARK: - Color Hex Extension

extension Color {
    /// 从 16 进制整数创建颜色
    init(hex: UInt32, alpha: Double = 1.0) {
        let red = Double((hex >> 16) & 0xFF) / 255.0
        let green = Double((hex >> 8) & 0xFF) / 255.0
        let blue = Double(hex & 0xFF) / 255.0
        self.init(red: red, green: green, blue: blue, opacity: alpha)
    }
}
