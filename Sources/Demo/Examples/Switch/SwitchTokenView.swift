import SwiftUI
import MoinUI

struct SwitchTokenView: View {
    @Localized var tr
    @ObservedObject var config = Moin.ConfigProvider.shared
    
    // MARK: - Sections
    
    private var componentSections: [DocSidebarSection] {
        [
            DocSidebarSection(
                title: "Size",
                items: ["trackHeight", "trackMinWidth", "handleSize", "trackHeightSM", "trackMinWidthSM", "handleSizeSM", "trackPadding", "innerMinMargin", "innerMaxMargin"],
                sectionId: "component"
            ),
            DocSidebarSection(
                title: "Color",
                items: ["colorPrimary", "colorPrimaryHover", "colorTextQuaternary", "colorTextTertiary", "handleBg", "handleShadow"],
                sectionId: "component"
            )
        ]
    }
    
    private var globalSections: [DocSidebarSection] {
        [
            DocSidebarSection(
                title: tr("doc.section.global_token"),
                items: ["colorPrimary", "colorTextDisabled", "colorBgDisabled"],
                sectionId: "global"
            )
        ]
    }
    
    private var allSections: [DocSidebarSection] { componentSections + globalSections }
    
    private func resetAll() {
        config.regenerateTokens()
        config.components.switch = .resolve(token: config.token, isDark: config.isDarkMode)
    }
    
    var body: some View {
        ComponentDocBody(
            sections: allSections,
            initialItemId: "component"
        ) { sectionId in
             if sectionId == "component" {
                Text(tr("doc.section.component_token")).font(.title3).fontWeight(.semibold)
            } else {
                Text(tr("doc.section.global_token")).font(.title3).fontWeight(.semibold)
            }
        } item: { item in
            if sectionId(for: item) == "global" {
                globalCard(for: item)
            } else {
                componentCard(for: item)
            }
        } footer: {
            HStack {
                Moin.Button(tr("playground.token.reset"), variant: .outlined) { resetAll() }
                Spacer()
            }.padding()
        }
    }
    
    private func sectionId(for item: String) -> String {
        if globalSections.flatMap({ $0.items }).contains(item) { return "global" }
        return "component"
    }

    // MARK: - Component Cards
    
    @ViewBuilder
    private func componentCard(for item: String) -> some View {
        switch item {
        case "trackHeight":
            TokenCard(
                name: "trackHeight",
                type: "CGFloat",
                defaultValue: "22",
                description: "轨道高度",
                sectionId: "component",
                preview: {
                    Moin.Switch(isOn: .constant(true))
                },
                editor: {
                    TokenValueRow(label: "Value", value: $config.components.switch.trackHeight, range: 10...50)
                }
            )
        case "trackMinWidth":
            TokenCard(
                name: "trackMinWidth",
                type: "CGFloat",
                defaultValue: "44",
                description: "最小宽度",
                sectionId: "component",
                preview: {
                    Moin.Switch(isOn: .constant(true))
                },
                editor: {
                    TokenValueRow(label: "Value", value: $config.components.switch.trackMinWidth, range: 20...100)
                }
            )
        case "handleSize":
            TokenCard(
                name: "handleSize",
                type: "CGFloat",
                defaultValue: "18",
                description: "把手大小",
                sectionId: "component",
                preview: {
                    Moin.Switch(isOn: .constant(true))
                },
                editor: {
                    TokenValueRow(label: "Value", value: $config.components.switch.handleSize, range: 10...40)
                }
            )
        case "trackHeightSM":
            TokenCard(
                name: "trackHeightSM",
                type: "CGFloat",
                defaultValue: "16",
                description: "小号轨道高度",
                sectionId: "component",
                preview: {
                    Moin.Switch(isOn: .constant(true), size: .small)
                },
                editor: {
                    TokenValueRow(label: "Value", value: $config.components.switch.trackHeightSM, range: 10...30)
                }
            )
        case "trackMinWidthSM":
            TokenCard(
                name: "trackMinWidthSM",
                type: "CGFloat",
                defaultValue: "28",
                description: "小号最小宽度",
                sectionId: "component",
                preview: {
                    Moin.Switch(isOn: .constant(true), size: .small)
                },
                editor: {
                    TokenValueRow(label: "Value", value: $config.components.switch.trackMinWidthSM, range: 10...60)
                }
            )
        case "handleSizeSM":
            TokenCard(
                name: "handleSizeSM",
                type: "CGFloat",
                defaultValue: "12",
                description: "小号把手大小",
                sectionId: "component",
                preview: {
                    Moin.Switch(isOn: .constant(true), size: .small)
                },
                editor: {
                    TokenValueRow(label: "Value", value: $config.components.switch.handleSizeSM, range: 6...20)
                }
            )
        case "trackPadding":
            TokenCard(
                name: "trackPadding",
                type: "CGFloat",
                defaultValue: "2",
                description: "轨道内边距",
                sectionId: "component",
                preview: {
                    Moin.Switch(isOn: .constant(true))
                },
                editor: {
                    TokenValueRow(label: "Value", value: $config.components.switch.trackPadding, range: 0...5)
                }
            )
        case "innerMinMargin":
            TokenCard(
                name: "innerMinMargin",
                type: "CGFloat",
                defaultValue: "9",
                description: "内容最小间距",
                sectionId: "component",
                preview: {
                    Moin.Switch(isOn: .constant(true))
                },
                editor: {
                    TokenValueRow(label: "Value", value: $config.components.switch.innerMinMargin, range: 0...20)
                }
            )
        case "innerMaxMargin":
            TokenCard(
                name: "innerMaxMargin",
                type: "CGFloat",
                defaultValue: "24",
                description: "内容最大间距",
                sectionId: "component",
                preview: {
                    Moin.Switch(isOn: .constant(true))
                },
                editor: {
                    TokenValueRow(label: "Value", value: $config.components.switch.innerMaxMargin, range: 10...40)
                }
            )
        case "colorPrimary":
             TokenCard(
                name: "colorPrimary",
                type: "Color",
                defaultValue: "blue6",
                description: "开启状态背景色",
                sectionId: "component",
                preview: {
                    Moin.Switch(isOn: .constant(true))
                },
                editor: {
                    ColorPresetRow(label: "Color", color: $config.components.switch.colorPrimary)
                }
            )
        case "colorTextQuaternary":
             TokenCard(
                name: "colorTextQuaternary",
                type: "Color",
                defaultValue: "black.opacity(0.25)",
                description: "关闭状态背景色",
                sectionId: "component",
                preview: {
                    Moin.Switch(isOn: .constant(false))
                },
                editor: {
                    ColorPresetRow(label: "Color", color: $config.components.switch.colorTextQuaternary)
                }
            )
        case "handleBg":
             TokenCard(
                name: "handleBg",
                type: "Color",
                defaultValue: "white",
                description: "把手颜色",
                sectionId: "component",
                preview: {
                    Moin.Switch(isOn: .constant(true))
                },
                editor: {
                    ColorPresetRow(label: "Color", color: $config.components.switch.handleBg)
                }
            )
        default: EmptyView()
        }
    }
    
    // MARK: - Global Cards
    
    @ViewBuilder
    private func globalCard(for item: String) -> some View {
        // Placeholder for global tokens, usually READ-ONLY link or redirect
        TokenCard(
            name: item,
            type: "Global",
            defaultValue: "-",
            description: "Global Token (Inherited)",
            sectionId: "global",
            preview: { EmptyView() }
        )
    }
}
