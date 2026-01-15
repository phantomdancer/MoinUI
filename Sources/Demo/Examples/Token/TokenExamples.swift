import SwiftUI
import MoinUI

/// Token 页面 Tab
enum TokenExamplesTab: String, CaseIterable {
    case examples
    case playground
}

/// Token 系统示例页面
struct TokenExamples: View {
    @Localized var tr
    @Binding var selectedTab: TokenExamplesTab
    @ObservedObject private var config = Moin.ConfigProvider.shared

    /// 锚点列表
    private let anchors: [AnchorItem] = [
        AnchorItem(id: "architecture", titleKey: "token.architecture"),
        AnchorItem(id: "seed", titleKey: "token.anchor.seed"),
        AnchorItem(id: "map", titleKey: "token.anchor.map"),
        AnchorItem(id: "component", titleKey: "token.anchor.component"),
        AnchorItem(id: "usage", titleKey: "token.usage"),
    ]

    var body: some View {
        Group {
            if selectedTab == .examples {
                examplesContent
            } else {
                TokenPlayground()
            }
        }
    }

    // MARK: - Examples Content

    private var examplesContent: some View {
        ExamplePageWithAnchor(pageName: "Token", anchors: anchors) { _ in
            introduction

            Divider()

            architecture.id("architecture")

            Divider()

            seedTokenSection.id("seed")

            Divider()

            mapTokenSection.id("map")

            Divider()

            componentTokenSection.id("component")

            Divider()

            usageSection.id("usage")
        }
    }

    // MARK: - Introduction

    private var introduction: some View {
        VStack(alignment: .leading, spacing: Moin.Constants.Spacing.md) {
            Text(tr("token.title"))
                .font(.largeTitle)
                .fontWeight(.bold)

            Text(tr("token.description"))
                .font(.body)
                .foregroundStyle(.secondary)
        }
    }

    // MARK: - Architecture

    private var architecture: some View {
        VStack(alignment: .leading, spacing: Moin.Constants.Spacing.md) {
            Text(tr("token.architecture"))
                .font(.title2)
                .fontWeight(.semibold)

            Text(tr("token.architecture_desc"))
                .font(.body)
                .foregroundStyle(.secondary)

            // 架构图
            HStack(spacing: Moin.Constants.Spacing.md) {
                tokenBox("SeedToken", tr("token.seed_brief"), config.token.colorPrimary)
                arrowView
                tokenBox("MapToken", tr("token.map_brief"), config.token.colorSuccess)
                arrowView
                tokenBox("Token", tr("token.alias_brief"), config.token.colorWarning)
                arrowView
                tokenBox("ComponentToken", tr("token.component_brief"), config.token.colorDanger)
            }
            .padding(.vertical, Moin.Constants.Spacing.md)
        }
    }

