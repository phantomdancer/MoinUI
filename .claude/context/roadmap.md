# 开发路线图

> 基于依赖关系的分层实现规划

## 第一层：原子组件（无依赖）

| 组件 | 说明 | 状态 |
|------|------|------|
| Button | 按钮 | ✅ |
| Icon | 图标 | 待实现 |
| Typography | 排版(Text/Title/Paragraph) | 待实现 |
| Divider | 分割线 | 待实现 |

## 第二层：布局组件（依赖第一层）

| 组件 | 说明 | 状态 |
|------|------|------|
| Space | 间距容器 | 待实现 |
| Flex | 弹性布局 | 待实现 |
| Grid | 栅格(Row/Col) | 待实现 |

## 第三层：基础交互（依赖1-2层）

| 组件 | 说明 | 状态 |
|------|------|------|
| Input | 输入框 | 待实现 |
| Switch | 开关 | 待实现 |
| Checkbox | 复选框 | 待实现 |
| Radio | 单选框 | 待实现 |
| Slider | 滑块 | 待实现 |
| Tag | 标签 | 待实现 |
| Badge | 徽标 | 待实现 |
| Avatar | 头像 | 待实现 |
| Tooltip | 文字提示 | 待实现 |
| Spin | 加载中 | 待实现 |
| Progress | 进度条 | 待实现 |

## 第四层：复合组件（依赖1-3层）

| 组件 | 说明 | 状态 |
|------|------|------|
| Select | 选择器 | 待实现 |
| Alert | 警告提示 | 待实现 |
| Card | 卡片 | 待实现 |
| Collapse | 折叠面板 | 待实现 |
| Tabs | 标签页 | 待实现 |
| Modal | 对话框 | 待实现 |
| Drawer | 抽屉 | 待实现 |
| Message | 全局提示 | 待实现 |
| Notification | 通知 | 待实现 |
| Popover | 气泡卡片 | 待实现 |
| Dropdown | 下拉菜单 | 待实现 |

## 第五层：高级组件（依赖1-4层）

| 组件 | 说明 | 状态 |
|------|------|------|
| Form | 表单 | 待实现 |
| Table | 表格 | 待实现 |
| Menu | 导航菜单 | 待实现 |
| DatePicker | 日期选择 | 待实现 |
| Pagination | 分页 | 待实现 |

## 建议实现顺序

Space → Divider → Typography → Icon → Input → Switch → Tag → Tooltip → Select → Alert → Card → Modal → Form → Table

## Button 后续增强

- [ ] Dashed 虚线样式
- [ ] 按钮组圆角优化
- [ ] 下拉按钮

## ConfigProvider 增强

- [ ] RTL 支持
- [ ] 更多语言包
- [ ] 配置持久化
