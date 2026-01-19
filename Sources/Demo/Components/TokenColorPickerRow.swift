import SwiftUI
import MoinUI

// MARK: - Token Color Picker Row (Dropdown)

/// 下拉式颜色选择行
struct TokenColorPickerRow: View {
    let label: String
    @Binding var color: Color
    
    // 常用预设颜色
    private let presets: [(String, Color)] = [
        ("Blue", Moin.Colors.blue),
        ("Purple", Moin.Colors.purple),
        ("Cyan", Moin.Colors.cyan),
        ("Green", Moin.Colors.green),
        ("Magenta", Moin.Colors.magenta),
        ("Pink", Moin.Colors.pink),
        ("Red", Moin.Colors.red),
        ("Orange", Moin.Colors.orange),
        ("Yellow", Moin.Colors.yellow),
        ("Volcano", Moin.Colors.volcano),
        ("GeekBlue", Moin.Colors.geekblue),
        ("Lime", Moin.Colors.lime),
        ("Gold", Moin.Colors.gold),
        ("Black", .black),
        ("White", .white),
        ("Gray", .gray),
        ("Clear", .clear)
    ]

    var body: some View {
        HStack {
            Text(label)
                .font(.system(size: 11, design: .monospaced))
                .foregroundStyle(.secondary)
            Spacer()
            
            HStack(spacing: 4) {
                // 原生拾色器（用于自定义）
                ColorPicker("", selection: $color)
                    .labelsHidden()
                    .frame(width: 20)
                
                // 下拉选择
                Picker("", selection: $color) {
                    ForEach(presets, id: \.1) { (name, presetColor) in
                        Text(name).tag(presetColor)
                    }
                }
                .labelsHidden()
                .pickerStyle(.menu)
                .frame(width: 90)
            }
        }
    }
}
