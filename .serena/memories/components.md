# 组件清单

## Typography 排版
- **文件**: `Sources/MoinUI/Components/Typography/`
- **API**: 
  - `Moin.Title(_:level:type:disabled:mark:underline:delete:code:)`
  - `Moin.Typography(_:type:disabled:mark:underline:delete:strong:italic:code:keyboard:)`
  - `Moin.Paragraph(_:type:disabled:mark:underline:delete:strong:italic:)`
  - `Moin.Link(_:disabled:action:)`
- **枚举**: TypographyType, TitleLevel
- **Demo**: `Sources/Demo/Examples/Typography/` (Examples, Playground, API, Token)

## Divider 分割线
- **文件**: `Sources/MoinUI/Components/Divider/`
- **API**: `Moin.Divider(orientation:variant:titlePlacement:content:)`
- **枚举**: DividerOrientation, DividerVariant, DividerTitlePlacement
- **Demo**: `Sources/Demo/Examples/Divider/` (Examples, Playground, API, Token)

## Space 间距
- **文件**: `Sources/MoinUI/Components/Space/`
- **API**: `Moin.Space(size:direction:alignment:wrap:compact:content:)`
- **枚举**: SpaceSize, SpaceDirection, SpaceAlignment, SpaceCompactPosition, SpaceCompactContext
- **Token**: SpaceToken (sizeSmall/Medium/Large)
- **Demo**: `Sources/Demo/Examples/Space/` (Examples, Playground, API)

## 通用组件

| 组件 | 状态 | 文件 |
|------|------|------|
| Button | ✅ | `Components/Button/Button.swift` |
| ButtonGroup | ✅ | `Components/Button/ButtonGroup.swift` |
| Typography | ✅ | `Components/Typography/Typography.swift` |
| Divider | ✅ | `Components/Divider/Divider.swift` |
| Space | ✅ | `Components/Space/Space.swift` |

## 配置组件

| 组件 | 状态 | 文件 |
|------|------|------|
| ConfigProvider | ✅ | `Config/ConfigProvider.swift` |
| Theme | ✅ | `Config/Theme.swift` |
| Localization | ✅ | `Localization/Localization.swift` |

## Button 功能

| 功能 | 状态 |
|------|------|
| Color (default/primary/success/warning/danger/info/custom) | ✅ |
| Variant (solid/outlined/dashed/filled/text/link) | ✅ |
| Size (small/medium/large) | ✅ |
| Shape (default/round/circle) | ✅ |
| Custom Color (.custom(Color)) | ✅ |
| Gradient | ✅ |
| fontColor | ✅ |
| Icon + Text | ✅ |
| Icon Placement (start/end) | ✅ |
| Loading (delay, 自定义 icon) | ✅ |
| Disabled | ✅ |
| Block | ✅ |
| Ghost | ✅ |
| href Link | ✅ |
| ButtonGroup | ✅ |
| ButtonToken | ✅ |