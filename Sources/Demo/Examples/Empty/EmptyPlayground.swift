import SwiftUI
import MoinUI

/// Empty Playground 状态
class EmptyPlaygroundState: ObservableObject {
    @Published var imageType: EmptyImageType = .default
    @Published var showDescription: Bool = true
    @Published var descriptionText: String = "暂无数据"
    @Published var showAction: Bool = false

    enum EmptyImageType: String, CaseIterable, CustomStringConvertible {
        case `default`
        case simple
        case folder
        case search
        case none

        var description: String { rawValue }
    }

    /// 生成代码
    func generateCode() -> String {
        var params: [String] = []

        switch imageType {
        case .default:
            break
        case .simple:
            params.append("image: .simple")
        case .folder:
            params.append("image: .systemIcon(\"folder\")")
        case .search:
            params.append("image: .systemIcon(\"magnifyingglass\")")
        case .none:
            params.append("image: .none")
        }

        if showDescription {
            params.append("description: \"\(descriptionText)\"")
        } else {
            params.append("description: \"\"")
        }

        if showAction {
            let paramsStr = params.isEmpty ? "" : params.joined(separator: ", ")
            return """
            Moin.Empty(\(paramsStr)) {
                Moin.Button("立即创建", type: .primary) {}
            }
            """
        }

        return "Moin.Empty(\(params.joined(separator: ", ")))"
    }
}

/// Empty Playground 视图
struct EmptyPlayground: View {
    @Localized var tr
    @StateObject private var state = EmptyPlaygroundState()
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

    var previewSection: some View {
        VStack(spacing: Moin.Constants.Spacing.sm) {
            HStack {
                Text(tr("playground.preview"))
                    .font(.system(size: 11, weight: .medium))
                    .foregroundStyle(.secondary)
                Spacer()
            }

            Spacer()
            emptyPreview
            Spacer()
        }
        .padding(Moin.Constants.Spacing.md)
        .frame(maxWidth: .infinity, minHeight: 200)
    }

    @ViewBuilder
    var emptyPreview: some View {
        let description = state.showDescription ? state.descriptionText : ""

        if state.showAction {
            emptyWithAction(description: description)
        } else {
            emptyWithoutAction(description: description)
        }
    }

    private func emptyWithAction(description: String?) -> some View {
        let imageType: Moin.Empty<Moin.Button<Text>>.ImageType = imageTypeValue()
        return Moin.Empty(image: imageType, description: description) {
            Moin.Button(tr("empty.create_now"), color: .primary) {}
        }
    }

    private func emptyWithoutAction(description: String?) -> some View {
        let imageType: Moin.Empty<EmptyView>.ImageType = imageTypeValue()
        return Moin.Empty(image: imageType, description: description)
    }

    private func imageTypeValue<T: View>() -> Moin.Empty<T>.ImageType {
        switch state.imageType {
        case .default: return .default
        case .simple: return .simple
        case .folder: return .systemIcon("folder")
        case .search: return .systemIcon("magnifyingglass")
        case .none: return .none
        }
    }
}

// MARK: - Props Panel

extension EmptyPlayground {
    var propsPanel: some View {
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
                        label: tr("empty.prop.image_type"),
                        propName: "image",
                        options: EmptyPlaygroundState.EmptyImageType.allCases,
                        value: $state.imageType
                    )

                    TogglePropControl(
                        label: tr("empty.prop.show_description"),
                        propName: "description",
                        value: $state.showDescription
                    )

                    if state.showDescription {
                        TextPropControl(
                            label: tr("empty.prop.description_text"),
                            propName: "description",
                            value: $state.descriptionText
                        )
                    }

                    TogglePropControl(
                        label: tr("empty.prop.show_action"),
                        propName: "content",
                        value: $state.showAction
                    )
                }
            }
            .padding(Moin.Constants.Spacing.md)
        }
    }
}

// MARK: - Code Section

extension EmptyPlayground {
    var codeSection: some View {
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
