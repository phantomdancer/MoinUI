# ConfigProvider 全局配置

## 设计指南

ConfigProvider 为组件提供统一的全局配置，包括主题、语言、设计令牌（Token）等。

### 设计原则

1. **单一数据源**：全局配置统一管理，避免配置分散
2. **响应式更新**：配置变更自动触发 UI 更新
3. **层级覆盖**：支持全局配置与局部覆盖
4. **类型安全**：使用 Swift 强类型定义配置项

### 核心功能

| 功能 | 说明 |
|------|------|
| 主题切换 | light / dark / system 三种模式 |
| 语言配置 | 中文 / 英文，支持扩展 |
| Token 系统 | 颜色、尺寸、圆角、间距等设计令牌 |
| 组件 Token | 针对特定组件的样式配置 |

---

## 竞品对比

| 功能 | Ant Design | Element Plus | shadcn/ui | MoinUI |
|------|------------|--------------|-----------|--------|
| **主题** |
| 浅色主题 | ✅ | ✅ | ✅ | ✅ |
| 深色主题 | ✅ | ✅ | ✅ | ✅ |
| 跟随系统 | ✅ | ✅ | ❌ | ✅ |
| 主题切换 API | ✅ | ✅ | ❌ | ✅ |
| **Token 系统** |
| 全局 Token | ✅ | ✅ (CSS Vars) | ✅ (CSS Vars) | ✅ |
| 组件级 Token | ✅ | ❌ | ❌ | ✅ |
| 运行时修改 | ✅ | ✅ | ❌ | ✅ |
| **国际化** |
| 内置多语言 | ✅ (50+) | ✅ (60+) | ❌ | ✅ (2) |
| 自定义翻译 | ✅ | ✅ | ❌ | ✅ |
| 语言切换 | ✅ | ✅ | ❌ | ✅ |
| **配置方式** |
| Provider 组件 | ✅ | ✅ | ❌ | ✅ |
| 嵌套配置 | ✅ | ✅ | ❌ | ✅ |
| 全局单例 | ❌ | ❌ | ❌ | ✅ |
| **其他** |
| 组件尺寸配置 | ✅ | ✅ | ❌ | ✅ |
| 方向 (RTL) | ✅ | ✅ | ❌ | ❌ |
| 前缀自定义 | ✅ | ❌ | ❌ | ❌ |

---

## MoinUI 实现方案

### 架构设计

```
MoinUIConfigProvider (单例)
├── config: MoinUIConfig
│   ├── locale: MoinUILocale        // 语言
│   ├── theme: MoinUITheme          // 主题
│   ├── token: MoinUIToken          // 全局 Token
│   └── components: MoinUIComponentToken  // 组件 Token
└── localization: MoinUILocalization     // 国际化管理
```

### Token 结构

```swift
public struct MoinUIToken {
    // 颜色
    public var colorPrimary: Color
    public var colorSuccess: Color
    public var colorWarning: Color
    public var colorDanger: Color
    public var colorInfo: Color

    // 背景 & 文字
    public var colorBgContainer: Color
    public var colorText: Color
    public var colorTextSecondary: Color
    public var colorBorder: Color

    // 圆角
    public var borderRadius: CGFloat
    public var borderRadiusLG: CGFloat
    public var borderRadiusSM: CGFloat

    // 尺寸
    public var controlHeight: CGFloat
    public var controlHeightLG: CGFloat
    public var controlHeightSM: CGFloat

    // 字体
    public var fontSize: CGFloat
    public var fontSizeLG: CGFloat
    public var fontSizeSM: CGFloat

    // 间距
    public var padding: CGFloat
    public var paddingLG: CGFloat
    public var paddingSM: CGFloat

    // 动画
    public var motionDuration: Double
}
```

### API 设计

```swift
// 获取全局配置
let config = MoinUIConfigProvider.shared

// 主题操作
config.theme = .dark           // 设置主题
config.toggleTheme()           // 切换主题
config.isDarkMode              // 判断是否深色

// 语言操作
config.locale = .enUS          // 设置语言
config.tr("button.submit")     // 获取翻译

// Token 操作
config.token.colorPrimary = .blue   // 修改主题色
config.primaryColor = .blue         // 快捷方式
config.borderRadius = 8             // 修改圆角

// 批量配置
config.configure { config in
    config.theme = .dark
    config.locale = .enUS
    config.token.colorPrimary = .purple
}

// 重置配置
config.reset()
```

### View Modifier

```swift
// 应用全局主题（App 入口必须使用）
ContentView()
    .moinUIThemeRoot()

// 设置主题
SomeView()
    .moinUITheme(.dark)

// 设置语言
SomeView()
    .moinUILocale(.enUS)

// 设置主题色
SomeView()
    .moinUIPrimaryColor(.purple)

// 完整配置
SomeView()
    .moinUIConfig(MoinUIConfig(
        locale: .zhCN,
        theme: .system,
        token: customToken
    ))
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
                .moinUIThemeRoot()  // 必须在入口添加
        }
    }
}

struct ContentView: View {
    @ObservedObject var config = MoinUIConfigProvider.shared

    var body: some View {
        VStack {
            // 使用 Token
            Text("Hello")
                .foregroundColor(config.token.colorPrimary)

            // 主题切换
            Button("切换主题") {
                config.toggleTheme()
            }

            // 语言切换
            Picker("语言", selection: $config.locale) {
                Text("中文").tag(MoinUILocale.zhCN)
                Text("English").tag(MoinUILocale.enUS)
            }
        }
    }
}
```

---

## 后续规划

- [ ] RTL (从右到左) 布局支持
- [ ] 组件尺寸全局配置 (componentSize)
- [ ] 更多内置语言包
- [ ] CSS Variables 导出（用于混合开发）
- [ ] 配置持久化（UserDefaults）
