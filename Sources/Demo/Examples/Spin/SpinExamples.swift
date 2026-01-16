import SwiftUI
import MoinUI

/// Spin Tab
enum SpinExamplesTab: String, CaseIterable {
    case examples
    case playground
    case api
    case token
}

struct SpinExamples: View {
    @Localized var tr
    @Binding var selectedTab: SpinExamplesTab
    @State private var isLoading = true
    @State private var showFullscreen = false

    /// 锚点列表
    private let anchors: [AnchorItem] = [
        AnchorItem(id: "basic", titleKey: "spin.basic"),
        AnchorItem(id: "tip", titleKey: "spin.tip"),
        AnchorItem(id: "nested", titleKey: "spin.nested"),
        AnchorItem(id: "delay", titleKey: "spin.delay"),
        AnchorItem(id: "fullscreen", titleKey: "spin.fullscreen"),
        AnchorItem(id: "custom", titleKey: "spin.custom"),
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
        ExamplePageWithAnchor(pageName: "Spin", anchors: anchors) { _ in
            basicExample.id("basic")
            tipExample.id("tip")
            nestedExample.id("nested")
            delayExample.id("delay")
            fullscreenExample.id("fullscreen")
            customIndicatorExample.id("custom")
        }
    }

    // MARK: - Playground Content

    private var playgroundContent: some View {
        SpinPlayground()
    }

    // MARK: - API Content

    private var apiContent: some View {
        SpinAPIContent()
    }

    // MARK: - Token Content

    private var tokenContent: some View {
        SpinTokenSection()
    }

    // MARK: - Examples

    private var basicExample: some View {
        ExampleSection(
            title: tr("spin.basic"),
            description: tr("spin.basic_desc"),
            content: {
                HStack(spacing: 40) {
                    VStack {
                        Moin.Spin(size: .small)
                        Text("Small").font(.caption)
                    }
                    VStack {
                        Moin.Spin()
                        Text("Default").font(.caption)
                    }
                    VStack {
                        Moin.Spin(size: .large)
                        Text("Large").font(.caption)
                    }
                }
            },
            code: {
                """
                Moin.Spin(size: .small)
                Moin.Spin()
                Moin.Spin(size: .large)
                """
            }
        )
    }

    private var tipExample: some View {
        ExampleSection(
            title: tr("spin.tip"),
            description: tr("spin.tip_desc"),
            content: {
                HStack(spacing: 40) {
                    Moin.Spin(tip: "Loading...")
                    Moin.Spin(size: .large, tip: tr("spin.loading"))
                }
            },
            code: {
                """
                Moin.Spin(tip: "Loading...")
                Moin.Spin(size: .large, tip: "\(tr("spin.loading"))")
                """
            }
        )
    }

    private var nestedExample: some View {
        ExampleSection(
            title: tr("spin.nested"),
            description: tr("spin.nested_desc"),
            content: {
                VStack(spacing: 16) {
                    Toggle("Loading", isOn: $isLoading)
                        .frame(width: 120)

                    Moin.Spin(spinning: isLoading, tip: tr("spin.loading")) {
                        VStack(spacing: 12) {
                            Text("Content Area")
                                .font(.headline)
                            Text(tr("spin.content_hint"))
                                .foregroundStyle(.secondary)
                            HStack {
                                ForEach(0..<3, id: \.self) { _ in
                                    RoundedRectangle(cornerRadius: 4)
                                        .fill(Color.blue.opacity(0.2))
                                        .frame(width: 60, height: 40)
                                }
                            }
                        }
                        .padding(24)
                        .background(Color.gray.opacity(0.05))
                        .cornerRadius(8)
                    }
                }
            },
            code: {
                """
                Moin.Spin(spinning: isLoading, tip: "\(tr("spin.loading"))") {
                    VStack {
                        Text("Content Area")
                        // ...
                    }
                }
                """
            }
        )
    }

    private var delayExample: some View {
        ExampleSection(
            title: tr("spin.delay"),
            description: tr("spin.delay_desc"),
            content: {
                VStack(alignment: .leading, spacing: 8) {
                    Text(tr("spin.delay_hint"))
                        .foregroundStyle(.secondary)
                    Moin.Spin(tip: "Delayed...", delay: 500)
                }
            },
            code: {
                """
                Moin.Spin(tip: "Delayed...", delay: 500)
                """
            }
        )
    }

    private var fullscreenExample: some View {
        ExampleSection(
            title: tr("spin.fullscreen"),
            description: tr("spin.fullscreen_desc"),
            content: {
                Moin.Button(tr("spin.show_fullscreen")) {
                    showFullscreen = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        showFullscreen = false
                    }
                }
            },
            code: {
                """
                Moin.Spin(spinning: true, tip: "\(tr("spin.fullscreen_loading"))", fullscreen: true)
                """
            }
        )
        .overlay {
            if showFullscreen {
                Moin.Spin(spinning: true, tip: tr("spin.fullscreen_loading"), fullscreen: true)
            }
        }
    }

    private var customIndicatorExample: some View {
        ExampleSection(
            title: tr("spin.custom"),
            description: tr("spin.custom_desc"),
            content: {
                HStack(spacing: 40) {
                    Moin.Spin {
                        Image(systemName: "arrow.triangle.2.circlepath")
                            .font(.system(size: 24))
                            .foregroundStyle(.blue)
                    }

                    Moin.Spin {
                        ProgressView()
                            .progressViewStyle(.circular)
                    }

                    Moin.Spin(tip: tr("spin.system_style")) {
                        ProgressView()
                            .progressViewStyle(.circular)
                            .scaleEffect(1.5)
                    }
                }
            },
            code: {
                """
                Moin.Spin {
                    Image(systemName: "arrow.triangle.2.circlepath")
                        .font(.system(size: 24))
                        .foregroundStyle(.blue)
                }

                Moin.Spin {
                    ProgressView()
                        .progressViewStyle(.circular)
                }
                """
            }
        )
    }
}

