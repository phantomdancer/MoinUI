import SwiftUI
import MoinUI

/// Spin Tab
enum SpinExamplesTab: String, CaseIterable {
    case examples
    case api
    case token
}

struct SpinExamples: View {
    @Localized var tr
    @Binding var selectedTab: SpinExamplesTab
    @State private var isLoading = true
    @State private var showFullscreen = false
    @State private var delayLoading = false

    // 懒加载状态
    @State private var apiReady = false
    @State private var tokenReady = false

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

    private func triggerLazyLoad(for tab: SpinExamplesTab) {
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
        ExamplePageWithAnchor(pageName: "Spin", anchors: anchors) { _ in
            basicExample.id("basic")
            tipExample.id("tip")
            nestedExample.id("nested")
            delayExample.id("delay")
            fullscreenExample.id("fullscreen")
            customIndicatorExample.id("custom")
        }
    }

    // MARK: - API Content

    private var apiContent: some View {
        SpinAPIView()
    }

    // MARK: - Token Content

    private var tokenContent: some View {
        SpinTokenView()
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
                VStack(alignment: .leading, spacing: 12) {
                    Moin.Button(tr("spin.start_delay_loading")) {
                        delayLoading = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            delayLoading = false
                        }
                    }
                    .disabled(delayLoading)

                    Text(tr("spin.delay_hint"))
                        .foregroundStyle(.secondary)

                    if delayLoading {
                        Moin.Spin(tip: tr("spin.loading"), delay: 500)
                    }
                }
                .frame(minHeight: 80)
            },
            code: {
                """
                // \(tr("spin.loading")) \(tr("spin.delay_hint"))
                Moin.Spin(spinning: true, delay: 500)
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
                    Moin.Spin(indicator: {
                        RotatingImage(systemName: "arrow.triangle.2.circlepath")
                            .font(.system(size: 24))
                            .foregroundStyle(.blue)
                    })

                    Moin.Spin(indicator: {
                        ProgressView()
                            .progressViewStyle(.circular)
                    })

                    Moin.Spin(tip: tr("spin.system_style"), indicator: {
                        ProgressView()
                            .progressViewStyle(.circular)
                            .scaleEffect(1.5)
                    })
                }
            },
            code: {
                """
                Moin.Spin(indicator: {
                    RotatingImage(systemName: "arrow.triangle.2.circlepath")
                        .font(.system(size: 24))
                        .foregroundStyle(.blue)
                })

                Moin.Spin(indicator: {
                    ProgressView()
                        .progressViewStyle(.circular)
                })

                Moin.Spin(tip: "\(tr("spin.system_style"))", indicator: {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .scaleEffect(1.5)
                })
                """
            }
        )
    }
}

// MARK: - RotatingImage

/// 自动旋转的图标
private struct RotatingImage: View {
    let systemName: String
    @State private var isRotating = false

    var body: some View {
        Image(systemName: systemName)
            .rotationEffect(.degrees(isRotating ? 360 : 0))
            .animation(.linear(duration: 1).repeatForever(autoreverses: false), value: isRotating)
            .onAppear { isRotating = true }
    }
}