    private func tokenBox(_ title: String, _ desc: String, _ color: Color) -> some View {
        VStack(spacing: Moin.Constants.Spacing.xs) {
            Text(title)
                .font(.system(size: 13, weight: .semibold, design: .monospaced))
                .foregroundStyle(color)
            Text(desc)
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(width: 120, height: 70)
        .background(color.opacity(0.1))
        .cornerRadius(Moin.Constants.Radius.sm)
        .overlay(
            RoundedRectangle(cornerRadius: Moin.Constants.Radius.sm)
                .stroke(color.opacity(0.3), lineWidth: 1)
        )
    }

    private var arrowView: some View {
        Image(systemName: "arrow.right")
            .foregroundStyle(.tertiary)
    }

    // MARK: - SeedToken Section

    private var seedTokenSection: some View {
        VStack(alignment: .leading, spacing: Moin.Constants.Spacing.md) {
            Text("SeedToken")
                .font(.title2)
                .fontWeight(.semibold)

            Text(tr("token.seed_desc"))
                .font(.body)
                .foregroundStyle(.secondary)

            // 当前 Seed 值展示 (24个属性)
            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: Moin.Constants.Spacing.sm) {
                // 品牌色 (6个)
                seedValueCard("colorPrimary", colorView: config.seed.colorPrimary)
                seedValueCard("colorSuccess", colorView: config.seed.colorSuccess)
                seedValueCard("colorWarning", colorView: config.seed.colorWarning)
                seedValueCard("colorError", colorView: config.seed.colorError)
                seedValueCard("colorInfo", colorView: config.seed.colorInfo)
                seedValueCard("colorLink", colorView: config.seed.colorLink)
                // 派生基础色 (2个)
                seedValueCard("colorTextBase", colorView: config.seed.colorTextBase)
                seedValueCard("colorBgBase", colorView: config.seed.colorBgBase)
                // 字体 (3个)
                seedValueCard("fontSize", value: "\(Int(config.seed.fontSize))pt")
                seedValueCard("fontFamily", value: "system")
                seedValueCard("fontFamilyCode", value: "mono")
                // 线条 (2个)
                seedValueCard("lineWidth", value: "\(Int(config.seed.lineWidth))px")
                seedValueCard("lineType", value: config.seed.lineType.rawValue)
                // 圆角 (1个)
                seedValueCard("borderRadius", value: "\(Int(config.seed.borderRadius))px")
                // 尺寸 (4个)
                seedValueCard("sizeUnit", value: "\(Int(config.seed.sizeUnit))px")
                seedValueCard("sizeStep", value: "\(Int(config.seed.sizeStep))px")
                seedValueCard("sizePopupArrow", value: "\(Int(config.seed.sizePopupArrow))px")
                seedValueCard("controlHeight", value: "\(Int(config.seed.controlHeight))px")
                // 层级 (2个)
                seedValueCard("zIndexBase", value: "\(config.seed.zIndexBase)")
                seedValueCard("zIndexPopupBase", value: "\(config.seed.zIndexPopupBase)")
                // 动画 (3个)
                seedValueCard("motion", value: config.seed.motion ? "true" : "false")
                seedValueCard("motionUnit", value: "\(config.seed.motionUnit)s")
                seedValueCard("motionBase", value: "\(config.seed.motionBase)")
                seedValueCard("motionEase", value: config.seed.motionEase.rawValue)
                // 其他 (2个)
                seedValueCard("opacityImage", value: "\(config.seed.opacityImage)")
                seedValueCard("wireframe", value: config.seed.wireframe ? "true" : "false")
            }

            ExampleSection(title: tr("token.seed_usage"), description: "") {
                EmptyView()
            } code: {
                """
                let config = Moin.ConfigProvider.shared

                // \(tr("token.modify_seed"))
                config.setPrimaryColor(.purple)
                config.setBorderRadius(8)
                config.setFontSize(16)

                // \(tr("token.batch_modify"))
                config.configureSeed { seed in
                    seed.colorPrimary = .indigo
                    seed.colorSuccess = .mint
                    seed.fontSize = 15
                }
                """
            }
        }
    }

    private func seedValueCard(_ name: String, colorView: Color? = nil, value: String? = nil) -> some View {
        HStack {
            if let color = colorView {
                Circle()
                    .fill(color)
                    .frame(width: 20, height: 20)
            }
            VStack(alignment: .leading, spacing: 2) {
                Text(name)
                    .font(.system(size: 11, design: .monospaced))
                    .foregroundStyle(.secondary)
                if let v = value {
                    Text(v)
                        .font(.system(size: 13, weight: .medium, design: .monospaced))
                }
            }
            Spacer()
        }
        .padding(Moin.Constants.Spacing.sm)
        .background(Color(nsColor: .controlBackgroundColor))
        .cornerRadius(Moin.Constants.Radius.sm)
    }

    // MARK: - MapToken Section

