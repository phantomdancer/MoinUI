# SwiftUI macOS Hover Cursor 解决方案

## 问题描述

在 SwiftUI macOS 中，当按钮或其他可交互视图放在 `LazyVStack`/`LazyHStack` 中时，`onHover` 和 cursor 效果会不稳定或完全失效。

### 症状

- 鼠标 cursor pointer 样式时有时无
- 在边界 hover 会闪一下
- 滚动后下面的按钮没有 hover 效果
- 效果不稳定

### 根本原因

1. **LazyStack 视图回收机制**：LazyVStack 会销毁滚出可见区域的视图，`@State` 变量被重置
2. **onHover 的 bug**：SwiftUI 的 `onHover` 在快速移动鼠标时可能不触发 `mouseExited`
3. **push/pop stack 不匹配**：视图回收时 `NSCursor.push()/pop()` 的调用不平衡

## 解决方案

### 关键改动

使用 `onContinuousHover` 替代 `onHover`，使用 `cursor.set()` 替代 `push()/pop()`：

```swift
.onContinuousHover { phase in
    switch phase {
    case .active:
        if !isHovered {
            withAnimation(stateAnimation) {
                isHovered = true
            }
        }
        let cursor: NSCursor = effectiveDisabled ? .operationNotAllowed : .pointingHand
        cursor.set()
    case .ended:
        if isHovered {
            withAnimation(stateAnimation) {
                isHovered = false
                isPressed = false
            }
        }
        NSCursor.arrow.set()
    }
}
```

### 为什么有效

1. **`onContinuousHover`** (macOS 13+) 比 `onHover` 更可靠，持续追踪 hover 状态
2. **`cursor.set()`** 直接设置当前 cursor，不依赖 stack 平衡，避免 LazyStack 回收视图时的 stack 不匹配问题

### 不需要的修复

以下方案经测试**无效**或**不必要**：

- ❌ `NSTrackingArea` + `NSViewRepresentable`
- ❌ `NSEvent.addLocalMonitorForEvents` 全局监听
- ❌ `.background(Color.white.opacity(0.001))` 透明背景修复
- ❌ `NSCursor.push()/pop()` 配合 guard 检查

## 适用范围

- **系统要求**：macOS 13.0+
- **场景**：任何在 `LazyVStack`/`LazyHStack`/`LazyVGrid` 中需要 hover cursor 效果的视图

## 参考资料

- [Apple FB11988707 - onHover 透明背景 bug](https://mjtsai.com/blog/2023/02/06/tracking-hover-location-in-swiftui/)
- [GitHub Gist - Cursor on View](https://gist.github.com/Amzd/cb8ba40625aeb6a015101d357acaad88)
- [Reliable SwiftUI mouse hover](https://gist.github.com/importRyan/c668904b0c5442b80b6f38a980595031)
