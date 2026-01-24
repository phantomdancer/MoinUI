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
Button ✅, Typography ✅, Divider ✅, Space ✅, Tag ✅, Badge ✅, Avatar ✅, Empty ✅, Spin ✅, Statistic ✅, Alert ✅, Progress ✅, Switch ✅, Checkbox ✅, Icon ⏭

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
| Radio | ★★☆☆☆ | 单选框 |
| Skeleton | ★★☆☆☆ | 骨架屏占位 |
| Result | ★★☆☆☆ | 结果页面 |
| Timeline | ★★☆☆☆ | 时间轴 |

### 第三梯队：中等组件（无依赖，较多状态/变体）

| 组件 | 复杂度 | 说明 |
|------|--------|------|
| Rate | ★★★☆☆ | 评分（交互稍复杂） |
| Slider | ★★★☆☆ | 滑动条 |
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
已完成: Button → Typography → Divider → Space → Tag → Badge → Avatar → Empty → Spin → Statistic → Alert → Progress → Switch → Checkbox

下一批: Radio


再下批: Radio

再下批: Rate → Slider → Input → Card → Collapse → Tabs

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