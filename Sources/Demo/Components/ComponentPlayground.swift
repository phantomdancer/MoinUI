import SwiftUI
import MoinUI

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

/// 按钮 Playground 状态
class ButtonPlaygroundState: ObservableObject {
    @Published var title: String = ""
    @Published var color: MoinUIButtonColor = .primary
    @Published var variant: MoinUIButtonVariant = .solid
    @Published var size: MoinUIButtonSize = .medium
    @Published var shape: MoinUIButtonShape = .default
    @Published var isDisabled: Bool = false
    @Published var isLoading: Bool = false
    @Published var isBlock: Bool = false
    @Published var isGhost: Bool = false
    @Published var icon: String = ""
    @Published var iconPlacement: MoinUIButtonIconPlacement = .start
    @Published var useCustomColor: Bool = false
    @Published var customColor: Color = .purple

    var hasIcon: Bool { !icon.isEmpty }

    /// 生成代码
    func generateCode(defaultText: String) -> String {
        var params: [String] = []
        let displayTitle = title.isEmpty ? defaultText : title

        // 标题
        params.append("\"\(displayTitle)\"")

        // 类型（非默认值才显示）
        if color != .default && !useCustomColor {
            params.append("color: .\(color)")
        }

        // 变体
        if variant != .solid {
            params.append("variant: .\(variant)")
        }

        // 尺寸
        if size != .medium {
            params.append("size: .\(size)")
        }

        // 形状
        if shape != .default {
            params.append("shape: .\(shape)")
        }

        // 图标
        if hasIcon {
            params.append("icon: \"\(icon)\"")
            if iconPlacement != .start {
                params.append("iconPlacement: .\(iconPlacement)")
            }
        }

        // 状态
        if isLoading {
            params.append("loading: true")
        }
        if isDisabled {
            params.append("isDisabled: true")
        }
        if isBlock {
            params.append("isBlock: true")
        }
        if isGhost {
            params.append("isGhost: true")
        }

        // 自定义颜色
        if useCustomColor {
            params.append("color: .\(colorName)")
        }

        if params.count <= 2 {
            return "MoinUIButton(\(params.joined(separator: ", "))) {}"
        } else {
            let indent = "    "
            return "MoinUIButton(\n\(indent)\(params.joined(separator: ",\n\(indent)"))\n) {}"
        }
    }

    /// 颜色名称
    var colorName: String {
        switch customColor {
        case .pink: return "pink"
        case .purple: return "purple"
        case .cyan: return "cyan"
        case .orange: return "orange"
        case .mint: return "mint"
        case .teal: return "teal"
        case .indigo: return "indigo"
        case .brown: return "brown"
        default: return "purple"
        }
    }
}

/// 按钮 Playground 视图
struct ButtonPlayground: View {
    @EnvironmentObject var localization: MoinUILocalization
    @StateObject private var state = ButtonPlaygroundState()
    @ObservedObject private var config = MoinUIConfigProvider.shared

    private var defaultText: String {
        localization.tr("playground.default_text")
    }

    var body: some View {
        HStack(spacing: 0) {
            // 左侧：预览 + 代码
            VStack(spacing: 0) {
                // 预览区域
                previewSection

                Divider()

                // 代码预览
                codeSection
            }

            Divider()

            // 右侧：属性控制面板
            controlPanel
                .frame(width: 320)
        }
        .background(Color(nsColor: .controlBackgroundColor))
        .cornerRadius(MoinUIConstants.Radius.md)
        .overlay(
            RoundedRectangle(cornerRadius: MoinUIConstants.Radius.md)
                .stroke(Color.primary.opacity(0.1), lineWidth: 1)
        )
    }

    // MARK: - Preview Section

    private var previewSection: some View {
        VStack(spacing: MoinUIConstants.Spacing.sm) {
            HStack {
                Text(localization.tr("playground.preview"))
                    .font(.system(size: 11, weight: .medium))
                    .foregroundStyle(.secondary)
                Spacer()
            }

            Spacer()

            // 按钮预览
            if state.hasIcon && state.title.isEmpty {
                MoinUIButton(
                    icon: state.icon,
                    color: state.useCustomColor ? .custom(state.customColor) : state.color,
                    size: state.size,
                    variant: state.variant,
                    shape: state.shape,
                    loading: MoinUIButtonLoading(state.isLoading),
                    isDisabled: state.isDisabled,
                    isGhost: state.isGhost
                ) {}
            } else {
                MoinUIButton(
                    state.title.isEmpty ? defaultText : state.title,
                    color: state.useCustomColor ? .custom(state.customColor) : state.color,
                    size: state.size,
                    variant: state.variant,
                    shape: state.shape,
                    icon: state.hasIcon ? state.icon : nil,
                    iconPlacement: state.iconPlacement,
                    loading: MoinUIButtonLoading(state.isLoading),
                    isDisabled: state.isDisabled,
                    isBlock: state.isBlock,
                    isGhost: state.isGhost
                ) {}
                .frame(maxWidth: state.isBlock ? .infinity : nil)
                .padding(.horizontal, state.isBlock ? MoinUIConstants.Spacing.xl : 0)
            }

            Spacer()
        }
        .padding(MoinUIConstants.Spacing.md)
        .frame(maxWidth: .infinity, minHeight: 120)
    }

    // MARK: - Control Panel

