import SwiftUI
import MoinUI

// MARK: - ExampleSection

/// 示例区块：上下布局，效果在上，代码在下
struct ExampleSection<Content: View>: View {
    let title: String
    let description: String
    @ViewBuilder let content: () -> Content
    let code: () -> String

    @ObservedObject private var config = MoinUIConfigProvider.shared

    var body: some View {
        VStack(alignment: .leading, spacing: MoinUIConstants.Spacing.md) {
            Text(title)
                .font(.title3)
                .fontWeight(.semibold)

            Text(description)
                .font(.body)
                .foregroundStyle(.secondary)

            content()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, MoinUIConstants.Spacing.lg)

            ScrollView(.horizontal, showsIndicators: false) {
                HighlightedCodeView(code: code(), fontSize: 12)
                    .padding(MoinUIConstants.Spacing.sm)
            }
            .background(config.isDarkMode ? Color(white: 0.08) : Color(white: 0.96))
            .cornerRadius(MoinUIConstants.Radius.sm)
            .id(code())
        }
    }
}

// MARK: - APITable

struct APITable: View {
    let headers: (String, String, String, String)
    let rows: [(String, String, String, String)]
    var columnWidths: (CGFloat, CGFloat, CGFloat, CGFloat) = (140, 180, 100, 220)

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    headerCell(headers.0, width: columnWidths.0)
                    headerCell(headers.1, width: columnWidths.1)
                    headerCell(headers.2, width: columnWidths.2)
                    headerCell(headers.3, width: columnWidths.3)
                }

                Divider()

                ForEach(rows.indices, id: \.self) { index in
                    HStack(spacing: 0) {
                        bodyCell(rows[index].0, isCode: true, width: columnWidths.0)
                        bodyCell(rows[index].1, isCode: true, width: columnWidths.1)
                        bodyCell(rows[index].2, width: columnWidths.2)
                        bodyCell(rows[index].3, width: columnWidths.3)
                    }
                    .background(index % 2 == 1 ? Color.primary.opacity(0.03) : Color.clear)

                    if index < rows.count - 1 {
                        Divider()
                    }
                }
            }
            .frame(minWidth: columnWidths.0 + columnWidths.1 + columnWidths.2 + columnWidths.3)
        }
        .background(Color(nsColor: .controlBackgroundColor))
        .cornerRadius(MoinUIConstants.Radius.md)
        .overlay(
            RoundedRectangle(cornerRadius: MoinUIConstants.Radius.md)
                .stroke(Color.primary.opacity(0.1), lineWidth: 1)
        )
    }

    private func headerCell(_ text: String, width: CGFloat) -> some View {
        Text(text)
            .font(.system(.caption, weight: .medium))
            .foregroundStyle(.secondary)
            .frame(width: width, alignment: .leading)
            .padding(.horizontal, MoinUIConstants.Spacing.sm)
            .padding(.vertical, MoinUIConstants.Spacing.xs)
    }

    private func bodyCell(_ text: String, isCode: Bool = false, width: CGFloat) -> some View {
        Text(text)
            .font(isCode ? .system(.caption, design: .monospaced) : .caption)
            .foregroundStyle(isCode ? Color.accentColor : .primary)
            .frame(width: width, alignment: .leading)
            .padding(.horizontal, MoinUIConstants.Spacing.sm)
            .padding(.vertical, MoinUIConstants.Spacing.xs)
    }
}

// MARK: - FAQ Components

struct FAQItem<Content: View>: View {
    let question: String
    @ViewBuilder let content: () -> Content
    @ObservedObject private var config = MoinUIConfigProvider.shared

    var body: some View {
        VStack(alignment: .leading, spacing: MoinUIConstants.Spacing.md) {
            Text(question)
                .font(.headline)
                .foregroundStyle(config.token.colorText)

            content()
                .font(.body)
                .foregroundStyle(config.token.colorTextSecondary)
        }
        .padding(MoinUIConstants.Spacing.lg)
        .background(config.token.colorBgElevated)
        .cornerRadius(MoinUIConstants.Radius.md)
    }
}

struct BulletPoint: View {
    let text: String

    init(_ text: String) {
        self.text = text
    }

    var body: some View {
        HStack(alignment: .top, spacing: MoinUIConstants.Spacing.sm) {
            Text("•")
            Text(text)
        }
    }
}
