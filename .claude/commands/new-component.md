# 创建新组件

创建 MoinUI 新组件，遵循现有架构和规范。

## 组件命名

所有组件以 `MoinUI` 开头，如 `MoinUIButton`、`MoinUIInput`。

## 目录结构

```
Sources/MoinUI/Components/{ComponentName}/
├── MoinUI{ComponentName}.swift      # 主组件
├── MoinUI{ComponentName}Type.swift  # 类型枚举（可选）
├── MoinUI{ComponentName}Size.swift  # 尺寸枚举（可选）
└── MoinUI{ComponentName}Variant.swift # 变体枚举（可选）
```

## 必要文件

### 1. 主组件 (MoinUI{ComponentName}.swift)

```swift
import SwiftUI

public struct MoinUI{ComponentName}: View {
    @EnvironmentObject var localization: MoinUILocalization
    @ObservedObject private var config = MoinUIConfigProvider.shared
    private var token: MoinUIToken { config.token }

    // 属性
    private let title: String
    private let type: MoinUI{ComponentName}Type
    private let size: MoinUI{ComponentName}Size
    private let isDisabled: Bool
    private let action: (() -> Void)?

    public init(
        _ title: String,
        type: MoinUI{ComponentName}Type = .default,
        size: MoinUI{ComponentName}Size = .medium,
        isDisabled: Bool = false,
        action: (() -> Void)? = nil
    ) {
        self.title = title
        self.type = type
        self.size = size
        self.isDisabled = isDisabled
        self.action = action
    }

    public var body: some View {
        // 实现
    }
}
```

### 2. 类型枚举 (MoinUI{ComponentName}Type.swift)

```swift
public enum MoinUI{ComponentName}Type {
    case `default`
    case primary
    case success
    case warning
    case danger
    case info
}
```

### 3. 尺寸枚举 (MoinUI{ComponentName}Size.swift)

```swift
public enum MoinUI{ComponentName}Size {
    case small
    case medium
    case large

    var height: CGFloat {
        switch self {
        case .small: return Constants.Size.controlHeightSM
        case .medium: return Constants.Size.controlHeight
        case .large: return Constants.Size.controlHeightLG
        }
    }

    var fontSize: CGFloat {
        switch self {
        case .small: return Constants.Font.fontSizeSM
        case .medium: return Constants.Font.fontSize
        case .large: return Constants.Font.fontSizeLG
        }
    }
}
```

## Token 使用规范

使用 `config.token` 获取样式值，不要硬编码：

```swift
// ✅ 正确
.foregroundStyle(token.colorPrimary)
.background(token.colorBgContainer)
.cornerRadius(token.borderRadius)

// ❌ 错误
.foregroundStyle(Color.blue)
.background(Color.white)
.cornerRadius(6)
```

## 常量使用

使用 `Constants` 中定义的常量：

```swift
// 间距
Constants.Spacing.xs  // 4
Constants.Spacing.sm  // 8
Constants.Spacing.md  // 12
Constants.Spacing.lg  // 16
Constants.Spacing.xl  // 24

// 圆角
Constants.Radius.sm   // 4
Constants.Radius.md   // 6
Constants.Radius.lg   // 8

// 控件高度
Constants.Size.controlHeightSM  // 24
Constants.Size.controlHeight    // 32
Constants.Size.controlHeightLG  // 40

// 字体
Constants.Font.fontSizeSM  // 12
Constants.Font.fontSize    // 14
Constants.Font.fontSizeLG  // 16
```

## 测试要求

在 `Tests/MoinUITests/` 创建测试文件：

```swift
// MoinUI{ComponentName}Tests.swift
import XCTest
@testable import MoinUI

final class MoinUI{ComponentName}Tests: XCTestCase {
    func testDefaultInit() {
        // 测试默认初始化
    }

    func testAllTypes() {
        // 测试所有类型
    }

    func testAllSizes() {
        // 测试所有尺寸
    }

    func testDisabledState() {
        // 测试禁用状态
    }
}
```

## Demo 示例

在 `Sources/Demo/Examples/` 创建示例文件：

```swift
// {ComponentName}Examples.swift
struct {ComponentName}Examples: View {
    @EnvironmentObject var localization: MoinUILocalization

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Constants.Spacing.xl) {
                typeExample
                sizeExample
                // ... 其他示例
                apiReference
            }
            .padding(Constants.Spacing.xl)
        }
    }

    // 使用 ExampleSection 包装每个示例
    private var typeExample: some View {
        ExampleSection(
            title: localization.tr("{component}.type"),
            description: localization.tr("{component}.type_desc")
        ) {
            // 示例组件
            MoinUI{Component}(localization.tr("{component}.label.default")) {}
        } code: {
            // 示例代码中的字符串必须使用 \() 插值国际化
            """
            MoinUI{Component}("\(localization.tr("{component}.label.default"))") {}
            """
        }
    }
}
```

## 国际化

1. 在 `Sources/MoinUI/Locales/` 添加翻译：

```json
// zh-CN.json
{
  "{component}": {
    "label": {
      "default": "默认",
      "primary": "主要"
    }
  }
}
```

2. 在 `Sources/Demo/Locales/` 添加 Demo 翻译

## 导航注册

在 `Sources/Demo/DemoApp.swift` 中：

1. 添加 NavItem：
```swift
enum NavItem {
    case {componentName}  // 添加
}
```

2. 添加图标和标题：
```swift
var icon: String {
    case .{componentName}: return "icon.name"
}

var titleKey: String {
    case .{componentName}: return "component.{componentName}"
}
```

3. 添加到组件列表：
```swift
static var components: [NavItem] { [.button, .{componentName}] }
```

4. 添加路由：
```swift
case .{componentName}:
    {ComponentName}Examples()
```

## 检查清单

- [ ] 主组件实现
- [ ] 枚举类型定义
- [ ] 使用 Token 和 Constants
- [ ] 支持浅色/深色主题
- [ ] 单元测试（覆盖所有属性）
- [ ] Demo 示例页面
- [ ] 示例代码字符串使用 `\(localization.tr(...))` 插值
- [ ] 中英文翻译
- [ ] 导航注册
- [ ] `swift build` 无警告
- [ ] `swift test` 全部通过
