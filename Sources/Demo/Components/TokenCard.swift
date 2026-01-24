import SwiftUI
import MoinUI

// MARK: - TokenCard Token卡片组件

struct TokenCard<Preview: View, Editor: View>: View {
    let name: String
    let type: String
    let defaultValue: String
    let description: String
    let sectionId: String
    @ViewBuilder let preview: () -> Preview
    @ViewBuilder let editor: (() -> Editor)?
    let code: () -> String
    
    init(
        name: String,
        type: String,
        defaultValue: String,
        description: String,
        sectionId: String,
        @ViewBuilder preview: @escaping () -> Preview,
        @ViewBuilder editor: @escaping () -> Editor,
        code: @escaping () -> String = { "" }
    ) {
        self.name = name
        self.type = type
        self.defaultValue = defaultValue
        self.description = description
        self.sectionId = sectionId
        self.preview = preview
        self.editor = editor
        self.code = code
    }
    
    init(
        name: String,
        type: String,
        defaultValue: String,
        description: String,
        sectionId: String,
        @ViewBuilder preview: @escaping () -> Preview,
        code: @escaping () -> String = { "" }
    ) where Editor == EmptyView {
        self.name = name
        self.type = type
        self.defaultValue = defaultValue
        self.description = description
        self.sectionId = sectionId
        self.preview = preview
        self.editor = nil
        self.code = code
    }
    
    @Localized var tr
    @Environment(\.moinToken) private var token
    @Environment(\.colorScheme) private var colorScheme

    private var isDarkMode: Bool { colorScheme == .dark }

    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.md) {
                // 标题行
                HStack {
                    Text(name)
                        .font(.system(size: 14, weight: .semibold, design: .monospaced))
                        .foregroundStyle(token.colorPrimary)
                        .textSelection(.enabled)
                    Text(type)
                        .font(.system(size: 12, design: .monospaced))
                        .foregroundStyle(.secondary)
                        .textSelection(.enabled)
                    Text("= \(defaultValue)")
                        .font(.system(size: 11, design: .monospaced))
                        .foregroundStyle(.tertiary)
                        .textSelection(.enabled)
                    Spacer()
                }

                Text(description)
                    .font(.system(size: 13))
                    .foregroundStyle(.secondary)
                    .textSelection(.enabled)

                // 预览
                HStack {
                    preview()
                    Spacer()
                }
                .padding(Moin.Constants.Spacing.md)
                .background(isDarkMode ? Color(white: 0.12) : Color(white: 0.98))
                .cornerRadius(Moin.Constants.Radius.sm)

                // 试一试
                if let editor = editor {
                    VStack(alignment: .trailing, spacing: 0) {
                        Text(tr("doc.try_it"))
                            .font(.system(size: 10, weight: .medium))
                            .foregroundStyle(token.colorPrimary)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 3)
                            .background(token.colorPrimary.opacity(0.15))
                            .cornerRadius(3)
                            .offset(y: 8)

                        HStack {
                            editor()
                            Spacer()
                        }
                        .padding(Moin.Constants.Spacing.md)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(token.colorPrimary.opacity(0.05))
                        .cornerRadius(Moin.Constants.Radius.sm)
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }

                // 代码
                let codeText = code()
                if !codeText.isEmpty {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HighlightedCodeView(code: codeText, fontSize: 12)
                            .padding(Moin.Constants.Spacing.sm)
                    }
                    .background(isDarkMode ? Color(white: 0.08) : Color(white: 0.96))
                    .cornerRadius(Moin.Constants.Radius.sm)
                }
            }
            .padding(Moin.Constants.Spacing.md)
            .background(Color(nsColor: .controlBackgroundColor))
            .cornerRadius(Moin.Constants.Radius.md)
            .overlay(
                RoundedRectangle(cornerRadius: Moin.Constants.Radius.md)
                    .stroke(Color.primary.opacity(0.1), lineWidth: 1)
            )
            
            // Name Tag (Ribbon replacement)
            Text(name)
                .font(.system(size: 10, weight: .medium, design: .monospaced))
                .foregroundStyle(.white)
                .padding(.horizontal, 6)
                .padding(.vertical, 2)
                .background(Color.gray.opacity(0.8))
                .clipShape(RoundedRectangle(cornerRadius: 4))
                .offset(x: -8, y: 8)
        }
        .scrollAnchor("\(sectionId).\(name)")
    }
}
