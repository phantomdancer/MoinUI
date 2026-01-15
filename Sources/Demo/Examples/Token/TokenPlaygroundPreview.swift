import SwiftUI
import MoinUI

struct TokenPlaygroundPreview: View {
    @Localized var tr
    @ObservedObject private var config = Moin.ConfigProvider.shared

    var body: some View {
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
                            Moin.Tag(tr("tag.example.default"))
                            Moin.Tag(tr("tag.example.processing"), color: .processing)
                            Moin.Tag(tr("tag.example.success"), color: .success)
                            Moin.Tag(tr("tag.example.warning"), color: .warning)
                            Moin.Tag(tr("tag.example.error"), color: .error)
                        }
                        // Solid 变体 - solidTextColor 影响所有 solid 标签
                        HStack(spacing: Moin.Constants.Spacing.sm) {
                            Moin.Tag(tr("tag.example.default"), variant: .solid)
                            Moin.Tag(tr("tag.example.processing"), color: .processing, variant: .solid)
                            Moin.Tag(tr("tag.example.success"), color: .success, variant: .solid)
                        }
                    }
                    
                    // Badge 组件
                    VStack(alignment: .leading, spacing: Moin.Constants.Spacing.sm) {
                        Text(tr("token.playground.badges"))
                            .font(.system(size: 12, weight: .medium))
                            .foregroundStyle(.secondary)
                        HStack(spacing: 24) {
                            Moin.Badge(count: 5) {
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(Color.gray.opacity(0.15))
                                    .frame(width: 40, height: 40)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 4)
                                            .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                                    )
                            }
                            Moin.Badge(count: 5, size: .small) {
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(Color.gray.opacity(0.15))
                                    .frame(width: 40, height: 40)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 4)
                                            .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                                    )
                            }
                            Moin.Badge(count: 100, color: .success) {
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(Color.gray.opacity(0.15))
                                    .frame(width: 40, height: 40)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 4)
                                            .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                                    )
                            }
                            Moin.Badge(dot: true) {
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(Color.gray.opacity(0.15))
                                    .frame(width: 40, height: 40)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 4)
                                            .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                                    )
                            }
                            Moin.Badge(dot: true, size: .small) {
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(Color.gray.opacity(0.15))
                                    .frame(width: 40, height: 40)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 4)
                                            .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                                    )
                            }
                            Moin.Badge(status: .processing, text: "Processing")
                            Moin.Badge(status: .error, text: "Error")
                        }
                    }

                    // Avatar 组件
                    VStack(alignment: .leading, spacing: Moin.Constants.Spacing.sm) {
                        Text(tr("token.playground.avatars"))
                            .font(.system(size: 12, weight: .medium))
                            .foregroundStyle(.secondary)

                        // 尺寸展示
                        HStack(spacing: 16) {
                            VStack(spacing: 4) {
                                Moin.Avatar(icon: "person", size: .small)
                                Text("SM").font(.system(size: 10)).foregroundStyle(.tertiary)
                            }
                            VStack(spacing: 4) {
                                Moin.Avatar(icon: "person", size: .default)
                                Text("Default").font(.system(size: 10)).foregroundStyle(.tertiary)
                            }
                            VStack(spacing: 4) {
                                Moin.Avatar(icon: "person", size: .large)
                                Text("LG").font(.system(size: 10)).foregroundStyle(.tertiary)
                            }
                        }

                        // 形状和类型
                        HStack(spacing: 16) {
                            Moin.Avatar(icon: "person", shape: .circle)
                            Moin.Avatar(icon: "person", shape: .square)
                            Moin.Avatar("U")
                            Moin.Avatar("Long", gap: 4)
                            Moin.Avatar("AB", backgroundColor: config.token.colorPrimary)
                        }

                        // AvatarGroup
                        HStack(spacing: 24) {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Group").font(.system(size: 10)).foregroundStyle(.tertiary)
                                Moin.AvatarGroup(size: .small) {
                                    Moin.Avatar(icon: "person")
                                    Moin.Avatar("A")
                                    Moin.Avatar("B", backgroundColor: .blue)
                                }
                            }
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Max: 2").font(.system(size: 10)).foregroundStyle(.tertiary)
                                Moin.AvatarGroup(maxCount: 2, size: .small) {
                                    Moin.Avatar(icon: "person")
                                    Moin.Avatar("A")
                                    Moin.Avatar("B")
                                    Moin.Avatar("C")
                                }
                            }
                        }
                    }

                    // Divider 组件
                    VStack(alignment: .leading, spacing: Moin.Constants.Spacing.sm) {
                        Text(tr("token.playground.dividers"))
                            .font(.system(size: 12, weight: .medium))
                            .foregroundStyle(.secondary)

                        HStack(alignment: .top, spacing: 32) {
                            // Column 1: Horizontal Dividers (Vertical Stack)
                            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.sm) {
                                Text("Horizontal")
                                    .font(.system(size: 10))
                                    .foregroundStyle(.tertiary)
                                
                                Moin.Divider()
                                Moin.Divider(tr("token.playground.divider_text"))
                                Moin.Divider(variant: .dashed)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            // Column 2: Vertical Dividers (Horizontal Stack)
                            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.sm) {
                                Text("Vertical")
                                    .font(.system(size: 10))
                                    .foregroundStyle(.tertiary)
                                
                                HStack(spacing: Moin.Constants.Spacing.md) {
                                    Text("Text")
                                        .font(.system(size: 12))
                                        .foregroundStyle(.secondary)
                                    Moin.Divider(orientation: .vertical)
                                    Text("Text")
                                        .font(.system(size: 12))
                                        .foregroundStyle(.secondary)
                                    Moin.Divider(orientation: .vertical, variant: .dashed)
                                    Text("Text")
                                        .font(.system(size: 12))
                                        .foregroundStyle(.secondary)
                                }
                                .frame(height: 24)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
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
    }
}
