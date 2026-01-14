import SwiftUI
import MoinUI

// MARK: - Token Playground Panel Tab

/// Token Playground 右侧面板 Tab
enum TokenPlaygroundPanelTab: String, CaseIterable {
    case seed
    case global
    case button
    case tag
    case space
    case divider

    var titleKey: String {
        switch self {
        case .seed: return "token.playground.tab.seed"
        case .global: return "token.playground.tab.global"
        case .button: return "token.playground.tab.button"
        case .tag: return "token.playground.tab.tag"
        case .space: return "token.playground.tab.space"
        case .divider: return "token.playground.tab.divider"
        }
    }
}

// MARK: - TokenPlayground

/// Token Playground 视图
struct TokenPlayground: View {
    @Localized var tr
    @ObservedObject private var config = Moin.ConfigProvider.shared
    @State private var selectedPanel: TokenPlaygroundPanelTab = .seed

    var body: some View {
        HStack(spacing: 0) {
            // 左侧：预览 + 代码
            VStack(spacing: 0) {
                previewSection
                Divider()
                codeSection
            }

            Divider()

            // 右侧：Token 编辑面板
            VStack(spacing: 0) {
                panelTabBar
                Divider()
                panelContent
            }
            .frame(width: 360)
        }
        .padding(Moin.Constants.Spacing.xl)
        .background(Color(nsColor: .controlBackgroundColor))
    }

    // MARK: - Preview Section

