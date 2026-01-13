import SwiftUI
import MoinUI

/// Typography Playground State
class TypographyPlaygroundState: ObservableObject {
    // Title settings
    @Published var titleLevel: Moin.Typography.TitleLevel = .h1
    @Published var titleType: Moin.Typography.TextType = .default
    @Published var titleDisabled = false
    @Published var titleMark = false
    @Published var titleUnderline = false
    @Published var titleDelete = false
    @Published var titleCode = false

    // Text settings
    @Published var textType: Moin.Typography.TextType = .default
    @Published var textDisabled = false
    @Published var textMark = false
    @Published var textUnderline = false
    @Published var textDelete = false
    @Published var textStrong = false
    @Published var textItalic = false
    @Published var textCode = false
    @Published var textKeyboard = false

    // Paragraph settings
    @Published var paragraphType: Moin.Typography.TextType = .default
    @Published var paragraphDisabled = false
    @Published var paragraphMark = false
    @Published var paragraphUnderline = false
    @Published var paragraphDelete = false
    @Published var paragraphStrong = false
    @Published var paragraphItalic = false
    @Published var paragraphEllipsis = false
    @Published var paragraphEllipsisRows: Int = 2

    // Link settings
    @Published var linkDisabled = false
    @Published var linkHref: String = ""

    @Published var previewMode: PreviewMode = .title

    enum PreviewMode: String, CaseIterable {
        case title
        case text
        case paragraph
        case link
    }

    func generateCode(previewTitle: String, previewText: String, previewParagraph: String, previewLink: String) -> String {
        switch previewMode {
        case .title:
            var params: [String] = ["\"\(previewTitle)\"", "level: .h\(titleLevel.rawValue)"]
            if titleType != .default { params.append("type: .\(titleType)") }
            if titleDisabled { params.append("disabled: true") }
            if titleMark { params.append("mark: true") }
            if titleUnderline { params.append("underline: true") }
            if titleDelete { params.append("delete: true") }
            if titleCode { params.append("code: true") }
            return "Moin.Typography.Title(\(params.joined(separator: ", ")))"
        case .text:
            var params: [String] = ["\"\(previewText)\""]
            if textType != .default { params.append("type: .\(textType)") }
            if textDisabled { params.append("disabled: true") }
            if textMark { params.append("mark: true") }
            if textUnderline { params.append("underline: true") }
            if textDelete { params.append("delete: true") }
            if textStrong { params.append("strong: true") }
            if textItalic { params.append("italic: true") }
            if textCode { params.append("code: true") }
            if textKeyboard { params.append("keyboard: true") }
            return "Moin.Typography.Text(\(params.joined(separator: ", ")))"
        case .paragraph:
            var params: [String] = ["\"\(previewParagraph)\""]
            if paragraphType != .default { params.append("type: .\(paragraphType)") }
            if paragraphDisabled { params.append("disabled: true") }
            if paragraphMark { params.append("mark: true") }
            if paragraphUnderline { params.append("underline: true") }
            if paragraphDelete { params.append("delete: true") }
            if paragraphStrong { params.append("strong: true") }
            if paragraphItalic { params.append("italic: true") }
            if paragraphEllipsis { params.append("ellipsis: .rows(\(paragraphEllipsisRows))") }
            return "Moin.Typography.Paragraph(\(params.joined(separator: ", ")))"
        case .link:
            var params: [String] = ["\"\(previewLink)\""]
            if !linkHref.isEmpty {
                params.append("href: URL(string: \"\(linkHref)\")")
            }
            if linkDisabled { params.append("disabled: true") }
            if linkHref.isEmpty {
                params.append("action: { }")
            }
            return "Moin.Typography.Link(\(params.joined(separator: ", ")))"
        }
    }
}

