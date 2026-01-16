# Spin 组件实施计划

## 参照 Ant Design 5.x 源码

---

## 一、属性列表 (Props)

| 属性 | 类型 | 默认值 | 说明 | SwiftUI适配 |
|------|------|--------|------|-------------|
| spinning | Bool | true | 是否旋转 | ✅ |
| size | SpinSize | .default | 尺寸: small/default/large | ✅ |
| tip | String? | nil | 嵌套模式下的提示文案 | ✅ |
| delay | Int? | nil | 延迟显示(ms)，防闪烁 | ✅ |
| indicator | View? | nil | 自定义加载图标 | ✅ |
| fullscreen | Bool | false | 全屏遮罩模式 | ✅ |
| percent | Double? | nil | 进度百分比(0-100) | ⏳ 后续 |
| children | View? | nil | 嵌套内容 | ✅ ViewBuilder |

### 排除项
- `prefixCls`, `className`, `style` → SwiftUI不需要
- `wrapperClassName` → SwiftUI不需要

---

## 二、Token 设计

```swift
struct SpinToken {
    // 尺寸
    var dotSize: CGFloat        // 默认加载图标尺寸 (20)
    var dotSizeSM: CGFloat      // 小尺寸 (14)
    var dotSizeLG: CGFloat      // 大尺寸 (32)
    
    // 颜色
    var dotColor: Color         // 加载点颜色 (colorPrimary)
    var tipColor: Color         // 提示文字颜色 (colorTextDescription)
    var maskBackground: Color   // 全屏遮罩背景 (colorBgMask)
    
    // 内容
    var contentHeight: CGFloat  // 嵌套模式最大高度 (400)
    
    // 动画
    var motionDuration: Double  // 动画时长
}
```

---

## 三、功能列表

### 核心功能
1. **基础旋转** - 默认四点旋转动画
2. **三种尺寸** - small / default / large
3. **加载提示** - tip 文案显示
4. **延迟加载** - delay 防止闪烁
5. **自定义图标** - indicator 自定义

### 嵌套模式
6. **嵌套内容** - 包裹子视图
7. **模糊效果** - spinning 时内容变模糊
8. **遮罩层** - 半透明遮罩

### 全屏模式
9. **全屏遮罩** - fullscreen 模式
10. **居中显示** - 加载图标居中

### 后续扩展
- [ ] percent 进度显示
- [ ] 数字滚动动画

---

## 四、文件结构

```
Sources/MoinUI/
├── Components/
│   └── Spin/
│       ├── Spin.swift              # 主组件
│       ├── SpinIndicator.swift     # 加载指示器(四点动画)
│       ├── SpinSize.swift          # 尺寸枚举
│       └── SpinExamples.swift      # 示例
├── Config/
│   └── Tokens/
│       └── SpinToken.swift         # Token定义
```

---

## 五、实施步骤

### Phase 1: 基础结构 ✅
1. [x] 创建 `SpinToken.swift`
2. [x] 创建 `SpinSize.swift` 枚举
3. [x] 创建 `SpinIndicator.swift` 四点动画

### Phase 2: 主组件 ✅
4. [x] 创建 `Spin.swift` 基础组件
5. [x] 实现 spinning 控制
6. [x] 实现 size 适配
7. [x] 实现 tip 显示

### Phase 3: 高级功能 ✅
8. [x] 实现 delay 延迟加载
9. [x] 实现 indicator 自定义
10. [x] 实现嵌套模式 (ViewBuilder)
11. [x] 实现 fullscreen 模式

### Phase 4: 收尾 ✅
12. [x] 创建示例 `SpinExamples.swift`
13. [x] Token Playground 面板
14. [x] 更新 roadmap

---

## 实施完成 ✅

完成时间: 2026-01-16

### 创建文件
- `Sources/MoinUI/Components/Spin/Spin.swift`
- `Sources/MoinUI/Components/Spin/SpinIndicator.swift`
- `Sources/MoinUI/Components/Spin/SpinSize.swift`
- `Sources/MoinUI/Components/Spin/SpinExamples.swift`
- `Sources/MoinUI/Config/Tokens/SpinToken.swift`
- `Sources/Demo/Examples/Token/Panels/TokenSpinPanel.swift`

### 更新文件
- `ComponentToken.swift` - 添加 spin
- `ConfigProvider.swift` - 添加 spin
- `TokenPlayground+Enums.swift` - 添加 .spin
- `TokenPlayground.swift` - 添加 Spin 面板
- `TokenPlaygroundCodeView.swift` - 添加 spin case
- `DemoIcons.swift` - 添加 spin 图标
- `zh-CN.json` / `en-US.json` - 添加 spin 翻译

---

## 六、动画设计

### 默认四点动画 (Ant Design 风格)
- 4个圆点，呈45°旋转排列
- 整体旋转动画 1.2s/圈
- 各点透明度交替变化 (0.3 → 1.0)

```
    ●
  ●   ●
    ●
```

### SwiftUI 实现思路
- `RotationEffect` 整体旋转
- 各点用 `opacity` 动画交替闪烁
- `withAnimation(.linear.repeatForever)`

---

## 七、参考

- Ant Design Spin: https://ant.design/components/spin
- 源码: components/spin/index.tsx, style/index.ts
