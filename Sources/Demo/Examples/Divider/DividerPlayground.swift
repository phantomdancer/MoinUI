import SwiftUI
import MoinUI

/// Divider Playground 状态
class DividerPlaygroundState: ObservableObject {
    @Published var orientation: Moin.DividerOrientation = .horizontal
    @Published var variant: Moin.DividerVariant = .solid
    @Published var titlePlacement: Moin.DividerTitlePlacement = .center
    @Published var hasText: Bool = false
    @Published var text: String = "Text"
    @Published var plain: Bool = false

    /// 生成代码
    func generateCode() -> String {
        if orientation == .vertical {
            var params: [String] = ["orientation: .vertical"]
            if variant != .solid {
                params.append("variant: .\(variant)")
            }
            return """
            Moin.Divider(\(params.joined(separator: ", ")))
                .frame(height: 20)
            """
        }

        if !hasText {
            if variant == .solid {
                return "Moin.Divider()"
            } else {
                return "Moin.Divider(variant: .\(variant))"
            }
        }

        var params: [String] = ["\"\(text)\""]
        if variant != .solid {
            params.append("variant: .\(variant)")
        }
        if titlePlacement != .center {
            params.append("titlePlacement: .\(titlePlacement)")
        }
        if plain {
            params.append("plain: true")
        }

        return "Moin.Divider(\(params.joined(separator: ", ")))"
    }
}

/// Divider Playground 视图
struct DividerPlayground: View {
    @Localized var tr
    @StateObject private var state = DividerPlaygroundState()
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
                propsTokenPanel
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

            if state.orientation == .vertical {
                HStack {
                    Text(tr("divider.playground.preview_text"))
                    if state.hasText {
                        Moin.Divider(state.text, orientation: .vertical, variant: state.variant, plain: state.plain)
                            .frame(height: 20)
                    } else {
                        Moin.Divider(orientation: .vertical, variant: state.variant)
                            .frame(height: 20)
                    }
                    Text(tr("divider.playground.preview_link"))
                        .foregroundStyle(Color.accentColor)
                }
            } else {
                VStack(alignment: .leading, spacing: 0) {
                    Text(tr("divider.playground.preview_content1"))
                        .lineLimit(1)

                    if state.hasText {
                        Moin.Divider(
                            state.text,
                            variant: state.variant,
                            titlePlacement: state.titlePlacement,
                            plain: state.plain
                        )
                    } else {
                        Moin.Divider(variant: state.variant)
                    }

                    Text(tr("divider.playground.preview_content2"))
                        .lineLimit(1)
                }
                .frame(maxWidth: 400)
            }

            Spacer()
        }
        .padding(Moin.Constants.Spacing.md)
        .frame(maxWidth: .infinity, minHeight: 150)
    }

    // MARK: - Props & Token Panel

    private var propsTokenPanel: some View {
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
                        label: tr("divider.prop.orientation"),
                        propName: "orientation: Moin.DividerOrientation",
                        options: Moin.DividerOrientation.allCases,
                        value: $state.orientation
                    )

                    SelectPropControl(
                        label: tr("divider.prop.variant"),
                        propName: "variant: Moin.DividerVariant",
                        options: Moin.DividerVariant.allCases,
                        value: $state.variant
                    )

                    TogglePropControl(
                        label: tr("divider.prop.has_text"),
                        propName: "title: String?",
                        value: $state.hasText
                    )

                    if state.hasText {
                        TextPropControl(
                            label: tr("divider.prop.text"),
                            propName: "title",
                            value: $state.text
                        )
                    }

                    if state.hasText && state.orientation == .horizontal {
                        SelectPropControl(
                            label: tr("divider.prop.title_placement"),
                            propName: "titlePlacement: Moin.DividerTitlePlacement",
                            options: Moin.DividerTitlePlacement.allCases,
                            value: $state.titlePlacement
                        )
                    }

                    if state.hasText {
                        TogglePropControl(
                            label: tr("divider.prop.plain"),
                            propName: "plain: Bool",
                            value: $state.plain
                        )
                    }
                }

                Divider()
                    .padding(.vertical, Moin.Constants.Spacing.sm)

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

                    TokenColorRow(
                        label: "lineColor",
                        color: $config.components.divider.lineColor
                    )
                    TokenColorRow(
                        label: "textColor",
                        color: $config.components.divider.textColor
                    )
                    TokenValueRow(
                        label: "fontSize",
                        value: $config.components.divider.fontSize,
                        range: 10...24
                    )
                    TokenValueRow(
                        label: "verticalMargin",
                        value: $config.components.divider.verticalMargin,
                        range: 0...40
                    )
                    TokenValueRow(
                        label: "horizontalMargin",
                        value: $config.components.divider.horizontalMargin,
                        range: 0...40
                    )
                    TokenValueRow(
                        label: "textPadding",
                        value: $config.components.divider.textPadding,
                        range: 0...40
                    )
                    TokenValueRow(
                        label: "lineWidth",
                        value: $config.components.divider.lineWidth,
                        range: 1...4
                    )
                    TokenValueRow(
                        label: "dashLength",
                        value: $config.components.divider.dashLength,
                        range: 1...20
                    )
                    TokenValueRow(
                        label: "dashGap",
                        value: $config.components.divider.dashGap,
                        range: 1...20
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

extension Moin.DividerOrientation: CustomStringConvertible {
    public var description: String { rawValue }
}

extension Moin.DividerVariant: CustomStringConvertible {
    public var description: String { rawValue }
}

extension Moin.DividerTitlePlacement: CustomStringConvertible {
    public var description: String { rawValue }
}
