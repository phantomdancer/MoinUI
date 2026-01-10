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

## Demo 页面结构（必须）

每个组件 Demo **必须**包含三个 Tab：
1. **示例 (Examples)** - 各场景用法示例
2. **演练场 (Playground)** - 实时调整属性预览
3. **API** - 属性表 + 组件 Token + 全局 Token

### Demo 文件结构

```
Sources/Demo/Examples/{Name}/
├── {Name}Examples.swift     # 主页面 + Tab 切换
├── {Name}Playground.swift   # 演练场
├── {Name}APIContent.swift   # API 文档
```

### Tab 枚举

```swift
enum {Name}ExamplesTab: String, CaseIterable {
    case examples
    case playground
    case api
}
```

### 参考实现

Button 组件为完整参考：`Sources/Demo/Examples/Button/`

## 检查清单

- [ ] 主组件实现
- [ ] 使用 Token 和 Constants
- [ ] 支持浅色/深色主题
- [ ] Demo 三个 Tab（示例、演练场、API）
- [ ] 中英文翻译
- [ ] 导航注册（含 Tab 切换）
- [ ] `swift build` 无警告
- [ ] `swift test` 通过