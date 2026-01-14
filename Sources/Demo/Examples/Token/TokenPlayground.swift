import SwiftUI
import AppKit
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

    var title: String {
        rawValue.capitalized
    }

    var icon: String {
        switch self {
        case .seed: return "leaf"
        case .global: return "globe"
        case .button: return "rectangle.and.hand.point.up.left"
        case .tag: return "tag"
        case .space: return "rectangle.split.3x1"
        case .divider: return "minus"
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

            // 中间：Token 编辑面板内容
            panelContent
                .frame(width: 320)

            Divider()

            // 右侧：竖排 Tab 导航
            panelTabBar
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
                            Moin.Button(tr("button.label.small"), color: .primary, size: .small, icon: "star.fill") {}
                            Moin.Button(tr("button.label.medium"), color: .primary, size: .medium, icon: "heart.fill") {}
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
                HighlightedCodeView(code: generateCode(), fontSize: 12)
            }
            .frame(maxWidth: .infinity, maxHeight: 100, alignment: .topLeading)
        }
        .padding(Moin.Constants.Spacing.md)
        .background(config.isDarkMode ? Color(white: 0.08) : Color(white: 0.96))
    }

    private func generateCode() -> String {
        """
        // \(tr("token.playground.code_comment"))
        let config = Moin.ConfigProvider.shared
        config.setPrimaryColor(Color(hex: "\(config.seed.colorPrimary.hexString)"))
        config.configureSeed { seed in
            seed.colorSuccess = Color(hex: "\(config.seed.colorSuccess.hexString)")
            seed.colorWarning = Color(hex: "\(config.seed.colorWarning.hexString)")
            seed.colorError = Color(hex: "\(config.seed.colorError.hexString)")
            seed.colorInfo = Color(hex: "\(config.seed.colorInfo.hexString)")
            seed.borderRadius = \(Int(config.seed.borderRadius))
            seed.fontSize = \(Int(config.seed.fontSize))
            seed.controlHeight = \(Int(config.seed.controlHeight))
        }
        """
    }

    // MARK: - Panel Tab Bar

    private var panelTabBar: some View {
        VStack(spacing: 4) {
            ForEach(TokenPlaygroundPanelTab.allCases, id: \.self) { tab in
                Button {
                    selectedPanel = tab
                } label: {
                    VStack(spacing: 4) {
                        Image(systemName: tab.icon)
                            .font(.system(size: 16))
                        Text(tab.title)
                            .font(.system(size: 10, weight: selectedPanel == tab ? .medium : .regular))
                    }
                    .foregroundStyle(selectedPanel == tab ? config.token.colorPrimary : .secondary)
                    .frame(width: 52, height: 52)
                    .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(selectedPanel == tab ? config.token.colorPrimary.opacity(0.1) : .clear)
                )
                .onHover { hovering in
                    if hovering {
                        NSCursor.pointingHand.push()
                    } else {
                        NSCursor.pop()
                    }
                }
            }
            Spacer()
        }
        .padding(.vertical, Moin.Constants.Spacing.xs)
        .frame(width: 56)
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
                        config.reset()
                    } label: {
                        HStack(spacing: 4) {
                            Image(systemName: "arrow.counterclockwise")
                            Text(tr("token.playground.reset"))
                        }
                        .font(.system(size: 11))
                        .foregroundStyle(.secondary)
                    }
                    .buttonStyle(.plain)
                    .onHover { hovering in
                        if hovering {
                            NSCursor.pointingHand.push()
                        } else {
                            NSCursor.pop()
                        }
                    }
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
                ColorPresetRow(label: "colorPrimary", color: $config.seed.colorPrimary, onChange: config.regenerateTokens)
                ColorPresetRow(label: "colorSuccess", color: $config.seed.colorSuccess, onChange: config.regenerateTokens)
                ColorPresetRow(label: "colorWarning", color: $config.seed.colorWarning, onChange: config.regenerateTokens)
                ColorPresetRow(label: "colorError", color: $config.seed.colorError, onChange: config.regenerateTokens)
                ColorPresetRow(label: "colorInfo", color: $config.seed.colorInfo, onChange: config.regenerateTokens)
                ColorPresetRow(label: "colorLink", color: $config.seed.colorLink, onChange: config.regenerateTokens)
            }

            // 基础色
            tokenGroup(tr("token.playground.base_colors")) {
                ColorPresetRow(label: "colorTextBase", color: $config.seed.colorTextBase, onChange: config.regenerateTokens)
                ColorPresetRow(label: "colorBgBase", color: $config.seed.colorBgBase, onChange: config.regenerateTokens)
            }

            // 字体
            tokenGroup(tr("token.playground.font")) {
                TokenValueRow(label: "fontSize", value: $config.seed.fontSize, range: 10...20, onChange: config.regenerateTokens)
            }

            // 圆角
            tokenGroup(tr("token.playground.radius")) {
                TokenValueRow(label: "borderRadius", value: $config.seed.borderRadius, range: 0...20, onChange: config.regenerateTokens)
            }

            // 尺寸
            tokenGroup(tr("token.playground.size")) {
                TokenValueRow(label: "controlHeight", value: $config.seed.controlHeight, range: 24...48, onChange: config.regenerateTokens)
                TokenValueRow(label: "sizeUnit", value: $config.seed.sizeUnit, range: 2...8, onChange: config.regenerateTokens)
            }

            // 线条
            tokenGroup(tr("token.playground.line")) {
                TokenValueRow(label: "lineWidth", value: $config.seed.lineWidth, range: 1...4, onChange: config.regenerateTokens)
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
                ColorPresetRow(label: "defaultColor", color: $config.components.button.defaultColor)
                ColorPresetRow(label: "defaultBg", color: $config.components.button.defaultBg)
                ColorPresetRow(label: "defaultBorderColor", color: $config.components.button.defaultBorderColor)
                ColorPresetRow(label: "primaryColor", color: $config.components.button.primaryColor)
                ColorPresetRow(label: "dangerColor", color: $config.components.button.dangerColor)
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
                ColorPresetRow(label: "defaultBg", color: $config.components.tag.defaultBg)
                ColorPresetRow(label: "defaultColor", color: $config.components.tag.defaultColor)
                ColorPresetRow(label: "solidTextColor", color: $config.components.tag.solidTextColor)
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
                ColorPresetRow(label: "lineColor", color: $config.components.divider.lineColor)
                ColorPresetRow(label: "textColor", color: $config.components.divider.textColor)
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
