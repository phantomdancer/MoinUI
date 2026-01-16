import SwiftUI
import MoinUI

/// Avatar Playground 状态
class AvatarPlaygroundState: ObservableObject {
    @Published var size: AvatarSize = .default
    @Published var shape: AvatarShape = .circle
    @Published var contentType: AvatarContentType = .icon
    @Published var text: String = "U"
    @Published var hasBackgroundColor: Bool = false
    @Published var gap: CGFloat = 4
    @Published var srcUrl: String = "https://api.dicebear.com/7.x/avataaars/png?seed=demo"

    enum AvatarContentType: String, CaseIterable, CustomStringConvertible {
        case icon
        case text
        case image
        case src

        var description: String { rawValue }
    }

    /// 生成代码
    func generateCode() -> String {
        var params: [String] = []

        switch contentType {
        case .icon:
            params.append("icon: \"person\"")
        case .text:
            return generateTextCode()
        case .image:
            params.append("image: Image(systemName: \"photo\")")
        case .src:
            return generateSrcCode()
        }

        if size != .default {
            params.append("size: .\(sizeString)")
        }
        if shape != .circle {
            params.append("shape: .square")
        }
        if hasBackgroundColor {
            params.append("backgroundColor: .blue")
        }

        return "Moin.Avatar(\(params.joined(separator: ", ")))"
    }

    private func generateTextCode() -> String {
        var params: [String] = ["\"\(text)\""]
        if size != .default {
            params.append("size: .\(sizeString)")
        }
        if shape != .circle {
            params.append("shape: .square")
        }
        if hasBackgroundColor {
            params.append("backgroundColor: .blue")
        }
        if gap != 4 {
            params.append("gap: \(Int(gap))")
        }
        return "Moin.Avatar(\(params.joined(separator: ", ")))"
    }

    private func generateSrcCode() -> String {
        var params: [String] = ["src: \"\(srcUrl)\""]
        if size != .default {
            params.append("size: .\(sizeString)")
        }
        if shape != .circle {
            params.append("shape: .square")
        }
        return "Moin.Avatar(\(params.joined(separator: ", ")))"
    }

    private var sizeString: String {
        switch size {
        case .large: return "large"
        case .small: return "small"
        default: return "default"
        }
    }
}

/// Avatar Playground 视图
struct AvatarPlayground: View {
    @Localized var tr
    @StateObject private var state = AvatarPlaygroundState()
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

            HStack(spacing: 24) {
                // 单个头像
                avatarPreview

                // AvatarGroup 预览
                Moin.AvatarGroup(maxCount: 3, size: state.size, shape: state.shape) {
                    Moin.Avatar(icon: "person")
                    Moin.Avatar("A")
                    Moin.Avatar("B", backgroundColor: .blue)
                    Moin.Avatar("C")
                }
            }

            Spacer()
        }
        .padding(Moin.Constants.Spacing.md)
        .frame(maxWidth: .infinity, minHeight: 150)
    }

    @ViewBuilder
    private var avatarPreview: some View {
        switch state.contentType {
        case .icon:
            Moin.Avatar(
                icon: "person",
                size: state.size,
                shape: state.shape,
                backgroundColor: state.hasBackgroundColor ? .blue : nil
            )
        case .text:
            Moin.Avatar(
                state.text,
                size: state.size,
                shape: state.shape,
                backgroundColor: state.hasBackgroundColor ? .blue : nil,
                gap: state.gap
            )
        case .image:
            Moin.Avatar(
                image: Image(systemName: "photo"),
                size: state.size,
                shape: state.shape
            )
        case .src:
            Moin.Avatar(
                src: state.srcUrl,
                size: state.size,
                shape: state.shape
            )
        }
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
                        label: tr("avatar.prop.content_type"),
                        propName: "contentType",
                        options: AvatarPlaygroundState.AvatarContentType.allCases,
                        value: $state.contentType
                    )

                    SelectPropControl(
                        label: tr("avatar.prop.size"),
                        propName: "size: AvatarSize",
                        options: [AvatarSize.large, AvatarSize.default, AvatarSize.small],
                        value: $state.size
                    )

                    SelectPropControl(
                        label: tr("avatar.prop.shape"),
                        propName: "shape: AvatarShape",
                        options: AvatarShape.allCases,
                        value: $state.shape
                    )

                    if state.contentType == .text {
                        TextPropControl(
                            label: tr("avatar.prop.text"),
                            propName: "text",
                            value: $state.text
                        )

                        PropControl(label: tr("avatar.prop.gap"), propName: "gap: CGFloat") {
                            HStack(spacing: 4) {
                                Button { if state.gap > 0 { state.gap -= 1 } } label: {
                                    Image(systemName: "minus")
                                        .font(.system(size: 10))
                                        .frame(width: 20, height: 20)
                                }
                                .buttonStyle(.plain)

                                Text("\(Int(state.gap))")
                                    .font(.system(size: 11, design: .monospaced))
                                    .frame(width: 30)

                                Button { state.gap += 1 } label: {
                                    Image(systemName: "plus")
                                        .font(.system(size: 10))
                                        .frame(width: 20, height: 20)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }

                    if state.contentType == .src {
                        TextPropControl(
                            label: tr("avatar.prop.src_url"),
                            propName: "src: String",
                            value: $state.srcUrl
                        )
                    }

                    if state.contentType != .src && state.contentType != .image {
                        TogglePropControl(
                            label: tr("avatar.prop.background_color"),
                            propName: "backgroundColor: Color?",
                            value: $state.hasBackgroundColor
                        )
                    }
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

// Make AvatarSize Hashable for Picker
extension AvatarSize: Hashable {
    public static func == (lhs: AvatarSize, rhs: AvatarSize) -> Bool {
        switch (lhs, rhs) {
        case (.large, .large), (.default, .default), (.small, .small): return true
        case (.custom(let a), .custom(let b)): return a == b
        default: return false
        }
    }

    public func hash(into hasher: inout Hasher) {
        switch self {
        case .large: hasher.combine(0)
        case .default: hasher.combine(1)
        case .small: hasher.combine(2)
        case .custom(let v): hasher.combine(v)
        }
    }
}

extension AvatarSize: CustomStringConvertible {
    public var description: String {
        switch self {
        case .large: return "large"
        case .default: return "default"
        case .small: return "small"
        case .custom(let v): return "\(Int(v))"
        }
    }
}

extension AvatarShape: CustomStringConvertible {
    public var description: String { rawValue }
}
