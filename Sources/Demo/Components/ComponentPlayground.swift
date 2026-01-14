import SwiftUI
import MoinUI

// MARK: - Playground 通用控制组件

/// 属性控制项：带参数名显示
struct PropControl<Content: View>: View {
    let label: String
    let propName: String
    @ViewBuilder let content: () -> Content

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            HStack {
                Text(label)
                    .font(.system(size: 12))
                Spacer()
                content()
            }
            Text(propName)
                .font(.system(size: 10, design: .monospaced))
                .foregroundStyle(.tertiary)
        }
    }
}

/// 选择器控制项
struct SelectPropControl<T: Hashable & CustomStringConvertible>: View {
    let label: String
    let propName: String
    let options: [T]
    @Binding var value: T

    var body: some View {
        PropControl(label: label, propName: propName) {
            Picker("", selection: $value) {
                ForEach(options, id: \.self) { option in
                    Text(option.description).tag(option)
                }
            }
            .labelsHidden()
            .pickerStyle(.menu)
            .frame(width: 100)
        }
    }
}

/// 开关控制项
struct TogglePropControl: View {
    let label: String
    let propName: String
    @Binding var value: Bool

    var body: some View {
        PropControl(label: label, propName: propName) {
            Toggle("", isOn: $value)
                .labelsHidden()
                .toggleStyle(.switch)
                .controlSize(.small)
        }
    }
}

/// 文本输入控制项
struct TextPropControl: View {
    let label: String
    let propName: String
    @Binding var value: String

    var body: some View {
        PropControl(label: label, propName: propName) {
            TextField("", text: $value)
                .textFieldStyle(.roundedBorder)
                .frame(width: 100)
        }
    }
}

/// 颜色选择控制项
struct ColorPropControl: View {
    let label: String
    let propName: String
    @Binding var value: Color

    private let colors: [Color] = [.pink, .purple, .cyan, .orange, .mint, .teal, .indigo, .brown]

    var body: some View {
        PropControl(label: label, propName: propName) {
            HStack(spacing: 4) {
                ForEach(colors, id: \.self) { color in
                    Circle()
                        .fill(color)
                        .frame(width: 16, height: 16)
                        .overlay(
                            Circle()
                                .stroke(Color.primary, lineWidth: value == color ? 2 : 0)
                        )
                        .onTapGesture {
                            value = color
                        }
                }
            }
        }
    }
}

// MARK: - Token 编辑组件

/// 预设颜色选项
private let presetColors: [Color] = [
    Color(hex: "#1677ff"),  // Ant Design Blue
    Color(hex: "#52c41a"),  // Green
    Color(hex: "#faad14"),  // Gold
    Color(hex: "#ff4d4f"),  // Red
    Color(hex: "#722ed1"),  // Purple
    Color(hex: "#13c2c2"),  // Cyan
    Color(hex: "#eb2f96"),  // Magenta
    Color(hex: "#fa8c16"),  // Orange
]

/// Token 颜色预设选择行
struct ColorPresetRow: View {
    let label: String
    @Binding var color: Color
    var onChange: (() -> Void)?

    var body: some View {
        HStack {
            Text(label)
                .font(.system(size: 11, design: .monospaced))
                .foregroundStyle(.secondary)
            Spacer()
            HStack(spacing: 6) {
                ForEach(presetColors, id: \.self) { preset in
                    Circle()
                        .fill(preset)
                        .frame(width: 16, height: 16)
                        .overlay(
                            Circle()
                                .stroke(color == preset ? Color.primary : Color.clear, lineWidth: 2)
                        )
                        .onTapGesture {
                            color = preset
                            onChange?()
                        }
                        .onHover { hovering in
                            if hovering {
                                NSCursor.pointingHand.push()
                            } else {
                                NSCursor.pop()
                            }
                        }
                }
            }
        }
    }
}

/// Token 颜色编辑行
struct TokenColorRow: View {
    let label: String
    @Binding var color: Color
    var onChange: (() -> Void)?

    var body: some View {
        HStack {
            Text(label)
                .font(.system(size: 11, design: .monospaced))
                .foregroundStyle(.secondary)
            Spacer()
            ColorPicker("", selection: $color)
                .labelsHidden()
                .frame(width: 40)
                .onChange(of: color) { _ in
                    onChange?()
                }
        }
    }
}

/// Token 颜色展示行（只读）
struct TokenColorDisplayRow: View {
    let label: String
    let color: Color

    var body: some View {
        HStack {
            Text(label)
                .font(.system(size: 11, design: .monospaced))
                .foregroundStyle(.secondary)
            Spacer()
            RoundedRectangle(cornerRadius: 4)
                .fill(color)
                .frame(width: 40, height: 20)
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Color.primary.opacity(0.2), lineWidth: 1)
                )
        }
    }
}

