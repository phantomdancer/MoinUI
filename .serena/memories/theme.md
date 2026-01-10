# 主题系统

## 主题模式

```swift
enum Moin.Theme { case light, dark, system }
```

## Token 属性

颜色: colorPrimary/Success/Warning/Danger/Info + Hover/Active 变体
背景: colorBgContainer, colorBgElevated, colorBgHover
文本: colorText, colorTextSecondary, colorTextDisabled
边框: colorBorder, colorBorderHover
布局: borderRadius(SM/LG), controlHeight(SM/LG), fontSize(SM/LG), padding(SM/LG)
动画: motionDuration

## 使用

```swift
// 启用
ContentView().moinThemeRoot()

// 切换
Moin.ConfigProvider.shared.applyTheme(.dark)
Moin.ConfigProvider.shared.toggleTheme()

// 检查
Moin.ConfigProvider.shared.isDarkMode

// 在 View 中
@Environment(\.moinToken) private var token
.foregroundStyle(token.colorPrimary)
```

## 系统跟随

监听 `AppleInterfaceThemeChangedNotification`，自动切换 Token。