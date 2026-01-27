import SwiftUI
import MoinUI

/// Skeleton Tab
enum SkeletonExamplesTab: String, CaseIterable {
    case examples
    case api
    case token
}

struct SkeletonExamples: View {
    @Localized var tr
    @Binding var selectedTab: SkeletonExamplesTab
    @State private var isLoading = true

    // 懒加载状态
    @State private var apiReady = false
    @State private var tokenReady = false

    /// 锚点列表
    private let anchors: [AnchorItem] = [
        AnchorItem(id: "basic", titleKey: "skeleton.basic"),
        AnchorItem(id: "active", titleKey: "skeleton.active"),
        AnchorItem(id: "complex", titleKey: "skeleton.complex"),
        AnchorItem(id: "element", titleKey: "skeleton.element"),
        AnchorItem(id: "loading", titleKey: "skeleton.loading"),
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

    private func triggerLazyLoad(for tab: SkeletonExamplesTab) {
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
        ExamplePageWithAnchor(pageName: "Skeleton", anchors: anchors) { _ in
            basicExample.id("basic")
            activeExample.id("active")
            complexExample.id("complex")
            elementExample.id("element")
            loadingExample.id("loading")
        }
    }

    // MARK: - API Content

    private var apiContent: some View {
        SkeletonAPIView()
    }

    // MARK: - Token Content

    private var tokenContent: some View {
        SkeletonTokenView()
    }

    // MARK: - Examples

    private var basicExample: some View {
        ExampleSection(
            title: tr("skeleton.basic"),
            description: tr("skeleton.basic_desc"),
            content: {
                VStack(spacing: 24) {
                    Moin.Skeleton()
                }
            },
            code: {
                """
                // \(tr("skeleton.default"))
                Moin.Skeleton()
                """
            }
        )
    }

    private var activeExample: some View {
        ExampleSection(
            title: tr("skeleton.active"),
            description: tr("skeleton.active_desc"),
            content: {
                VStack(spacing: 24) {
                    Moin.Skeleton(active: true, avatar: true)
                }
            },
            code: {
                """
                // \(tr("skeleton.animation"))
                Moin.Skeleton(active: true, avatar: true)
                """
            }
        )
    }

    private var complexExample: some View {
        ExampleSection(
            title: tr("skeleton.complex"),
            description: tr("skeleton.complex_desc"),
            content: {
                VStack(spacing: 24) {
                    // 只有段落
                    Moin.Skeleton(title: false, paragraph: true)

                    // 圆角模式
                    Moin.Skeleton(avatar: true, round: true)

                    // 自定义段落行数
                    Moin.Skeleton(
                        avatar: nil,
                        title: Moin.SkeletonTitleProps(width: 200),
                        paragraph: Moin.SkeletonParagraphProps(rows: 2, width: 150),
                        round: false
                    )
                }
            },
            code: {
                """
                // \(tr("skeleton.paragraph_only"))
                Moin.Skeleton(title: false, paragraph: true)

                // \(tr("skeleton.round_mode"))
                Moin.Skeleton(avatar: true, round: true)

                // \(tr("skeleton.custom_config"))
                Moin.Skeleton(
                    avatar: nil,
                    title: Moin.SkeletonTitleProps(width: 200),
                    paragraph: Moin.SkeletonParagraphProps(rows: 2, width: 150),
                    round: false
                )
                """
            }
        )
    }

    private var elementExample: some View {
        ExampleSection(
            title: tr("skeleton.element"),
            description: tr("skeleton.element_desc"),
            content: {
                VStack(spacing: 24) {
                    // 头像元素
                    VStack(alignment: .leading, spacing: 8) {
                        Text(tr("skeleton.avatar_element")).font(.caption).foregroundStyle(.secondary)
                        HStack(spacing: 16) {
                            Moin.SkeletonAvatar(shape: .circle)
                            Moin.SkeletonAvatar(shape: .square)
                            Moin.SkeletonAvatar(size: .large)
                            Moin.SkeletonAvatar(size: .small)
                            Moin.SkeletonAvatar(size: 48) // 自定义尺寸
                        }
                    }

                    // 按钮元素
                    VStack(alignment: .leading, spacing: 8) {
                        Text(tr("skeleton.button_element")).font(.caption).foregroundStyle(.secondary)
                        HStack(spacing: 16) {
                            Moin.SkeletonButton(shape: .default)
                            Moin.SkeletonButton(shape: .circle)
                            Moin.SkeletonButton(shape: .round)
                            Moin.SkeletonButton(shape: .square)
                            Moin.SkeletonButton(size: .small)
                            Moin.SkeletonButton(size: .large)
                            Moin.SkeletonButton(block: true)
                        }
                    }

                    // 输入框元素
                    VStack(alignment: .leading, spacing: 8) {
                        Text(tr("skeleton.input_element")).font(.caption).foregroundStyle(.secondary)
                        HStack(spacing: 16) {
                            Moin.SkeletonInput()
                            Moin.SkeletonInput(size: .small)
                            Moin.SkeletonInput(size: .large)
                            Moin.SkeletonInput(block: true)
                        }
                    }

                    // 图片元素
                    VStack(alignment: .leading, spacing: 8) {
                        Text(tr("skeleton.image_element")).font(.caption).foregroundStyle(.secondary)
                        HStack(spacing: 16) {
                            Moin.SkeletonImage()
                            Moin.SkeletonImage(width: 120, height: 80)
                        }
                    }

                    // Node 元素
                    VStack(alignment: .leading, spacing: 8) {
                        Text(tr("skeleton.node_element")).font(.caption).foregroundStyle(.secondary)
                        HStack(spacing: 16) {
                            Moin.SkeletonNode()
                            Moin.SkeletonNode {
                                Circle()
                                    .fill(Color.blue)
                                    .frame(width: 40, height: 40)
                            }
                        }
                    }
                }
            },
            code: {
                """
                // \(tr("skeleton.avatar_element"))
                Moin.SkeletonAvatar(shape: .circle)
                Moin.SkeletonAvatar(shape: .square)
                Moin.SkeletonAvatar(size: .large)
                Moin.SkeletonAvatar(size: .small)
                Moin.SkeletonAvatar(size: 48)

                // \(tr("skeleton.button_element"))
                Moin.SkeletonButton(shape: .default)
                Moin.SkeletonButton(shape: .circle)
                Moin.SkeletonButton(shape: .round)
                Moin.SkeletonButton(shape: .square)
                Moin.SkeletonButton(size: .small)
                Moin.SkeletonButton(size: .large)
                Moin.SkeletonButton(block: true)

                // \(tr("skeleton.input_element"))
                Moin.SkeletonInput()
                Moin.SkeletonInput(size: .small)
                Moin.SkeletonInput(size: .large)
                Moin.SkeletonInput(block: true)

                // \(tr("skeleton.image_element"))
                Moin.SkeletonImage()
                Moin.SkeletonImage(width: 120, height: 80)

                // \(tr("skeleton.node_element"))
                Moin.SkeletonNode()
                Moin.SkeletonNode {
                    Circle()
                        .fill(Color.blue)
                        .frame(width: 40, height: 40)
                }
                """
            }
        )
    }

    private var loadingExample: some View {
        ExampleSection(
            title: tr("skeleton.loading"),
            description: tr("skeleton.loading_desc"),
            content: {
                VStack(spacing: 16) {
                    Toggle(tr("skeleton.toggle_loading"), isOn: $isLoading)
                        .frame(width: 160)

                    Moin.Skeleton(loading: isLoading, active: true, avatar: true) {
                        HStack(spacing: 16) {
                            Circle()
                                .fill(Color.blue)
                                .frame(width: 40, height: 40)
                            VStack(alignment: .leading, spacing: 4) {
                                Text(tr("skeleton.user_name"))
                                    .font(.headline)
                                Text(tr("skeleton.user_desc"))
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }
                            Spacer()
                        }
                    }
                }
            },
            code: {
                """
                Moin.Skeleton(loading: isLoading, active: true, avatar: true) {
                    HStack(spacing: 16) {
                        // \(tr("skeleton.actual_content"))
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 40, height: 40)
                        VStack(alignment: .leading) {
                            Text("\(tr("skeleton.user_name"))")
                            Text("\(tr("skeleton.user_desc"))")
                        }
                    }
                }
                """
            }
        )
    }
}
