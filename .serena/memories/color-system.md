# MoinUI 色彩系统

## 核心文件
- `Sources/MoinUI/Utils/Colors.swift` - 色彩工具、预设色、色板生成

## 色板生成算法
基于 HSV 色彩模型，生成 1-10 级色板：
- Level 1-5: 浅色（饱和度递减，明度递增）
- Level 6: 主色
- Level 7-10: 深色（饱和度递增，明度递减）

```swift
// 生成色板
let palette = Moin.ColorPalette.generate(from: color, theme: .light)
palette[6]  // 主色
palette[5]  // hover 色
palette[7]  // active 色
```

## 语义色映射
| 状态 | 色阶 |
|------|------|
| normal | level 6 |
| hover | level 5 |
| active | level 7 |

## Token 中的语义色
```swift
token.colorPrimary       // 主色 level 6
token.colorPrimaryHover  // level 5
token.colorPrimaryActive // level 7
// success/warning/danger/info 同理
```

## 预设色板
`Moin.Colors` 提供 12 个预生成色板：
- blue, purple, cyan, green, magenta, red, orange, yellow, volcano, geekblue, gold, lime

## 暗色主题
暗色主题色板通过与背景色 (#141414) 混合生成：
```swift
Moin.ColorPalette.generate(from: color, theme: .dark, backgroundColor: darkBg)
```

## Button 颜色逻辑
- `.primary/.success/.warning/.danger` → 使用 token 语义色
- `.custom(Color)` → 动态生成色板取 level 5/6/7
