# 开发路线图

## Ant Design 组件分类参考

| 分类 | 组件 |
|------|------|
| 通用 | Button, Icon, Typography |
| 布局 | Divider, Flex, Grid, Layout, Space, Splitter |
| 导航 | Affix, Anchor, Breadcrumb, Dropdown, Menu, Pagination, Steps |
| 数据录入 | AutoComplete, Cascader, Checkbox, ColorPicker, DatePicker, Form, Input, InputNumber, Mentions, Radio, Rate, Select, Slider, Switch, TimePicker, Transfer, TreeSelect, Upload |
| 数据展示 | Avatar, Badge, Calendar, Card, Carousel, Collapse, Descriptions, Empty, Image, List, Masonry, Popover, QRCode, Segmented, Statistic, Table, Tabs, Tag, Timeline, Tooltip, Tour, Tree |
| 反馈 | Alert, Drawer, Message, Modal, Notification, Popconfirm, Progress, Result, Skeleton, Spin |
| 其他 | App, ConfigProvider, FloatButton, Watermark |

---

## 按复杂度排序（简单优先，无依赖优先）

### 已完成
Button ✅, Typography ✅, Divider ✅, Space ✅, Tag ✅, Badge ✅, Avatar ✅, Empty ✅, Spin ✅, Statistic ✅, Alert ✅, Progress ✅, Switch ✅, Checkbox ✅, Radio ✅, Skeleton ✅, Rate ✅, Slider ✅, Icon ⏭

### 第一梯队：极简组件（无依赖，几乎无状态）

| 组件 | 复杂度 | 说明 |
|------|--------|------|
| Tag | ★☆☆☆☆ | ✅ 已完成 |
| Badge | ★☆☆☆☆ | ✅ 已完成 |
| Avatar | ★☆☆☆☆ | ✅ 已完成 |
| Empty | ★☆☆☆☆ | ✅ 已完成 |
| Spin | ★☆☆☆☆ | ✅ 已完成 |
| Statistic | ★☆☆☆☆ | ✅ 已完成 |

### 第二梯队：简单组件（无依赖，少量状态）

| 组件 | 复杂度 | 说明 |
|------|--------|------|
| Alert | ★★☆☆☆ | ✅ 已完成 |
| Progress | ★★☆☆☆ | ✅ 已完成 (v2: percentPosition, circleSteps, strokeColors) |
| Switch | ★★☆☆☆ | ✅ 已完成 |
| Checkbox | ★★☆☆☆ | ✅ 已完成 |
| Radio | ★★☆☆☆ | ✅ 已完成 |
| Skeleton | ★★☆☆☆ | ✅ 已完成 |
| Result | ★★☆☆☆ | 结果页面 |
| Timeline | ★★☆☆☆ | 时间轴 |

### 第三梯队：中等组件（无依赖，较多状态/变体）

| 组件 | 复杂度 | 说明 |
|------|--------|------|
| Rate | ★★★☆☆ | ✅ 已完成 |
| Slider | ★★★☆☆ | ✅ 已完成 |
| Input | ★★★☆☆ | 输入框（状态多） |
| InputNumber | ★★★☆☆ | 数字输入 |
| Card | ★★★☆☆ | 卡片容器 |
| Collapse | ★★★☆☆ | 折叠面板 |
| Tabs | ★★★☆☆ | 标签页切换 |
| Segmented | ★★★☆☆ | 分段控制器 |
| Descriptions | ★★★☆☆ | 描述列表 |

### 第四梯队：弹出层组件（需处理定位/层级）

| 组件 | 复杂度 | 说明 |
|------|--------|------|
| Tooltip | ★★★☆☆ | 文字提示气泡 |
| Popover | ★★★☆☆ | 气泡卡片 |
| Modal | ★★★☆☆ | 对话框 |
| Drawer | ★★★☆☆ | 侧边抽屉 |
| Message | ★★★☆☆ | 全局消息 |
| Notification | ★★★☆☆ | 通知提醒 |
| Dropdown | ★★★☆☆ | 下拉菜单 |

### 第五梯队：组合组件（依赖前置组件）