    private var previewSection: some View {
        VStack(alignment: .leading, spacing: Moin.Constants.Spacing.md) {
            HStack {
                Text(tr("token.playground.preview"))
                    .font(.system(size: 11, weight: .medium))
                    .foregroundStyle(.secondary)
                Spacer()
            }

            ScrollView {
                VStack(alignment: .leading, spacing: Moin.Constants.Spacing.lg) {
                    // 语义色按钮
                    VStack(alignment: .leading, spacing: Moin.Constants.Spacing.sm) {
                        Text(tr("token.playground.colors"))
                            .font(.system(size: 12, weight: .medium))
                            .foregroundStyle(.secondary)
                        HStack(spacing: Moin.Constants.Spacing.sm) {
                            Moin.Button(tr("button.label.primary"), color: .primary) {}
                            Moin.Button(tr("button.label.success"), color: .success) {}
                            Moin.Button(tr("button.label.warning"), color: .warning) {}
                            Moin.Button(tr("button.label.danger"), color: .danger) {}
                            Moin.Button(tr("button.label.info"), color: .info) {}
                        }
                    }

                    // 尺寸按钮
                    VStack(alignment: .leading, spacing: Moin.Constants.Spacing.sm) {
                        Text(tr("token.playground.sizes"))
                            .font(.system(size: 12, weight: .medium))
                            .foregroundStyle(.secondary)
                        HStack(spacing: Moin.Constants.Spacing.sm) {
                            Moin.Button(tr("button.label.small"), color: .primary, size: .small) {}
                            Moin.Button(tr("button.label.medium"), color: .primary, size: .medium) {}
                            Moin.Button(tr("button.label.large"), color: .primary, size: .large) {}
                        }
                    }

                    // 变体按钮
                    VStack(alignment: .leading, spacing: Moin.Constants.Spacing.sm) {
                        Text(tr("token.playground.variants"))
                            .font(.system(size: 12, weight: .medium))
                            .foregroundStyle(.secondary)
                        HStack(spacing: Moin.Constants.Spacing.sm) {
                            Moin.Button(tr("button.label.solid"), color: .primary, variant: .solid) {}
                            Moin.Button(tr("button.label.outlined"), color: .primary, variant: .outlined) {}
                            Moin.Button(tr("button.label.dashed"), color: .primary, variant: .dashed) {}
                            Moin.Button(tr("button.label.filled"), color: .primary, variant: .filled) {}
                            Moin.Button(tr("button.label.text"), color: .primary, variant: .text) {}
                        }
                    }

                    // Tag 组件
                    VStack(alignment: .leading, spacing: Moin.Constants.Spacing.sm) {
                        Text(tr("token.playground.tags"))
                            .font(.system(size: 12, weight: .medium))
                            .foregroundStyle(.secondary)
                        HStack(spacing: Moin.Constants.Spacing.sm) {
                            Moin.Tag("Default")
                            Moin.Tag("Primary", color: .primary)
                            Moin.Tag("Success", color: .success)
                            Moin.Tag("Warning", color: .warning)
                            Moin.Tag("Error", color: .error)
                        }
                    }

                    // Divider 组件
                    VStack(alignment: .leading, spacing: Moin.Constants.Spacing.sm) {
                        Text(tr("token.playground.dividers"))
                            .font(.system(size: 12, weight: .medium))
                            .foregroundStyle(.secondary)
                        Moin.Divider()
                        Moin.Divider(tr("token.playground.divider_text"))
                        Moin.Divider(variant: .dashed)
                    }

                    // Space 组件
                    VStack(alignment: .leading, spacing: Moin.Constants.Spacing.sm) {
                        Text(tr("token.playground.spacing"))
                            .font(.system(size: 12, weight: .medium))
                            .foregroundStyle(.secondary)
                        Moin.Space(size: .medium) {
                            ForEach(0..<4) { _ in
                                RoundedRectangle(cornerRadius: config.token.borderRadius)
                                    .fill(config.token.colorPrimary.opacity(0.3))
                                    .frame(width: 60, height: 32)
                            }
                        }
                    }

                    // Typography
                    VStack(alignment: .leading, spacing: Moin.Constants.Spacing.sm) {
                        Text(tr("token.playground.typography"))
                            .font(.system(size: 12, weight: .medium))
                            .foregroundStyle(.secondary)
                        Text("Heading 1")
                            .font(.system(size: config.token.fontSizeHeading1))
                            .foregroundStyle(config.token.colorText)
                        Text("Heading 3")
                            .font(.system(size: config.token.fontSizeHeading3))
                            .foregroundStyle(config.token.colorText)
                        Text("Body Text - \(tr("token.playground.body_sample"))")
                            .font(.system(size: config.token.fontSize))
                            .foregroundStyle(config.token.colorText)
                        Text("Secondary Text")
                            .font(.system(size: config.token.fontSizeSM))
                            .foregroundStyle(config.token.colorTextSecondary)
                    }
                }
                .padding(Moin.Constants.Spacing.md)
            }
        }
        .padding(Moin.Constants.Spacing.md)
        .frame(maxWidth: .infinity, minHeight: 400)
        .background(
            RoundedRectangle(cornerRadius: Moin.Constants.Radius.md)
                .fill(Color(nsColor: .windowBackgroundColor))
        )
    }

    // MARK: - Code Section

    private var codeSection: some View {
        VStack(alignment: .leading, spacing: Moin.Constants.Spacing.sm) {
            HStack {
                Text(tr("token.playground.code"))
                    .font(.system(size: 11, weight: .medium))
                    .foregroundStyle(.secondary)
                Spacer()
            }

            ScrollView(.horizontal, showsIndicators: false) {
                Text(generateCode())
                    .font(.system(size: 12, design: .monospaced))
                    .foregroundStyle(.primary)
            }
            .frame(maxWidth: .infinity, maxHeight: 100, alignment: .topLeading)
        }
        .padding(Moin.Constants.Spacing.md)
        .background(config.isDarkMode ? Color(white: 0.08) : Color(white: 0.96))
    }

    private func generateCode() -> String {
        """
        // 修改 SeedToken
        let config = Moin.ConfigProvider.shared
        config.setPrimaryColor(Color(hex: "\(config.seed.colorPrimary.hexString)"))
        config.setBorderRadius(\(Int(config.seed.borderRadius)))
        config.setFontSize(\(Int(config.seed.fontSize)))
        """
    }

    // MARK: - Panel Tab Bar

