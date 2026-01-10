# 组件清单

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