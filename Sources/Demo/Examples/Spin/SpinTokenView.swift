import SwiftUI
import MoinUI

// MARK: - SpinTokenView

struct SpinTokenView: View {
    @Localized var tr
    @Environment(\.moinToken) var token
    @ObservedObject var config = Moin.ConfigProvider.shared
    
    // MARK: - Token Sections
    
    private var tokenSections: [DocSidebarSection] {
        [
            DocSidebarSection(
                title: tr("spin.token.size"),
                items: ["dotSize", "dotSizeSM", "dotSizeLG", "contentHeight"],
                sectionId: "size"
            ),
            DocSidebarSection(
                title: tr("spin.token.color"),
                items: ["dotColor", "tipColor", "maskBackground"],
                sectionId: "color"
            ),
            DocSidebarSection(
                title: tr("spin.token.animation"),
                items: ["motionDuration"],
                sectionId: "animation"
            )
        ]
    }
    
    // 重置所有 Spin Token 到默认值
    private func resetAll() {
        config.components.spin = .generate(from: config.token)
    }
    
    var body: some View {
        ComponentDocBody(
            sections: tokenSections,
            initialItemId: "size"
        ) { sectionId in
            if sectionId == "size" {
                Text(tr("spin.token.size")).font(.title3).fontWeight(.semibold)
            } else if sectionId == "color" {
                Text(tr("spin.token.color")).font(.title3).fontWeight(.semibold)
            } else if sectionId == "animation" {
                Text(tr("spin.token.animation")).font(.title3).fontWeight(.semibold)
            }
        } item: { item in
            cardForItem(item)
        } footer: {
            HStack(spacing: Moin.Constants.Spacing.sm) {
                Moin.Button(tr("playground.token.reset"), color: .primary, variant: .solid) {
                    resetAll()
                }
                
                Text(tr("token.playground.reset_desc"))
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
                
                Spacer()
            }
            .padding(Moin.Constants.Spacing.md)
        }
    }
    
    @ViewBuilder
    private func cardForItem(_ item: String) -> some View {
        switch item {
        // Size
        case "dotSize": dotSizeCard
        case "dotSizeSM": dotSizeSMCard
        case "dotSizeLG": dotSizeLGCard
        case "contentHeight": contentHeightCard
        // Color
        case "dotColor": dotColorCard
        case "tipColor": tipColorCard
        case "maskBackground": maskBackgroundCard
        // Animation
        case "motionDuration": motionDurationCard
        default: EmptyView()
        }
    }
    
    // MARK: - Size Cards
    
    private var dotSizeCard: some View {
        TokenCard(
            name: "dotSize",
            type: "CGFloat",
            defaultValue: "20",
            description: tr("spin.token.dotSize_desc"),
            sectionId: "size"
        ) {
            Moin.Spin(size: .default)
        } editor: {
            TokenValueRow(label: "dotSize", value: Binding(
                 get: { Moin.ConfigProvider.shared.components.spin.dotSize },
                 set: { Moin.ConfigProvider.shared.components.spin.dotSize = $0 }
            ))
        } code: {
            "config.components.spin.dotSize = \(Int(config.components.spin.dotSize))"
        }
        .scrollAnchor("size.dotSize")
    }
    
    private var dotSizeSMCard: some View {
        TokenCard(
            name: "dotSizeSM",
            type: "CGFloat",
            defaultValue: "14",
            description: tr("spin.token.dotSizeSM_desc"),
            sectionId: "size"
        ) {
            Moin.Spin(size: .small)
        } editor: {
            TokenValueRow(label: "dotSizeSM", value: Binding(
                 get: { Moin.ConfigProvider.shared.components.spin.dotSizeSM },
                 set: { Moin.ConfigProvider.shared.components.spin.dotSizeSM = $0 }
            ))
        } code: {
            "config.components.spin.dotSizeSM = \(Int(config.components.spin.dotSizeSM))"
        }
        .scrollAnchor("size.dotSizeSM")
    }
    
    private var dotSizeLGCard: some View {
        TokenCard(
            name: "dotSizeLG",
            type: "CGFloat",
            defaultValue: "32",
            description: tr("spin.token.dotSizeLG_desc"),
            sectionId: "size"
        ) {
            Moin.Spin(size: .large)
        } editor: {
            TokenValueRow(label: "dotSizeLG", value: Binding(
                 get: { Moin.ConfigProvider.shared.components.spin.dotSizeLG },
                 set: { Moin.ConfigProvider.shared.components.spin.dotSizeLG = $0 }
            ))
        } code: {
            "config.components.spin.dotSizeLG = \(Int(config.components.spin.dotSizeLG))"
        }
        .scrollAnchor("size.dotSizeLG")
    }
    
