import SwiftUI
import MoinUI

/// Tag 组件文档页面 Tab
enum TagExamplesTab: String, CaseIterable {
    case examples
    case playground
    case api
    case token
}

/// Tag component examples
struct TagExamples: View {
    @Localized var tr
    @Binding var selectedTab: TagExamplesTab

    // 懒加载状态
    @State private var playgroundReady = false
    @State private var apiReady = false
    @State private var tokenReady = false

    /// 锚点列表
    private let anchors: [AnchorItem] = [
        AnchorItem(id: "basic", titleKey: "tag.basic"),
        AnchorItem(id: "colorful", titleKey: "tag.colorful"),
        AnchorItem(id: "size", titleKey: "tag.size"),
        AnchorItem(id: "round", titleKey: "tag.round"),
        AnchorItem(id: "variant", titleKey: "tag.variant"),
        AnchorItem(id: "icon", titleKey: "tag.icon"),
        AnchorItem(id: "closable", titleKey: "tag.closable"),
        AnchorItem(id: "checkable", titleKey: "tag.checkable"),
    ]

    var body: some View {
        Group {
            switch selectedTab {
            case .examples:
                examplesContent
            case .playground:
                if playgroundReady {
                    playgroundContent
                } else {
                    loadingView
                }
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

    private func triggerLazyLoad(for tab: TagExamplesTab) {
        switch tab {
        case .examples:
            break
        case .playground:
            if !playgroundReady {
                DispatchQueue.main.async { playgroundReady = true }
            }
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
        ExamplePageWithAnchor(pageName: "Tag", anchors: anchors) { _ in
            basicExample.id("basic")
            colorfulExample.id("colorful")
            sizeExample.id("size")
            roundExample.id("round")
            variantExample.id("variant")
            iconExample.id("icon")
            closableExample.id("closable")
            checkableExample.id("checkable")
        }
    }

    // MARK: - Playground Content

    private var playgroundContent: some View {
        TagPlayground()
            .padding(Moin.Constants.Spacing.xl)
    }

    // MARK: - API Content

    private var apiContent: some View {
        TagAPIContent()
    }

    // MARK: - Token Content

    private var tokenContent: some View {
        TagTokenSection()
    }

    // MARK: - Examples

    private var basicExample: some View {
        ExampleSection(
            title: tr("tag.basic"),
            description: tr("tag.basic_desc")
        ) {
            HStack(spacing: Moin.Constants.Spacing.sm) {
                Moin.Tag(tr("tag.example.tag1"))
                Moin.Tag(tr("tag.example.tag2"))
                Moin.Tag(tr("tag.example.tag3"))
            }
        } code: {
            """
            Moin.Tag("\(tr("tag.example.tag1"))")
            Moin.Tag("\(tr("tag.example.tag2"))")
            Moin.Tag("\(tr("tag.example.tag3"))")
            """
        }
    }

    private var colorfulExample: some View {
        ExampleSection(
            title: tr("tag.colorful"),
            description: tr("tag.colorful_desc")
        ) {
            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.md) {
                // 语义色
                HStack(spacing: Moin.Constants.Spacing.sm) {
                    Moin.Tag(tr("tag.example.default"), color: .default)
                    Moin.Tag(tr("tag.example.success"), color: .success)
                    Moin.Tag(tr("tag.example.processing"), color: .processing)
                    Moin.Tag(tr("tag.example.warning"), color: .warning)
                    Moin.Tag(tr("tag.example.error"), color: .error)
                }

                // 预设色
                HStack(spacing: Moin.Constants.Spacing.sm) {
                    Moin.Tag("magenta", color: .magenta)
                    Moin.Tag("red", color: .red)
                    Moin.Tag("volcano", color: .volcano)
                    Moin.Tag("orange", color: .orange)
                    Moin.Tag("gold", color: .gold)
                }

                HStack(spacing: Moin.Constants.Spacing.sm) {
                    Moin.Tag("lime", color: .lime)
                    Moin.Tag("green", color: .green)
                    Moin.Tag("cyan", color: .cyan)
                    Moin.Tag("blue", color: .blue)
                    Moin.Tag("geekblue", color: .geekblue)
                    Moin.Tag("purple", color: .purple)
                }

                // 自定义颜色
                HStack(spacing: Moin.Constants.Spacing.sm) {
                    Moin.Tag("#f50", color: .custom(Color(hex: 0xFF5500)))
                    Moin.Tag("#2db7f5", color: .custom(Color(hex: 0x2DB7F5)))
                    Moin.Tag("#87d068", color: .custom(Color(hex: 0x87D068)))
                    Moin.Tag("#108ee9", color: .custom(Color(hex: 0x108EE9)))
                }
            }
        } code: {
            """
            // \(tr("tag.semantic_colors"))
            Moin.Tag("\(tr("tag.example.default"))", color: .default)
            Moin.Tag("\(tr("tag.example.success"))", color: .success)
            Moin.Tag("\(tr("tag.example.processing"))", color: .processing)
            Moin.Tag("\(tr("tag.example.warning"))", color: .warning)
            Moin.Tag("\(tr("tag.example.error"))", color: .error)

            // \(tr("tag.preset_colors"))
            Moin.Tag("magenta", color: .magenta)
            Moin.Tag("red", color: .red)
            // ...

            // \(tr("tag.custom_colors"))
            Moin.Tag("#f50", color: .custom(Color(hex: 0xFF5500)))
            Moin.Tag("#2db7f5", color: .custom(Color(hex: 0x2DB7F5)))
            """
        }
    }

    private var sizeExample: some View {
        ExampleSection(
            title: tr("tag.size"),
            description: tr("tag.size_desc")
        ) {
            HStack(spacing: Moin.Constants.Spacing.sm) {
                Moin.Tag(tr("tag.example.large"), size: .large)
                Moin.Tag(tr("tag.example.medium"), size: .medium)
                Moin.Tag(tr("tag.example.small"), size: .small)
            }
        } code: {
            """
            Moin.Tag("\(tr("tag.example.large"))", size: .large)
            Moin.Tag("\(tr("tag.example.medium"))", size: .medium)
            Moin.Tag("\(tr("tag.example.small"))", size: .small)
            """
        }
    }

    private var roundExample: some View {
        ExampleSection(
            title: tr("tag.round"),
            description: tr("tag.round_desc")
        ) {
            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.md) {
                HStack(spacing: Moin.Constants.Spacing.sm) {
                    Moin.Tag(tr("tag.example.tag1"), round: true)
                    Moin.Tag(tr("tag.example.tag2"), color: .processing, round: true)
                    Moin.Tag(tr("tag.example.tag3"), color: .success, round: true)
                }

                HStack(spacing: Moin.Constants.Spacing.sm) {
                    Moin.Tag(tr("tag.example.large"), size: .large, round: true)
                    Moin.Tag(tr("tag.example.medium"), size: .medium, round: true)
                    Moin.Tag(tr("tag.example.small"), size: .small, round: true)
                }
            }
        } code: {
            """
            Moin.Tag("\(tr("tag.example.tag1"))", round: true)
            Moin.Tag("\(tr("tag.example.tag2"))", color: .processing, round: true)
            Moin.Tag("\(tr("tag.example.large"))", size: .large, round: true)
            """
        }
    }

    private var variantExample: some View {
        ExampleSection(
            title: tr("tag.variant"),
            description: tr("tag.variant_desc")
        ) {
            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.md) {
                HStack(spacing: Moin.Constants.Spacing.sm) {
                    Moin.Tag(tr("tag.example.filled"), color: .default, variant: .filled)
                    Moin.Tag(tr("tag.example.outlined"), color: .default, variant: .outlined)
                    Moin.Tag(tr("tag.example.solid"), color: .default, variant: .solid)
                    Moin.Tag(tr("tag.example.borderless"), color: .default, variant: .borderless)
                }

                HStack(spacing: Moin.Constants.Spacing.sm) {
                    Moin.Tag(tr("tag.example.filled"), color: .processing, variant: .filled)
                    Moin.Tag(tr("tag.example.outlined"), color: .processing, variant: .outlined)
                    Moin.Tag(tr("tag.example.solid"), color: .processing, variant: .solid)
                    Moin.Tag(tr("tag.example.borderless"), color: .processing, variant: .borderless)
                }

                HStack(spacing: Moin.Constants.Spacing.sm) {
                    Moin.Tag(tr("tag.example.filled"), color: .success, variant: .filled)
                    Moin.Tag(tr("tag.example.outlined"), color: .success, variant: .outlined)
                    Moin.Tag(tr("tag.example.solid"), color: .success, variant: .solid)
                    Moin.Tag(tr("tag.example.borderless"), color: .success, variant: .borderless)
                }
            }
        } code: {
            """
            Moin.Tag("\(tr("tag.example.filled"))", color: .default, variant: .filled)
            Moin.Tag("\(tr("tag.example.outlined"))", color: .default, variant: .outlined)
            Moin.Tag("\(tr("tag.example.solid"))", color: .default, variant: .solid)
            Moin.Tag("\(tr("tag.example.borderless"))", color: .default, variant: .borderless)
            """
        }
    }

    private var iconExample: some View {
        ExampleSection(
            title: tr("tag.icon"),
            description: tr("tag.icon_desc")
        ) {
            HStack(spacing: Moin.Constants.Spacing.sm) {
                Moin.Tag(tr("tag.example.apple"), color: .default, icon: "apple.logo")
                Moin.Tag(tr("tag.example.star"), color: .gold, icon: "star.fill")
                Moin.Tag(tr("tag.example.heart"), color: .magenta, icon: "heart.fill")
                Moin.Tag(tr("tag.example.check"), color: .success, icon: "checkmark.circle.fill")
            }
        } code: {
            """
            Moin.Tag("\(tr("tag.example.apple"))", icon: "apple.logo")
            Moin.Tag("\(tr("tag.example.star"))", color: .gold, icon: "star.fill")
            Moin.Tag("\(tr("tag.example.heart"))", color: .magenta, icon: "heart.fill")
            Moin.Tag("\(tr("tag.example.check"))", color: .success, icon: "checkmark.circle.fill")
            """
        }
    }

    private var closableExample: some View {
        ClosableTagExample()
    }

    private var checkableExample: some View {
        CheckableTagExample()
    }
}

// MARK: - Closable Tag Example

struct ClosableTagExample: View {
    @Localized var tr
    @State private var tags = ["Tag 1", "Tag 2", "Tag 3"]

