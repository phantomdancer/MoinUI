# MoinUI 文档

> 现代化的 macOS SwiftUI 组件库

## 目录结构

```
doc/
├── README.md                    # 本文件
└── components/                  # 组件文档
    ├── Button.md               # 按钮
    ├── ConfigProvider.md       # 全局配置
    ├── Localization.md         # 国际化
    └── Theme.md                # 主题
```

## 组件文档

### 通用

| 组件 | 说明 | 状态 |
|------|------|------|
| [Button](components/Button.md) | 按钮，触发操作或事件 | ✅ 已完成 |

### 配置

| 组件 | 说明 | 状态 |
|------|------|------|
| [ConfigProvider](components/ConfigProvider.md) | 全局配置，主题/语言/Token | ✅ 已完成 |
| [Theme](components/Theme.md) | 主题系统，浅色/深色/跟随系统 | ✅ 已完成 |
| [Localization](components/Localization.md) | 国际化，多语言支持 | ✅ 已完成 |

## 快速开始

### 安装

```swift
// Package.swift
dependencies: [
    .package(url: "https://github.com/anthropics/moin-ui.git", from: "1.0.0")
]
```

### 基本用法

```swift
import SwiftUI
import MoinUI

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .moinUIThemeRoot()  // 启用全局主题
        }
    }
}

struct ContentView: View {
    var body: some View {
        MoinUIButton("点击我", type: .primary) {
            print("clicked")
        }
    }
}
```

## 文档规范

每个组件文档包含：

1. **设计指南** - 设计原则、使用场景
2. **竞品对比** - 与 Ant Design / Element Plus / shadcn 功能对比
3. **实现方案** - API 设计、代码示例
4. **后续规划** - 待实现功能

## 开发计划

### 待开发组件

| 组件 | 优先级 | 说明 |
|------|--------|------|
| Input | 高 | 输入框 |
| Select | 高 | 选择器 |
| Checkbox | 高 | 复选框 |
| Radio | 高 | 单选框 |
| Switch | 中 | 开关 |
| Slider | 中 | 滑块 |
| DatePicker | 中 | 日期选择 |
| Modal | 中 | 对话框 |
| Message | 中 | 消息提示 |
| Table | 低 | 表格 |
| Tree | 低 | 树形控件 |

## 相关链接

- [GitHub](https://github.com/anthropics/moin-ui)
- [Ant Design](https://ant.design)
- [Element Plus](https://element-plus.org)
- [shadcn/ui](https://ui.shadcn.com)
