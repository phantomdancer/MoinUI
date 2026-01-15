import SwiftUI
import MoinUI

/// Badge 演练场
struct BadgePlayground: View {
    @Localized var tr
    @Environment(\.moinToken) private var token

    @State private var count: Double = 5
    @State private var showZero = false
    @State private var isDot = false
    @State private var overflowCount: Double = 99
    @State private var selectedSize: BadgeSize = .default
    @State private var selectedColor: BadgeColor = .default

    var body: some View {
        VStack(spacing: Moin.Constants.Spacing.xl) {
            // 预览区
            previewSection

            Moin.Divider()

            // 控制区
            controlSection
        }
    }

    private var previewSection: some View {
        VStack(spacing: Moin.Constants.Spacing.md) {
            Text(tr("badge.playground.preview"))
                .font(.headline)

            HStack(spacing: Moin.Constants.Spacing.xl) {
                Moin.Badge(
                    count: Int(count),
                    dot: isDot,
                    showZero: showZero,
                    overflowCount: Int(overflowCount),
                    size: selectedSize,
                    color: selectedColor
                ) {
                    RoundedRectangle(cornerRadius: 6)
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 40, height: 40)
                }
            }
            .frame(height: 80)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(token.colorBgContainer)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }

    private var controlSection: some View {
        VStack(alignment: .leading, spacing: Moin.Constants.Spacing.md) {
            // Count
            HStack {
                Text(tr("badge.playground.count"))
                    .frame(width: 120, alignment: .leading)
                Slider(value: $count, in: 0...200, step: 1)
                Text("\(Int(count))")
                    .frame(width: 40)
            }

            // Overflow Count
            HStack {
                Text(tr("badge.playground.overflow"))
                    .frame(width: 120, alignment: .leading)
                Slider(value: $overflowCount, in: 9...999, step: 1)
                Text("\(Int(overflowCount))")
                    .frame(width: 40)
            }

            // Toggles
            HStack(spacing: Moin.Constants.Spacing.xl) {
                Toggle(tr("badge.playground.dot"), isOn: $isDot)
                Toggle(tr("badge.playground.showZero"), isOn: $showZero)
            }

            // Size
            HStack {
                Text(tr("badge.playground.size"))
                    .frame(width: 120, alignment: .leading)
                Picker("", selection: $selectedSize) {
                    Text("default").tag(BadgeSize.default)
                    Text("small").tag(BadgeSize.small)
                }
                .pickerStyle(.segmented)
                .frame(width: 200)
            }

            // Color
            HStack {
                Text(tr("badge.playground.color"))
                    .frame(width: 120, alignment: .leading)
                HStack(spacing: Moin.Constants.Spacing.sm) {
                    colorButton(.default, label: "default", color: token.colorDanger)
                    colorButton(.success, label: "success", color: token.colorSuccess)
                    colorButton(.processing, label: "processing", color: token.colorPrimary)
                    colorButton(.warning, label: "warning", color: token.colorWarning)
                    colorButton(.error, label: "error", color: token.colorDanger)
                }
            }
        }
    }

    private func colorButton(_ badgeColor: BadgeColor, label: String, color: Color) -> some View {
        Button {
            selectedColor = badgeColor
        } label: {
            Circle()
                .fill(color)
                .frame(width: 24, height: 24)
                .overlay {
                    if isSelected(badgeColor) {
                        Circle()
                            .strokeBorder(.white, lineWidth: 2)
                    }
                }
        }
        .buttonStyle(.plain)
    }

    private func isSelected(_ badgeColor: BadgeColor) -> Bool {
        switch (selectedColor, badgeColor) {
        case (.default, .default), (.success, .success), (.processing, .processing),
             (.warning, .warning), (.error, .error):
            return true
        default:
            return false
        }
    }
}