    var body: some View {
        ExampleSection(
            title: tr("tag.closable"),
            description: tr("tag.closable_desc")
        ) {
            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.md) {
                // 三种大小
                HStack(spacing: Moin.Constants.Spacing.sm) {
                    Moin.Tag(tr("tag.example.large"), size: .large, closable: true)
                    Moin.Tag(tr("tag.example.medium"), size: .medium, closable: true)
                    Moin.Tag(tr("tag.example.small"), size: .small, closable: true)
                }

                // 动态示例
                HStack(spacing: Moin.Constants.Spacing.sm) {
                    ForEach(tags, id: \.self) { tag in
                        Moin.Tag(tag, closable: true) {
                            withAnimation {
                                tags.removeAll { $0 == tag }
                            }
                        }
                    }

                    if tags.isEmpty {
                        Button(tr("tag.reset")) {
                            withAnimation {
                                tags = ["Tag 1", "Tag 2", "Tag 3"]
                            }
                        }
                        .buttonStyle(.plain)
                        .foregroundStyle(.secondary)
                    }
                }
            }
        } code: {
            """
            Moin.Tag("\(tr("tag.example.large"))", size: .large, closable: true)
            Moin.Tag("\(tr("tag.example.medium"))", size: .medium, closable: true)
            Moin.Tag("\(tr("tag.example.small"))", size: .small, closable: true)
            """
        }
    }
}

// MARK: - Checkable Tag Example

struct CheckableTagExample: View {
    @Localized var tr
    @State private var checked1 = false
    @State private var checked2 = true
    @State private var checked3 = false

    var body: some View {
        ExampleSection(
            title: tr("tag.checkable"),
            description: tr("tag.checkable_desc")
        ) {
            HStack(spacing: Moin.Constants.Spacing.sm) {
                Moin.CheckableTag(tr("tag.example.movies"), isChecked: $checked1)
                Moin.CheckableTag(tr("tag.example.books"), isChecked: $checked2)
                Moin.CheckableTag(tr("tag.example.music"), isChecked: $checked3)
            }
        } code: {
            """
            @State private var checked = false

            Moin.CheckableTag("\(tr("tag.example.movies"))", isChecked: $checked)
            Moin.CheckableTag("\(tr("tag.example.books"))", isChecked: $checked)
            Moin.CheckableTag("\(tr("tag.example.music"))", isChecked: $checked)
            """
        }
    }
}
