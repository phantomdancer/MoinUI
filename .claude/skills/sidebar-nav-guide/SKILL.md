---
name: sidebar-nav-guide
description: "MoinUI Demo 侧边栏导航添加指南。添加新组件或分组到 Demo 应用左侧边栏的完整步骤。关键文件：DemoApp.swift（NavItem枚举、Sidebar、DetailView）、DemoIcons.swift（图标）、DemoTranslations.swift（翻译注册）、Locales/（翻译文件）。操作：添加导航项、添加分组、添加组件示例页面。"
---

# Demo 侧边栏导航添加指南

## 文件清单

| 文件 | 作用 |
|------|------|
| `Sources/Demo/DemoApp.swift` | NavItem 枚举、Sidebar、DetailView |
| `Sources/Demo/DemoIcons.swift` | 图标常量 |
| `Sources/Demo/DemoTranslations.swift` | 翻译注册 |
| `Sources/Demo/Locales/*.json` | 主翻译 |
| `Sources/Demo/Examples/[组件]/` | 组件示例 |
| `Sources/Demo/Locales/[组件]/` | 组件翻译 |

---

## 添加步骤

### 1. DemoIcons.swift - 添加图标

```swift
static let spin = "arrow.trianglehead.2.counterclockwise.rotate.90"
```

### 2. DemoApp.swift - NavItem 枚举

```swift
// 添加 case
case spin

// icon 属性
case .spin: return DemoIcons.spin

// titleKey 属性
case .spin: return "component.spin"

// 分组数组
static var feedback: [NavItem] { [.spin] }
```

### 3. DemoApp.swift - Sidebar

```swift
Section(tr("nav.feedback")) {
    ForEach(NavItem.feedback) { item in
        NavigationLink(value: item) {
            Label(tr(item.titleKey), systemImage: item.icon)
        }
    }
}
```

### 4. DemoApp.swift - ContentView

```swift
// 添加状态
@State private var spinTab: SpinExamplesTab = .examples

// DetailView 参数
DetailView(..., spinTab: $spinTab, ...)

// Toolbar Picker
if navManager.selectedItem == .spin {
    Picker("", selection: $spinTab) {
        Text(tr("tab.examples")).tag(SpinExamplesTab.examples)
        Text(tr("tab.playground")).tag(SpinExamplesTab.playground)
        Text(tr("tab.api")).tag(SpinExamplesTab.api)
        Text(tr("tab.token")).tag(SpinExamplesTab.token)
    }
    .pickerStyle(.segmented)
    .fixedSize()
}
```

### 5. DemoApp.swift - DetailView

```swift
@Binding var spinTab: SpinExamplesTab

case .spin:
    SpinExamples(selectedTab: $spinTab)
```

### 6. 创建示例文件

`Sources/Demo/Examples/Spin/SpinExamples.swift`:

```swift
enum SpinExamplesTab: String, CaseIterable {
    case examples, playground, api, token
}

struct SpinExamples: View {
    @Binding var selectedTab: SpinExamplesTab

    // 锚点必须用 AnchorItem
    private let anchors: [AnchorItem] = [
        AnchorItem(id: "basic", titleKey: "spin.basic"),
    ]

    // ExampleSection 用法
    ExampleSection(
        title: tr("..."),
        description: tr("..."),
        content: { /* View */ },
        code: { /* String */ }
    )

    // APITable headers 是元组
    APITable(
        headers: (tr("api.property"), tr("api.type"), tr("api.default"), tr("api.description")),
        rows: [("name", "Type", "default", "desc")]
    )
}
```

### 7. 添加翻译

主翻译 `Locales/zh-CN.json`:
```json
{ "nav": { "feedback": "反馈" }, "component": { "spin": "Spin 加载中" } }
```

组件翻译 `Locales/Spin/zh-CN.json`:
```json
{ "spin.basic": "基础用法", "spin.basic_desc": "..." }
```

### 8. DemoTranslations.swift - 注册

```swift
private static let componentDirs = [
    // ...
    "Locales/Spin",
]
```

### 9. MoinUI 组件 - 暴露命名空间

```swift
public extension Moin {
    typealias Spin = MoinUI.Spin
}
```

---

## 验证

```bash
swift build && swift test
```
