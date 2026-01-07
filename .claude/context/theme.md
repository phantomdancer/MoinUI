# 主题系统

> MoinUI 主题系统说明

## 概述

MoinUI 提供完整的主题系统，支持浅色、深色和跟随系统三种模式。

## 核心组件

| 组件 | 文件 | 说明 |
|------|------|------|
| MoinUITheme | `Config/MoinUITheme.swift` | 主题枚举 (light/dark/system) |
| MoinUIToken | `Config/MoinUITheme.swift` | 设计令牌（颜色、间距、圆角等） |
| MoinUIConfigProvider | `Config/MoinUIConfigProvider.swift` | 全局配置管理 |

## 主题模式

```swift
public enum MoinUITheme: String, CaseIterable {
    case light      // 浅色
    case dark       // 深色
    case system     // 跟随系统（默认）
}
```

## Token 系统

### 预设 Token

- `MoinUIToken.light` - 浅色主题令牌
- `MoinUIToken.dark` - 暗色主题令牌

### Token 属性

```swift
// 颜色
colorPrimary, colorSuccess, colorWarning, colorDanger, colorInfo
colorBgContainer, colorBgElevated, colorBgHover
colorText, colorTextSecondary, colorTextDisabled
colorBorder, colorBorderHover

// 布局
borderRadius, borderRadiusSM, borderRadiusLG
controlHeight, controlHeightSM, controlHeightLG
fontSize, fontSizeSM, fontSizeLG
padding, paddingSM, paddingLG

// 动画
motionDuration
```

## 使用方式

### 启用全局主题

```swift
@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .moinUIThemeRoot()  // 一行代码启用
        }
    }
}
```

### 切换主题

```swift
// 应用指定主题
MoinUIConfigProvider.shared.applyTheme(.dark)
MoinUIConfigProvider.shared.applyTheme(.light)
MoinUIConfigProvider.shared.applyTheme(.system)

// 切换浅色/深色
MoinUIConfigProvider.shared.toggleTheme()
```

### 检查当前模式

```swift
if MoinUIConfigProvider.shared.isDarkMode {
    // 当前是深色模式
}
```

### 使用 Token

```swift
let token = MoinUIConfigProvider.shared.token

// 在 View 中
.foregroundStyle(token.colorPrimary)
.background(token.colorBgContainer)
.cornerRadius(token.borderRadius)
```

## 系统跟随

当 `theme = .system` 时，MoinUI 会：
1. 监听系统外观变化通知 (`AppleInterfaceThemeChangedNotification`)
2. 自动切换对应的 Token（light/dark）
3. 触发 UI 重绘

无需手动处理系统外观变化。
