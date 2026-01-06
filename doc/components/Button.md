# Button 按钮

## 设计指南

按钮用于触发一个操作或事件，如提交表单、打开对话框、取消操作等。

### 设计原则

1. **主次分明**：一个页面中主要操作按钮应突出显示，次要操作使用默认或文本按钮
2. **位置一致**：按钮应放置在用户期望的位置，通常在表单底部或卡片右下角
3. **反馈及时**：点击后应有视觉反馈（hover、active、loading 状态）
4. **语义清晰**：使用颜色区分操作类型（成功、警告、危险等）

### 使用场景

| 类型 | 使用场景 |
|------|----------|
| Primary | 主要操作，每个区域最多一个 |
| Default | 次要操作，无特殊语义 |
| Danger | 危险操作，如删除、授权 |
| Success | 成功/确认操作 |
| Warning | 警告操作 |
| Link | 外部链接跳转 |

---

## 竞品对比

| 功能 | Ant Design | Element Plus | shadcn/ui | MoinUI |
|------|------------|--------------|-----------|--------|
| **类型 (Type)** |
| Primary | ✅ | ✅ | ✅ | ✅ |
| Default | ✅ | ✅ | ✅ | ✅ |
| Dashed | ✅ | ❌ | ❌ | ❌ |
| Text | ✅ | ✅ | ✅ | ✅ |
| Link | ✅ | ✅ | ✅ | ✅ |
| **语义色** |
| Danger | ✅ | ✅ | ✅ | ✅ |
| Success | ❌ | ✅ | ❌ | ✅ |
| Warning | ❌ | ✅ | ❌ | ✅ |
| Info | ❌ | ✅ | ❌ | ✅ |
| **变体 (Variant)** |
| Solid/Filled | ✅ | ✅ | ✅ | ✅ |
| Outline | ✅ | ✅ | ✅ | ✅ |
| Ghost | ✅ | ❌ | ✅ | ✅ |
| **尺寸 (Size)** |
| Small | ✅ | ✅ | ✅ | ✅ |
| Medium/Default | ✅ | ✅ | ✅ | ✅ |
| Large | ✅ | ✅ | ✅ | ✅ |
| **形状 (Shape)** |
| Default (圆角) | ✅ | ✅ | ✅ | ✅ |
| Round (胶囊) | ✅ | ✅ | ❌ | ✅ |
| Circle (圆形) | ✅ | ✅ | ❌ | ✅ |
| **状态** |
| Disabled | ✅ | ✅ | ✅ | ✅ |
| Loading | ✅ | ✅ | ❌ | ✅ |
| **功能** |
| 图标按钮 | ✅ | ✅ | ✅ | ✅ |
| 图标+文字 | ✅ | ✅ | ✅ | ✅ |
| 图标位置 | ✅ | ❌ | ❌ | ✅ |
| Block (占满宽度) | ✅ | ❌ | ❌ | ✅ |
| href 链接 | ✅ | ✅ | ❌ | ✅ |
| 按钮组 | ✅ | ✅ | ❌ | ✅ |

---

## MoinUI 实现方案

### API 设计

```swift
MoinUIButton(
    _ title: String,                           // 按钮文字
    type: MoinUIButtonType = .default,         // 类型
    size: MoinUIButtonSize = .medium,          // 尺寸
    variant: MoinUIButtonVariant = .solid,     // 变体
    shape: MoinUIButtonShape = .default,       // 形状
    icon: String? = nil,                       // 图标 (SF Symbols)
    iconPosition: MoinUIButtonIconPosition = .leading,  // 图标位置
    isLoading: Bool = false,                   // 加载状态
    isDisabled: Bool = false,                  // 禁用状态
    isBlock: Bool = false,                     // 占满宽度
    href: URL? = nil,                          // 链接地址
    action: (() -> Void)? = nil                // 点击回调
)
```

### 枚举定义

```swift
// 按钮类型
public enum MoinUIButtonType {
    case `default`  // 默认灰色
    case primary    // 主要蓝色
    case success    // 成功绿色
    case warning    // 警告橙色
    case danger     // 危险红色
    case info       // 信息灰色
}

// 按钮变体
public enum MoinUIButtonVariant {
    case solid      // 实心填充
    case outline    // 边框
    case text       // 纯文本
    case link       // 链接样式
    case ghost      // 幽灵按钮
}

// 按钮尺寸
public enum MoinUIButtonSize {
    case small
    case medium
    case large
}

// 按钮形状
public enum MoinUIButtonShape {
    case `default`  // 圆角矩形
    case round      // 胶囊形
    case circle     // 圆形
}

// 图标位置
public enum MoinUIButtonIconPosition {
    case leading    // 左侧
    case trailing   // 右侧
}
```

### 主题集成

- 使用 Token 系统管理颜色、尺寸、圆角等样式
- 支持浅色/深色主题自动切换
- 支持自定义 Token 覆盖默认样式

### 使用示例

```swift
// 基础按钮
MoinUIButton("按钮") {}

// 主要按钮
MoinUIButton("提交", type: .primary) {}

// 图标+文字
MoinUIButton("搜索", type: .primary, icon: "magnifyingglass") {}

// 图标在右侧
MoinUIButton("下一步", icon: "arrow.right", iconPosition: .trailing) {}

// 链接按钮
MoinUIButton("GitHub", type: .primary, icon: "link", href: URL(string: "https://github.com"))

// 按钮组
MoinUIButtonGroup {
    MoinUIButton(icon: "chevron.left", type: .primary, shape: .default) {}
    MoinUIButton(icon: "chevron.right", type: .primary, shape: .default) {}
}
```

---

## 后续规划

- [ ] Dashed 虚线按钮样式
- [ ] 按钮组圆角优化（首尾按钮单侧圆角）
- [ ] 下拉按钮 (Dropdown Button)
- [ ] 按钮波纹动效
