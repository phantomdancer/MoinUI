import SwiftUI

// MARK: - Timeline Mode

/// Timeline 显示模式
public enum _TimelineMode: String, CaseIterable {
    /// 内容在轴线右侧 (默认)
    case start
    /// 内容在轴线左侧
    case end
    /// 内容交替显示
    case alternate
}

/// Timeline 节点位置
public enum _TimelineItemPosition: String {
    case start
    case end
}

/// Timeline 预设颜色
public enum _TimelineColor {
    case blue
    case red
    case green
    case gray
    case custom(Color)

    func resolve(token: Moin.Token) -> Color {
        switch self {
        case .blue: return token.colorPrimary
        case .red: return token.colorDanger
        case .green: return token.colorSuccess
        case .gray: return token.colorTextDisabled
        case let .custom(color): return color
        }
    }
}

// MARK: - Timeline Item

public struct _TimelineItem<Content: View, Label: View, Dot: View>: View {
    @Environment(\.moinToken) private var token
    @Environment(\.moinTimelineToken) private var timelineToken
    @Environment(\.timelineMode) private var mode
    @Environment(\.timelineItemIndex) private var index
    @Environment(\.timelineItemCount) private var itemCount
    @Environment(\.timelinePending) private var pending

    let color: _TimelineColor
    let position: _TimelineItemPosition?
    let label: Label
    let dot: Dot
    let loading: Bool
    let content: Content

    public init(
        color: _TimelineColor = .blue,
        position: _TimelineItemPosition? = nil,
        loading: Bool = false,
        @ViewBuilder label: () -> Label,
        @ViewBuilder dot: () -> Dot,
        @ViewBuilder content: () -> Content
    ) {
        self.color = color
        self.position = position
        self.loading = loading
        self.label = label()
        self.dot = dot()
        self.content = content()
    }

    public var body: some View {
        let isLast = index == itemCount - 1
        let showTail = !isLast || pending

        HStack(alignment: .top, spacing: 0) {
            if effectivePosition == .end {
                // 左侧 label
                if Label.self != EmptyView.self {
                    label
                        .font(.system(size: token.fontSize))
                        .foregroundStyle(token.colorTextSecondary)
                        .frame(minWidth: 80, alignment: .trailing)
                        .padding(.trailing, timelineToken.contentInsetStart)
                }

                // 节点 + 轨迹
                nodeAndTail(showTail: showTail)

                // 右侧内容
                content
                    .padding(.leading, timelineToken.contentInsetStart)
                    .frame(maxWidth: .infinity, alignment: .leading)
            } else {
                // 左侧内容
                content
                    .padding(.trailing, timelineToken.contentInsetStart)
                    .frame(maxWidth: .infinity, alignment: .trailing)

                // 节点 + 轨迹
                nodeAndTail(showTail: showTail)

                // 右侧 label
                if Label.self != EmptyView.self {
                    label
                        .font(.system(size: token.fontSize))
                        .foregroundStyle(token.colorTextSecondary)
                        .frame(minWidth: 80, alignment: .leading)
                        .padding(.leading, timelineToken.contentInsetStart)
                }
            }
        }
        .padding(.bottom, isLast ? 0 : timelineToken.itemPaddingBottom)
    }

    @ViewBuilder
    private func nodeAndTail(showTail: Bool) -> some View {
        VStack(spacing: 0) {
            // 节点
            ZStack {
                if loading {
                    // 加载状态 - 使用 Spin (小尺寸)
                    Moin.Spin(spinning: true, size: .small)
                        .frame(width: timelineToken.dotSize, height: timelineToken.dotSize)
                } else if Dot.self != EmptyView.self {
                    // 自定义节点
                    dot
                        .font(.system(size: timelineToken.dotSize))
                } else {
                    // 默认圆点
                    Circle()
                        .fill(timelineToken.dotBg)
                        .frame(width: timelineToken.dotSize, height: timelineToken.dotSize)
                        .overlay(
                            Circle()
                                .stroke(color.resolve(token: token), lineWidth: timelineToken.dotBorderWidth)
                        )
                }
            }
            .frame(width: timelineToken.dotSize, height: timelineToken.dotSize)

            // 轨迹线
            if showTail {
                Rectangle()
                    .fill(timelineToken.tailColor)
                    .frame(width: timelineToken.tailWidth)
                    .frame(maxHeight: .infinity)
            }
        }
    }

    private var effectivePosition: _TimelineItemPosition {
        if let position = position {
            return position
        }
        switch mode {
        case .start:
            return .end
        case .end:
            return .start
        case .alternate:
            return index % 2 == 0 ? .end : .start
        }
    }
}

// MARK: - Timeline Component

public struct _Timeline<Content: View>: View {
    @Environment(\.moinToken) private var token
    @Environment(\.moinTimelineToken) private var timelineToken

    let mode: _TimelineMode
    let reverse: Bool
    let pending: Bool
    let content: Content

    public init(
        mode: _TimelineMode = .start,
        reverse: Bool = false,
        pending: Bool = false,
        @ViewBuilder content: () -> Content
    ) {
        self.mode = mode
        self.reverse = reverse
        self.pending = pending
        self.content = content()
    }

    public var body: some View {
        let items = extractItems()
        let displayItems = reverse ? Array(items.reversed()) : items
        let count = displayItems.count + (pending ? 1 : 0)

        VStack(alignment: .leading, spacing: 0) {
            ForEach(Array(displayItems.enumerated()), id: \.offset) { index, item in
                item
                    .environment(\.timelineMode, mode)
                    .environment(\.timelineItemIndex, index)
                    .environment(\.timelineItemCount, count)
                    .environment(\.timelinePending, pending)
            }

            // Pending 节点
            if pending {
                pendingItem(index: displayItems.count, count: count)
            }
        }
    }