    private var controlPanel: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: MoinUIConstants.Spacing.md) {
                HStack {
                    Text(localization.tr("playground.props"))
                        .font(.system(size: 11, weight: .medium))
                        .foregroundStyle(.secondary)
                    Spacer()
                }

                VStack(spacing: MoinUIConstants.Spacing.sm) {
                    TextPropControl(
                        label: localization.tr("playground.prop.title"),
                        propName: localization.tr("playground.prop.title_prop"),
                        value: $state.title
                    )

                    SelectPropControl(
                        label: localization.tr("playground.prop.type"),
                        propName: localization.tr("playground.prop.type_prop"),
                        options: MoinUIButtonColor.allCases,
                        value: $state.color
                    )
                    .disabled(state.useCustomColor)
                    .opacity(state.useCustomColor ? 0.5 : 1)

                    TogglePropControl(
                        label: localization.tr("playground.prop.custom_color"),
                        propName: localization.tr("playground.prop.custom_color_prop"),
                        value: $state.useCustomColor
                    )

                    if state.useCustomColor {
                        ColorPropControl(
                            label: localization.tr("playground.prop.color"),
                            propName: localization.tr("playground.prop.color_prop"),
                            value: $state.customColor
                        )
                    }

                    SelectPropControl(
                        label: localization.tr("playground.prop.variant"),
                        propName: localization.tr("playground.prop.variant_prop"),
                        options: MoinUIButtonVariant.allCases,
                        value: $state.variant
                    )

                    SelectPropControl(
                        label: localization.tr("playground.prop.size"),
                        propName: localization.tr("playground.prop.size_prop"),
                        options: MoinUIButtonSize.allCases,
                        value: $state.size
                    )

                    SelectPropControl(
                        label: localization.tr("playground.prop.shape"),
                        propName: localization.tr("playground.prop.shape_prop"),
                        options: MoinUIButtonShape.allCases,
                        value: $state.shape
                    )

                    TextPropControl(
                        label: localization.tr("playground.prop.icon"),
                        propName: localization.tr("playground.prop.icon_prop"),
                        value: $state.icon
                    )

                    if state.hasIcon {
                        SelectPropControl(
                            label: localization.tr("playground.prop.icon_placement"),
                            propName: localization.tr("playground.prop.icon_placement_prop"),
                            options: MoinUIButtonIconPlacement.allCases,
                            value: $state.iconPlacement
                        )
                    }

                    Divider()
                        .padding(.vertical, MoinUIConstants.Spacing.xs)

                    TogglePropControl(
                        label: localization.tr("playground.prop.disabled"),
                        propName: localization.tr("playground.prop.disabled_prop"),
                        value: $state.isDisabled
                    )

                    TogglePropControl(
                        label: localization.tr("playground.prop.loading"),
                        propName: localization.tr("playground.prop.loading_prop"),
                        value: $state.isLoading
                    )

                    TogglePropControl(
                        label: localization.tr("playground.prop.block"),
                        propName: localization.tr("playground.prop.block_prop"),
                        value: $state.isBlock
                    )

                    TogglePropControl(
                        label: localization.tr("playground.prop.ghost"),
                        propName: localization.tr("playground.prop.ghost_prop"),
                        value: $state.isGhost
                    )
                }
            }
            .padding(MoinUIConstants.Spacing.md)
        }
    }

    // MARK: - Code Section

    private var codeSection: some View {
        VStack(alignment: .leading, spacing: MoinUIConstants.Spacing.sm) {
            HStack {
                Text(localization.tr("playground.code"))
                    .font(.system(size: 11, weight: .medium))
                    .foregroundStyle(.secondary)
                Spacer()
            }

            ScrollView(.horizontal, showsIndicators: false) {
                HighlightedCodeView(code: state.generateCode(defaultText: defaultText), fontSize: 12)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
        .padding(MoinUIConstants.Spacing.md)
        .background(config.isDarkMode ? Color(white: 0.08) : Color(white: 0.96))
    }
}

// MARK: - 扩展枚举以支持 Playground

extension MoinUIButtonColor: CaseIterable, CustomStringConvertible {
    public static var allCases: [MoinUIButtonColor] {
        [.default, .primary, .success, .warning, .danger, .info]
    }

    public var description: String {
        switch self {
        case .default: return "default"
        case .primary: return "primary"
        case .success: return "success"
        case .warning: return "warning"
        case .danger: return "danger"
        case .info: return "info"
        case .custom: return "custom"
        }
    }
}

extension MoinUIButtonVariant: CaseIterable, CustomStringConvertible {
    public static var allCases: [MoinUIButtonVariant] {
        [.solid, .outlined, .dashed, .filled, .text, .link]
    }

    public var description: String {
        switch self {
        case .solid: return "solid"
        case .outlined: return "outlined"
        case .dashed: return "dashed"
        case .filled: return "filled"
        case .text: return "text"
        case .link: return "link"
        }
    }
}

extension MoinUIButtonSize: CaseIterable, CustomStringConvertible {
    public static var allCases: [MoinUIButtonSize] {
        [.small, .medium, .large]
    }

    public var description: String {
        switch self {
        case .small: return "small"
        case .medium: return "medium"
        case .large: return "large"
        }
    }
}

extension MoinUIButtonShape: CaseIterable, CustomStringConvertible {
    public static var allCases: [MoinUIButtonShape] {
        [.default, .round, .circle]
    }

    public var description: String {
        switch self {
        case .default: return "default"
        case .round: return "round"
        case .circle: return "circle"
        }
    }
}

extension MoinUIButtonIconPlacement: CaseIterable, CustomStringConvertible {
    public static var allCases: [MoinUIButtonIconPlacement] {
        [.start, .end]
    }

    public var description: String {
        switch self {
        case .start: return "start"
        case .end: return "end"
        }
    }
}
