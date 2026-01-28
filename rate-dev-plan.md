# Rate 组件实现计划

## 概述
实现 MoinUI Rate 评分组件，完全参照 Ant Design Rate 的属性和 Token 设计。

---

## 文件结构

```
Sources/MoinUI/
├── Components/Rate/
│   └── Rate.swift                    # 主组件 + Factory
├── Config/Tokens/
│   └── RateToken.swift               # Token 定义

Sources/Demo/
├── Examples/Rate/
│   ├── RateExamples.swift            # Examples Tab
│   ├── RateAPIView.swift             # API Tab
│   └── RateTokenView.swift           # Token Tab
```

---

## 一、RateToken（组件令牌）

**文件**: `Sources/MoinUI/Config/Tokens/RateToken.swift`

```swift
public extension Moin {
    struct RateToken {
        public var starColor: Color       // 已填充颜色，默认 yellow6
        public var starBg: Color          // 未填充背景，默认 colorFillContent
        public var starSize: CGFloat      // 默认尺寸 20 (controlHeight * 0.625)
        public var starSizeSM: CGFloat    // 小尺寸 15
        public var starSizeLG: CGFloat    // 大尺寸 25
        public var starHoverScale: CGFloat // 悬停缩放 1.1
        public var starGap: CGFloat       // 间距 marginXXS

        public static func generate(from token: Token) -> RateToken
    }
}
```

**注册点**: `ComponentToken.swift` 添加 `rate: Moin.RateToken`

---

## 二、Rate 组件

**文件**: `Sources/MoinUI/Components/Rate/Rate.swift`

### 属性（与 Ant Design 一致）
| 属性 | 类型 | 默认值 |
|------|------|--------|
| value | Binding<Double> | - |
| count | Int | 5 |
| allowHalf | Bool | false |
| allowClear | Bool | true |
| disabled | Bool | false |
| size | Size | .medium |
| character | View | star.fill |
| onChange | Callback | nil |
| onHoverChange | Callback | nil |

### 尺寸枚举
```swift
public enum Size {
    case small, medium, large, custom(CGFloat)
}
```

### 核心逻辑
1. **半星计算**: GeometryReader 检测点击位置 x < width/2 → 半星
2. **悬停效果**: onContinuousHover + scaleEffect(starHoverScale)
3. **点击清除**: allowClear && 点击当前值 → value = 0
4. **渲染**: displayValue >= index+1 全填充 / >= index+0.5 半填充 / else 空心

### Factory 注册
```swift
public struct _MoinRateFactory {
    public typealias Size = _Rate<AnyView>.Size
    public func callAsFunction(value:count:allowHalf:allowClear:disabled:size:onChange:onHoverChange:) -> _Rate<Image>
    public func callAsFunction<C: View>(..., @ViewBuilder character: () -> C) -> _Rate<C>
}
// Moin.swift: public static let Rate = _MoinRateFactory()
```

---

## 三、Demo 三个 Tab

### 1. Examples Tab (`RateExamples.swift`)
| 锚点 | 示例 |
|------|------|
| basic | 基础用法 |
| half | 半星选择 |
| disabled | 只读状态 |
| clear | 允许清除 |
| count | 自定义数量 |
| character | 自定义字符 |
| size | 三种尺寸 |

### 2. API Tab (`RateAPIView.swift`)
9 个属性的 PropertyCard

### 3. Token Tab (`RateTokenView.swift`)
- 组件 Token: starColor, starBg, starSize, starSizeSM, starSizeLG, starHoverScale, starGap
- 全局 Token: yellow6, colorFillContent, controlHeight/SM/LG, marginXXS

---

## 四、注册点汇总

| 文件 | 修改内容 |
|------|----------|
| `Config/Tokens/ComponentToken.swift` | 添加 `rate: Moin.RateToken` |
| `Moin.swift` | 添加 `public static let Rate = _MoinRateFactory()` |
| `Demo/DemoApp.swift` NavItem | 添加 `case rate` 到 dataEntry 分组 |
| `Demo/DemoApp.swift` icon | 添加 `case .rate: return DemoIcons.rate` |
| `Demo/DemoApp.swift` titleKey | 添加 `case .rate: return "component.rate"` |
| `Demo/DemoApp.swift` DetailView | 添加 `case .rate: RateExamples()` |
| `Demo/DemoIcons.swift` | 添加 `static let rate = "star.fill"` |
| `Demo/DemoTranslations.swift` | 注册 Rate 翻译路径 |
| `Demo/Locales/zh-CN.json` | 添加 rate 相关翻译 |
| `Demo/Locales/en-US.json` | 添加 rate 相关翻译 |

---

## 五、翻译 Key

```json
{
  "component.rate": "Rate 评分",
  "rate.basic": "基础用法",
  "rate.basic_desc": "最简单的评分组件",
  "rate.half": "半星",
  "rate.half_desc": "支持选择半星",
  "rate.disabled": "只读",
  "rate.disabled_desc": "禁用交互的只读状态",
  "rate.clear": "清除",
  "rate.clear_desc": "再次点击可清除评分",
  "rate.count": "自定义数量",
  "rate.count_desc": "自定义星星总数",
  "rate.character": "自定义字符",
  "rate.character_desc": "使用自定义图标或字符",
  "rate.size": "尺寸",
  "rate.size_desc": "三种预设尺寸",
  "rate.prop_*": "...",
  "rate.token.*": "..."
}
```

---

## 六、验证步骤

1. `swift build` 零警告
2. `swift test` 全部通过
3. Demo 运行：检查三个 Tab 正常显示
4. 功能测试：点击、半星、悬停、清除、禁用

---

## 关键参考文件

- `/Sources/MoinUI/Components/Skeleton/Skeleton.swift` - 组件结构模式
- `/Sources/MoinUI/Config/Tokens/SkeletonToken.swift` - Token 定义模式
- `/Sources/Demo/Examples/Skeleton/` - Demo 三 Tab 模式
- `/Sources/Demo/DemoApp.swift:391-493` - NavItem 注册
