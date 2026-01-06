# Theme 主题

## 设计指南

Theme 提供浅色、深色和跟随系统三种主题模式，通过 Token 系统统一管理颜色和样式。

### 设计原则

1. **一致性**：所有组件使用统一的 Token，确保视觉一致
2. **对比度**：深色模式下适当调亮颜色，保证可读性
3. **无缝切换**：主题切换时平滑过渡，无闪烁
4. **系统集成**：支持跟随 macOS 系统外观自动切换

### 主题模式

| 模式 | 说明 |
|------|------|
| Light | 浅色主题，白色背景 |
| Dark | 深色主题，深色背景 |
| System | 跟随 macOS 系统设置 |

---

## 竞品对比

| 功能 | Ant Design | Element Plus | shadcn/ui | MoinUI |
|------|------------|--------------|-----------|--------|
| **主题模式** |
| 浅色主题 | ✅ | ✅ | ✅ | ✅ |
| 深色主题 | ✅ | ✅ | ✅ | ✅ |
| 跟随系统 | ✅ | ✅ | ❌ | ✅ |
| 自定义主题 | ✅ | ✅ | ✅ | ✅ |
| **实现方式** |
| CSS Variables | ✅ | ✅ | ✅ | ❌ (原生) |
| Token 系统 | ✅ | ❌ | ❌ | ✅ |
| 运行时切换 | ✅ | ✅ | ❌ | ✅ |
| **颜色系统** |
| 语义色 (primary等) | ✅ | ✅ | ✅ | ✅ |
| 状态色 (hover/active) | ✅ | ✅ | ✅ | ✅ |
| 背景/文字色 | ✅ | ✅ | ✅ | ✅ |
| 边框色 | ✅ | ✅ | ✅ | ✅ |
| **尺寸系统** |
| 间距 (spacing) | ✅ | ✅ | ✅ | ✅ |
| 圆角 (radius) | ✅ | ✅ | ✅ | ✅ |
| 控件高度 | ✅ | ✅ | ❌ | ✅ |
| 字体大小 | ✅ | ✅ | ✅ | ✅ |
| **动画** |
| 过渡动画 | ✅ | ✅ | ✅ | ✅ |
| 动画时长配置 | ✅ | ❌ | ❌ | ✅ |

---

## MoinUI 实现方案

### 主题枚举

```swift
public enum MoinUITheme: String, CaseIterable {
    case light   // 浅色
    case dark    // 深色
    case system  // 跟随系统

    public static let `default`: MoinUITheme = .system
}
```

### 颜色体系

#### 语义色

| Token | 浅色模式 | 深色模式 | 用途 |
|-------|---------|---------|------|
| colorPrimary | #1677FF | #3889FF | 主要操作 |
| colorSuccess | #52BA44 | #66C759 | 成功状态 |
| colorWarning | #FAAB33 | #FFB84D | 警告状态 |
| colorDanger | #FF4D4F | #FF6666 | 危险操作 |
| colorInfo | #8C8C8C | #A6A6B3 | 信息提示 |

#### 背景与文字

| Token | 浅色模式 | 深色模式 | 用途 |
|-------|---------|---------|------|
| colorBgContainer | #FFFFFF | #1A1A1F | 容器背景 |
| colorBgElevated | #FFFFFF | #242429 | 悬浮层背景 |
| colorBgHover | #FAFAFA | #262629 | 悬停背景 |
| colorText | #212121 | #EBEBEB | 主要文字 |
| colorTextSecondary | #737373 | #A6A6A6 | 次要文字 |
| colorTextDisabled | #A6A6A6 | #666666 | 禁用文字 |
| colorBorder | #D9D9D9 | #404040 | 边框 |

### 尺寸体系

#### 间距 (Spacing)

| Token | 值 | 用途 |
|-------|-----|------|
| xs | 4px | 极小间距 |
| sm | 8px | 小间距 |
| md | 12px | 中等间距 |
| lg | 16px | 大间距 |
| xl | 24px | 超大间距 |

#### 圆角 (Radius)

| Token | 值 | 用途 |
|-------|-----|------|
| borderRadiusSM | 4px | 小圆角 |
| borderRadius | 6px | 默认圆角 |
| borderRadiusLG | 8px | 大圆角 |

#### 控件高度

| Token | 值 | 用途 |
|-------|-----|------|
| controlHeightSM | 24px | 小尺寸控件 |
| controlHeight | 32px | 默认控件 |
| controlHeightLG | 40px | 大尺寸控件 |

### API 设计

```swift
let config = MoinUIConfigProvider.shared

// 获取当前主题
let theme = config.theme

// 设置主题
config.theme = .dark
config.applyTheme(.dark)

// 切换主题 (light <-> dark)
config.toggleTheme()

// 判断是否深色模式
if config.isDarkMode {
    // 深色模式逻辑
}

// 访问 Token
let primaryColor = config.token.colorPrimary
let radius = config.token.borderRadius

// 修改 Token
config.token.colorPrimary = .purple
config.primaryColor = .purple  // 快捷方式
```

### View Modifier

```swift
// App 入口必须添加（启用全局主题）
ContentView()
    .moinUIThemeRoot()

// 设置局部主题
SomeView()
    .moinUITheme(.dark)
```

### 使用示例

```swift
import SwiftUI
import MoinUI

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .moinUIThemeRoot()  // 必须
        }
    }
}

struct ContentView: View {
    @ObservedObject var config = MoinUIConfigProvider.shared

    var body: some View {
        VStack(spacing: config.token.padding) {
            // 使用主题色
            Text("Hello")
                .foregroundColor(config.token.colorPrimary)

            // 主题切换按钮
            Button {
                config.toggleTheme()
            } label: {
                Image(systemName: config.isDarkMode ? "sun.max.fill" : "moon.fill")
            }

            // 主题选择器
            Picker("主题", selection: Binding(
                get: { config.theme },
                set: { config.applyTheme($0) }
            )) {
                ForEach(MoinUITheme.allCases, id: \.self) { theme in
                    Label(theme.displayName, systemImage: theme.iconName)
                        .tag(theme)
                }
            }
        }
        .padding(config.token.paddingLG)
        .background(config.token.colorBgContainer)
    }
}
```

---

## 后续规划

- [ ] 自定义主题预设（如 Compact 紧凑模式）
- [ ] 主题编辑器（可视化调整 Token）
- [ ] 主题导入/导出 (JSON)
- [ ] 高对比度主题（无障碍）
- [ ] 主题切换动画优化
