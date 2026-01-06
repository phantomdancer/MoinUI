# MoinUI

A macOS SwiftUI component library.

[中文文档](./README.zh-CN.md)

## Installation

Add the dependency in `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/phantomdancer/moin-ui.git", from: "0.1.0")
]
```

Then reference it in your target:

```swift
.target(
    name: "YourApp",
    dependencies: ["MoinUI"]
)
```

## Documentation

This project includes a Demo app with complete documentation and usage examples.

**Option 1:** Download the pre-built Demo app from [Releases](https://github.com/phantomdancer/moin-ui/releases)

**Option 2:** Build from source:

```bash
pnpm install
pnpm dev
```

## Requirements

- macOS 13.0+
- Swift 5.9+

## License

MIT
