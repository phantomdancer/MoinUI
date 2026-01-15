import SwiftUI
import MoinUI

/// Badge 组件文档页面 Tab
enum BadgeExamplesTab: String, CaseIterable {
    case examples
    case playground
    case api
    case token
}

/// Badge component examples
struct BadgeExamples: View {
    @Localized var tr
    @Binding var selectedTab: BadgeExamplesTab

    /// 锚点列表
    private let anchors: [AnchorItem] = [
        AnchorItem(id: "basic", titleKey: "badge.basic"),
        AnchorItem(id: "overflow", titleKey: "badge.overflow"),
        AnchorItem(id: "dot", titleKey: "badge.dot"),
        AnchorItem(id: "change", titleKey: "badge.change"),
        AnchorItem(id: "offset", titleKey: "badge.offset"),
        AnchorItem(id: "custom", titleKey: "badge.custom"),
        AnchorItem(id: "standalone", titleKey: "badge.standalone"),
        AnchorItem(id: "status", titleKey: "badge.status"),
        AnchorItem(id: "size", titleKey: "badge.size"),
        AnchorItem(id: "colorful", titleKey: "badge.colorful"),
    ]

    var body: some View {
        Group {
            if selectedTab == .examples {
                examplesContent
            } else if selectedTab == .playground {
                playgroundContent
            } else if selectedTab == .api {
                apiContent
            } else {
                tokenContent
            }
        }
    }

    // MARK: - Examples Content

    private var examplesContent: some View {
        ExamplePageWithAnchor(pageName: "Badge", anchors: anchors) { _ in
            basicExample.id("basic")
            overflowExample.id("overflow")
            dotExample.id("dot")
            changeExample.id("change")
            offsetExample.id("offset")
            customExample.id("custom")
            standaloneExample.id("standalone")
            statusExample.id("status")
            sizeExample.id("size")
            colorfulExample.id("colorful")
        }
    }

    // MARK: - Playground Content

    private var playgroundContent: some View {
        BadgePlayground()
            .padding(Moin.Constants.Spacing.xl)
    }

    // MARK: - API Content

    private var apiContent: some View {
        BadgeAPIContent()
    }

    // MARK: - Token Content

    private var tokenContent: some View {
        BadgeTokenSection()
    }

    // MARK: - Examples

    private var basicExample: some View {
        ExampleSection(
            title: tr("badge.basic"),
            description: tr("badge.basic_desc")
        ) {
            HStack(spacing: Moin.Constants.Spacing.xl) {
                Moin.Badge(count: 5) {
                    sampleBox
                }
                Moin.Badge(count: 0, showZero: true) {
                    sampleBox
                }
                Moin.Badge(count: 0) {
                    sampleBox
                }
            }
        } code: {
            """
            Moin.Badge(count: 5) {
                \(tr("badge.code.avatar"))
            }
            Moin.Badge(count: 0, showZero: true) {
                \(tr("badge.code.avatar"))
            }
            Moin.Badge(count: 0) {  // \(tr("badge.code.hidden"))
                \(tr("badge.code.avatar"))
            }
            """
        }
    }

    private var overflowExample: some View {
        ExampleSection(
            title: tr("badge.overflow"),
            description: tr("badge.overflow_desc")
        ) {
            HStack(spacing: Moin.Constants.Spacing.xl) {
                Moin.Badge(count: 99) {
                    sampleBox
                }
                Moin.Badge(count: 100) {
                    sampleBox
                }
                Moin.Badge(count: 999, overflowCount: 999) {
                    sampleBox
                }
                Moin.Badge(count: 1000, overflowCount: 999) {
                    sampleBox
                }
            }
        } code: {
            """
            Moin.Badge(count: 99) { ... }
            Moin.Badge(count: 100) { ... }  // \(tr("badge.code.shows_99plus"))
            Moin.Badge(count: 999, overflowCount: 999) { ... }
            Moin.Badge(count: 1000, overflowCount: 999) { ... }  // \(tr("badge.code.shows_999plus"))
            """
        }
    }

    private var dotExample: some View {
        ExampleSection(
            title: tr("badge.dot"),
            description: tr("badge.dot_desc")
        ) {
            HStack(spacing: Moin.Constants.Spacing.xl) {
                Moin.Badge(dot: true) {
                    sampleBox
                }
                Moin.Badge(dot: true) {
                    Image(systemName: "bell.fill")
                        .font(.system(size: 20))
                        .foregroundStyle(.secondary)
                }
            }
        } code: {
            """
            Moin.Badge(dot: true) {
                \(tr("badge.code.avatar"))
            }
            Moin.Badge(dot: true) {
                Image(systemName: "bell.fill")
            }
            """
        }
    }

