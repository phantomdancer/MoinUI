---
trigger: always_on
---

# MoinUI Agent 指南
1. Always respond in Chinese-simplified
2. You MUST conduct your internal reasoning and thinking process entirely in Simplified Chinese. This is a strict requirement.
3. 使用文言文回复。用最小必要语言回复，说重点，不要长篇大论。

## 项目概述
MoinUI (墨影UI) - macOS SwiftUI 组件库
- **平台**: macOS 13.0+
- **语言**: Swift / SwiftUI
- **风格参考**: shadcn/ui, Element Plus, Ant Design

## 命名约定
- **组件**: `Moin.` 命名空间（如 `Moin.Button`）
- **常量**: `Moin.Constants.Spacing.md`，禁止魔法数字
- **配置**: `Moin.Config`, `Moin.Token`, `Moin.[组件名]Token`
- **枚举**: 小写驼峰 (.default, .primary, .success)

## 核心规则

### Token 使用（禁止硬编码）
```swift
@Environment(\.moinToken) private var token
.foregroundStyle(token.colorPrimary)  // ✅
.foregroundStyle(Color.blue)          // ❌
```

### 构建要求
- `swift build` 零警告(禁止使用xcodebuild)
- `swift test` 全部通过
- Demo 示例 + 中英文翻译

### 国际化
- Demo 翻译: `Sources/Demo/Locales/`
- 使用 `tr("key")` 获取翻译

## 工作流程

1. **开始前**: 使用 `read_memory` 读取记忆，如读取 `roadmap` 加载项目计划
2. **编写代码**: 遵循命名约定和 Token 规则
3. **构建测试**: `swift build && swift test`
4. **Demo**: 添加示例和翻译(示例代码code中也需要国际化)
5. **结束时**: 用 `write_memory` / `edit_memory` 更新 roadmap 等记忆
6. **回复**: 完成后回复的最后一行必须为：✅ 어머!
7. **通知**: 使用notify-bark skill发送任务完成通知

使用serena操作记忆，如果serena不可用，可自行阅读 .serena/memories目录下的记忆文件。

## 设计原则

- **Token 驱动**: 所有样式通过 token 实现
- **原生适配**: 利用 SwiftUI 原生能力
- **简化优先**: 复杂功能可简化

## Playground 规范

- **颜色选择**: 使用 `ColorPresetRow` 预设颜色选择（禁用 `TokenColorRow` ColorPicker）
- **数值调节**: 使用 `TokenValueRow`
- **布局结构**: 左侧预览+代码，右侧属性面板（参考 DividerPlayground）

## 竞品参考
分析开源工具时，可 clone 到 `ThirdLibs/` 目录后查看其代码。

- **Ant Design**: `ThirdLibs/ant-design/`，若无请 clone
有两个工具可用：
https://ant.design/llms.txt
https://ant.design/llms-full.txt
已经下载到：ThirdLibs/ant-design/ 目录下，如果txt 文件不存在，你需要 wget 或者curl 下载到该目录，因为文件太大了。

- **Element Plus**: https://element-plus.org
- **shadcn/ui**: https://ui.shadcn.com

# MoinUI 目录结构

## 📁 核心代码

### Sources/MoinUI/ - 主库代码
- **Components/** - 组件实现
  - Avatar/ - 头像组件
  - Button/ - 按钮组件
  - 其他省略

- **Config/** - 配置系统
  - Tokens/ - Token配置
    - AvatarToken.swift
    - ButtonToken.swift
    - 其他省略
  - Config.swift
  - ConfigProvider.swift
  - Theme.swift

- **Utils/** - 工具类
  - Colors.swift
  - Constants.swift
  - TruncationMask.swift
  - Version.swift
  - ViewSizeReader.swift

- **Localization/** - 库级别国际化

- **Moin.swift** - 库入口文件

---

## 📖 Demo应用

### Sources/Demo/ - Demo应用
- **Examples/** - 组件示例展示
  - ExampleComponents.swift - 示例通用组件
  - Avatar/ - 头像示例 + Token配置
  - Button/ - 按钮示例 + Token配置 + API文档
  - 其他省略

- **Views/** - Demo主页面视图
  - HomeView.swift
  - QuickStartView.swift
  - ThemeView.swift

- **Locales/** - 翻译文件
  - en-US.json - 英文翻译
  - zh-CN.json - 中文翻译

- **Resources/** - 资源文件

- **Utils/** - Demo工具类

- **Components/** - Demo专用组件

- DemoApp.swift - Demo应用入口
- DemoTranslations.swift - Demo翻译管理

---

## 🧪 测试

### Tests/MoinTests/ - 单元测试
- MoinUI组件测试用例