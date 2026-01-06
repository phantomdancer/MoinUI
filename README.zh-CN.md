# MoinUI 墨影UI

macOS SwiftUI 组件库。

[English](./README.md)

## 安装

在 `Package.swift` 中添加依赖：

```swift
dependencies: [
    .package(url: "https://github.com/phantomdancer/moin-ui.git", from: "0.1.0")
]
```

然后在 target 中引用：

```swift
.target(
    name: "YourApp",
    dependencies: ["MoinUI"]
)
```

## 文档

本项目包含 Demo 应用，提供完整的文档和使用示例。

**方式一：** 从 [Releases](https://github.com/phantomdancer/moin-ui/releases) 下载预编译的 Demo 应用

**方式二：** 从源码构建运行：

```bash
pnpm install
pnpm dev
```

## 要求

- macOS 13.0+
- Swift 5.9+

## 许可证

MIT