    @State private var dynamicCount = 5
    @State private var showDot = true

    private var changeExample: some View {
        ExampleSection(
            title: tr("badge.change"),
            description: tr("badge.change_desc")
        ) {
            VStack(spacing: Moin.Constants.Spacing.lg) {
                HStack(spacing: Moin.Constants.Spacing.xl) {
                    Moin.Badge(count: dynamicCount) {
                        sampleBox
                    }
                    HStack(spacing: Moin.Constants.Spacing.sm) {
                        Moin.Button("-", color: .primary, variant: .outlined) {
                            if dynamicCount > 0 { dynamicCount -= 1 }
                        }
                        Moin.Button("+", color: .primary, variant: .outlined) {
                            dynamicCount += 1
                        }
                        Moin.Button("?", color: .primary, variant: .outlined) {
                            dynamicCount = Int.random(in: 0...100)
                        }
                    }
                }
                HStack(spacing: Moin.Constants.Spacing.xl) {
                    Moin.Badge(dot: showDot) {
                        sampleBox
                    }
                    Toggle(tr("badge.playground.dot"), isOn: $showDot)
                        .toggleStyle(.switch)
                        .fixedSize()
                }
            }
        } code: {
            """
            @State private var count = 5

            Moin.Badge(count: count) { ... }

            Button("-") { count -= 1 }
            Button("+") { count += 1 }
            """
        }
    }

    private var offsetExample: some View {
        ExampleSection(
            title: tr("badge.offset"),
            description: tr("badge.offset_desc")
        ) {
            HStack(spacing: Moin.Constants.Spacing.xl) {
                Moin.Badge(count: 5, offset: (10, -10)) {
                    sampleBox
                }
                Moin.Badge(count: 5, offset: (-5, 5)) {
                    sampleBox
                }
            }
        } code: {
            """
            Moin.Badge(count: 5, offset: (10, -10)) {
                \(tr("badge.code.avatar"))
            }
            Moin.Badge(count: 5, offset: (-5, 5)) {
                \(tr("badge.code.avatar"))
            }
            """
        }
    }

    private var customExample: some View {
        ExampleSection(
            title: tr("badge.custom"),
            description: tr("badge.custom_desc")
        ) {
            HStack(spacing: Moin.Constants.Spacing.xl) {
                // 自定义图标
                Moin.Badge(count: {
                    Image(systemName: "clock.fill")
                        .font(.system(size: 10))
                        .foregroundStyle(.red)
                }) {
                    sampleBox
                }

                // 自定义视图
                Moin.Badge(count: {
                    Image(systemName: "exclamationmark.circle.fill")
                        .font(.system(size: 12))
                        .foregroundStyle(.orange)
                }) {
                    sampleBox
                }

                // 自定义复杂视图
                Moin.Badge(count: {
                    HStack(spacing: 2) {
                        Image(systemName: "star.fill")
                            .font(.system(size: 8))
                        Text("NEW")
                            .font(.system(size: 8, weight: .bold))
                    }
                    .fixedSize()
                    .foregroundStyle(.white)
                    .padding(.horizontal, 4)
                    .padding(.vertical, 2)
                    .background(.orange)
                    .clipShape(Capsule())
                }) {
                    sampleBox
                }
            }
        } code: {
            """
            // \(tr("badge.code.custom_icon"))
            Moin.Badge(count: {
                Image(systemName: "clock.fill")
                    .foregroundStyle(.red)
            }) {
                Avatar()
            }

            // \(tr("badge.code.custom_view"))
            Moin.Badge(count: {
                HStack {
                    Image(systemName: "star.fill")
                    Text("NEW")
                }
                .background(.orange)
                .clipShape(Capsule())
            }) {
                Avatar()
            }
            """
        }
    }

    private var standaloneExample: some View {
        ExampleSection(
            title: tr("badge.standalone"),
            description: tr("badge.standalone_desc")
        ) {
            HStack(spacing: Moin.Constants.Spacing.md) {
                Moin.Badge(count: 25)
                Moin.Badge(count: 4, color: .success)
                Moin.Badge(count: 109, color: .processing)
                Moin.Badge(dot: true)
            }
        } code: {
            """
            Moin.Badge(count: 25)
            Moin.Badge(count: 4, color: .success)
            Moin.Badge(count: 109, color: .processing)
            Moin.Badge(dot: true)
            """
        }
    }