    private var mapTokenSection: some View {
        VStack(alignment: .leading, spacing: Moin.Constants.Spacing.md) {
            Text("MapToken")
                .font(.title2)
                .fontWeight(.semibold)

            Text(tr("token.map_desc"))
                .font(.body)
                .foregroundStyle(.secondary)

            // 派生规则表格
            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.sm) {
                Text(tr("token.derive_rules"))
                    .font(.headline)

                derivationRow(tr("token.derive_color"), tr("token.derive_color_desc"))
                derivationRow(tr("token.derive_text"), tr("token.derive_text_desc"))
                derivationRow(tr("token.derive_size"), tr("token.derive_size_desc"))
            }
            .padding(Moin.Constants.Spacing.md)
            .background(Color(nsColor: .controlBackgroundColor))
            .cornerRadius(Moin.Constants.Radius.md)
        }
    }

    private func derivationRow(_ title: String, _ desc: String) -> some View {
        HStack(alignment: .top, spacing: Moin.Constants.Spacing.sm) {
            Image(systemName: "arrow.right.circle.fill")
                .foregroundStyle(config.token.colorPrimary)
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(size: 13, weight: .medium))
                Text(desc)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Spacer()
        }
    }

    // MARK: - ComponentToken Section

    private var componentTokenSection: some View {
        VStack(alignment: .leading, spacing: Moin.Constants.Spacing.md) {
            Text("ComponentToken")
                .font(.title2)
                .fontWeight(.semibold)

            Text(tr("token.component_desc"))
                .font(.body)
                .foregroundStyle(.secondary)

            // 组件 Token 列表
            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.sm) {
                componentTokenRow("ButtonToken", "\(tr("token.button_token_count"))")
                componentTokenRow("SpaceToken", "\(tr("token.space_token_count"))")
                componentTokenRow("DividerToken", "\(tr("token.divider_token_count"))")
                componentTokenRow("BadgeToken", "\(tr("token.badge_token_count"))")
            }

            ExampleSection(title: tr("token.component_usage"), description: "") {
                EmptyView()
            } code: {
                """
                // \(tr("token.override_component"))
                config.components.button.primaryColor = .white
                config.components.button.iconGap = 8
                config.components.divider.lineWidth = 2

                // \(tr("token.regenerate_all"))
                config.regenerateTokens()
                """
            }
        }
    }

    private func componentTokenRow(_ name: String, _ count: String) -> some View {
        HStack {
            Text(name)
                .font(.system(size: 13, weight: .medium, design: .monospaced))
            Spacer()
            Text(count)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding(Moin.Constants.Spacing.sm)
        .background(Color(nsColor: .controlBackgroundColor))
        .cornerRadius(Moin.Constants.Radius.sm)
    }

    // MARK: - Usage Section

    private var usageSection: some View {
        VStack(alignment: .leading, spacing: Moin.Constants.Spacing.md) {
            Text(tr("token.usage"))
                .font(.title2)
                .fontWeight(.semibold)

            ExampleSection(title: tr("token.usage_view"), description: tr("token.usage_view_desc")) {
                HStack(spacing: Moin.Constants.Spacing.md) {
                    Moin.Button(tr("button.label.primary"), color: .primary) {}
                    Moin.Button(tr("button.label.success"), color: .success) {}
                }
            } code: {
                """
                struct MyView: View {
                    @Environment(\\.moinToken) private var token

                    var body: some View {
                        Text("Hello")
                            .foregroundStyle(token.colorPrimary)
                            .padding(token.padding)
                            .cornerRadius(token.borderRadius)
                    }
                }
                """
            }

            ExampleSection(title: tr("token.usage_dynamic"), description: tr("token.usage_dynamic_desc")) {
                HStack(spacing: Moin.Constants.Spacing.sm) {
                    ForEach([Color.blue, .purple, .pink, .orange, .green], id: \.self) { color in
                        Button {
                            config.setPrimaryColor(color)
                        } label: {
                            Circle()
                                .fill(color)
                                .frame(width: 28, height: 28)
                                .overlay(
                                    Circle()
                                        .stroke(config.seed.colorPrimary == color ? Color.primary : Color.clear, lineWidth: 2)
                                )
                        }
                        .buttonStyle(.plain)
                    }
                }
            } code: {
                """
                // \(tr("token.change_primary"))
                Moin.ConfigProvider.shared.setPrimaryColor(.purple)

                // \(tr("token.all_components_update"))
                """
            }
        }
    }
}
