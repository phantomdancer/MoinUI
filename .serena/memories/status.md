# 项目状态

## 当前任务

待实现 Typography 组件

## 最近完成

- 2026-01-11: Token 系统完整对齐 Ant Design（SeedToken 28属性, MapToken 90+, ButtonToken 41）
- 2026-01-10: Divider 组件（水平/垂直、实线/虚线/点线、带文字、演练场）
- 2026-01-10: Space 组件（间距布局，支持 size/direction/alignment/wrap）
- 2026-01-10: 色彩系统重构（HSV 色板生成算法，语义色 hover/active 使用色阶）
- 2026-01-10: Colors 示例分章节（语义色、预设色、色板级别、动态生成）
- 2026-01-09: 代码简化、组件分层规划
- 2026-01-08: ButtonToken 完整实现、fontColor 参数、type→color+variant 统一

## Token 系统架构

```
SeedToken (28) → MapToken (90+) → Token (别名) → ComponentToken
```

### SeedToken 分类
- 品牌色 (6): colorPrimary/Success/Warning/Error/Info/Link
- 派生基础色 (2): colorTextBase, colorBgBase
- 字体 (4): fontSize, lineHeight, fontFamily, fontFamilyCode
- 线条 (2): lineWidth, lineType
- 圆角 (1): borderRadius
- 尺寸 (3): sizeUnit, sizeStep, controlHeight
- 间距 (2): padding, margin
- 层级 (2): zIndexBase, zIndexPopupBase
- 动画 (4): motion, motionUnit, motionDuration, motionEase
- 其他 (2): opacityImage, wireframe

## 待处理

- Typography 组件