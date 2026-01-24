# 新组件开发模板

## 目录结构

```
Sources/MoinUI/Components/{Name}/
├── {Name}.swift
├── {Name}Type.swift (可选)
└── {Name}Size.swift (可选)
```

## 主组件实现规范

```swift
public extension Moin {
    struct {Name}: View {
        @Environment(\.moinToken) private var token
        @Environment(\.isEnabled) private var isEnabled // 系统禁用状态
        
        // 如果需要控制鼠标指针 (Cursor)，需自行处理禁用状态
        // var isDisabled: Bool 
        
        public init(...) { }
        
        public var body: some View {
            // ... implementation
            .onContinuousHover { phase in
                // 使用 onContinuousHover 处理光标
                // 交互状态 (Clickable): .pointingHand
                // 禁用状态 (Disabled): .operationNotAllowed
            }
        }
    }
}
```

## Demo 页面结构（必须）

每个组件 Demo **必须**包含三个 Tab - 3个 tab 都必须与ThirdLibs/ant-design目录中源码的完全一致：
1. **示例 (Examples)** - 各场景用法示例，覆盖所有属性
2. **API** - 属性表及交互式演示
3. **Token** - 组件 Token 文档及实时调试

### Demo 文件结构

```
Sources/Demo/Examples/{Name}/
├── {Name}Examples.swift      # 主页面 (Examples Tab)
├── {Name}APIView.swift       # API 文档 (API Tab)
├── {Name}TokenView.swift     # Token 文档 (Token Tab)
```

### 翻译文件结构

```
Sources/Demo/Locales/{Name}/
├── zh-CN.json
├── en-US.json
```

**规则**: 只要左侧导航有独立入口的，翻译文件放自己目录；根目录只放共享翻译。
注意：所有代码中的以及示例 code 中的都需要国际化，不能硬编码字符串。

---

## 详细实现细则 (Critical)

### 1. Token View (`{Name}TokenView.swift`)

Token 页面必须支持**实时预览**和**修改生效**。

*   **交互式组件封装**: 在文件底部定义 `private struct Interactive{Name}: View`。
    *   必须包含 `@State` 以支持内部状态切换（如 Switch 的开关）。
    *   **必须**支持文本/内容参数（如 `checkedText`, `uncheckedText`），以确保背景色、边距等 Token 的变化肉眼可见。不可仅展示空组件。
*   **强制刷新**: 在 `TokenCard` 的预览视图中，必须对组件应用 `.id(token.propertyName)` 或 `.id(config.components.{name}.propertyName)`。
    *   原因：SwiftUI 的环境变量有时不会深层触发重绘，或是 Color 类型的值传递问题。使用 `.id()` 强制 View 身份变更以触发重绘。
*   **Token 更新逻辑**:
    *   对于 **Token 覆盖 (Override)**（如 `config.token.colorTextQuaternary`），在 `set` 闭包中，**不要**调用 `config.regenerateTokens()`（因为这会重置所有 Token，导致刚才的修改丢失）。
    *   应调用 `config.components = ComponentToken.generate(from: config.token, isDark: config.isDarkMode)`。只重新生成组件 Token，保留当前的 Seed/Token 修改。
*   **代码示例**: `code` 闭包中必须显示当前**实时值**，禁止硬编码或省略号。
    *   正确: `"config.components.switch.handleBg = \(config.components.switch.handleBg)"`

### 2. API View (`{Name}APIView.swift`)

*   **一致性**: `PropertyCard` 中的 `code` 文本必须与闭包中实际运行的代码**完全一致**。
*   **交互性**: 示例必须是活的。使用 `@State` 变量绑定到组件，让用户可以真正点击/交互。
    *   例如：`Moin.Switch(isOn: $isOn)` 而不是 `.constant(true)`。

### 3. 组件内部 (`{Name}.swift`)

*   **Cursor 处理**: 
    *   **可点击组件**: 必须在 Hover 时显示手型光标 (`.pointingHand`)。
    *   **禁用状态**: 若需支持 `operationNotAllowed` 光标，不能直接使用 `.disabled(true)`（会禁用所有交互含 Hover）。应添加 `isDisabled` 参数，自行处理交互逻辑。
    *   实现方式：`.onContinuousHover` + `NSCursor`。
*   **Token 消费**: 确保组件内部消费了正确的 Token。
    *   `SwitchToken.resolve` 中应使用传入的 `token` 参数（如 `token.colorTextQuaternary`），而非硬编码颜色值。

### 4. 优化与细节 (Optimizations)

*   **内部组件优先**: 在 Demo、API 示例和 Token 预览中，凡涉及基础元素（如按钮、图标、分割线等），**优先使用 MoinUI 已实现的组件**（如 `Moin.Button`, `Moin.Divider`），而非 SwiftUI 原生组件。这能确保风格统一并测试组件间的协同工作。
*   **无障碍 (A11y)**: 虽未强制，但应考虑基本的 label 和 hint。
*   **布局与响应**: 组件应适应不同尺寸 (Size) 和紧凑环境 (Compact Context)。
*   **动画**: 使用 Token 定义的动画参数 (`motionDuration`, `motionEase`)。

## 检查清单

- [ ] **交互体验**: 可点击状态显示 `.pointingHand`，禁用状态显示 `.operationNotAllowed`。
- [ ] **主组件**: 实现 `isDisabled` (如需) 和 `onContinuousHover` 光标逻辑。
- [ ] **Token View**: 使用 `Interactive{Name}` 封装，带演示文本，确保样式变化可见。
- [ ] **Token View**: 使用 `.id()` 强制刷新 Token 预览。
- [ ] **Token View**: 修改 Global Token 时仅重新生成 Components (`ComponentToken.generate`)。
- [ ] **Token View**: `code` 展示实时数值，无硬编码。
- [ ] **API View**: 示例使用 `@State`，`code` 与预览代码一致且可交互。
- [ ] **国际化**: 全面覆盖，包括 `code` 块中的字符串。
- [ ] **构建测试**: `swift build` 无警告，`swift test` 通过。
- [ ] **一致性**: 对比 Ant Design 源码，确保 API 和 Token 命名/行为一致。