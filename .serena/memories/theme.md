# 主题系统

## 主题模式

```swift
enum Moin.Theme { case light, dark, system }
```

## Token 系统（对齐 Ant Design 四层架构）

### 架构层级
```
SeedToken (8核心值) → MapToken (派生50+) → Token (别名层) → ComponentToken (组件层)
```

### SeedToken（种子 Token）
核心可配置值，所有派生的源头：
- `colorPrimary`, `colorSuccess`, `colorWarning`, `colorError`, `colorInfo`
- `fontSize` (14), `borderRadius` (6), `controlHeight` (32)
- `padding` (12), `motionDuration` (0.25)

### MapToken（映射 Token）
从 SeedToken 派生：
- **颜色派生**：使用 ColorPalette.generate() 生成 10 级色板
- **文字派生**：透明度梯度 0.88/0.65/0.45/0.25
- **尺寸派生**：
  - fontSize: SM = base-2, LG = base+2
  - controlHeight: SM = base×0.75, LG = base×1.25
  - borderRadius: SM = base-2, LG = base+2

### Token（别名层）
从 MapToken 包装，保持现有 API：
- `colorDanger` → `map.colorError`（别名映射）
- 所有属性为存储属性，支持双向绑定

### ComponentToken
各组件 Token 有 `generate(from: Token)` 方法：
- `ButtonToken.generate(from:isDark:)`
- `SpaceToken.generate(from:)`
- `DividerToken.generate(from:)`

## 使用

```swift
// 启用
ContentView().moinThemeRoot()

// 切换主题
Moin.ConfigProvider.shared.applyTheme(.dark)
Moin.ConfigProvider.shared.toggleTheme()

// 修改种子值，自动级联派生
config.setPrimaryColor(.purple)
config.setBorderRadius(8)

// 或直接配置种子
config.configureSeed { seed in
    seed.colorPrimary = .indigo
    seed.fontSize = 16
}

// 重置所有 Token
config.reset()

// 在 View 中
@Environment(\.moinToken) private var token
.foregroundStyle(token.colorPrimary)
```

## 系统跟随

监听 `AppleInterfaceThemeChangedNotification`，自动切换 Token。