// MARK: - API Content

struct SpinAPIContent: View {
    @Localized var tr

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // Moin.Spin
                Text("Moin.Spin")
                    .font(.title2.bold())

                Text(tr("spin.api.desc"))
                    .foregroundStyle(.secondary)

                APITable(
                    headers: (tr("api.property"), tr("api.type"), tr("api.default"), tr("api.description")),
                    rows: [
                        ("spinning", "Bool", "true", tr("spin.api.spinning")),
                        ("size", "SpinSize", ".default", tr("spin.api.size")),
                        ("tip", "String?", "nil", tr("spin.api.tip")),
                        ("delay", "Int?", "nil", tr("spin.api.delay")),
                        ("percent", "SpinPercent?", "nil", tr("spin.api.percent")),
                        ("fullscreen", "Bool", "false", tr("spin.api.fullscreen")),
                        ("indicator", "View?", "nil", tr("spin.api.indicator")),
                        ("content", "View?", "nil", tr("spin.api.content"))
                    ]
                )

                Divider()

                // SpinSize
                Text("SpinSize")
                    .font(.title2.bold())

                Text(tr("spin.api.size_desc"))
                    .foregroundStyle(.secondary)

                APITable(
                    headers: (tr("api.value"), tr("api.description"), "", ""),
                    rows: [
                        (".small", tr("spin.api.size_small"), "", ""),
                        (".default", tr("spin.api.size_default"), "", ""),
                        (".large", tr("spin.api.size_large"), "", "")
                    ],
                    columnWidths: (140, 300, 0, 0)
                )

                Divider()

                // SpinPercent
                Text("SpinPercent")
                    .font(.title2.bold())

                Text(tr("spin.api.percent_desc"))
                    .foregroundStyle(.secondary)

                APITable(
                    headers: (tr("api.value"), tr("api.description"), "", ""),
                    rows: [
                        (".value(Double)", tr("spin.api.percent_value"), "", ""),
                        (".auto", tr("spin.api.percent_auto"), "", "")
                    ],
                    columnWidths: (180, 300, 0, 0)
                )
            }
            .padding(24)
        }
    }
}

// MARK: - Token Section

struct SpinTokenSection: View {
    @Localized var tr
    @Environment(\.moinConfig) private var config

    var body: some View {
        let token = config.components.spin

        ScrollView {
            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.xl) {
                Text(tr("spin.token.title"))
                    .font(.title2)
                    .fontWeight(.semibold)

                Text(tr("spin.token.desc"))
                    .foregroundStyle(.secondary)

                // Size Tokens
                Text(tr("spin.token.size"))
                    .font(.headline)

                APITable(
                    headers: (
                        tr("api.property"),
                        tr("api.type"),
                        tr("api.default"),
                        tr("api.description")
                    ),
                    rows: [
                        ("dotSize", "CGFloat", "\(Int(token.dotSize))", tr("spin.token.dotSize_desc")),
                        ("dotSizeSM", "CGFloat", "\(Int(token.dotSizeSM))", tr("spin.token.dotSizeSM_desc")),
                        ("dotSizeLG", "CGFloat", "\(Int(token.dotSizeLG))", tr("spin.token.dotSizeLG_desc")),
                        ("contentHeight", "CGFloat", "\(Int(token.contentHeight))", tr("spin.token.contentHeight_desc")),
                    ]
                )

                // Color Tokens
                Text(tr("spin.token.color"))
                    .font(.headline)

                APITable(
                    headers: (
                        tr("api.property"),
                        tr("api.type"),
                        tr("api.default"),
                        tr("api.description")
                    ),
                    rows: [
                        ("dotColor", "Color", "colorPrimary", tr("spin.token.dotColor_desc")),
                        ("tipColor", "Color", "colorTextTertiary", tr("spin.token.tipColor_desc")),
                        ("maskBackground", "Color", "colorBgMask", tr("spin.token.maskBackground_desc")),
                        ("progressTrackColor", "Color", "colorFillSecondary", tr("spin.token.progressTrackColor_desc")),
                    ]
                )

                // Animation Tokens
                Text(tr("spin.token.animation"))
                    .font(.headline)

                APITable(
                    headers: (
                        tr("api.property"),
                        tr("api.type"),
                        tr("api.default"),
                        tr("api.description")
                    ),
                    rows: [
                        ("motionDuration", "Double", "1.2", tr("spin.token.motionDuration_desc")),
                    ]
                )
            }
            .padding(24)
        }
    }
}