    private var panelTabBar: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                ForEach(TokenPlaygroundPanelTab.allCases, id: \.self) { tab in
                    Button {
                        selectedPanel = tab
                    } label: {
                        Text(tr(tab.titleKey))
                            .font(.system(size: 11, weight: selectedPanel == tab ? .medium : .regular))
                            .foregroundStyle(selectedPanel == tab ? config.token.colorPrimary : .secondary)
                            .padding(.horizontal, Moin.Constants.Spacing.sm)
                            .padding(.vertical, Moin.Constants.Spacing.xs)
                            .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)
                    .background(selectedPanel == tab ? config.token.colorPrimary.opacity(0.1) : .clear)
                }
            }
            .padding(.horizontal, Moin.Constants.Spacing.xs)
        }
        .frame(height: 32)
        .background(Color(nsColor: .controlBackgroundColor))
    }

    // MARK: - Panel Content

    private var panelContent: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.md) {
                // 重置按钮
                HStack {
                    Spacer()
                    Button {
                        config.regenerateTokens()
                    } label: {
                        HStack(spacing: 4) {
                            Image(systemName: "arrow.counterclockwise")
                            Text(tr("token.playground.reset"))
                        }
                        .font(.system(size: 11))
                        .foregroundStyle(.secondary)
                    }
                    .buttonStyle(.plain)
                }

                // 根据选中 Tab 显示内容
                switch selectedPanel {
                case .seed:
                    seedTokenPanel
                case .global:
                    globalTokenPanel
                case .button:
                    buttonTokenPanel
                case .tag:
                    tagTokenPanel
                case .space:
                    spaceTokenPanel
                case .divider:
                    dividerTokenPanel
                }
            }
            .padding(Moin.Constants.Spacing.md)
        }
    }

    // MARK: - Seed Token Panel

    private var seedTokenPanel: some View {
        VStack(alignment: .leading, spacing: Moin.Constants.Spacing.md) {
            // 品牌色
            tokenGroup(tr("token.playground.brand_colors")) {
                TokenColorRow(label: "colorPrimary", color: $config.seed.colorPrimary)
                TokenColorRow(label: "colorSuccess", color: $config.seed.colorSuccess)
                TokenColorRow(label: "colorWarning", color: $config.seed.colorWarning)
                TokenColorRow(label: "colorError", color: $config.seed.colorError)
                TokenColorRow(label: "colorInfo", color: $config.seed.colorInfo)
                TokenColorRow(label: "colorLink", color: $config.seed.colorLink)
            }

            // 基础色
            tokenGroup(tr("token.playground.base_colors")) {
                TokenColorRow(label: "colorTextBase", color: $config.seed.colorTextBase)
                TokenColorRow(label: "colorBgBase", color: $config.seed.colorBgBase)
            }

            // 字体
            tokenGroup(tr("token.playground.font")) {
                TokenValueRow(label: "fontSize", value: $config.seed.fontSize, range: 10...20)
            }

            // 圆角
            tokenGroup(tr("token.playground.radius")) {
                TokenValueRow(label: "borderRadius", value: $config.seed.borderRadius, range: 0...20)
            }

            // 尺寸
            tokenGroup(tr("token.playground.size")) {
                TokenValueRow(label: "controlHeight", value: $config.seed.controlHeight, range: 24...48)
                TokenValueRow(label: "sizeUnit", value: $config.seed.sizeUnit, range: 2...8)
            }

            // 线条
            tokenGroup(tr("token.playground.line")) {
                TokenValueRow(label: "lineWidth", value: $config.seed.lineWidth, range: 1...4)
            }
        }
    }

    // MARK: - Global Token Panel

    private var globalTokenPanel: some View {
        VStack(alignment: .leading, spacing: Moin.Constants.Spacing.md) {
            // 颜色 (只读展示)
            tokenGroup(tr("token.playground.derived_colors")) {
                TokenColorDisplayRow(label: "colorPrimaryHover", color: config.token.colorPrimaryHover)
                TokenColorDisplayRow(label: "colorPrimaryActive", color: config.token.colorPrimaryActive)
                TokenColorDisplayRow(label: "colorPrimaryBg", color: config.token.colorPrimaryBg)
                TokenColorDisplayRow(label: "colorPrimaryBorder", color: config.token.colorPrimaryBorder)
            }

            // 文本颜色
            tokenGroup(tr("token.playground.text_colors")) {
                TokenColorDisplayRow(label: "colorText", color: config.token.colorText)
                TokenColorDisplayRow(label: "colorTextSecondary", color: config.token.colorTextSecondary)
                TokenColorDisplayRow(label: "colorTextTertiary", color: config.token.colorTextTertiary)
            }

            // 背景颜色
            tokenGroup(tr("token.playground.bg_colors")) {
                TokenColorDisplayRow(label: "colorBgContainer", color: config.token.colorBgContainer)
                TokenColorDisplayRow(label: "colorBgElevated", color: config.token.colorBgElevated)
                TokenColorDisplayRow(label: "colorBgLayout", color: config.token.colorBgLayout)
            }

            // 边框颜色
            tokenGroup(tr("token.playground.border_colors")) {
                TokenColorDisplayRow(label: "colorBorder", color: config.token.colorBorder)
                TokenColorDisplayRow(label: "colorBorderSecondary", color: config.token.colorBorderSecondary)
            }

            // 派生尺寸
            tokenGroup(tr("token.playground.derived_sizes")) {
                TokenDisplayRow(label: "fontSizeSM", value: "\(Int(config.token.fontSizeSM))px")
                TokenDisplayRow(label: "fontSizeLG", value: "\(Int(config.token.fontSizeLG))px")
                TokenDisplayRow(label: "controlHeightSM", value: "\(Int(config.token.controlHeightSM))px")
                TokenDisplayRow(label: "controlHeightLG", value: "\(Int(config.token.controlHeightLG))px")
                TokenDisplayRow(label: "borderRadiusSM", value: "\(Int(config.token.borderRadiusSM))px")
                TokenDisplayRow(label: "borderRadiusLG", value: "\(Int(config.token.borderRadiusLG))px")
            }

            // 间距
            tokenGroup(tr("token.playground.spacing_values")) {
                TokenDisplayRow(label: "paddingXS", value: "\(Int(config.token.paddingXS))px")
                TokenDisplayRow(label: "paddingSM", value: "\(Int(config.token.paddingSM))px")
                TokenDisplayRow(label: "padding", value: "\(Int(config.token.padding))px")
                TokenDisplayRow(label: "paddingMD", value: "\(Int(config.token.paddingMD))px")
                TokenDisplayRow(label: "paddingLG", value: "\(Int(config.token.paddingLG))px")
            }
        }
    }

    // MARK: - Button Token Panel

    private var buttonTokenPanel: some View {
        VStack(alignment: .leading, spacing: Moin.Constants.Spacing.md) {
            tokenGroup(tr("token.playground.button_colors")) {
                TokenColorRow(label: "defaultColor", color: $config.components.button.defaultColor)
                TokenColorRow(label: "defaultBg", color: $config.components.button.defaultBg)
                TokenColorRow(label: "defaultBorderColor", color: $config.components.button.defaultBorderColor)
                TokenColorRow(label: "primaryColor", color: $config.components.button.primaryColor)
                TokenColorRow(label: "dangerColor", color: $config.components.button.dangerColor)
            }

            tokenGroup(tr("token.playground.button_sizes")) {
                TokenValueRow(label: "paddingInline", value: $config.components.button.paddingInline, range: 0...30)
                TokenValueRow(label: "paddingInlineLG", value: $config.components.button.paddingInlineLG, range: 0...40)
                TokenValueRow(label: "paddingInlineSM", value: $config.components.button.paddingInlineSM, range: 0...20)
                TokenValueRow(label: "paddingBlock", value: $config.components.button.paddingBlock, range: 0...20)
                TokenValueRow(label: "iconGap", value: $config.components.button.iconGap, range: 0...16)
            }

            tokenGroup(tr("token.playground.button_font")) {
                TokenValueRow(label: "contentFontSize", value: $config.components.button.contentFontSize, range: 10...20)
                TokenValueRow(label: "contentFontSizeLG", value: $config.components.button.contentFontSizeLG, range: 12...24)
                TokenValueRow(label: "contentFontSizeSM", value: $config.components.button.contentFontSizeSM, range: 8...16)
            }
        }
    }

    // MARK: - Tag Token Panel

    private var tagTokenPanel: some View {
        VStack(alignment: .leading, spacing: Moin.Constants.Spacing.md) {
            tokenGroup(tr("token.playground.tag_colors")) {
                TokenColorRow(label: "defaultBg", color: $config.components.tag.defaultBg)
                TokenColorRow(label: "defaultColor", color: $config.components.tag.defaultColor)
                TokenColorRow(label: "solidTextColor", color: $config.components.tag.solidTextColor)
            }

            tokenGroup(tr("token.playground.tag_sizes")) {
                TokenValueRow(label: "fontSize", value: $config.components.tag.fontSize, range: 8...16)
                TokenValueRow(label: "fontSizeLG", value: $config.components.tag.fontSizeLG, range: 10...20)
                TokenValueRow(label: "fontSizeSM", value: $config.components.tag.fontSizeSM, range: 6...14)
                TokenValueRow(label: "paddingH", value: $config.components.tag.paddingH, range: 0...16)
                TokenValueRow(label: "paddingV", value: $config.components.tag.paddingV, range: 0...12)
            }
        }
    }

    // MARK: - Space Token Panel

    private var spaceTokenPanel: some View {
        VStack(alignment: .leading, spacing: Moin.Constants.Spacing.md) {
            tokenGroup(tr("token.playground.space_sizes")) {
                TokenValueRow(label: "sizeSmall", value: $config.components.space.sizeSmall, range: 2...16)
                TokenValueRow(label: "sizeMedium", value: $config.components.space.sizeMedium, range: 4...24)
                TokenValueRow(label: "sizeLarge", value: $config.components.space.sizeLarge, range: 8...32)
            }
        }
    }

    // MARK: - Divider Token Panel

    private var dividerTokenPanel: some View {
        VStack(alignment: .leading, spacing: Moin.Constants.Spacing.md) {
            tokenGroup(tr("token.playground.divider_colors")) {
                TokenColorRow(label: "lineColor", color: $config.components.divider.lineColor)
                TokenColorRow(label: "textColor", color: $config.components.divider.textColor)
            }

            tokenGroup(tr("token.playground.divider_sizes")) {
                TokenValueRow(label: "fontSize", value: $config.components.divider.fontSize, range: 10...18)
                TokenValueRow(label: "lineWidth", value: $config.components.divider.lineWidth, range: 1...4)
                TokenValueRow(label: "verticalMargin", value: $config.components.divider.verticalMargin, range: 0...32)
                TokenValueRow(label: "horizontalMargin", value: $config.components.divider.horizontalMargin, range: 0...24)
                TokenValueRow(label: "textPadding", value: $config.components.divider.textPadding, range: 0...32)
            }
        }
    }

    // MARK: - Helper

    private func tokenGroup<Content: View>(_ title: String, @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: Moin.Constants.Spacing.sm) {
            Text(title)
                .font(.system(size: 11, weight: .medium))
                .foregroundStyle(.secondary)
            content()
        }
    }
}

// MARK: - Color Extension

extension Color {
    var hexString: String {
        guard let components = NSColor(self).cgColor.components else { return "#000000" }
        let r = Int(components[0] * 255)
        let g = Int(components[1] * 255)
        let b = Int(components[2] * 255)
        return String(format: "#%02X%02X%02X", r, g, b)
    }
}
