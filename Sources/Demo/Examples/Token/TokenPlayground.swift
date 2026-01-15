import SwiftUI
import AppKit
import MoinUI

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
                TokenPlaygroundPreview()
                Divider()
                TokenPlaygroundCodeView(selectedPanel: selectedPanel)
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
                    TokenSeedPanel()
                case .global:
                    TokenGlobalPanel()
                case .button:
                    TokenButtonPanel()
                case .tag:
                    TokenTagPanel()
                case .badge:
                    TokenBadgePanel()
                case .avatar:
                    TokenAvatarPanel()
                case .space:
                    TokenSpacePanel()
                case .divider:
                    TokenDividerPanel()
                }
            }
            .padding(Moin.Constants.Spacing.md)
        }
    }
}