    private var contentHeightCard: some View {
        TokenCard(
            name: "contentHeight",
            type: "CGFloat",
            defaultValue: "400",
            description: tr("spin.token.contentHeight_desc"),
            sectionId: "size"
        ) {
            // 使用 ScrollView 展示 contentHeight 效果
            Moin.Spin(spinning: true, tip: tr("spin.loading")) {
                ScrollView {
                    VStack(spacing: 8) {
                        ForEach(0..<10, id: \.self) { i in
                            Text("Content Line \(i + 1)")
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 8)
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(4)
                        }
                    }
                    .padding(8)
                }
                .frame(height: config.components.spin.contentHeight)
            }
        } editor: {
            TokenValueRow(label: "contentHeight", value: Binding(
                 get: { Moin.ConfigProvider.shared.components.spin.contentHeight },
                 set: { Moin.ConfigProvider.shared.components.spin.contentHeight = $0 }
            ), range: 50...600, step: 50)
        } code: {
            "config.components.spin.contentHeight = \(Int(config.components.spin.contentHeight))"
        }
        .scrollAnchor("size.contentHeight")
    }
    
    // MARK: - Color Cards
    
    private var dotColorCard: some View {
        TokenCard(
            name: "dotColor",
            type: "Color",
            defaultValue: "token.colorPrimary",
            description: tr("spin.token.dotColor_desc"),
            sectionId: "color"
        ) {
            Moin.Spin()
        } editor: {
            ColorPresetRow(label: "dotColor", color: Binding(
                 get: { Moin.ConfigProvider.shared.components.spin.dotColor },
                 set: { Moin.ConfigProvider.shared.components.spin.dotColor = $0 }
            ))
        } code: {
            "config.components.spin.dotColor = Color(...)"
        }
        .scrollAnchor("color.dotColor")
    }
    
    private var tipColorCard: some View {
         TokenCard(
             name: "tipColor",
             type: "Color",
             defaultValue: "token.colorTextTertiary",
             description: tr("spin.token.tipColor_desc"),
             sectionId: "color"
         ) {
             Moin.Spin(tip: "Loading...")
         } editor: {
             ColorPresetRow(label: "tipColor", color: Binding(
                  get: { Moin.ConfigProvider.shared.components.spin.tipColor },
                  set: { Moin.ConfigProvider.shared.components.spin.tipColor = $0 }
             ))
         } code: {
             "config.components.spin.tipColor = Color(...)"
         }
         .scrollAnchor("color.tipColor")
     }
    
    private var maskBackgroundCard: some View {
          TokenCard(
              name: "maskBackground",
              type: "Color",
              defaultValue: "token.colorBgMask",
              description: tr("spin.token.maskBackground_desc"),
              sectionId: "color"
          ) {
              // 模拟全屏模式的遮罩效果
              ZStack {
                  // 背景内容
                  VStack(spacing: 4) {
                      Text("Background")
                          .font(.caption)
                      Text("Content")
                          .font(.caption)
                  }
                  .frame(width: 120, height: 80)
                  .background(Color.white)
                  .cornerRadius(4)
                  
                  // 遮罩层
                  config.components.spin.maskBackground
                      .cornerRadius(4)
                  
                  // 白色指示器
                  SpinIndicator(
                      size: config.components.spin.dotSize,
                      color: .white,
                      duration: config.components.spin.motionDuration
                  )
              }
              .frame(width: 120, height: 80)
          } editor: {
              ColorPresetRow(label: "maskBackground", color: Binding(
                   get: { Moin.ConfigProvider.shared.components.spin.maskBackground },
                   set: { Moin.ConfigProvider.shared.components.spin.maskBackground = $0 }
              ))
          } code: {
              "config.components.spin.maskBackground = Color(...)"
          }
          .scrollAnchor("color.maskBackground")
      }
    
    // MARK: - Animation Cards
    
    private var motionDurationCard: some View {
         TokenCard(
             name: "motionDuration",
             type: "Double",
             defaultValue: "1.2",
             description: tr("spin.token.motionDuration_desc"),
             sectionId: "animation"
         ) {
             Moin.Spin()
         } editor: {
             TokenValueRow(label: "motionDuration", value: Binding(
                  get: { CGFloat(Moin.ConfigProvider.shared.components.spin.motionDuration) },
                  set: { Moin.ConfigProvider.shared.components.spin.motionDuration = Double($0) }
             ), range: 0.1...5, step: 0.1)
         } code: {
             "config.components.spin.motionDuration = \(config.components.spin.motionDuration)"
         }
         .scrollAnchor("animation.motionDuration")
     }
}
