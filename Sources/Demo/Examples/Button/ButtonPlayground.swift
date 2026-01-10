import SwiftUI
import MoinUI

// MARK: - ButtonPlayground

/// 按钮 Playground 视图
struct ButtonPlayground: View {
    @Localized var tr
    @StateObject private var state = ButtonPlaygroundState()
    @ObservedObject private var config = Moin.ConfigProvider.shared
    @State private var selectedTab: PlaygroundPanelTab = .props

    private var defaultText: String {
        tr("playground.default_text")
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

            // 右侧：属性/Token 控制面板
            VStack(spacing: 0) {
                // Tab 切换
                HStack(spacing: 0) {
                    ForEach(PlaygroundPanelTab.allCases, id: \.self) { tab in
                        Button {
                            selectedTab = tab
                        } label: {
                            Text(tr(tab.titleKey))
                                .font(.system(size: 12, weight: selectedTab == tab ? .medium : .regular))
                                .foregroundStyle(selectedTab == tab ? config.token.colorPrimary : .secondary)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, Moin.Constants.Spacing.sm)
                                .contentShape(Rectangle())
                        }
                        .buttonStyle(.plain)
                        .background(selectedTab == tab ? config.token.colorPrimary.opacity(0.1) : .clear)
                    }
                }
                .background(Color(nsColor: .controlBackgroundColor))

                Divider()

                // Tab 内容
                if selectedTab == .props {
                    propsPanel
                } else {
                    tokenPanel
                }
            }
            .frame(width: 320)
        }
        .background(Color(nsColor: .controlBackgroundColor))
        .cornerRadius(Moin.Constants.Radius.md)
        .overlay(
            RoundedRectangle(cornerRadius: Moin.Constants.Radius.md)
                .stroke(Color.primary.opacity(0.1), lineWidth: 1)
        )
    }

    // MARK: - Preview Section

    private var previewSection: some View {
        VStack(spacing: Moin.Constants.Spacing.sm) {
            HStack {
                Text(tr("playground.preview"))
                    .font(.system(size: 11, weight: .medium))
                    .foregroundStyle(.secondary)
                Spacer()
            }

            Spacer()

            // 按钮预览
            if state.hasIcon && state.title.isEmpty {
                Moin.Button(
                    icon: state.icon,
                    color: state.useCustomColor ? .custom(state.customColor) : state.color,
                    size: state.size,
                    variant: state.variant,
                    shape: state.shape,
                    loading: Moin.ButtonLoading(state.isLoading),
                    isDisabled: state.isDisabled,
                    isGhost: state.isGhost
                ) {}
            } else {
                Moin.Button(
                    state.title.isEmpty ? defaultText : state.title,
                    color: state.useCustomColor ? .custom(state.customColor) : state.color,
                    size: state.size,
                    variant: state.variant,
                    shape: state.shape,
                    icon: state.hasIcon ? state.icon : nil,
                    iconPlacement: state.iconPlacement,
                    loading: Moin.ButtonLoading(state.isLoading),
                    isDisabled: state.isDisabled,
                    isBlock: state.isBlock,
                    isGhost: state.isGhost
                ) {}
                .frame(maxWidth: state.isBlock ? .infinity : nil)
                .padding(.horizontal, state.isBlock ? Moin.Constants.Spacing.xl : 0)
            }

            Spacer()
        }
        .padding(Moin.Constants.Spacing.md)
        .frame(maxWidth: .infinity, minHeight: 120)
    }

    // MARK: - Props Panel

    private var propsPanel: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.md) {
                HStack {
                    Text(tr("playground.props"))
                        .font(.system(size: 11, weight: .medium))
                        .foregroundStyle(.secondary)
                    Spacer()
                }

                VStack(spacing: Moin.Constants.Spacing.sm) {
                    TextPropControl(
                        label: tr("playground.prop.title"),
                        propName: tr("playground.prop.title_prop"),
                        value: $state.title
                    )

                    SelectPropControl(
                        label: tr("playground.prop.type"),
                        propName: tr("playground.prop.type_prop"),
                        options: Moin.ButtonColor.allCases,
                        value: $state.color
                    )
                    .disabled(state.useCustomColor)
                    .opacity(state.useCustomColor ? 0.5 : 1)

                    TogglePropControl(
                        label: tr("playground.prop.custom_color"),
                        propName: tr("playground.prop.custom_color_prop"),
                        value: $state.useCustomColor
                    )

                    if state.useCustomColor {
                        ColorPropControl(
                            label: tr("playground.prop.color"),
                            propName: tr("playground.prop.color_prop"),
                            value: $state.customColor
                        )
                    }

                    SelectPropControl(
                        label: tr("playground.prop.variant"),
                        propName: tr("playground.prop.variant_prop"),
                        options: Moin.ButtonVariant.allCases,
                        value: $state.variant
                    )

                    SelectPropControl(
                        label: tr("playground.prop.size"),
                        propName: tr("playground.prop.size_prop"),
                        options: Moin.ButtonSize.allCases,
                        value: $state.size
                    )

                    SelectPropControl(
                        label: tr("playground.prop.shape"),
                        propName: tr("playground.prop.shape_prop"),
                        options: Moin.ButtonShape.allCases,
                        value: $state.shape
                    )

                    TextPropControl(
                        label: tr("playground.prop.icon"),
                        propName: tr("playground.prop.icon_prop"),
                        value: $state.icon
                    )

                    if state.hasIcon {
                        SelectPropControl(
                            label: tr("playground.prop.icon_placement"),
                            propName: tr("playground.prop.icon_placement_prop"),
                            options: Moin.ButtonIconPlacement.allCases,
                            value: $state.iconPlacement
                        )
                    }

                    Divider()
                        .padding(.vertical, Moin.Constants.Spacing.xs)

                    TogglePropControl(
                        label: tr("playground.prop.disabled"),
                        propName: tr("playground.prop.disabled_prop"),
                        value: $state.isDisabled
                    )

                    TogglePropControl(
                        label: tr("playground.prop.loading"),
                        propName: tr("playground.prop.loading_prop"),
                        value: $state.isLoading
                    )

                    TogglePropControl(
                        label: tr("playground.prop.block"),
                        propName: tr("playground.prop.block_prop"),
                        value: $state.isBlock
                    )

                    TogglePropControl(
                        label: tr("playground.prop.ghost"),
                        propName: tr("playground.prop.ghost_prop"),
                        value: $state.isGhost
                    )
                }
            }
            .padding(Moin.Constants.Spacing.md)
        }
    }

    // MARK: - Token Panel

    private var tokenPanel: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.md) {
                // 重置按钮
                HStack {
                    Spacer()
                    Button {
                        config.components.button = config.isDarkMode ? .dark : .light
                        config.token = config.isDarkMode ? .dark : .light
                    } label: {
                        HStack(spacing: 4) {
                            Image(systemName: "arrow.counterclockwise")
                            Text(tr("playground.token.reset"))
                        }
                        .font(.system(size: 11))
                        .foregroundStyle(.secondary)
                    }
                    .buttonStyle(.plain)
                }

                // Component Token
                VStack(alignment: .leading, spacing: Moin.Constants.Spacing.sm) {
                    Text(tr("playground.token.component"))
                        .font(.system(size: 11, weight: .medium))
                        .foregroundStyle(.secondary)

                    TokenColorRow(
                        label: "defaultColor",
                        color: $config.components.button.defaultColor
                    )
                    TokenColorRow(
                        label: "defaultBg",
                        color: $config.components.button.defaultBg
                    )
                    TokenColorRow(
                        label: "defaultBorderColor",
                        color: $config.components.button.defaultBorderColor
                    )
                    TokenColorRow(
                        label: "primaryColor",
                        color: $config.components.button.primaryColor
                    )
                    TokenColorRow(
                        label: "dangerColor",
                        color: $config.components.button.dangerColor
                    )
                    TokenDisplayRow(
                        label: "fontWeight",
                        value: ".medium"
                    )
                    TokenValueRow(
                        label: "iconGap",
                        value: $config.components.button.iconGap,
                        range: 0...20
                    )
                    TokenValueRow(
                        label: "paddingInline",
                        value: $config.components.button.paddingInline,
                        range: 0...30
                    )
                    TokenValueRow(
                        label: "paddingBlock",
                        value: $config.components.button.paddingBlock,
                        range: 0...20
                    )
                }

                Divider()

                // Global Token
                VStack(alignment: .leading, spacing: Moin.Constants.Spacing.sm) {
                    Text(tr("playground.token.global"))
                        .font(.system(size: 11, weight: .medium))
                        .foregroundStyle(.secondary)

                    TokenColorRow(
                        label: "colorPrimary",
                        color: $config.token.colorPrimary
                    )
                    TokenColorRow(
                        label: "colorSuccess",
                        color: $config.token.colorSuccess
                    )
                    TokenColorRow(
                        label: "colorWarning",
                        color: $config.token.colorWarning
                    )
                    TokenColorRow(
                        label: "colorDanger",
                        color: $config.token.colorDanger
                    )
                    TokenValueRow(
                        label: "controlHeight",
                        value: $config.token.controlHeight,
                        range: 20...60
                    )
                    TokenValueRow(
                        label: "borderRadius",
                        value: $config.token.borderRadius,
                        range: 0...20
                    )
                    TokenDisplayRow(
                        label: "motionDuration",
                        value: "\(config.token.motionDuration)s"
                    )
                }
            }
            .padding(Moin.Constants.Spacing.md)
        }
    }

    // MARK: - Code Section

    private var codeSection: some View {
        VStack(alignment: .leading, spacing: Moin.Constants.Spacing.sm) {
            HStack {
                Text(tr("playground.code"))
                    .font(.system(size: 11, weight: .medium))
                    .foregroundStyle(.secondary)
                Spacer()
            }

            ScrollView(.horizontal, showsIndicators: false) {
                HighlightedCodeView(code: state.generateCode(defaultText: defaultText), fontSize: 12)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
        .padding(Moin.Constants.Spacing.md)
        .background(config.isDarkMode ? Color(white: 0.08) : Color(white: 0.96))
    }
}

// MARK: - ButtonPlaygroundState

/// 按钮 Playground 状态
class ButtonPlaygroundState: ObservableObject {
    @Published var title: String = "按钮 Button"
    @Published var color: Moin.ButtonColor = .primary
    @Published var variant: Moin.ButtonVariant = .solid
    @Published var size: Moin.ButtonSize = .medium
    @Published var shape: Moin.ButtonShape = .default
    @Published var isDisabled: Bool = false
    @Published var isLoading: Bool = false
    @Published var isBlock: Bool = false
    @Published var isGhost: Bool = false
    @Published var icon: String = "arrow.left"
    @Published var iconPlacement: Moin.ButtonIconPlacement = .start
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
            return "Moin.Button(\(params.joined(separator: ", "))) {}"
        } else {
            let indent = "    "
            return "Moin.Button(\n\(indent)\(params.joined(separator: ",\n\(indent)"))\n) {}"
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

// MARK: - 扩展枚举以支持 Playground

extension Moin.ButtonColor: CaseIterable, CustomStringConvertible {
    public static var allCases: [Moin.ButtonColor] {
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

extension Moin.ButtonVariant: CaseIterable, CustomStringConvertible {
    public static var allCases: [Moin.ButtonVariant] {
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

extension Moin.ButtonSize: CaseIterable, CustomStringConvertible {
    public static var allCases: [Moin.ButtonSize] {
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

extension Moin.ButtonShape: CaseIterable, CustomStringConvertible {
    public static var allCases: [Moin.ButtonShape] {
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

extension Moin.ButtonIconPlacement: CaseIterable, CustomStringConvertible {
    public static var allCases: [Moin.ButtonIconPlacement] {
        [.start, .end]
    }

    public var description: String {
        switch self {
        case .start: return "start"
        case .end: return "end"
        }
    }
}
