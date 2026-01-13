import SwiftUI
import MoinUI

/// Tag Playground State
class TagPlaygroundState: ObservableObject {
    @Published var text: String = "Tag"
    @Published var color: Moin.TagColor = .default
    @Published var variant: Moin.TagVariant = .filled
    @Published var showIcon: Bool = false
    @Published var closable: Bool = false

    // CheckableTag
    @Published var isChecked: Bool = false
    @Published var previewMode: PreviewMode = .tag

    enum PreviewMode: String, CaseIterable {
        case tag
        case checkable
    }

    func generateCode() -> String {
        switch previewMode {
        case .tag:
            var params: [String] = ["\"\(text)\""]
            if !isDefaultColor { params.append("color: \(colorString)") }
            if variant != .filled { params.append("variant: .\(variant)") }
            if showIcon { params.append("icon: \"tag.fill\"") }
            if closable { params.append("closable: true") }
            return "Moin.Tag(\(params.joined(separator: ", ")))"
        case .checkable:
            return "Moin.CheckableTag(\"\(text)\", isChecked: $isChecked)"
        }
    }

    private var isDefaultColor: Bool {
        if case .default = color { return true }
        return false
    }

    private var colorString: String {
        switch color {
        case .default: return ".default"
        case .success: return ".success"
        case .processing: return ".processing"
        case .warning: return ".warning"
        case .error: return ".error"
        case .custom: return ".custom(...)"
        }
    }
}

/// Tag Playground
struct TagPlayground: View {
    @Localized var tr
    @StateObject private var state = TagPlaygroundState()
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

            Group {
                switch state.previewMode {
                case .tag:
                    Moin.Tag(
                        state.text,
                        color: state.color,
                        variant: state.variant,
                        icon: state.showIcon ? "tag.fill" : nil,
                        closable: state.closable
                    ) {
                        print("Tag closed")
                    }
                case .checkable:
                    Moin.CheckableTag(state.text, isChecked: $state.isChecked)
                }
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

                // Mode selector
                SelectPropControl(
                    label: tr("tag.playground.mode"),
                    propName: "previewMode",
                    options: TagPlaygroundState.PreviewMode.allCases,
                    value: $state.previewMode
                )

                Divider()
                    .padding(.vertical, Moin.Constants.Spacing.xs)

                // Text input
                TextPropControl(
                    label: tr("tag.playground.text"),
                    propName: "text: String",
                    value: $state.text
                )

                if state.previewMode == .tag {
                    tagControls
                }
            }
            .padding(Moin.Constants.Spacing.md)
        }
    }

    private var tagControls: some View {
        VStack(spacing: Moin.Constants.Spacing.sm) {
            // Color selector
            PropControl(label: tr("tag.playground.color"), propName: "color: Moin.TagColor") {
                Picker("", selection: $state.color) {
                    Text("default").tag(Moin.TagColor.default)
                    Text("success").tag(Moin.TagColor.success)
                    Text("processing").tag(Moin.TagColor.processing)
                    Text("warning").tag(Moin.TagColor.warning)
                    Text("error").tag(Moin.TagColor.error)
                }
                .pickerStyle(.menu)
                .frame(width: 120)
            }

            // Variant selector
            SelectPropControl(
                label: tr("tag.playground.variant"),
                propName: "variant: Moin.TagVariant",
                options: Moin.TagVariant.allCases,
                value: $state.variant
            )

            TogglePropControl(label: tr("tag.playground.icon"), propName: "icon: String?", value: $state.showIcon)
            TogglePropControl(label: tr("tag.playground.closable"), propName: "closable: Bool", value: $state.closable)
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

// MARK: - Extensions

extension Moin.TagVariant: CaseIterable, CustomStringConvertible {
    public static var allCases: [Moin.TagVariant] { [.filled, .outlined, .solid, .borderless] }
    public var description: String {
        switch self {
        case .filled: return "filled"
        case .outlined: return "outlined"
        case .solid: return "solid"
        case .borderless: return "borderless"
        }
    }
}

extension TagPlaygroundState.PreviewMode: CustomStringConvertible {
    var description: String { rawValue }
}
