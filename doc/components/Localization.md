# Localization 国际化

## 设计指南

Localization 提供组件库的多语言支持，采用 JSON 格式管理翻译文本。

### 设计原则

1. **简洁易用**：`tr("key")` 一行代码获取翻译
2. **嵌套结构**：JSON 支持嵌套，自动扁平化为点号分隔的 key
3. **优雅降级**：当前语言无翻译时，回退到英文，再回退到 key 本身
4. **运行时扩展**：支持动态注册自定义翻译

### 翻译优先级

```
自定义翻译 > 内置翻译 > 英文回退 > 返回 key
```

---

## 竞品对比

| 功能 | Ant Design | Element Plus | shadcn/ui | MoinUI |
|------|------------|--------------|-----------|--------|
| **基础功能** |
| 多语言切换 | ✅ | ✅ | ❌ | ✅ |
| 内置语言包 | ✅ (50+) | ✅ (60+) | ❌ | ✅ (2) |
| 默认语言 | 英文 | 中文 | - | 中文 |
| **翻译格式** |
| JSON 格式 | ❌ (JS) | ❌ (JS) | ❌ | ✅ |
| 嵌套结构 | ✅ | ✅ | ❌ | ✅ |
| 扁平化 key | ✅ | ✅ | ❌ | ✅ |
| **扩展能力** |
| 自定义翻译 | ✅ | ✅ | ❌ | ✅ |
| 运行时注册 | ✅ | ✅ | ❌ | ✅ |
| 合并覆盖 | ✅ | ✅ | ❌ | ✅ |
| **API 风格** |
| Provider 组件 | ✅ | ✅ | ❌ | ✅ |
| Hook/函数 | ✅ useIntl | ✅ useLocale | ❌ | ✅ tr() |
| 全局函数 | ❌ | ❌ | ❌ | ✅ |
| **其他** |
| 日期格式化 | ✅ | ✅ | ❌ | ❌ |
| 数字格式化 | ✅ | ✅ | ❌ | ❌ |
| 复数形式 | ✅ | ❌ | ❌ | ❌ |
| RTL 支持 | ✅ | ✅ | ❌ | ❌ |

---

## MoinUI 实现方案

### 架构设计

```
MoinUILocalization (单例)
├── locale: MoinUILocale              // 当前语言
├── translations: [Locale: [Key: Value]]   // 内置翻译
└── customTranslations: [Locale: [Key: Value]]  // 自定义翻译
```

### 支持的语言

```swift
public enum MoinUILocale: String, CaseIterable {
    case zhCN = "zh-CN"   // 简体中文（默认）
    case enUS = "en-US"   // 英文
}
```

### JSON 翻译文件格式

```json
{
  "button": {
    "submit": "提交",
    "cancel": "取消",
    "label": {
      "loading": "加载中"
    }
  },
  "message": {
    "success": "操作成功"
  }
}
```

自动扁平化为：
- `button.submit` → "提交"
- `button.cancel` → "取消"
- `button.label.loading` → "加载中"
- `message.success` → "操作成功"

### API 设计

```swift
// 获取翻译（当前语言）
let text = tr("button.submit")

// 或通过实例
let localization = MoinUILocalization.shared
let text = localization.tr("button.submit")

// 获取指定语言翻译
let text = localization.tr("button.submit", locale: .enUS)

// 切换语言
localization.setLocale(.enUS)

// 注册单个翻译
localization.register("app.title", translations: [
    .zhCN: "我的应用",
    .enUS: "My App"
])

// 批量注册
localization.registerAll([
    ("app.title", [.zhCN: "我的应用", .enUS: "My App"]),
    ("app.desc", [.zhCN: "描述", .enUS: "Description"])
])

// 从字典注册（嵌套结构）
localization.registerFromDictionary([
    "app": [
        "title": "我的应用",
        "desc": "描述"
    ]
], locale: .zhCN)

// 从 JSON 字符串注册
try localization.registerFromJSONString("""
{
    "app": {
        "title": "My App"
    }
}
""", locale: .enUS)

// 从 JSON Data 注册
try localization.registerFromJSON(jsonData, locale: .zhCN)
```

### SwiftUI 集成

```swift
struct ContentView: View {
    @EnvironmentObject var localization: MoinUILocalization

    var body: some View {
        VStack {
            // 使用 tr() 获取翻译
            Text(localization.tr("button.submit"))

            // 或使用全局函数
            Text(tr("button.cancel"))

            // 语言切换
            Picker("语言", selection: $localization.locale) {
                Text("中文").tag(MoinUILocale.zhCN)
                Text("English").tag(MoinUILocale.enUS)
            }
        }
    }
}
```

### 使用示例

```swift
import MoinUI

// 1. 在 App 入口注入
@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .moinUIThemeRoot()  // 自动注入 localization
        }
    }
}

// 2. 注册应用翻译
struct AppTranslations {
    static func register() {
        let localization = MoinUILocalization.shared

        // 注册中文
        localization.registerFromDictionary([
            "app": [
                "name": "我的应用",
                "welcome": "欢迎使用"
            ]
        ], locale: .zhCN)

        // 注册英文
        localization.registerFromDictionary([
            "app": [
                "name": "My App",
                "welcome": "Welcome"
            ]
        ], locale: .enUS)
    }
}

// 3. 使用翻译
Text(tr("app.name"))
```

---

## 后续规划

- [ ] 更多内置语言包（日语、韩语等）
- [ ] 日期/时间格式化
- [ ] 数字/货币格式化
- [ ] 复数形式支持
- [ ] 从 Bundle 加载应用翻译文件
- [ ] 翻译缺失警告（开发模式）
