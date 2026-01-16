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
        Text(tr("spin.playground.coming_soon"))
            .foregroundStyle(.secondary)
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(40)
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
            VStack(alignment: .leading, spacing: 24) {
                Text(tr("spin.token.title"))
                    .font(.title2.bold())

                Text(tr("spin.token.desc"))
                    .foregroundStyle(.secondary)

                // Size Tokens
                TokenGroup(title: tr("spin.token.size")) {
                    tokenRow("dotSize", "\(Int(token.dotSize))pt")
                    tokenRow("dotSizeSM", "\(Int(token.dotSizeSM))pt")
                    tokenRow("dotSizeLG", "\(Int(token.dotSizeLG))pt")
                    tokenRow("contentHeight", "\(Int(token.contentHeight))pt")
                }

                // Color Tokens
                TokenGroup(title: tr("spin.token.color")) {
                    colorRow("dotColor", token.dotColor)
                    colorRow("tipColor", token.tipColor)
                    colorRow("maskBackground", token.maskBackground)
                }

                // Animation Tokens
                TokenGroup(title: tr("spin.token.animation")) {
                    tokenRow("motionDuration", "\(token.motionDuration)s")
                }
            }
            .padding(24)
        }
    }

    private func tokenRow(_ name: String, _ value: String) -> some View {
        HStack {
            Text(name)
                .font(.system(size: 12, design: .monospaced))
                .foregroundStyle(.secondary)
            Spacer()
            Text(value)
                .font(.system(size: 12, design: .monospaced))
        }
        .padding(.vertical, 4)
    }

    private func colorRow(_ name: String, _ color: Color) -> some View {
        HStack {
            Text(name)
                .font(.system(size: 12, design: .monospaced))
                .foregroundStyle(.secondary)
            Spacer()
            Circle()
                .fill(color)
                .frame(width: 16, height: 16)
                .overlay(Circle().stroke(Color.primary.opacity(0.2), lineWidth: 1))
        }
        .padding(.vertical, 4)
    }
}
