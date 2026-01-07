# 竞品功能对比

与竞品（Ant Design、Element Plus、shadcn/ui）进行功能对比。

## 对比表格模板

| 功能 | Ant Design | Element Plus | shadcn/ui | MoinUI |
|------|------------|--------------|-----------|--------|
| **类型** |
| Primary | ✅ | ✅ | ✅ | ✅ |
| Default | ✅ | ✅ | ✅ | ✅ |
| Danger | ✅ | ✅ | ✅ | ✅ |
| Success | ❌ | ✅ | ❌ | ✅ |
| Warning | ❌ | ✅ | ❌ | ✅ |
| Info | ❌ | ✅ | ❌ | ✅ |
| **变体** |
| Solid | ✅ | ✅ | ✅ | ✅ |
| Outline | ✅ | ✅ | ✅ | ✅ |
| Text | ✅ | ✅ | ✅ | ✅ |
| Ghost | ✅ | ❌ | ✅ | ✅ |
| **尺寸** |
| Small | ✅ | ✅ | ✅ | ✅ |
| Medium | ✅ | ✅ | ✅ | ✅ |
| Large | ✅ | ✅ | ✅ | ✅ |
| **状态** |
| Disabled | ✅ | ✅ | ✅ | ✅ |
| Loading | ✅ | ✅ | ❌ | ✅ |

## 使用方式

分析新组件时：

1. 查阅竞品文档：
   - https://ant.design/components/
   - https://element-plus.org/zh-CN/component/
   - https://ui.shadcn.com/docs/components/

2. 提取核心功能点
3. 填写对比表格
4. 确定 MoinUI 实现范围

## 设计原则

- **跟随主流**：Ant Design 和 Element Plus 都有的功能优先实现
- **取长补短**：Element Plus 有而 Ant Design 没有的语义色（success/warning/info）保留
- **简化优先**：shadcn 没有的复杂功能可酌情简化或跳过
- **原生适配**：利用 SwiftUI 原生能力，不生搬 Web 概念

## 已完成组件

### Button

| 功能 | 状态 |
|------|------|
| Type (default/primary/success/warning/danger/info) | ✅ |
| Variant (solid/outline/text/link/ghost) | ✅ |
| Size (small/medium/large) | ✅ |
| Shape (default/round/circle) | ✅ |
| Icon + Text | ✅ |
| Icon Position | ✅ |
| Loading | ✅ |
| Disabled | ✅ |
| Block | ✅ |
| href Link | ✅ |
| ButtonGroup | ✅ |

### ConfigProvider

| 功能 | 状态 |
|------|------|
| Theme (light/dark/system) | ✅ |
| Token System | ✅ |
| Runtime Modify | ✅ |

### Localization

| 功能 | 状态 |
|------|------|
| 中文/英文 | ✅ |
| 自定义翻译 | ✅ |
| JSON 格式 | ✅ |

## 待开发组件

| 组件 | 优先级 | 竞品参考 |
|------|--------|----------|
| Input | 高 | antd/el |
| Select | 高 | antd/el |
| Checkbox | 高 | antd/el |
| Radio | 高 | antd/el |
| Switch | 中 | antd/el |
| Slider | 中 | antd/el |
| DatePicker | 中 | antd/el |
| Modal | 中 | antd/el |
| Message | 中 | antd/el |
| Table | 低 | antd/el |