    private var statusExample: some View {
        ExampleSection(
            title: tr("badge.status"),
            description: tr("badge.status_desc")
        ) {
            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.sm) {
                HStack(spacing: Moin.Constants.Spacing.xl) {
                    Moin.Badge(status: .success)
                    Moin.Badge(status: .processing)
                    Moin.Badge(status: .default)
                    Moin.Badge(status: .error)
                    Moin.Badge(status: .warning)
                }
                VStack(alignment: .leading, spacing: Moin.Constants.Spacing.xs) {
                    Moin.Badge(status: .success, text: tr("badge.example.success"))
                    Moin.Badge(status: .processing, text: tr("badge.example.processing"))
                    Moin.Badge(status: .default, text: tr("badge.example.default"))
                    Moin.Badge(status: .error, text: tr("badge.example.error"))
                    Moin.Badge(status: .warning, text: tr("badge.example.warning"))
                }
            }
        } code: {
            """
            Moin.Badge(status: .success)
            Moin.Badge(status: .processing)
            Moin.Badge(status: .default)
            Moin.Badge(status: .error)
            Moin.Badge(status: .warning)

            Moin.Badge(status: .success, text: "\(tr("badge.example.success"))")
            """
        }
    }

    private var sizeExample: some View {
        ExampleSection(
            title: tr("badge.size"),
            description: tr("badge.size_desc")
        ) {
            HStack(spacing: Moin.Constants.Spacing.xl) {
                Moin.Badge(count: 5, size: .default) {
                    sampleBox
                }
                Moin.Badge(count: 5, size: .small) {
                    sampleBox
                }
            }
        } code: {
            """
            Moin.Badge(count: 5, size: .default) { ... }
            Moin.Badge(count: 5, size: .small) { ... }
            """
        }
    }

    private var colorfulExample: some View {
        ExampleSection(
            title: tr("badge.colorful"),
            description: tr("badge.colorful_desc")
        ) {
            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.md) {
                // 语义色
                HStack(spacing: Moin.Constants.Spacing.xl) {
                    Moin.Badge(count: 5, color: .default) { sampleBox }
                    Moin.Badge(count: 5, color: .success) { sampleBox }
                    Moin.Badge(count: 5, color: .processing) { sampleBox }
                    Moin.Badge(count: 5, color: .warning) { sampleBox }
                    Moin.Badge(count: 5, color: .error) { sampleBox }
                }
                
                // 预设色
                HStack(spacing: Moin.Constants.Spacing.xl) {
                    Moin.Badge(count: 5, color: .magenta) { sampleBox }
                    Moin.Badge(count: 5, color: .red) { sampleBox }
                    Moin.Badge(count: 5, color: .volcano) { sampleBox }
                    Moin.Badge(count: 5, color: .orange) { sampleBox }
                    Moin.Badge(count: 5, color: .gold) { sampleBox }
                }
                HStack(spacing: Moin.Constants.Spacing.xl) {
                    Moin.Badge(count: 5, color: .lime) { sampleBox }
                    Moin.Badge(count: 5, color: .green) { sampleBox }
                    Moin.Badge(count: 5, color: .cyan) { sampleBox }
                    Moin.Badge(count: 5, color: .blue) { sampleBox }
                    Moin.Badge(count: 5, color: .geekblue) { sampleBox }
                    Moin.Badge(count: 5, color: .purple) { sampleBox }
                }
                
                // 自定义颜色
                HStack(spacing: Moin.Constants.Spacing.xl) {
                    Moin.Badge(count: 5, color: .custom(Color(hex: 0xf50))) { sampleBox }
                    Moin.Badge(count: 5, color: .custom(Color(hex: 0x2db7f5))) { sampleBox }
                    Moin.Badge(count: 5, color: .custom(Color(hex: 0x87d068))) { sampleBox }
                    Moin.Badge(count: 5, color: .custom(Color(hex: 0x108ee9))) { sampleBox }
                }
            }
        } code: {
            """
            // \(tr("tag.semantic_colors"))
            Moin.Badge(count: 5, color: .default) { ... }
            Moin.Badge(count: 5, color: .success) { ... }
            Moin.Badge(count: 5, color: .processing) { ... }
            Moin.Badge(count: 5, color: .warning) { ... }
            Moin.Badge(count: 5, color: .error) { ... }

            // \(tr("tag.preset_colors"))
            Moin.Badge(count: 5, color: .magenta) { ... }
            Moin.Badge(count: 5, color: .red) { ... }
            Moin.Badge(count: 5, color: .volcano) { ... }
            // ...

            // \(tr("tag.custom_colors"))
            Moin.Badge(count: 5, color: .custom(Color(hex: 0xf50))) { ... }
            """
        }
    }

    // MARK: - Helper Views

    private var sampleBox: some View {
        RoundedRectangle(cornerRadius: 6)
            .fill(Color.gray.opacity(0.3))
            .frame(width: 40, height: 40)
    }
}