/// Token 数值编辑行
struct TokenValueRow: View {
    let label: String
    @Binding var value: CGFloat
    var range: ClosedRange<CGFloat> = 0...100
    var onChange: (() -> Void)?

    @State private var minusHovered = false
    @State private var plusHovered = false

    var body: some View {
        HStack {
            Text(label)
                .font(.system(size: 11, design: .monospaced))
                .foregroundStyle(.secondary)
            Spacer()
            HStack(spacing: 4) {
                Button {
                    if value > range.lowerBound {
                        value -= 1
                        onChange?()
                    }
                } label: {
                    Image(systemName: "minus")
                        .font(.system(size: 10))
                        .frame(width: 20, height: 20)
                        .background(
                            Circle()
                                .fill(minusHovered ? Color.primary.opacity(0.1) : .clear)
                        )
                        .contentShape(Circle())
                }
                .buttonStyle(.plain)
                .onHover { hovering in
                    minusHovered = hovering
                    if hovering {
                        NSCursor.pointingHand.push()
                    } else {
                        NSCursor.pop()
                    }
                }

                Text("\(Int(value))")
                    .font(.system(size: 11, design: .monospaced))
                    .frame(width: 30)

                Button {
                    if value < range.upperBound {
                        value += 1
                        onChange?()
                    }
                } label: {
                    Image(systemName: "plus")
                        .font(.system(size: 10))
                        .frame(width: 20, height: 20)
                        .background(
                            Circle()
                                .fill(plusHovered ? Color.primary.opacity(0.1) : .clear)
                        )
                        .contentShape(Circle())
                }
                .buttonStyle(.plain)
                .onHover { hovering in
                    plusHovered = hovering
                    if hovering {
                        NSCursor.pointingHand.push()
                    } else {
                        NSCursor.pop()
                    }
                }
            }
        }
    }
}

/// Token 值展示行（只读）
struct TokenDisplayRow: View {
    let label: String
    let value: String

    var body: some View {
        HStack {
            Text(label)
                .font(.system(size: 11, design: .monospaced))
                .foregroundStyle(.secondary)
            Spacer()
            Text(value)
                .font(.system(size: 11, design: .monospaced))
                .foregroundStyle(.primary)
        }
    }
}

// MARK: - Playground 通用类型

/// Playground 右侧面板 Tab
enum PlaygroundPanelTab: String, CaseIterable {
    case props
    case token

    var titleKey: String {
        switch self {
        case .props: return "playground.tab.props"
        case .token: return "playground.tab.token"
        }
    }
}

// MARK: - ResizableContainer

/// 可调整宽度的容器，用于演示响应式布局效果
struct ResizableContainer<Content: View>: View {
    @State private var width: CGFloat
    let minWidth: CGFloat
    let maxWidth: CGFloat
    let content: Content

    init(
        initialWidth: CGFloat = 400,
        minWidth: CGFloat = 200,
        maxWidth: CGFloat = 800,
        @ViewBuilder content: () -> Content
    ) {
        self._width = State(initialValue: initialWidth)
        self.minWidth = minWidth
        self.maxWidth = maxWidth
        self.content = content()
    }

    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            // 内容区域
            VStack(alignment: .leading, spacing: 0) {
                content
            }
            .frame(width: width, alignment: .leading)
            .padding(Moin.Constants.Spacing.md)
            .background(
                RoundedRectangle(cornerRadius: Moin.Constants.Radius.sm)
                    .strokeBorder(style: StrokeStyle(lineWidth: 1, dash: [4, 4]))
                    .foregroundStyle(Color.secondary.opacity(0.5))
            )

            // 拖动手柄
            Rectangle()
                .fill(Color.clear)
                .frame(width: 12)
                .contentShape(Rectangle())
                .overlay(
                    VStack(spacing: 2) {
                        ForEach(0..<3) { _ in
                            Circle()
                                .fill(Color.secondary.opacity(0.4))
                                .frame(width: 4, height: 4)
                        }
                    }
                )
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            let newWidth = width + value.translation.width
                            width = min(max(newWidth, minWidth), maxWidth)
                        }
                )
                .onHover { hovering in
                    if hovering {
                        NSCursor.resizeLeftRight.push()
                    } else {
                        NSCursor.pop()
                    }
                }

            Spacer(minLength: 0)
        }
        .overlay(alignment: .bottomTrailing) {
            Text("\(Int(width))px")
                .font(.system(size: 10, design: .monospaced))
                .foregroundStyle(.secondary)
                .padding(.horizontal, 6)
                .padding(.vertical, 2)
                .background(Color(nsColor: .controlBackgroundColor).opacity(0.8))
                .cornerRadius(4)
                .padding(4)
        }
    }
}