| 组件 | 复杂度 | 依赖 |
|------|--------|------|
| Select | ★★★★☆ | Input + Popover |
| AutoComplete | ★★★★☆ | Input + Popover |
| DatePicker | ★★★★☆ | Input + Popover |
| TimePicker | ★★★★☆ | Input + Popover |
| ColorPicker | ★★★★☆ | Input + Popover |
| Popconfirm | ★★★★☆ | Popover + Button |
| Menu | ★★★★☆ | 递归结构 |

### 第六梯队：复杂组件

| 组件 | 复杂度 | 依赖 |
|------|--------|------|
| Table | ★★★★★ | 多组件 |
| Tree | ★★★★★ | Checkbox，递归 |
| List | ★★★★☆ | Avatar 等 |
| Transfer | ★★★★★ | Checkbox, Input |
| Form | ★★★★★ | 所有输入组件 |
| Calendar | ★★★★★ | DatePicker 机制 |

---

## 建议实现顺序

```
已完成: Button → Typography → Divider → Space → Tag → Badge → Avatar → Empty → Spin → Statistic → Alert → Progress → Switch → Checkbox → Radio → Skeleton ✅

### 架构重构 (2026-01-27)
- ✅ 全部组件采用 Factory 模式：`Moin.Component("title")` 直接调用
- 模式: `struct _MoinComponentFactory` + `callAsFunction` 方法
- 子组件: `Moin.Component.SubComponent(...)` (实例属性 Factory)
  - Tag.Checkable, Badge.Ribbon, Avatar.Group, Space.Compact
  - Spin.Indicator, Button.Loading, Checkbox.Group
  - Radio.Group, Radio.GroupView

#### API 设计原则（与 Ant Design 一致）
- **参数传递**: 用户通过简写枚举传参，如 `Moin.Avatar("A", size: .large, shape: .circle)`
- **不暴露 typealias**: 移除 `Moin.Component.Size` 等 typealias，避免类型污染
- **下划线约定**: `_Component` 类型保持 public（Factory 参数需要），但下划线前缀表示"不推荐直接使用"
- **@_spi 不适用**: 因 Factory 参数/返回值使用下划线类型，无法应用 SPI 隐藏

#### 内部类型访问控制
- 纯内部辅助类型改为 `private` 或 `internal`：
  - `_AvatarGroupContainer`, `_AnyShape`, `_SpinDot`, `_AvatarTextView` (private)
  - `_AvatarAsyncImage`, `_RadioButton`, `_RadioButtonPosition` (internal)
- 需要作为 Factory 参数/返回值的类型保持 `public`

下一批: Input → Card → Collapse → Tabs

再下批: Tooltip → Popover → Modal → Message

再下批: Select → DatePicker → Menu → Table
```

### 待优化 (Optimizations)

- **Avatar**:
  - [ ] accessibilityLabel (无障碍支持，对应 Ant Design 的 alt)
  - [ ] 响应式尺寸 (根据窗口大小自动调整，如 `{ compact: 24, regular: 32 }`)
  - [ ] AvatarGroup max.popover (溢出头像 Popover 展示)
  - 已排除: srcSet (Web特有)、draggable (SwiftUI不适用)、crossOrigin (不需要)

- **Button**:
  - [x] Doc: Grouped API & Token navigation (DocSidebar)

- **Tag**:
  - [x] Doc: Grouped API & Token navigation (DocSidebar)

- **Badge**:
  - [ ] 添加 Title 属性 (悬停显示完整数值)
  - [ ] 添加缩放进出动画
  - [ ] 考虑实现数字滚动效果

- **Statistic**:
  - 已排除: Timer 组件 (SwiftUI 原生支持)、formatter (View 类型已覆盖)、分隔符 (NumberFormatter 处理)

- **Localization**:
  - [x] Refactor JSON structure (separate component/common keys)

- **Rate**:
  - [ ] tooltips prop (需 Tooltip 组件支持)

- **Slider**:
  - [ ] 带输入框的滑块 (需 Input 组件支持)
  - [ ] 自定义提示 tooltip (需 Tooltip 组件支持)