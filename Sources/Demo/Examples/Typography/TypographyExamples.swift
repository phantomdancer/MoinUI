import SwiftUI
import MoinUI

/// Typography 组件文档页面 Tab
enum TypographyExamplesTab: String, CaseIterable {
    case examples
    case playground
    case api
    case token
}

/// Typography component examples
struct TypographyExamples: View {
    @Localized var tr
    @Binding var selectedTab: TypographyExamplesTab

    // 懒加载状态
    @State private var playgroundReady = false
    @State private var apiReady = false
    @State private var tokenReady = false

    /// 锚点列表
    private let anchors: [AnchorItem] = [
        AnchorItem(id: "title", titleKey: "typography.title"),
        AnchorItem(id: "text", titleKey: "typography.text"),
        AnchorItem(id: "paragraph", titleKey: "typography.paragraph"),
        AnchorItem(id: "ellipsis", titleKey: "typography.ellipsis"),
        AnchorItem(id: "link", titleKey: "typography.link"),
        AnchorItem(id: "type", titleKey: "typography.type"),
        AnchorItem(id: "decoration", titleKey: "typography.decoration"),
        AnchorItem(id: "alias", titleKey: "typography.alias"),
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

    private func triggerLazyLoad(for tab: TypographyExamplesTab) {
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
        ExamplePageWithAnchor(pageName: "Typography", anchors: anchors) { _ in
            titleExample.id("title")
            textExample.id("text")
            paragraphExample.id("paragraph")
            ellipsisExample.id("ellipsis")
            linkExample.id("link")
            typeExample.id("type")
            decorationExample.id("decoration")
            aliasExample.id("alias")
        }
    }

    // MARK: - Playground Content

    private var playgroundContent: some View {
        TypographyPlayground()
            .padding(Moin.Constants.Spacing.xl)
    }

    // MARK: - API Content

    private var apiContent: some View {
        TypographyAPIContent()
    }

    // MARK: - Token Content

    private var tokenContent: some View {
        TypographyTokenContent()
    }

    // MARK: - Examples

    private var titleExample: some View {
        ExampleSection(
            title: tr("typography.title"),
            description: tr("typography.title_desc")
        ) {
            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.sm) {
                Moin.Typography.Title(tr("typography.example.h1"), level: .h1)
                Moin.Typography.Title(tr("typography.example.h2"), level: .h2)
                Moin.Typography.Title(tr("typography.example.h3"), level: .h3)
                Moin.Typography.Title(tr("typography.example.h4"), level: .h4)
                Moin.Typography.Title(tr("typography.example.h5"), level: .h5)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        } code: {
            """
            Moin.Typography.Title("\(tr("typography.example.h1"))", level: .h1)
            Moin.Typography.Title("\(tr("typography.example.h2"))", level: .h2)
            Moin.Typography.Title("\(tr("typography.example.h3"))", level: .h3)
            Moin.Typography.Title("\(tr("typography.example.h4"))", level: .h4)
            Moin.Typography.Title("\(tr("typography.example.h5"))", level: .h5)
            """
        }
    }

    private var textExample: some View {
        ExampleSection(
            title: tr("typography.text"),
            description: tr("typography.text_desc")
        ) {
            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.md) {
                Moin.Typography.Text(tr("typography.example.default"))
                Moin.Typography.Text(tr("typography.example.code"), code: true)
                Moin.Typography.Text(tr("typography.example.keyboard"), keyboard: true)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        } code: {
            """
            Moin.Typography.Text("\(tr("typography.example.default"))")
            Moin.Typography.Text("\(tr("typography.example.code"))", code: true)
            Moin.Typography.Text("\(tr("typography.example.keyboard"))", keyboard: true)
            """
        }
    }

    private var paragraphExample: some View {
        ExampleSection(
            title: tr("typography.paragraph"),
            description: tr("typography.paragraph_desc")
        ) {
            VStack(alignment: .leading, spacing: 0) {
                Moin.Typography.Paragraph(tr("typography.lorem_long"))
                Moin.Typography.Paragraph(tr("typography.lorem_short"))
            }
        } code: {
            """
            Moin.Typography.Paragraph("\(tr("typography.lorem_long"))")
            Moin.Typography.Paragraph("\(tr("typography.lorem_short"))")
            """
        }
    }

    private var ellipsisExample: some View {
        ExampleSection(
            title: tr("typography.ellipsis"),
            description: tr("typography.ellipsis_desc")
        ) {
            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.lg) {
                // 单行省略
                VStack(alignment: .leading, spacing: Moin.Constants.Spacing.xs) {
                    Moin.Typography.Text(tr("typography.ellipsis_single"), type: .secondary)
                    Moin.Typography.Paragraph(
                        tr("typography.lorem_ellipsis"),
                        ellipsis: .rows(1)
                    )
                }

                // 多行省略
                VStack(alignment: .leading, spacing: Moin.Constants.Spacing.xs) {
                    Moin.Typography.Text(tr("typography.ellipsis_multi"), type: .secondary)
                    Moin.Typography.Paragraph(
                        tr("typography.lorem_ellipsis"),
                        ellipsis: .rows(2)
                    )
                }

                // 可展开
                VStack(alignment: .leading, spacing: Moin.Constants.Spacing.xs) {
                    Moin.Typography.Text(tr("typography.ellipsis_expandable"), type: .secondary)
                    Moin.Typography.Paragraph(
                        tr("typography.lorem_ellipsis"),
                        ellipsis: .expandable(
                            rows: 2,
                            collapsible: true,
                            expandSymbol: tr("typography.expand"),
                            collapseSymbol: tr("typography.collapse")
                        )
                    )
                }

                // 带 tooltip
                VStack(alignment: .leading, spacing: Moin.Constants.Spacing.xs) {
                    Moin.Typography.Text(tr("typography.ellipsis_tooltip"), type: .secondary)
                    Moin.Typography.Paragraph(
                        tr("typography.lorem_ellipsis"),
                        ellipsis: Moin.Typography.EllipsisConfig(rows: 1, tooltip: true)
                    )
                }
            }
        } code: {
            """
            // \(tr("typography.ellipsis_single"))
            Moin.Typography.Paragraph(text, ellipsis: .rows(1))

            // \(tr("typography.ellipsis_multi"))
            Moin.Typography.Paragraph(text, ellipsis: .rows(2))

            // \(tr("typography.ellipsis_expandable"))
            Moin.Typography.Paragraph(
                text,
                ellipsis: .expandable(rows: 2, collapsible: true)
            )

            // \(tr("typography.ellipsis_tooltip"))
            Moin.Typography.Paragraph(
                text,
                ellipsis: Moin.Typography.EllipsisConfig(rows: 1, tooltip: true)
            )
            """
        }
    }

