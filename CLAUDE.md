使用文言文回复。用最小必要语言回复，说重点，不要长篇大论。

## 项目概述

MoinUI（墨影UI）- macOS SwiftUI 组件库。

- **平台**: macOS only
- **语言**: Swift / SwiftUI
- **结构**: Swift Package

风格参考：shadcn、Element Plus
功能参考：Ant Design、Element Plus

## 命令

```bash
yarn dev          # 启动开发（推荐）
swift build       # 构建
swift test        # 测试
swift package clean && swift build  # 清理重建
```

## 项目结构

```
Sources/
├── MoinUI/                    # 组件库
│   ├── Components/            # 组件（Button、Input...）
│   ├── Config/                # 配置（Theme、ConfigProvider）
│   ├── Localization/          # 国际化
│   ├── Locales/               # 翻译文件 (JSON)
│   └── Utils/                 # 工具（Constants）
└── Demo/                      # 示例应用
    ├── Examples/              # 组件示例页
    ├── Views/                 # 页面
    └── Locales/               # Demo翻译

Tests/MoinUITests/             # 测试
```

## 编码规范

### 必须遵守

- **组件命名**: 以 `MoinUI` 开头（MoinUIButton、MoinUIInput）
- **常量**: 使用 `Constants.swift`，禁止硬编码魔法数字
- **Token**: 使用 `config.token` 获取样式，禁止硬编码颜色
- **编译**: 每次修改后 `swift build`，零警告
- **测试**: 完整测试，高覆盖率
- **示例**: Demo 中有完整示例，代码字符串用 `\(localization.tr(...))` 插值

### 代码风格

- 简洁复用，避免冗余
- 合理拆分文件，单文件不宜过长
- 不实现 #Preview
- 保留有意义的注释

### Token 使用

```swift
// ✅ 正确
.foregroundStyle(token.colorPrimary)
.background(token.colorBgContainer)

// ❌ 错误
.foregroundStyle(Color.blue)
.background(Color.white)
```

### Constants 使用

```swift
Constants.Spacing.sm   // 8
Constants.Spacing.md   // 12
Constants.Radius.md    // 6
Constants.Size.controlHeight  // 32
```

## 工作流程

1. **开始前**：读取 `.claude/context/` 了解当前状态
2. 编写代码
3. `swift build` 确保无警告
4. `swift test` 确保测试通过
5. Demo 中添加示例
6. 添加中英文翻译
7. **完成后**：更新 `.claude/context/` 相关文件
8. 回复"毕。"

## 项目上下文（重要）

`.claude/context/` 目录记录项目持续状态，**每次任务开始时读取，完成后更新**：

| 文件 | 用途 |
|------|------|
| `status.md` | 当前任务、最近完成、待处理 |
| `components.md` | 已完成组件清单及功能 |
| `roadmap.md` | 待开发组件规划 |
| `component-template.md` | 新组件开发模板 |

## 国际化

- 默认中文，支持英文切换
- 组件翻译: `Sources/MoinUI/Locales/`
- Demo翻译: `Sources/Demo/Locales/`
- 使用 `localization.tr("key")` 获取翻译

## 竞品参考

| 竞品 | 链接 |
|------|------|
| Ant Design | 源码已上下载到本地 ThirdLibs/ant-design 目录 |
| Element Plus | https://element-plus.org |
| shadcn/ui | https://ui.shadcn.com |

### 设计原则

- **跟随主流**：antd 和 el 都有的功能优先实现
- **取长补短**：el 有而 antd 没有的语义色保留
- **简化优先**：shadcn 没有的复杂功能可简化
- **原生适配**：利用 SwiftUI 原生能力

使用 context7 工具查询竞品文档。
