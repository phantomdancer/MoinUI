# 新组件开发模板

创建新组件时参考此模板。

## 目录结构

```
Sources/MoinUI/Components/{ComponentName}/
├── {ComponentName}.swift           # 主组件
├── {ComponentName}Type.swift       # 类型枚举（可选）
├── {ComponentName}Size.swift       # 尺寸枚举（可选）
└── {ComponentName}Variant.swift    # 变体枚举（可选）
```

## 主组件模板

```swift
import SwiftUI

public extension Moin {
    struct {ComponentName}: View {
        @Environment(\.moinUIToken) private var token
        @Environment(\.moinLocalization) private var localization

        private let title: String
        private let type: Moin.{ComponentName}Type
        private let size: Moin.{ComponentName}Size
        private let isDisabled: Bool
        private let action: (() -> Void)?

        public init(
            _ title: String,
            type: Moin.{ComponentName}Type = .default,
            size: Moin.{ComponentName}Size = .medium,
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
}
```

## 枚举模板

```swift
// Type
public extension Moin {
    enum {ComponentName}Type {
        case `default`, primary, success, warning, danger, info
    }
}

// Size
public extension Moin {
    enum {ComponentName}Size {
        case small, medium, large

        var height: CGFloat {
            switch self {
            case .small: return Moin.Constants.Size.controlHeightSM
            case .medium: return Moin.Constants.Size.controlHeight
            case .large: return Moin.Constants.Size.controlHeightLG
            }
        }
    }
}
```

## 测试模板

```swift
// Tests/MoinTests/{ComponentName}Tests.swift
import XCTest
@testable import MoinUI

final class {ComponentName}Tests: XCTestCase {
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
    @Environment(\.moinLocalization) private var localization

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Moin.Constants.Spacing.xl) {
                typeExample
                sizeExample
                apiReference
            }
            .padding(Moin.Constants.Spacing.xl)
        }
    }

    private var typeExample: some View {
        ExampleSection(
            title: localization.tr("{component}.type"),
            description: localization.tr("{component}.type_desc")
        ) {
            Moin.{Component}(localization.tr("{component}.label.default")) {}
        } code: {
            // 示例代码字符串必须使用 \() 插值
            """
            Moin.{Component}("\(localization.tr("{component}.label.default"))") {}
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
