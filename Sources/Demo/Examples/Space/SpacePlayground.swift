import SwiftUI
import MoinUI

/// Space Playground 状态
class SpacePlaygroundState: ObservableObject {
    @Published var size: Moin.SpaceSize = .medium
    @Published var direction: Moin.SpaceDirection = .horizontal
    @Published var alignment: Moin.SpaceAlignment = .center
    @Published var wrap: Bool = false
    @Published var customSize: CGFloat = 16
    @Published var useSeparator: Bool = false

    /// 生成代码
    func generateCode() -> String {
        var params: [String] = []

        if size != .medium {
            switch size {
            case .small: params.append("size: .small")
            case .large: params.append("size: .large")
            case ._custom: params.append("size: \(Int(customSize))")
            default: break
            }
        }

        if direction != .horizontal {
            params.append("direction: .vertical")
        }

        if alignment != .center {
            params.append("alignment: .\(alignment)")
        }

        if wrap {
            params.append("wrap: true")
        }

        let separatorCode = useSeparator ? ",\n    separator: { Moin.Divider(orientation: .vertical) }" : ""

        if params.isEmpty {
            return """
            Moin.Space {
                Moin.Button("Button 1", color: .primary) {}
                Moin.Button("Button 2", color: .primary) {}
                Moin.Button("Button 3", color: .primary) {}
            }
            """
        } else {
            return """
            Moin.Space(
                \(params.joined(separator: ",\n    "))\(separatorCode)
            ) {
                Moin.Button("Button 1", color: .primary) {}
                Moin.Button("Button 2", color: .primary) {}
                Moin.Button("Button 3", color: .primary) {}
            }
            """
        }
    }
}

/// Space Playground 视图
struct SpacePlayground: View {
    @Localized var tr
    @StateObject private var state = SpacePlaygroundState()
    @ObservedObject private var config = Moin.ConfigProvider.shared
    @State private var selectedTab: PlaygroundPanelTab = .props

    var body: some View {
        HStack(spacing: 0) {
            // 左侧：预览 + 代码
            VStack(spacing: 0) {
                previewSection
                Divider()
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

            // Space 预览
            let actualSize: Moin.SpaceSize = {
                switch state.size {
                case ._custom: return ._custom(state.customSize)
                default: return state.size
                }
            }()

            if state.useSeparator {
                Moin.Space(
                    size: actualSize,
                    direction: state.direction,
                    alignment: state.alignment,
                    wrap: state.wrap,
                    separator: { Moin.Divider(orientation: state.direction == .horizontal ? .vertical : .horizontal) }
                ) {
                    Moin.Button("Button 1", color: .primary) {}
                    Moin.Button("Button 2", color: .success) {}
                    Moin.Button("Button 3", color: .warning) {}
                }
                .frame(maxWidth: state.wrap ? 200 : nil)
            } else {
                Moin.Space(
                    size: actualSize,
                    direction: state.direction,
                    alignment: state.alignment,
                    wrap: state.wrap
                ) {
                    Moin.Button("Button 1", color: .primary) {}
                    Moin.Button("Button 2", color: .success) {}
                    Moin.Button("Button 3", color: .warning) {}
                }
                .frame(maxWidth: state.wrap ? 200 : nil)
            }

            Spacer()
        }
        .padding(Moin.Constants.Spacing.md)
        .frame(maxWidth: .infinity, minHeight: 150)
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
                    SelectPropControl(
                        label: tr("space.prop.size"),
                        propName: "size: Moin.SpaceSize",
                        options: Moin.SpaceSize.playgroundCases,
                        value: $state.size
                    )

                    if case ._custom = state.size {
                        PropControl(label: tr("space.prop.custom_size"), propName: "size: CGFloat") {
                            HStack(spacing: 4) {
                                Button {
                                    if state.customSize > 0 { state.customSize -= 2 }
                                } label: {
                                    Image(systemName: "minus")
                                        .font(.system(size: 10))
                                }
                                .buttonStyle(.plain)

                                Text("\(Int(state.customSize))")
                                    .font(.system(size: 11, design: .monospaced))
                                    .frame(width: 30)

                                Button {
                                    if state.customSize < 100 { state.customSize += 2 }
                                } label: {
                                    Image(systemName: "plus")
                                        .font(.system(size: 10))
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }

                    SelectPropControl(
                        label: tr("space.prop.direction"),
                        propName: "direction: Moin.SpaceDirection",
                        options: Moin.SpaceDirection.allCases,
                        value: $state.direction
                    )

                    SelectPropControl(
                        label: tr("space.prop.alignment"),
                        propName: "alignment: Moin.SpaceAlignment",
                        options: Moin.SpaceAlignment.allCases,
                        value: $state.alignment
                    )

                    TogglePropControl(
                        label: tr("space.prop.wrap"),
                        propName: "wrap: Bool",
                        value: $state.wrap
                    )
                    .disabled(state.direction == .vertical)
                    .opacity(state.direction == .vertical ? 0.5 : 1)

                    TogglePropControl(
                        label: tr("space.prop.separator"),
                        propName: "separator: () -> View",
                        value: $state.useSeparator
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
                HStack {
                    Spacer()
                    Button {
                        config.regenerateTokens()
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

                VStack(alignment: .leading, spacing: Moin.Constants.Spacing.sm) {
                    Text(tr("playground.token.component"))
                        .font(.system(size: 11, weight: .medium))
                        .foregroundStyle(.secondary)

                    TokenValueRow(
                        label: "sizeSmall",
                        value: $config.components.space.sizeSmall,
                        range: 0...40
                    )
                    TokenValueRow(
                        label: "sizeMedium",
                        value: $config.components.space.sizeMedium,
                        range: 0...40
                    )
                    TokenValueRow(
                        label: "sizeLarge",
                        value: $config.components.space.sizeLarge,
                        range: 0...40
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
                HighlightedCodeView(code: state.generateCode(), fontSize: 12)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
        .padding(Moin.Constants.Spacing.md)
        .background(config.isDarkMode ? Color(white: 0.08) : Color(white: 0.96))
    }
}

// MARK: - 扩展枚举以支持 Playground

extension Moin.SpaceSize: CustomStringConvertible {
    static var playgroundCases: [Moin.SpaceSize] {
        [.small, .medium, .large, ._custom(16)]
    }

    public var description: String {
        switch self {
        case .small: return "small"
        case .medium: return "medium"
        case .large: return "large"
        case ._custom: return "custom"
        }
    }
}

extension Moin.SpaceSize: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(description)
    }

    public static func == (lhs: Moin.SpaceSize, rhs: Moin.SpaceSize) -> Bool {
        lhs.description == rhs.description
    }
}

extension Moin.SpaceDirection: CaseIterable, CustomStringConvertible {
    public static var allCases: [Moin.SpaceDirection] {
        [.horizontal, .vertical]
    }

    public var description: String {
        switch self {
        case .horizontal: return "horizontal"
        case .vertical: return "vertical"
        }
    }
}

extension Moin.SpaceAlignment: CaseIterable, CustomStringConvertible {
    public static var allCases: [Moin.SpaceAlignment] {
        [.start, .center, .end]
    }

    public var description: String {
        switch self {
        case .start: return "start"
        case .center: return "center"
        case .end: return "end"
        }
    }
}
