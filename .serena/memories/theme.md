# 主题系统

## 主题模式

```swift
enum Moin.Theme { case light, dark, system }
```

## Token 系统（对齐 Ant Design 四层架构）

### 架构层级
```
SeedToken (18核心值) → MapToken (80+派生) → Token (别名层) → ComponentToken (组件层)
```

### SeedToken（种子 Token）18 个属性
- **品牌色**: colorPrimary, colorSuccess, colorWarning, colorError, colorInfo, colorLink
- **字体**: fontSize, lineHeight
- **线条**: lineWidth
- **圆角**: borderRadius
- **尺寸**: sizeUnit, sizeStep, controlHeight
- **间距**: padding, margin
- **层级**: zIndexBase, zIndexPopupBase
- **动画**: motionDuration

### MapToken（映射 Token）80+ 属性
- **颜色派生**: 5种色板 × 10级 + Bg/Border/Text 变体
- **链接色**: colorLink/Hover/Active
- **文字**: 4级透明度梯度
- **背景**: Container/Elevated/Layout/Spotlight/Mask + Fill(4级)
- **字体**: fontSize(SM/LG/XL) + Heading(1-5)
- **行高**: lineHeight(SM/LG) + Heading(1-5)
- **控件**: controlHeight(XS/SM/LG)
- **圆角**: borderRadius(XS/SM/LG/Outer)
- **间距**: padding(XXS/XS/SM/MD/LG/XL) + margin(XXS~XXL)
- **动画**: motionDuration(Fast/Mid/Slow)

### Token（别名层）
从 MapToken 包装，保持现有 API，属性可变支持覆盖。

### ComponentToken
- **ButtonToken**: 40 个属性（含阴影/行高/按钮组）
- **SpaceToken**: 3 个属性
- **DividerToken**: 9 个属性

## 使用

```swift
// 启用
ContentView().moinThemeRoot()

// 修改种子值，自动级联派生
config.setPrimaryColor(.purple)
config.setBorderRadius(8)

// 批量修改
config.configureSeed { seed in
    seed.colorPrimary = .indigo
    seed.fontSize = 15
    seed.sizeUnit = 4
}

// 在 View 中
@Environment(\.moinToken) private var token
.foregroundStyle(token.colorPrimary)
.padding(token.paddingMD)
.font(.system(size: token.fontSizeHeading3))
```

## 系统跟随

监听 `AppleInterfaceThemeChangedNotification`，自动切换 Token。
