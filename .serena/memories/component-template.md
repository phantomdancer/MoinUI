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

每个组件 Demo **必须**包含四个 Tab：
1. **示例 (Examples)** - 各场景用法示例
2. **演练场 (Playground)** - 实时调整属性预览
3. **API** - 属性表
4. **Token** - 组件 Token 文档（组件 token/全局 token）
5. **TokenPlauyground** Token 页面的Plauyground页面中，在右侧要添加该按钮的导致，且图标一致。需要实现所有token的实时预览和修改

### Demo 文件结构

```
Sources/Demo/Examples/{Name}/
├── {Name}Examples.swift      # 主页面 + Tab 切换
├── {Name}Playground.swift    # 演练场
├── {Name}APIContent.swift    # API 文档
├── {Name}TokenSection.swift  # Token 文档
```

### 翻译文件结构

```
Sources/Demo/Locales/{Name}/
├── zh-CN.json
├── en-US.json
```

**规则**: 只要左侧导航有独立入口的，翻译文件放自己目录；根目录只放共享翻译。
注意：所有代码中的以及示例 code 中的都需要国际化，不能硬编码字符串。

### Tab 枚举

```swift
enum {Name}ExamplesTab: String, CaseIterable {
    case examples
    case playground
    case api
    case token
}
```

### 参考实现

Typography 组件为完整参考：`Sources/Demo/Examples/Typography/`

## 国际化要求

**全部需要国际化**，包括：
- 示例内容和描述
- **code 代码块中的示例文本**（使用 `\(tr("key"))` 插值）
- API 表格
- Token 表格
- Playground 所有标签和预览文本

## 检查清单

- [ ] 主组件实现
- [ ] 使用 Token 和 Constants
- [ ] 支持浅色/深色主题
- [ ] Demo 四个 Tab（示例、演练场、API、Token）
- [ ] **完整国际化**（含 code 块）
- [ ] 翻译文件放组件目录
- [ ] 导航注册（含 Tab 切换）
- [ ] TokenPlayground添加Token预览
- [ ] `swift build` 无警告
- [ ] `swift test` 通过