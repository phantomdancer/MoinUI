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
                    Skeleton()
                    Skeleton(avatar: true)
                }
                .frame(width: 350)
            },
            code: {
                """
                // \(tr("skeleton.default"))
                Skeleton()

                // \(tr("skeleton.with_avatar"))
                Skeleton(avatar: true)
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
                    Skeleton(active: true)
                    Skeleton(active: true, avatar: true)
                }
                .frame(width: 350)
            },
            code: {
                """
                // \(tr("skeleton.animation"))
                Skeleton(active: true)
                Skeleton(active: true, avatar: true)
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
                    Skeleton(active: true, title: false, paragraph: true)

                    // 圆角模式
                    Skeleton(active: true, avatar: true, round: true)

                    // 自定义段落行数
                    Skeleton(
                        active: true,
                        avatar: nil,
                        title: SkeletonTitleConfig(width: 200),
                        paragraph: SkeletonParagraphConfig(rows: 2, width: 150),
                        round: false
                    )
                }
                .frame(width: 350)
            },
            code: {
                """
                // \(tr("skeleton.paragraph_only"))
                Skeleton(active: true, title: false, paragraph: true)

                // \(tr("skeleton.round_mode"))
                Skeleton(active: true, avatar: true, round: true)

                // \(tr("skeleton.custom_config"))
                Skeleton(
                    active: true,
                    avatar: nil,
                    title: SkeletonTitleConfig(width: 200),
                    paragraph: SkeletonParagraphConfig(rows: 2, width: 150),
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
                    HStack(spacing: 16) {
                        SkeletonElement.avatar(active: true)
                        SkeletonElement.avatar(shape: .square, active: true)
                        SkeletonElement.avatar(size: .large, active: true)
                        SkeletonElement.avatar(size: .small, active: true)
                    }

                    // 按钮元素
                    HStack(spacing: 16) {
                        SkeletonElement.button(active: true)
                        SkeletonElement.button(shape: .circle, active: true)
                        SkeletonElement.button(shape: .round, active: true)
                        SkeletonElement.button(size: .small, active: true)
                    }

                    // 输入框元素
                    SkeletonElement.input(active: true)
                        .frame(width: 200)

                    // 图片元素
                    HStack(spacing: 16) {
                        SkeletonElement.image(active: true)
                        SkeletonElement.image(width: 120, height: 80, active: true)
                    }
                }
            },
            code: {
                """
                // \(tr("skeleton.avatar_element"))
                SkeletonElement.avatar(active: true)
                SkeletonElement.avatar(shape: .square, active: true)
                SkeletonElement.avatar(size: .large, active: true)

                // \(tr("skeleton.button_element"))
                SkeletonElement.button(active: true)
                SkeletonElement.button(shape: .circle, active: true)
                SkeletonElement.button(shape: .round, active: true)

                // \(tr("skeleton.input_element"))
                SkeletonElement.input(active: true)

                // \(tr("skeleton.image_element"))
                SkeletonElement.image(active: true)
                SkeletonElement.image(width: 120, height: 80, active: true)
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

                    Skeleton(loading: isLoading, active: true, avatar: true) {
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
                    .frame(width: 350)
                }
            },
            code: {
                """
                Skeleton(loading: isLoading, active: true, avatar: true) {
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
