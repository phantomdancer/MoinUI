import SwiftUI
import MoinUI

/// Spin Playground 状态
class SpinPlaygroundState: ObservableObject {
    @Published var spinning: Bool = true
    @Published var size: SpinSize = .default
    @Published var showTip: Bool = false
    @Published var tip: String = "Loading..."
    @Published var delay: Int = 0

    /// 生成代码
    func generateCode() -> String {
        var params: [String] = []

        if !spinning {
            params.append("spinning: false")
        }
        if size != .default {
            params.append("size: .\(size)")
        }
        if showTip && !tip.isEmpty {
            params.append("tip: \"\(tip)\"")
        }
        if delay > 0 {
            params.append("delay: \(delay)")
        }

        if params.isEmpty {
            return "Moin.Spin()"
        }
        return "Moin.Spin(\(params.joined(separator: ", ")))"
    }
}

/// Spin Playground 视图
struct SpinPlayground: View {
    @Localized var tr
    @StateObject private var state = SpinPlaygroundState()
    @ObservedObject private var config = Moin.ConfigProvider.shared

    var body: some View {
        HStack(spacing: 0) {
            VStack(spacing: 0) {
                previewSection
                Divider()
                codeSection
            }

            Divider()

            VStack(spacing: 0) {
                propsPanel
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

            ZStack {
                Moin.Spin(
                    spinning: state.spinning,
                    size: state.size,
                    tip: state.showTip ? state.tip : nil,
                    delay: state.delay > 0 ? state.delay : nil
                )
            }
            .frame(minHeight: 100)

            Spacer()
        }
        .padding(Moin.Constants.Spacing.md)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    // MARK: - Code Section

    private var codeSection: some View {
        VStack(alignment: .leading, spacing: Moin.Constants.Spacing.sm) {
            HStack {
                Text(tr("playground.code"))
                    .font(.system(size: 11, weight: .medium))
                    .foregroundStyle(.secondary)
                Spacer()
                Button {
                    NSPasteboard.general.clearContents()
                    NSPasteboard.general.setString(state.generateCode(), forType: .string)
                } label: {
                    Image(systemName: "doc.on.doc")
                        .font(.system(size: 11))
                }
                .buttonStyle(.borderless)
                .help(tr("playground.copy_code"))
            }

            ScrollView(.horizontal, showsIndicators: false) {
                Text(state.generateCode())
                    .font(.system(size: 12, design: .monospaced))
                    .foregroundStyle(.primary)
            }
        }
        .padding(Moin.Constants.Spacing.md)
        .frame(height: 80)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.black.opacity(0.03))
    }

    // MARK: - Props Panel

    private var propsPanel: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.md) {
                // Header
                HStack {
                    Text(tr("playground.props"))
                        .font(.system(size: 11, weight: .medium))
                        .foregroundStyle(.secondary)
                    Spacer()
                }

                // Spinning Toggle
                TogglePropControl(
                    label: tr("spin.prop.spinning"),
                    propName: "spinning: Bool",
                    value: $state.spinning
                )

                // Size Picker
                SelectPropControl(
                    label: tr("spin.prop.size"),
                    propName: "size: SpinSize",
                    options: SpinSize.allCases,
                    value: $state.size
                )

                Divider()

                // Tip
                TogglePropControl(
                    label: tr("spin.prop.show_tip"),
                    propName: "tip: String?",
                    value: $state.showTip
                )
                if state.showTip {
                    TextPropControl(
                        label: tr("spin.prop.tip_text"),
                        propName: "tip",
                        value: $state.tip
                    )
                }

                Divider()

                // Delay
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(tr("spin.prop.delay"))
                            .font(.system(size: 11, weight: .medium))
                            .foregroundStyle(.secondary)
                        Spacer()
                        Text("\(state.delay)ms")
                            .font(.system(size: 11, design: .monospaced))
                            .foregroundStyle(.tertiary)
                    }
                    Slider(value: Binding(
                        get: { Double(state.delay) },
                        set: { state.delay = Int($0) }
                    ), in: 0...2000, step: 100)
                }

                Divider()

                // Token Section
                HStack {
                    Text(tr("playground.token.component"))
                        .font(.system(size: 11, weight: .medium))
                        .foregroundStyle(.secondary)
                    Spacer()
                }

                ColorPresetRow(
                    label: "dotColor",
                    color: $config.components.spin.dotColor
                )
                ColorPresetRow(
                    label: "tipColor",
                    color: $config.components.spin.tipColor
                )
                TokenValueRow(
                    label: "dotSize",
                    value: $config.components.spin.dotSize,
                    range: 10...40
                )
                TokenValueRow(
                    label: "motionDuration",
                    value: Binding(
                        get: { CGFloat(config.components.spin.motionDuration) },
                        set: { config.components.spin.motionDuration = Double($0) }
                    ),
                    range: 0.5...3.0
                )
            }
            .padding(Moin.Constants.Spacing.md)
        }
    }
}

// MARK: - Preview

#Preview("Spin Playground") {
    SpinPlayground()
        .frame(width: 800, height: 500)
        .padding()
}
