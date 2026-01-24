import SwiftUI
import MoinUI

// MARK: - ExampleSection

/// 示例区块：上下布局，效果在上，代码在下
struct ExampleSection<Content: View>: View {
    let title: String
    let description: String
    @ViewBuilder let content: () -> Content
    let code: () -> String

    @ObservedObject private var config = Moin.ConfigProvider.shared

    var body: some View {
        VStack(alignment: .leading, spacing: Moin.Constants.Spacing.md) {
            Text(title)
                .font(.title3)
                .fontWeight(.semibold)

            Text(description)
                .font(.body)
                .foregroundStyle(.secondary)

            content()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, Moin.Constants.Spacing.lg)

            ScrollView(.horizontal, showsIndicators: false) {
                HighlightedCodeView(code: code(), fontSize: 12)
                    .padding(Moin.Constants.Spacing.sm)
            }
            .background(config.isDarkMode ? Color(white: 0.08) : Color(white: 0.96))
            .cornerRadius(Moin.Constants.Radius.sm)
            .id(code())
        }
    }
}

// MARK: - APITable

struct APITable: View {
    let headers: (String, String, String, String)
    let rows: [(String, String, String, String)]
    var columnWidths: (CGFloat, CGFloat, CGFloat, CGFloat) = (140, 180, 100, 220)

    /// 按首列字母排序
    private var sortedRows: [(String, String, String, String)] {
        rows.sorted { $0.0.lowercased() < $1.0.lowercased() }
    }

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    headerCell(headers.0, width: columnWidths.0)
                    headerCell(headers.1, width: columnWidths.1)
                    headerCell(headers.2, width: columnWidths.2)
                    headerCell(headers.3, width: columnWidths.3)
                }

                Moin.Divider()

                ForEach(sortedRows.indices, id: \.self) { index in
                    HStack(spacing: 0) {
                        bodyCell(sortedRows[index].0, isCode: true, width: columnWidths.0)
                        bodyCell(sortedRows[index].1, isCode: true, width: columnWidths.1)
                        bodyCell(sortedRows[index].2, width: columnWidths.2)
                        bodyCell(sortedRows[index].3, width: columnWidths.3)
                    }
                    .background(index % 2 == 1 ? Color.primary.opacity(0.03) : Color.clear)

                    if index < sortedRows.count - 1 {
                        Moin.Divider()
                    }
                }
            }
            .frame(minWidth: columnWidths.0 + columnWidths.1 + columnWidths.2 + columnWidths.3)
        }
        .background(Color(nsColor: .controlBackgroundColor))
        .cornerRadius(Moin.Constants.Radius.md)
        .overlay(
            RoundedRectangle(cornerRadius: Moin.Constants.Radius.md)
                .stroke(Color.primary.opacity(0.1), lineWidth: 1)
        )
    }

    private func headerCell(_ text: String, width: CGFloat) -> some View {
        Text(text)
            .font(.system(.caption, weight: .medium))
            .foregroundStyle(.secondary)
            .frame(width: width, alignment: .leading)
            .padding(.horizontal, Moin.Constants.Spacing.sm)
            .padding(.vertical, Moin.Constants.Spacing.xs)
    }

    private func bodyCell(_ text: String, isCode: Bool = false, width: CGFloat) -> some View {
        Text(text)
            .font(isCode ? .system(.caption, design: .monospaced) : .caption)
            .foregroundStyle(isCode ? Color.accentColor : .primary)
            .frame(width: width, alignment: .leading)
            .padding(.horizontal, Moin.Constants.Spacing.sm)
            .padding(.vertical, Moin.Constants.Spacing.xs)
    }
}

// MARK: - FAQ Components

struct FAQItem<Content: View>: View {
    let question: String
    @ViewBuilder let content: () -> Content
    @ObservedObject private var config = Moin.ConfigProvider.shared

    var body: some View {
        VStack(alignment: .leading, spacing: Moin.Constants.Spacing.md) {
            Text(question)
                .font(.headline)
                .foregroundStyle(config.token.colorText)

            content()
                .font(.body)
                .foregroundStyle(config.token.colorTextSecondary)
        }
        .padding(Moin.Constants.Spacing.lg)
        .background(config.token.colorBgElevated)
        .cornerRadius(Moin.Constants.Radius.md)
    }
}

struct BulletPoint: View {
    let text: String

    init(_ text: String) {
        self.text = text
    }

    var body: some View {
        HStack(alignment: .top, spacing: Moin.Constants.Spacing.sm) {
            Text("•")
            Text(text)
        }
    }
}

// MARK: - RibbonCard

struct RibbonCard: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(Color.gray.opacity(0.1))
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .strokeBorder(Color.gray.opacity(0.2))
            )
            .frame(width: 80, height: 60)
    }
}