    @ViewBuilder
    private func pendingItem(index: Int, count: Int) -> some View {
        _TimelineItem(
            color: .gray,
            loading: true,
            label: { EmptyView() },
            dot: { EmptyView() },
            content: { EmptyView() }
        )
        .environment(\.timelineMode, mode)
        .environment(\.timelineItemIndex, index)
        .environment(\.timelineItemCount, count)
        .environment(\.timelinePending, pending)
    }

    private func extractItems() -> [AnyView] {
        var items: [AnyView] = []
        extractItemsHelper(from: content, into: &items)
        return items
    }

    private func extractItemsHelper<V: View>(from view: V, into items: inout [AnyView]) {
        let mirror = Mirror(reflecting: view)

        // 处理 TupleView
        if mirror.displayStyle == .tuple {
            for child in mirror.children {
                if let childView = child.value as? any View {
                    extractItemsHelperAny(from: childView, into: &items)
                }
            }
            return
        }

        // 处理 _ConditionalContent
        if let conditionalMirror = mirror.children.first(where: { $0.label == "storage" }) {
            let storageMirror = Mirror(reflecting: conditionalMirror.value)
            if let content = storageMirror.children.first?.value as? any View {
                extractItemsHelperAny(from: content, into: &items)
            }
            return
        }

        // 处理 Group
        let typeName = String(describing: type(of: view))
        if typeName.hasPrefix("Group") {
            if let contentChild = mirror.children.first(where: { $0.label == "content" }),
               let groupContent = contentChild.value as? any View
            {
                extractItemsHelperAny(from: groupContent, into: &items)
            }
            return
        }

        // 处理 ForEach
        if typeName.hasPrefix("ForEach") {
            items.append(AnyView(view))
            return
        }

        // 普通 View
        items.append(AnyView(view))
    }

    private func extractItemsHelperAny(from view: any View, into items: inout [AnyView]) {
        let mirror = Mirror(reflecting: view)

        // 处理 TupleView
        if mirror.displayStyle == .tuple {
            for child in mirror.children {
                if let childView = child.value as? any View {
                    extractItemsHelperAny(from: childView, into: &items)
                }
            }
            return
        }

        // 处理 _ConditionalContent
        if let conditionalMirror = mirror.children.first(where: { $0.label == "storage" }) {
            let storageMirror = Mirror(reflecting: conditionalMirror.value)
            if let content = storageMirror.children.first?.value as? any View {
                extractItemsHelperAny(from: content, into: &items)
            }
            return
        }

        // 处理 Group
        let typeName = String(describing: type(of: view))
        if typeName.hasPrefix("Group") {
            if let contentChild = mirror.children.first(where: { $0.label == "content" }),
               let groupContent = contentChild.value as? any View
            {
                extractItemsHelperAny(from: groupContent, into: &items)
            }
            return
        }

        // 处理 ForEach
        if typeName.hasPrefix("ForEach") {
            items.append(AnyView(erasing: view))
            return
        }

        // 普通 View
        items.append(AnyView(erasing: view))
    }
}

// MARK: - Environment Keys

private struct TimelineModeKey: EnvironmentKey {
    static let defaultValue: _TimelineMode = .start
}

private struct TimelineItemIndexKey: EnvironmentKey {
    static let defaultValue: Int = 0
}

private struct TimelineItemCountKey: EnvironmentKey {
    static let defaultValue: Int = 1
}

private struct TimelinePendingKey: EnvironmentKey {
    static let defaultValue: Bool = false
}

extension EnvironmentValues {
    var timelineMode: _TimelineMode {
        get { self[TimelineModeKey.self] }
        set { self[TimelineModeKey.self] = newValue }
    }

    var timelineItemIndex: Int {
        get { self[TimelineItemIndexKey.self] }
        set { self[TimelineItemIndexKey.self] = newValue }
    }

    var timelineItemCount: Int {
        get { self[TimelineItemCountKey.self] }
        set { self[TimelineItemCountKey.self] = newValue }
    }

    var timelinePending: Bool {
        get { self[TimelinePendingKey.self] }
        set { self[TimelinePendingKey.self] = newValue }
    }
}

// MARK: - Factory

public struct _MoinTimelineFactory {
    public init() {}

    /// 基础调用
    public func callAsFunction<Content: View>(
        mode: _TimelineMode = .start,
        reverse: Bool = false,
        pending: Bool = false,
        @ViewBuilder content: () -> Content
    ) -> _Timeline<Content> {
        _Timeline(
            mode: mode,
            reverse: reverse,
            pending: pending,
            content: content
        )
    }

    /// Item 子组件 Factory
    public var Item: _MoinTimelineItemFactory { _MoinTimelineItemFactory() }
}

public struct _MoinTimelineItemFactory {
    public init() {}

    /// 简单调用 (仅内容字符串)
    public func callAsFunction(
        _ text: String,
        color: _TimelineColor = .blue
    ) -> _TimelineItem<Text, EmptyView, EmptyView> {
        _TimelineItem(
            color: color,
            label: { EmptyView() },
            dot: { EmptyView() },
            content: { Text(text) }
        )
    }

    /// 完整调用
    public func callAsFunction<Content: View, Label: View, Dot: View>(
        color: _TimelineColor = .blue,
        position: _TimelineItemPosition? = nil,
        loading: Bool = false,
        @ViewBuilder label: () -> Label = { EmptyView() },
        @ViewBuilder dot: () -> Dot = { EmptyView() },
        @ViewBuilder content: () -> Content
    ) -> _TimelineItem<Content, Label, Dot> {
        _TimelineItem(
            color: color,
            position: position,
            loading: loading,
            label: label,
            dot: dot,
            content: content
        )
    }
}
