# 新组件开发模板

创建新组件时参考此模板。

## 目录结构

```
Sources/MoinUI/Components/{ComponentName}/
├── MoinUI{ComponentName}.swift      # 主组件
├── MoinUI{ComponentName}Type.swift  # 类型枚举（可选）
├── MoinUI{ComponentName}Size.swift  # 尺寸枚举（可选）
└── MoinUI{ComponentName}Variant.swift # 变体枚举（可选）
```

## 主组件模板

```swift
import SwiftUI

public struct MoinUI{ComponentName}: View {
    @EnvironmentObject var localization: MoinUILocalization
    @ObservedObject private var config = MoinUIConfigProvider.shared
    private var token: MoinUIToken { config.token }

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

## 枚举模板

```swift
// Type
public enum MoinUI{ComponentName}Type {
    case `default`, primary, success, warning, danger, info
}

// Size
public enum MoinUI{ComponentName}Size {
    case small, medium, large

    var height: CGFloat {
        switch self {
        case .small: return Constants.Size.controlHeightSM
        case .medium: return Constants.Size.controlHeight
        case .large: return Constants.Size.controlHeightLG
        }
    }
}
```

## 测试模板

```swift
// Tests/MoinUITests/MoinUI{ComponentName}Tests.swift
import XCTest
@testable import MoinUI

final class MoinUI{ComponentName}Tests: XCTestCase {
    func testDefaultInit() {}
    func testAllTypes() {}
    func testAllSizes() {}
    func testDisabledState() {}
}
```

## Demo 示例模板

```swift
// Sources/Demo/Examples/{ComponentName}Examples.swift
struct {ComponentName}Examples: View {
    @EnvironmentObject var localization: MoinUILocalization

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Constants.Spacing.xl) {
                typeExample
                sizeExample
                apiReference
            }
            .padding(Constants.Spacing.xl)
        }
    }

    private var typeExample: some View {
        ExampleSection(
            title: localization.tr("{component}.type"),
            description: localization.tr("{component}.type_desc")
        ) {
            MoinUI{Component}(localization.tr("{component}.label.default")) {}
        } code: {
            // 示例代码字符串必须使用 \() 插值
            """
            MoinUI{Component}("\(localization.tr("{component}.label.default"))") {}
            """
        }
    }
}
```

## 导航注册

在 `Sources/Demo/DemoApp.swift`：

```swift
// 1. NavItem 添加 case
case {componentName}

// 2. icon
case .{componentName}: return "icon.name"

// 3. titleKey
case .{componentName}: return "component.{componentName}"

// 4. components 列表
static var components: [NavItem] { [.button, .{componentName}] }

// 5. DetailView 路由
case .{componentName}: {ComponentName}Examples()
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
