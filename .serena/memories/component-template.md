# 新组件开发模板

## 目录结构

```
Sources/MoinUI/Components/{Name}/
├── {Name}.swift
├── {Name}Type.swift (可选)
└── {Name}Size.swift (可选)
```

## 主组件

```swift
public extension Moin {
    struct {Name}: View {
        @Environment(\.moinToken) private var token
        
        public init(...) { }
        public var body: some View { }
    }
}
```

## 检查清单

- [ ] 主组件实现
- [ ] 使用 Token 和 Constants
- [ ] 支持浅色/深色主题
- [ ] 单元测试
- [ ] Demo 示例 + 中英文翻译
- [ ] 导航注册
- [ ] `swift build` 无警告
- [ ] `swift test` 通过