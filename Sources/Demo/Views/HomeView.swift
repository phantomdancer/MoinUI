import SwiftUI
import MoinUI

/// Homepage inspired by Ant Design, Element Plus, shadcn/ui
struct HomeView: View {
    @ObservedObject private var config = Moin.ConfigProvider.shared

    private var token: Moin.Token { config.token }

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                HeroSection()
                FeaturesSection()
                ComponentsPreviewSection()
            }
        }
        .background(token.colorBgContainer)
        .measureRenderTime("Home")
    }
}

// MARK: - Hero Section

private struct HeroSection: View {
    @Localized var tr
    @ObservedObject private var config = Moin.ConfigProvider.shared

    private var token: Moin.Token { config.token }

    private let gradientColors = [
        Color(red: 0.2, green: 0.5, blue: 1.0),
        Color(red: 0.5, green: 0.3, blue: 0.9)
    ]

    var body: some View {
        HStack(spacing: Moin.Constants.Spacing.xxl) {
            // 左侧文字区域
            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.lg) {
                HStack(spacing: Moin.Constants.Spacing.sm) {
                    Text("MoinUI")
                        .font(.system(size: 42, weight: .bold, design: .rounded))
                        .foregroundStyle(
                            LinearGradient(
                                colors: gradientColors,
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        // 关闭大标题的文字选择，保持渐变效果
                        .textSelection(.disabled)

                    Text("v\(Moin.version)")
                        .font(.caption)
                        .foregroundStyle(token.colorTextSecondary)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(token.colorBgHover)
                        .clipShape(Capsule())
                }

                Text(tr("home.tagline"))
                    .font(.title3)
                    .foregroundStyle(token.colorTextSecondary)

                HStack(spacing: Moin.Constants.Spacing.md) {
                    Moin.Button(tr("home.get_started"), color: .primary, size: .large) {
                        NavigationManager.shared.navigate(to: .quickStart)
                    }
                    Moin.Button(tr("home.github"), size: .large, variant: .outlined) {}
                }
                .padding(.top, Moin.Constants.Spacing.sm)
            }

            Spacer(minLength: 0)

            // 右侧 Logo
            ZStack {
                RoundedRectangle(cornerRadius: 28)
                    .fill(
                        LinearGradient(
                            colors: gradientColors,
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 120, height: 120)
                    .shadow(color: gradientColors[0].opacity(0.3), radius: 30, y: 15)

                AppIcon()
            }
        }
        .padding(.horizontal, Moin.Constants.Spacing.xxl)
        .padding(.vertical, Moin.Constants.Spacing.xxl)
        .frame(maxWidth: .infinity)
        .background(token.colorBgElevated)
    }
}

// MARK: - Features Section

private struct FeaturesSection: View {
    @Localized var tr
    @ObservedObject private var config = Moin.ConfigProvider.shared

    private var token: Moin.Token { config.token }

    private let features: [(icon: String, titleKey: String, descKey: String)] = [
        ("swift", "home.feature.native_title", "home.feature.native_desc"),
        ("paintbrush.pointed", "home.feature.theme_title", "home.feature.theme_desc"),
        ("globe", "home.feature.i18n_title", "home.feature.i18n_desc")
    ]

    var body: some View {
        ResponsiveLayout(minItemWidth: 280) {
            ForEach(features, id: \.titleKey) { feature in
                FeatureCard(
                    icon: feature.icon,
                    title: tr(feature.titleKey),
                    description: tr(feature.descKey)
                )
            }
        }
        .padding(.horizontal, Moin.Constants.Spacing.xxl)
        .padding(.vertical, Moin.Constants.Spacing.xl)
        .background(token.colorBgContainer)
    }
}

private struct FeatureCard: View {
    let icon: String
    let title: String
    let description: String
    @State private var isHovered = false
    @ObservedObject private var config = Moin.ConfigProvider.shared

    private var token: Moin.Token { config.token }

    var body: some View {
        VStack(alignment: .leading, spacing: Moin.Constants.Spacing.md) {
            HStack(spacing: Moin.Constants.Spacing.sm) {
                Image(systemName: icon)
                    .font(.system(size: 20))
                    .foregroundStyle(token.colorPrimary)

                Text(title)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(token.colorText)
            }

            Text(description)
                .font(.body)
                .foregroundStyle(token.colorTextSecondary)
                .lineLimit(3)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(Moin.Constants.Spacing.xl)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(token.colorBgElevated)
                .shadow(color: .black.opacity(isHovered ? 0.1 : 0.05), radius: isHovered ? 8 : 4, y: 2)
        )
        .scaleEffect(isHovered ? 1.01 : 1.0)
        .animation(.easeOut(duration: 0.2), value: isHovered)
        .onHover { isHovered = $0 }
    }
}

// MARK: - Components Preview Section

private struct ComponentsPreviewSection: View {
    @Localized var tr
    @ObservedObject private var config = Moin.ConfigProvider.shared

    private var token: Moin.Token { config.token }

    var body: some View {
        VStack(alignment: .leading, spacing: Moin.Constants.Spacing.xl) {
            // 标题
            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.xs) {
                Text(tr("home.components"))
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundStyle(token.colorText)

                Text(tr("home.components_desc"))
                    .font(.subheadline)
                    .foregroundStyle(token.colorTextSecondary)
            }

            // Button 预览
            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.lg) {
                Text("Button")
                    .font(.headline)
                    .foregroundStyle(token.colorText)

                VStack(alignment: .leading, spacing: Moin.Constants.Spacing.md) {
                    // Types
                    HStack(spacing: Moin.Constants.Spacing.sm) {
                        Moin.Button(tr("button.label.primary"), color: .primary) {}
                        Moin.Button(tr("button.label.success"), color: .success) {}
                        Moin.Button(tr("button.label.warning"), color: .warning) {}
                        Moin.Button(tr("button.label.danger"), color: .danger) {}
                        Moin.Button(tr("button.label.default")) {}
                    }

                    // Variants
                    HStack(spacing: Moin.Constants.Spacing.sm) {
                        Moin.Button(tr("button.label.solid"), color: .primary, variant: .solid) {}
                        Moin.Button(tr("button.label.outlined"), color: .primary, variant: .outlined) {}
                        Moin.Button(tr("button.label.text"), color: .primary, variant: .text) {}
                        Moin.Button(tr("button.label.link"), color: .primary, variant: .link) {}
                    }

                    // Sizes & Icons
                    HStack(spacing: Moin.Constants.Spacing.sm) {
                        Moin.Button(tr("button.label.large"), color: .primary, size: .large) {}
                        Moin.Button(tr("button.label.medium"), color: .primary, size: .medium) {}
                        Moin.Button(tr("button.label.small"), color: .primary, size: .small) {}
                        Moin.Button(icon: "plus", color: .primary, shape: .circle) {}
                    }
                }
            }
            .padding(Moin.Constants.Spacing.xl)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(token.colorBgElevated)
            )
        }
        .padding(.horizontal, Moin.Constants.Spacing.xxl)
        .padding(.vertical, Moin.Constants.Spacing.xl)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(token.colorBgHover.opacity(0.5))
    }
}
