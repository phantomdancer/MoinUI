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
                .frame(width: 260)

            Divider()

            // 右侧：竖排 Tab 导航
            panelTabBar
        }
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
                            Moin.Button(tr("button.label.link"), color: .primary, variant: .link) {}
                        }
                    }

                    // 默认色按钮（测试 defaultColor）
                    VStack(alignment: .leading, spacing: Moin.Constants.Spacing.sm) {
                        Text(tr("token.playground.default_buttons"))
                            .font(.system(size: 12, weight: .medium))
                            .foregroundStyle(.secondary)
                        HStack(spacing: Moin.Constants.Spacing.sm) {
                            Moin.Button(tr("button.label.default"), color: .default, variant: .solid) {}
                            Moin.Button(tr("button.label.default"), color: .default, variant: .outlined) {}
                            Moin.Button(tr("button.label.default"), color: .default, variant: .text) {}
                            Moin.Button(tr("button.label.default"), color: .default, variant: .link) {}
                        }
                    }

                    // Tag 组件
                    VStack(alignment: .leading, spacing: Moin.Constants.Spacing.sm) {
                        Text(tr("token.playground.tags"))
                            .font(.system(size: 12, weight: .medium))
                            .foregroundStyle(.secondary)
                        // Filled 变体（默认）- defaultBg/defaultColor 影响 Default 标签
                        HStack(spacing: Moin.Constants.Spacing.sm) {
                            Moin.Tag("Default")
                            Moin.Tag("Primary", color: .primary)
                            Moin.Tag("Success", color: .success)
                            Moin.Tag("Warning", color: .warning)
                            Moin.Tag("Error", color: .error)
                        }
                        // Solid 变体 - solidTextColor 影响所有 solid 标签
                        HStack(spacing: Moin.Constants.Spacing.sm) {
                            Moin.Tag("Default", variant: .solid)
                            Moin.Tag("Primary", color: .primary, variant: .solid)
                            Moin.Tag("Success", color: .success, variant: .solid)
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

                        HStack(spacing: Moin.Constants.Spacing.md) {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Small")
                                    .font(.system(size: 10))
                                    .foregroundStyle(.tertiary)
                                Moin.Space(size: .small) {
                                    ForEach(0..<3, id: \.self) { _ in
                                        RoundedRectangle(cornerRadius: config.token.borderRadius)
                                            .fill(config.token.colorPrimary.opacity(0.3))
                                            .frame(width: 40, height: 24)
                                    }
                                }
                            }

                            VStack(alignment: .leading, spacing: 4) {
                                Text("Medium")
                                    .font(.system(size: 10))
                                    .foregroundStyle(.tertiary)
                                Moin.Space(size: .medium) {
                                    ForEach(0..<3, id: \.self) { _ in
                                        RoundedRectangle(cornerRadius: config.token.borderRadius)
                                            .fill(config.token.colorSuccess.opacity(0.3))
                                            .frame(width: 40, height: 24)
                                    }
                                }
                            }

                            VStack(alignment: .leading, spacing: 4) {
                                Text("Large")
                                    .font(.system(size: 10))
                                    .foregroundStyle(.tertiary)
                                Moin.Space(size: .large) {
                                    ForEach(0..<3, id: \.self) { _ in
                                        RoundedRectangle(cornerRadius: config.token.borderRadius)
                                            .fill(config.token.colorWarning.opacity(0.3))
                                            .frame(width: 40, height: 24)
                                    }
                                }
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

            ScrollView([.horizontal, .vertical], showsIndicators: true) {
                VStack(alignment: .leading, spacing: 0) {
                    HighlightedCodeView(code: generateCode(), fontSize: 12)
                        .fixedSize(horizontal: true, vertical: true)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding(Moin.Constants.Spacing.sm)
            }
            .frame(minHeight: 150, maxHeight: 200, alignment: .topLeading)
            .background(config.isDarkMode ? Color(white: 0.08) : Color(white: 0.96))
            .cornerRadius(Moin.Constants.Radius.sm)
            .id("code-\(selectedPanel.rawValue)")
        }
        .padding(Moin.Constants.Spacing.md)
    }

    private func generateCode() -> String {
        switch selectedPanel {
        case .seed:
            return """
// \(tr("token.playground.code_seed_config"))
let config = Moin.ConfigProvider.shared
config.configureSeed { seed in
    // \(tr("token.playground.brand_colors"))
    seed.colorPrimary = Color(hex: "\(config.seed.colorPrimary.hexString)")
    seed.colorSuccess = Color(hex: "\(config.seed.colorSuccess.hexString)")
    seed.colorWarning = Color(hex: "\(config.seed.colorWarning.hexString)")
    seed.colorError = Color(hex: "\(config.seed.colorError.hexString)")
    seed.colorInfo = Color(hex: "\(config.seed.colorInfo.hexString)")
    seed.colorLink = Color(hex: "\(config.seed.colorLink.hexString)")
    // \(tr("token.playground.base_colors"))
    seed.colorTextBase = Color(hex: "\(config.seed.colorTextBase.hexString)")
    seed.colorBgBase = Color(hex: "\(config.seed.colorBgBase.hexString)")
    // \(tr("token.playground.font"))
    seed.fontSize = \(Int(config.seed.fontSize))
    // \(tr("token.playground.radius"))
    seed.borderRadius = \(Int(config.seed.borderRadius))
    // \(tr("token.playground.size"))
    seed.controlHeight = \(Int(config.seed.controlHeight))
    seed.sizeUnit = \(Int(config.seed.sizeUnit))
    // \(tr("token.playground.line"))
    seed.lineWidth = \(Int(config.seed.lineWidth))
}
"""
        case .global:
            return """
// \(tr("token.playground.code_global_readonly"))
// \(tr("token.playground.derived_colors"))
token.colorPrimaryHover    // \(config.token.colorPrimaryHover.hexString)
token.colorPrimaryActive   // \(config.token.colorPrimaryActive.hexString)
token.colorPrimaryBg       // \(config.token.colorPrimaryBg.hexString)
token.colorPrimaryBorder   // \(config.token.colorPrimaryBorder.hexString)
// \(tr("token.playground.text_colors"))
token.colorText            // \(config.token.colorText.hexString)
token.colorTextSecondary   // \(config.token.colorTextSecondary.hexString)
token.colorTextTertiary    // \(config.token.colorTextTertiary.hexString)
// \(tr("token.playground.bg_colors"))
token.colorBgContainer     // \(config.token.colorBgContainer.hexString)
token.colorBgElevated      // \(config.token.colorBgElevated.hexString)
token.colorBgLayout        // \(config.token.colorBgLayout.hexString)
// \(tr("token.playground.border_colors"))
token.colorBorder          // \(config.token.colorBorder.hexString)
token.colorBorderSecondary // \(config.token.colorBorderSecondary.hexString)
// \(tr("token.playground.derived_sizes"))
token.fontSizeSM = \(Int(config.token.fontSizeSM))
token.fontSizeLG = \(Int(config.token.fontSizeLG))
token.controlHeightSM = \(Int(config.token.controlHeightSM))
token.controlHeightLG = \(Int(config.token.controlHeightLG))
token.borderRadiusSM = \(Int(config.token.borderRadiusSM))
token.borderRadiusLG = \(Int(config.token.borderRadiusLG))
// \(tr("token.playground.spacing_values"))
token.paddingXS = \(Int(config.token.paddingXS))
token.paddingSM = \(Int(config.token.paddingSM))
token.padding = \(Int(config.token.padding))
token.paddingMD = \(Int(config.token.paddingMD))
token.paddingLG = \(Int(config.token.paddingLG))
"""
        case .button:
            return """
// \(tr("token.playground.code_button_config"))
config.components.button.defaultColor = Color(hex: "\(config.components.button.defaultColor.hexString)")
config.components.button.defaultBg = Color(hex: "\(config.components.button.defaultBg.hexString)")
config.components.button.defaultBorderColor = Color(hex: "\(config.components.button.defaultBorderColor.hexString)")
config.components.button.primaryColor = Color(hex: "\(config.components.button.primaryColor.hexString)")
config.components.button.dangerColor = Color(hex: "\(config.components.button.dangerColor.hexString)")
// \(tr("token.playground.button_sizes"))
config.components.button.paddingInline = \(Int(config.components.button.paddingInline))
config.components.button.paddingInlineLG = \(Int(config.components.button.paddingInlineLG))
config.components.button.paddingInlineSM = \(Int(config.components.button.paddingInlineSM))
config.components.button.paddingBlock = \(Int(config.components.button.paddingBlock))
config.components.button.iconGap = \(Int(config.components.button.iconGap))
// \(tr("token.playground.button_font"))
config.components.button.contentFontSize = \(Int(config.components.button.contentFontSize))
config.components.button.contentFontSizeLG = \(Int(config.components.button.contentFontSizeLG))
config.components.button.contentFontSizeSM = \(Int(config.components.button.contentFontSizeSM))
"""
        case .tag:
            return """
// \(tr("token.playground.code_tag_config"))
config.components.tag.defaultBg = Color(hex: "\(config.components.tag.defaultBg.hexString)")
config.components.tag.defaultColor = Color(hex: "\(config.components.tag.defaultColor.hexString)")
config.components.tag.solidTextColor = Color(hex: "\(config.components.tag.solidTextColor.hexString)")
// \(tr("token.playground.tag_sizes"))
config.components.tag.fontSize = \(Int(config.components.tag.fontSize))
config.components.tag.fontSizeLG = \(Int(config.components.tag.fontSizeLG))
config.components.tag.fontSizeSM = \(Int(config.components.tag.fontSizeSM))
config.components.tag.paddingH = \(Int(config.components.tag.paddingH))
config.components.tag.paddingV = \(Int(config.components.tag.paddingV))
"""
        case .space:
            return """
// \(tr("token.playground.code_space_config"))
config.components.space.sizeSmall = \(Int(config.components.space.sizeSmall))
config.components.space.sizeMedium = \(Int(config.components.space.sizeMedium))
config.components.space.sizeLarge = \(Int(config.components.space.sizeLarge))
"""
        case .divider:
            return """
// \(tr("token.playground.code_divider_config"))
config.components.divider.lineColor = Color(hex: "\(config.components.divider.lineColor.hexString)")
config.components.divider.textColor = Color(hex: "\(config.components.divider.textColor.hexString)")
// \(tr("token.playground.divider_sizes"))
config.components.divider.fontSize = \(Int(config.components.divider.fontSize))
config.components.divider.lineWidth = \(Int(config.components.divider.lineWidth))
config.components.divider.verticalMargin = \(Int(config.components.divider.verticalMargin))
config.components.divider.horizontalMargin = \(Int(config.components.divider.horizontalMargin))
config.components.divider.textPadding = \(Int(config.components.divider.textPadding))
"""
        }
    }

    // MARK: - Panel Tab Bar

    private var panelTabBar: some View {
        VStack(spacing: 4) {
            ForEach(TokenPlaygroundPanelTab.allCases, id: \.self) { tab in
                Button {
                    selectedPanel = tab
                } label: {
                    HStack(spacing: 8) {
                        Image(systemName: tab.icon)
                            .font(.system(size: 12))
                            .frame(width: 16)
                        Text(tab.title)
                            .font(.system(size: 12))
                            .lineLimit(1)
                            .fixedSize(horizontal: true, vertical: false)
                    }
                    .foregroundStyle(selectedPanel == tab ? config.token.colorPrimary : .secondary)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 8)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
                .background(
                    RoundedRectangle(cornerRadius: 6)
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
        .padding(8)
        .fixedSize(horizontal: true, vertical: false)
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
                TokenValueRow(label: "fontSize", value: $config.seed.fontSize, onChange: config.regenerateTokens)
            }

            // 圆角
            tokenGroup(tr("token.playground.radius")) {
                TokenValueRow(label: "borderRadius", value: $config.seed.borderRadius, onChange: config.regenerateTokens)
            }

            // 尺寸
            tokenGroup(tr("token.playground.size")) {
                TokenValueRow(label: "controlHeight", value: $config.seed.controlHeight, onChange: config.regenerateTokens)
                TokenValueRow(label: "sizeUnit", value: $config.seed.sizeUnit, onChange: config.regenerateTokens)
            }

            // 线条
            tokenGroup(tr("token.playground.line")) {
                TokenValueRow(label: "lineWidth", value: $config.seed.lineWidth, onChange: config.regenerateTokens)
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
                TokenValueRow(label: "paddingInline", value: $config.components.button.paddingInline)
                TokenValueRow(label: "paddingInlineLG", value: $config.components.button.paddingInlineLG)
                TokenValueRow(label: "paddingInlineSM", value: $config.components.button.paddingInlineSM)
                TokenValueRow(label: "paddingBlock", value: $config.components.button.paddingBlock)
                TokenValueRow(label: "iconGap", value: $config.components.button.iconGap)
            }

            tokenGroup(tr("token.playground.button_font")) {
                TokenValueRow(label: "contentFontSize", value: $config.components.button.contentFontSize)
                TokenValueRow(label: "contentFontSizeLG", value: $config.components.button.contentFontSizeLG)
                TokenValueRow(label: "contentFontSizeSM", value: $config.components.button.contentFontSizeSM)
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
                TokenValueRow(label: "fontSize", value: $config.components.tag.fontSize)
                TokenValueRow(label: "fontSizeLG", value: $config.components.tag.fontSizeLG)
                TokenValueRow(label: "fontSizeSM", value: $config.components.tag.fontSizeSM)
                TokenValueRow(label: "paddingH", value: $config.components.tag.paddingH)
                TokenValueRow(label: "paddingV", value: $config.components.tag.paddingV)
            }
        }
    }

    // MARK: - Space Token Panel

    private var spaceTokenPanel: some View {
        VStack(alignment: .leading, spacing: Moin.Constants.Spacing.md) {
            tokenGroup(tr("token.playground.space_sizes")) {
                TokenValueRow(label: "sizeSmall", value: $config.components.space.sizeSmall)
                TokenValueRow(label: "sizeMedium", value: $config.components.space.sizeMedium)
                TokenValueRow(label: "sizeLarge", value: $config.components.space.sizeLarge)
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
                TokenValueRow(label: "fontSize", value: $config.components.divider.fontSize)
                TokenValueRow(label: "lineWidth", value: $config.components.divider.lineWidth)
                TokenValueRow(label: "verticalMargin", value: $config.components.divider.verticalMargin)
                TokenValueRow(label: "horizontalMargin", value: $config.components.divider.horizontalMargin)
                TokenValueRow(label: "textPadding", value: $config.components.divider.textPadding)
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