/// Typography Playground
struct TypographyPlayground: View {
    @Localized var tr
    @StateObject private var state = TypographyPlaygroundState()
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
                case .title:
                    Moin.Typography.Title(
                        tr("typography.playground.preview_title"),
                        level: state.titleLevel,
                        type: state.titleType,
                        disabled: state.titleDisabled,
                        mark: state.titleMark,
                        underline: state.titleUnderline,
                        delete: state.titleDelete,
                        code: state.titleCode
                    )
                case .text:
                    Moin.Typography.Text(
                        tr("typography.playground.preview_text"),
                        type: state.textType,
                        disabled: state.textDisabled,
                        mark: state.textMark,
                        underline: state.textUnderline,
                        delete: state.textDelete,
                        strong: state.textStrong,
                        italic: state.textItalic,
                        code: state.textCode,
                        keyboard: state.textKeyboard
                    )
                case .paragraph:
                    Moin.Typography.Paragraph(
                        tr("typography.playground.preview_paragraph"),
                        type: state.paragraphType,
                        disabled: state.paragraphDisabled,
                        mark: state.paragraphMark,
                        underline: state.paragraphUnderline,
                        delete: state.paragraphDelete,
                        strong: state.paragraphStrong,
                        italic: state.paragraphItalic,
                        ellipsis: state.paragraphEllipsis ? .rows(state.paragraphEllipsisRows) : nil
                    )
                    .frame(maxWidth: 300)
                case .link:
                    if state.linkHref.isEmpty {
                        Moin.Typography.Link(
                            tr("typography.playground.preview_link"),
                            disabled: state.linkDisabled
                        ) {
                            print("Link clicked")
                        }
                    } else {
                        Moin.Typography.Link(
                            tr("typography.playground.preview_link"),
                            href: URL(string: state.linkHref),
                            disabled: state.linkDisabled
                        )
                    }
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
                    label: tr("typography.playground.mode"),
                    propName: tr("typography.playground.preview_mode"),
                    options: TypographyPlaygroundState.PreviewMode.allCases,
                    value: $state.previewMode
                )

                Divider()
                    .padding(.vertical, Moin.Constants.Spacing.xs)

                if state.previewMode == .title {
                    titleControls
                } else if state.previewMode == .text {
                    textControls
                } else if state.previewMode == .paragraph {
                    paragraphControls
                } else {
                    linkControls
                }
            }
            .padding(Moin.Constants.Spacing.md)
        }
    }

    private var titleControls: some View {
        VStack(spacing: Moin.Constants.Spacing.sm) {
            SelectPropControl(
                label: tr("typography.playground.level"),
                propName: "level: Moin.Typography.TitleLevel",
                options: Moin.Typography.TitleLevel.allCases,
                value: $state.titleLevel
            )

            SelectPropControl(
                label: tr("typography.playground.type"),
                propName: "type: Moin.Typography.TextType",
                options: Moin.Typography.TextType.allCases,
                value: $state.titleType
            )

            TogglePropControl(label: tr("typography.playground.disabled"), propName: "disabled: Bool", value: $state.titleDisabled)
            TogglePropControl(label: tr("typography.playground.mark"), propName: "mark: Bool", value: $state.titleMark)
            TogglePropControl(label: tr("typography.playground.underline"), propName: "underline: Bool", value: $state.titleUnderline)
            TogglePropControl(label: tr("typography.playground.delete"), propName: "delete: Bool", value: $state.titleDelete)
            TogglePropControl(label: tr("typography.playground.code"), propName: "code: Bool", value: $state.titleCode)
        }
    }

    private var textControls: some View {
        VStack(spacing: Moin.Constants.Spacing.sm) {
            SelectPropControl(
                label: tr("typography.playground.type"),
                propName: "type: Moin.Typography.TextType",
                options: Moin.Typography.TextType.allCases,
                value: $state.textType
            )

            TogglePropControl(label: tr("typography.playground.disabled"), propName: "disabled: Bool", value: $state.textDisabled)
            TogglePropControl(label: tr("typography.playground.mark"), propName: "mark: Bool", value: $state.textMark)
            TogglePropControl(label: tr("typography.playground.underline"), propName: "underline: Bool", value: $state.textUnderline)
            TogglePropControl(label: tr("typography.playground.delete"), propName: "delete: Bool", value: $state.textDelete)
            TogglePropControl(label: tr("typography.playground.strong"), propName: "strong: Bool", value: $state.textStrong)
            TogglePropControl(label: tr("typography.playground.italic"), propName: "italic: Bool", value: $state.textItalic)
            TogglePropControl(label: tr("typography.playground.code"), propName: "code: Bool", value: $state.textCode)
            TogglePropControl(label: tr("typography.playground.keyboard"), propName: "keyboard: Bool", value: $state.textKeyboard)
        }
    }

    private var paragraphControls: some View {
        VStack(spacing: Moin.Constants.Spacing.sm) {
            SelectPropControl(
                label: tr("typography.playground.type"),
                propName: "type: Moin.Typography.TextType",
                options: Moin.Typography.TextType.allCases,
                value: $state.paragraphType
            )

            TogglePropControl(label: tr("typography.playground.disabled"), propName: "disabled: Bool", value: $state.paragraphDisabled)
            TogglePropControl(label: tr("typography.playground.mark"), propName: "mark: Bool", value: $state.paragraphMark)
            TogglePropControl(label: tr("typography.playground.underline"), propName: "underline: Bool", value: $state.paragraphUnderline)
            TogglePropControl(label: tr("typography.playground.delete"), propName: "delete: Bool", value: $state.paragraphDelete)
            TogglePropControl(label: tr("typography.playground.strong"), propName: "strong: Bool", value: $state.paragraphStrong)
            TogglePropControl(label: tr("typography.playground.italic"), propName: "italic: Bool", value: $state.paragraphItalic)
            TogglePropControl(label: tr("typography.playground.ellipsis"), propName: "ellipsis: EllipsisConfig?", value: $state.paragraphEllipsis)

            if state.paragraphEllipsis {
                PropControl(label: tr("typography.playground.ellipsis_rows"), propName: "rows: Int") {
                    HStack(spacing: 4) {
                        Button {
                            if state.paragraphEllipsisRows > 1 { state.paragraphEllipsisRows -= 1 }
                        } label: {
                            Image(systemName: "minus")
                                .font(.system(size: 10))
                        }
                        .buttonStyle(.plain)

                        Text("\(state.paragraphEllipsisRows)")
                            .font(.system(size: 11, design: .monospaced))
                            .frame(width: 20)

                        Button {
                            if state.paragraphEllipsisRows < 10 { state.paragraphEllipsisRows += 1 }
                        } label: {
                            Image(systemName: "plus")
                                .font(.system(size: 10))
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
        }
    }

    private var linkControls: some View {
        VStack(spacing: Moin.Constants.Spacing.sm) {
            TextPropControl(
                label: tr("typography.playground.href"),
                propName: "href: URL?",
                value: $state.linkHref
            )
            TogglePropControl(label: tr("typography.playground.disabled"), propName: "disabled: Bool", value: $state.linkDisabled)
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
                HighlightedCodeView(
                    code: state.generateCode(
                        previewTitle: tr("typography.playground.preview_title"),
                        previewText: tr("typography.playground.preview_text"),
                        previewParagraph: tr("typography.playground.preview_paragraph"),
                        previewLink: tr("typography.playground.preview_link")
                    ),
                    fontSize: 12
                )
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
        .padding(Moin.Constants.Spacing.md)
        .background(config.isDarkMode ? Color(white: 0.08) : Color(white: 0.96))
    }
}

extension Moin.Typography.TitleLevel: CustomStringConvertible {
    public var description: String { "h\(rawValue)" }
}

extension Moin.Typography.TextType: CustomStringConvertible {
    public var description: String { rawValue }
}

extension TypographyPlaygroundState.PreviewMode: CustomStringConvertible {
    var description: String { rawValue }
}