    private var linkExample: some View {
        ExampleSection(
            title: tr("typography.link"),
            description: tr("typography.link_desc")
        ) {
            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.md) {
                Moin.Typography.Link(tr("typography.example.link"), href: githubRepoURL)
                Moin.Typography.Link(tr("typography.example.link"), disabled: true) {
                    print("This should not be printed")
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        } code: {
            """
            Moin.Typography.Link("\(tr("typography.example.link"))", href: URL(string: "https://github.com/phantomdancer/MoinUI.git"))
            Moin.Typography.Link("\(tr("typography.example.link"))", disabled: true) {}
            """
        }
    }

    private var typeExample: some View {
        ExampleSection(
            title: tr("typography.type"),
            description: tr("typography.type_desc")
        ) {
            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.md) {
                Moin.Typography.Text(tr("typography.example.type_default"), type: .default)
                Moin.Typography.Text(tr("typography.example.type_secondary"), type: .secondary)
                Moin.Typography.Text(tr("typography.example.type_success"), type: .success)
                Moin.Typography.Text(tr("typography.example.type_warning"), type: .warning)
                Moin.Typography.Text(tr("typography.example.type_danger"), type: .danger)
                Moin.Typography.Text(tr("typography.example.type_disabled"), disabled: true)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        } code: {
            """
            Moin.Typography.Text("\(tr("typography.example.type_default"))", type: .default)
            Moin.Typography.Text("\(tr("typography.example.type_secondary"))", type: .secondary)
            Moin.Typography.Text("\(tr("typography.example.type_success"))", type: .success)
            Moin.Typography.Text("\(tr("typography.example.type_warning"))", type: .warning)
            Moin.Typography.Text("\(tr("typography.example.type_danger"))", type: .danger)
            Moin.Typography.Text("\(tr("typography.example.type_disabled"))", disabled: true)
            """
        }
    }

    private var decorationExample: some View {
        ExampleSection(
            title: tr("typography.decoration"),
            description: tr("typography.decoration_desc")
        ) {
            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.md) {
                Moin.Typography.Text(tr("typography.example.strong"), strong: true)
                Moin.Typography.Text(tr("typography.example.italic"), italic: true)
                Moin.Typography.Text(tr("typography.example.underline"), underline: true)
                Moin.Typography.Text(tr("typography.example.delete"), delete: true)
                Moin.Typography.Text(tr("typography.example.mark"), mark: true)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        } code: {
            """
            Moin.Typography.Text("\(tr("typography.example.strong"))", strong: true)
            Moin.Typography.Text("\(tr("typography.example.italic"))", italic: true)
            Moin.Typography.Text("\(tr("typography.example.underline"))", underline: true)
            Moin.Typography.Text("\(tr("typography.example.delete"))", delete: true)
            Moin.Typography.Text("\(tr("typography.example.mark"))", mark: true)
            """
        }
    }

    private var aliasExample: some View {
        ExampleSection(
            title: tr("typography.alias"),
            description: tr("typography.alias_desc")
        ) {
            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.md) {
                Moin.Typography.Title(tr("typography.example.h1"))
                Moin.Typography.Paragraph(tr("typography.lorem_short"))
                Moin.Typography.Text(tr("typography.example.default"))
                Moin.Typography.Link(tr("typography.example.link")) {
                    print("Link clicked")
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        } code: {
            """
            private typealias Title = Moin.Typography.Title
            private typealias Paragraph = Moin.Typography.Paragraph
            private typealias Text = Moin.Typography.Text
            private typealias Link = Moin.Typography.Link

            Title("\(tr("typography.example.h1"))")
            Paragraph("\(tr("typography.lorem_short"))")
            Text("\(tr("typography.example.default"))")
            Link("\(tr("typography.example.link"))") { print("clicked") }
            """
        }
    }
}
