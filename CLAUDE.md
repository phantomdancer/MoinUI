# MoinUI Agent 指南
使用文言文回复。用最小必要语言回复，说重点，不要长篇大论。

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
- `swift build` 零警告
- `swift test` 全部通过
- Demo 示例 + 中英文翻译

### 国际化
- Demo 翻译: `Sources/Demo/Locales/`
- 使用 `tr("key")` 获取翻译

## 工作流程

1. **开始前**: 用 `list_memories` 查看记忆，`read_memory("session-progress")` 恢复进度
2. **编写代码**: 遵循命名约定和 Token 规则
3. **构建测试**: `swift build && swift test`
4. **Demo**: 添加示例和翻译
5. **记忆**: 用 `write_memory` 更新状态和记忆
6. **结束时**: 更新 session-progress，结合 `git log --oneline -10` 生成进度
7. **回复**: 完成后回复的最后一行必须为：✅ 毕。

## 设计原则

- **Token 驱动**: 所有样式通过 token 实现
- **原生适配**: 利用 SwiftUI 原生能力
- **简化优先**: 复杂功能可简化

## 竞品参考
分析开源工具时，可 clone 到 `ThirdLibs/` 目录后查看其代码。

- **Ant Design**: `ThirdLibs/ant-design/`，若无请 clone
有两个工具可用：
https://ant.design/llms.txt
https://ant.design/llms-full.txt
已经下载到：ThirdLibs/ant-design/ 目录下，如果txt 文件不存在，你需要 wget 或者curl 下载到该目录，因为文件太大了。

- **Element Plus**: https://element-plus.org
- **shadcn/ui**: https://ui.shadcn.com
