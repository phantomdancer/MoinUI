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
│   │   └── Button/
│   │       ├── MoinUIButton.swift
│   │       ├── MoinUIButtonType.swift
│   │       ├── MoinUIButtonSize.swift
│   │       └── MoinUIButtonVariant.swift
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
- **示例**: Demo 中有完整示例

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

1. 编写代码
2. `swift build` 确保无警告
3. `swift test` 确保测试通过
4. Demo 中添加示例
5. 添加中英文翻译
6. 完成后回复"毕。"

## 国际化

- 默认中文，支持英文切换
- 组件翻译: `Sources/MoinUI/Locales/`
- Demo翻译: `Sources/Demo/Locales/`
- 使用 `localization.tr("key")` 获取翻译

## Skills（斜杠命令）

- `/new-component` - 创建新组件模板和规范
- `/compare-competitors` - 竞品功能对比表

## 竞品参考

- [Ant Design](https://ant.design)
- [Element Plus](https://element-plus.org)
- [shadcn/ui](https://ui.shadcn.com)

使用 context7 工具查询竞品文档。
