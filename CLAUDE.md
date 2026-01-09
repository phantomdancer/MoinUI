# MoinUI Agent 指南
使用文言文回复。用最小必要语言回复，说重点，不要长篇大论。

## 项目概述
MoinUI (墨影UI) - macOS SwiftUI 组件库
- **平台**: macOS only (13.0+)
- **语言**: Swift / SwiftUI
- **结构**: Swift Package Manager

风格参考：shadcn/ui, Element Plus
功能参考：Ant Design, Element Plus

## 核心命令

### 开发命令
```bash
pnpm dev                    # 启动开发（推荐）
swift build                 # 构建项目
swift test                  # 运行所有测试
swift test --enable-code-coverage  # 运行测试并生成覆盖率
pnpm test:coverage          # 显示覆盖率报告
pnpm test:coverage:html    # 生成 HTML 覆盖率
swift package clean && swift build  # 清理并重新构建
```

### 运行单个测试
```bash
swift test --filter MoinTests/测试类名/测试方法名
swift test --filter ".*关键词.*"  # 运行匹配模式的测试
swift test -l              # 列出所有测试
```

### 依赖管理
```bash
swift package resolve      # 解析依赖
swift package update       # 更新依赖
```

## 代码风格指南

### 命名约定
- **组件**: `Moin.` 命名空间（如 `Moin.Button`）
- **常量**: `Moin.Constants` 枚举，嵌套枚举
- **配置**: `Moin.Config`, `Moin.Token`, `Moin.[组件名]Token`
- **扩展**: 对现有类型使用 `public extension`
- **枚举**: 小写驼峰命名 (.default, .primary, .success)

### 文件组织
```
Sources/MoinUI/
├── Components/           # 组件实现
│   ├── [组件名]/         # 组件文件夹，包含所有相关类型
├── Config/               # 配置和主题
├── Localization/         # 国际化管理
└── Utils/               # 工具和常量

Sources/Demo/
└── Examples/            # 组件示例页

Tests/MoinTests/       # 测试
```

### 导入顺序
1. SwiftUI
2. AppKit (如果需要 macOS 特定功能)
3. 项目导入 (测试时使用 @testable import MoinUI)

### 常量使用
**✅ 正确:**
```swift
Moin.Constants.Spacing.sm   // 8
Moin.Constants.Radius.md    // 6
```

**❌ 错误:**
```swift
8   // 魔法数字
```

### Token 使用
通过 token 获取样式，禁止硬编码：

**✅ 正确:**
```swift
@Environment(\.moinUIToken) private var token
.foregroundStyle(token.colorPrimary)
.background(token.colorBgContainer)
```

**❌ 错误:**
```swift
.foregroundStyle(Color.blue)
.background(Color.white)
```

### 组件结构模式
```swift
public extension Moin {
    struct 组件名<Label: View>: View {
        // 属性
        @State private var state: Type
        @Environment(\.moinUIToken) private var token

        // 初始化器
        public init(...) { ... }

        // 主体
        public var body: some View { ... }

        // 计算属性和辅助方法
    }
}

// 便捷初始化器
public extension Moin.组件名 where Label == Text {
    init(_ title: String, ...) { ... }
}
```

### MARK 注释
使用 MARK 注释组织代码：
```swift
// MARK: - 属性
// MARK: - 初始化器
// MARK: - 主体
// MARK: - 计算属性
// MARK: - 辅助方法
// MARK: - 便捷初始化器
```

### 状态管理
- 使用 `@State` 管理局部组件状态
- 使用 `@Environment` 共享配置 (tokens, locale)
- 避免在组件中使用 `@ObservedObject` (改用 Environment)

### 错误处理
- 使用 `try?` 处理可选错误
- 对关键操作使用 `try` 配合正确的错误类型
- 开发时用 print() 记录错误

### 测试指南
- 使用 XCTest 框架
- 测试类继承自 `XCTestCase`
- 使用 `setUp()` 在每个测试前重置状态: `Moin.ConfigProvider.shared.reset()`
- 测试命名: `test[方法名][场景]`
- 覆盖正常路径和边界情况

### Demo 要求
- 每个组件必须在 `Sources/Demo/Examples/` 中有完整示例
- 使用 `localization.tr("key")` 处理所有用户可见文本
- 代码示例必须使用字符串插值进行翻译: `\(localization.tr("key"))`
- 包含所有变体、尺寸、颜色和状态
- 添加 API 文档章节

### 国际化 (i18n)
- 默认: 中文 (zh-CN)，支持英文 (en-US)
- 组件翻译: `Sources/MoinUI/Localization/Locales/`
- Demo 翻译: `Sources/Demo/Locales/`
- 使用 `localization.tr("key")` 获取翻译
- 翻译键格式: `component.property` (如 "button.label.primary")

### 构建要求
- **零警告**: 每次修改后运行 `swift build`，确保无警告
- **测试覆盖率**: 所有新代码必须有高覆盖率测试
- **编译**: 必须在 macOS 13.0+ 上成功编译

### 代码质量
- 保持文件聚焦和合理大小 (建议 < 500 行)
- 当主体太复杂时提取辅助方法
- 使用计算属性获取派生值
- 优先使用 `@ViewBuilder` 处理条件视图
- 不实现 `#Preview` (使用 Demo 应用代替)

## 工作流程

1. **开始前**: 读取 `.claude/context/` 了解当前状态
2. **编写代码**: 按照规范编写 Swift 代码
3. **构建**: `swift build` - 确保零警告
4. **测试**: `swift test` - 确保所有测试通过
5. **Demo**: 在 Sources/Demo/Examples/ 添加完整示例
6. **翻译**: 添加中英文翻译
7. **上下文**: 更新 `.claude/context/` 文件 (用简洁文言文)
8. **验证**: 再次构建确认一切正常
9. **回复**: 完成后回复 "毕。"

## 设计原则

- **跟随主流**: 实现 antd 和 element-plus 都有的功能
- **取长补短**: 保留 element-plus 有而 antd 缺少的语义色
- **简化优先**: shadcn 没有的复杂功能可以简化
- **原生适配**: 利用 SwiftUI 原生能力
- **Token 驱动**: 所有样式通过可配置 token 实现

## 快速参考

### 常用 Token
```swift
token.colorPrimary          // 主品牌色
token.colorSuccess          // 成功绿
token.colorWarning          // 警告橙
token.colorDanger           // 危险红
token.colorInfo             // 信息灰
token.colorBgContainer      // 背景
token.colorText             // 主文本
token.borderRadius          // 圆角
token.controlHeight         // 控件高度
token.motionDuration        // 动画时长
```

### 环境值
```swift
@Environment(\.moinConfig) var moinConfig
@Environment(\.moinUIToken) var token
@Environment(\.moinLocalization) var localization
```

### 间距常量
```swift
Moin.Constants.Spacing.xs  // 4
Moin.Constants.Spacing.sm  // 8
Moin.Constants.Spacing.md  // 12
Moin.Constants.Spacing.lg  // 16
Moin.Constants.Spacing.xl  // 24
```

### 视图修饰器
```swift
.moinUIConfig(config)           // 应用配置
.moinUILocale(.enUS)           // 设置语言
.moinUIPrimaryColor(.red)      // 设置主色
.moinUITheme(.dark)            // 设置主题
```

## 竞品参考
- **Ant Design**: 已下载到 `ThirdLibs/ant-design/` (如缺失请 clone)；https://context7.com/ant-design/ant-design/llms.txt；
- **Element Plus**: https://element-plus.org
- **shadcn/ui**: https://ui.shadcn.com

需要时使用 context7 工具查询竞品文档。
