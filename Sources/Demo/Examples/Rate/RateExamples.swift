import SwiftUI
import MoinUI

/// Rate Tab
enum RateExamplesTab: String, CaseIterable {
    case examples
    case api
    case token
}

struct RateExamples: View {
    @Localized var tr
    @Binding var selectedTab: RateExamplesTab

    // 状态
    @State private var basicValue: Double = 3
    @State private var halfValue: Double = 2.5
    @State private var disabledValue: Double = 3
    @State private var clearValue: Double = 3
    @State private var countValue: Double = 3
    @State private var characterValue: Double = 3
    @State private var sizeValue: Double = 3

    // 懒加载状态
    @State private var apiReady = false
    @State private var tokenReady = false

    /// 锚点列表
    private let anchors: [AnchorItem] = [
        AnchorItem(id: "basic", titleKey: "rate.basic"),
        AnchorItem(id: "half", titleKey: "rate.half"),
        AnchorItem(id: "disabled", titleKey: "rate.disabled"),
        AnchorItem(id: "clear", titleKey: "rate.clear"),
        AnchorItem(id: "count", titleKey: "rate.count"),
        AnchorItem(id: "character", titleKey: "rate.character"),
        AnchorItem(id: "size", titleKey: "rate.size"),
    ]

    var body: some View {
        Group {
            switch selectedTab {
            case .examples:
                examplesContent
            case .api:
                if apiReady {
                    apiContent
                } else {
                    loadingView
                }
            case .token:
                if tokenReady {
                    tokenContent
                } else {
                    loadingView
                }
            }
        }
        .onAppear { triggerLazyLoad(for: selectedTab) }
        .onChange(of: selectedTab) { triggerLazyLoad(for: $0) }
    }

    private var loadingView: some View {
        Moin.Spin()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private func triggerLazyLoad(for tab: RateExamplesTab) {
        switch tab {
        case .examples:
            break
        case .api:
            if !apiReady {
                DispatchQueue.main.async { apiReady = true }
            }
        case .token:
            if !tokenReady {
                DispatchQueue.main.async { tokenReady = true }
            }
        }
    }

    // MARK: - Examples Content

    private var examplesContent: some View {
        ExamplePageWithAnchor(pageName: "Rate", anchors: anchors) { _ in
            basicExample.id("basic")
            halfExample.id("half")
            disabledExample.id("disabled")
            clearExample.id("clear")
            countExample.id("count")
            characterExample.id("character")
            sizeExample.id("size")
        }
    }

    // MARK: - API Content

    private var apiContent: some View {
        RateAPIView()
    }

    // MARK: - Token Content

    private var tokenContent: some View {
        RateTokenView()
    }

    // MARK: - Examples

    private var basicExample: some View {
        ExampleSection(
            title: tr("rate.basic"),
            description: tr("rate.basic_desc"),
            content: {
                VStack(alignment: .leading, spacing: 12) {
                    Moin.Rate(value: $basicValue)
                    Text("\(tr("rate.current_value")): \(basicValue, specifier: "%.1f")")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            },
            code: {
                """
                @State private var value: Double = 3

                Moin.Rate(value: $value)
                """
            }
        )
    }

    private var halfExample: some View {
        ExampleSection(
            title: tr("rate.half"),
            description: tr("rate.half_desc"),
            content: {
                VStack(alignment: .leading, spacing: 12) {
                    Moin.Rate(value: $halfValue, allowHalf: true)
                    Text("\(tr("rate.current_value")): \(halfValue, specifier: "%.1f")")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            },
            code: {
                """
                @State private var value: Double = 2.5

                Moin.Rate(value: $value, allowHalf: true)
                """
            }
        )
    }

    private var disabledExample: some View {
        ExampleSection(
            title: tr("rate.disabled"),
            description: tr("rate.disabled_desc"),
            content: {
                Moin.Rate(value: $disabledValue, disabled: true)
            },
            code: {
                """
                Moin.Rate(value: $value, disabled: true)
                """
            }
        )
    }

    private var clearExample: some View {
        ExampleSection(
            title: tr("rate.clear"),
            description: tr("rate.clear_desc"),
            content: {
                VStack(alignment: .leading, spacing: 12) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("allowClear: true (\(tr("rate.default")))").font(.caption).foregroundStyle(.secondary)
                        Moin.Rate(value: $clearValue, allowClear: true)
                    }
                    VStack(alignment: .leading, spacing: 4) {
                        Text("allowClear: false").font(.caption).foregroundStyle(.secondary)
                        Moin.Rate(value: .constant(3), allowClear: false)
                    }
                }
            },
            code: {
                """
                // allowClear: true (\(tr("rate.default")))
                Moin.Rate(value: $value, allowClear: true)

                // allowClear: false
                Moin.Rate(value: $value, allowClear: false)
                """
            }
        )
    }

    private var countExample: some View {
        ExampleSection(
            title: tr("rate.count"),
            description: tr("rate.count_desc"),
            content: {
                VStack(alignment: .leading, spacing: 12) {
                    Moin.Rate(value: $countValue, count: 10)
                    Text("\(tr("rate.current_value")): \(countValue, specifier: "%.0f") / 10")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            },
            code: {
                """
                Moin.Rate(value: $value, count: 10)
                """
            }
        )
    }

    private var characterExample: some View {
        ExampleSection(
            title: tr("rate.character"),
            description: tr("rate.character_desc"),
            content: {
                VStack(alignment: .leading, spacing: 16) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(tr("rate.heart_icon")).font(.caption).foregroundStyle(.secondary)
                        Moin.Rate(value: $characterValue, allowHalf: true) {
                            Image(systemName: "heart.fill")
                        }
                    }
                    VStack(alignment: .leading, spacing: 4) {
                        Text(tr("rate.letter_character")).font(.caption).foregroundStyle(.secondary)
                        Moin.Rate(value: .constant(3)) {
                            Text("A")
                                .fontWeight(.bold)
                        }
                    }
                }
            },
            code: {
                """
                // \(tr("rate.heart_icon"))
                Moin.Rate(value: $value, allowHalf: true) {
                    Image(systemName: "heart.fill")
                }

                // \(tr("rate.letter_character"))
                Moin.Rate(value: $value) {
                    Text("A").fontWeight(.bold)
                }
                """
            }
        )
    }

    private var sizeExample: some View {
        ExampleSection(
            title: tr("rate.size"),
            description: tr("rate.size_desc"),
            content: {
                VStack(alignment: .leading, spacing: 16) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("small").font(.caption).foregroundStyle(.secondary)
                        Moin.Rate(value: $sizeValue, size: .small)
                    }
                    VStack(alignment: .leading, spacing: 4) {
                        Text("medium (\(tr("rate.default")))").font(.caption).foregroundStyle(.secondary)
                        Moin.Rate(value: $sizeValue, size: .medium)
                    }
                    VStack(alignment: .leading, spacing: 4) {
                        Text("large").font(.caption).foregroundStyle(.secondary)
                        Moin.Rate(value: $sizeValue, size: .large)
                    }
                    VStack(alignment: .leading, spacing: 4) {
                        Text("32").font(.caption).foregroundStyle(.secondary)
                        Moin.Rate(value: $sizeValue, size: 32)
                    }
                }
            },
            code: {
                """
                Moin.Rate(value: $value, size: .small)
                Moin.Rate(value: $value, size: .medium)  // \(tr("rate.default"))
                Moin.Rate(value: $value, size: .large)
                Moin.Rate(value: $value, size: 32)
                """
            }
        )
    }
}
