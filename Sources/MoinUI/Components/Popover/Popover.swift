import SwiftUI

// MARK: - _Popover

public struct _Popover<Content: View, TitleContent: View, PopoverContent: View>: View {
    private let content: Content
    private let titleContent: TitleContent?
    private let popoverContent: PopoverContent
    private let placement: _TooltipPlacement
    private let arrowConfig: _TooltipArrowConfig
    private let trigger: _TooltipTrigger
    private let disabled: Bool
    private let isControlled: Bool
    
    @Binding private var open: Bool
    @State private var internalIsOpen: Bool = false
    @State private var isHovering: Bool = false
    @State private var hoverTask: Task<Void, Never>?
    
    @Environment(\.moinPopoverToken) private var popoverToken
    @Environment(\.moinToken) private var token
    @Environment(\.colorScheme) private var colorScheme
    
    @StateObject private var layoutState = TooltipLayoutState()
    
    private var effectiveIsOpen: Bool {
        if disabled { return false }
        return isControlled ? open : internalIsOpen
    }
    
    // MARK: - Init with View content
    
    public init(
        @ViewBuilder content: () -> Content,
        @ViewBuilder title: () -> TitleContent,
        @ViewBuilder popoverContent: () -> PopoverContent,
        placement: _TooltipPlacement = .top,
        arrow: _TooltipArrowConfig = .true,
        trigger: _TooltipTrigger = .hover,
        open: Binding<Bool>? = nil,
        disabled: Bool = false
    ) {
        self.content = content()
        self.titleContent = title()
        self.popoverContent = popoverContent()
        self.placement = placement
        self.arrowConfig = arrow
        self.trigger = trigger
        self._open = open ?? .constant(false)
        self.disabled = disabled
        self.isControlled = open != nil
    }
    
    public var body: some View {
        content
            .overlay(
                TooltipAnchor(
                    open: effectiveIsOpen,
                    tooltipContent: popoverView,
                    placement: placement,
                    arrowConfig: arrowConfig,
                    trigger: trigger,
                    arrowSize: token.sizePopupArrow,
                    offset: 4,
                    maxWidth: nil, // Popover 不限定宽度
                    zIndex: popoverToken.zIndexPopup,
                    layoutState: layoutState,
                    onHover: { hovering in
                        handleHover(hovering)
                    },
                    onClick: {
                        handleAnchorClick()
                    },
                    onClose: {
                        handleForceClose()
                    }
                )
                .allowsHitTesting(false)
            )
            .simultaneousGesture(
                TapGesture().onEnded {
                    guard trigger == .click else { return }
                    toggleWithAnimation()
                }
            )
    }
    
    // MARK: - Popover View
    
    private var popoverView: some View {
        PopoverBubble(
            placement: placement,
            arrowConfig: arrowConfig,
            bgColor: token.colorBgElevated,
            arrowSize: token.sizePopupArrow,
            borderRadius: token.borderRadiusLG,
            arrowOffset: 8,
            layoutState: layoutState
        ) {
            VStack(alignment: .leading, spacing: popoverToken.titleMarginBottom) {
                if let titleContent = titleContent {
                    titleContent
                        .font(.system(size: token.fontSize, weight: .semibold))
                        .foregroundStyle(token.colorText)
                }
                popoverContent
                    .font(.system(size: token.fontSize))
                    .foregroundStyle(token.colorText)
            }
            .padding(popoverToken.innerPadding)
            .frame(minWidth: popoverToken.titleMinWidth, alignment: .leading)
        }
        .shadow(
            color: Color.black.opacity(0.12),
            radius: 8,
            x: 0,
            y: 3
        )
        .fixedSize()
        .environment(\.moinToken, token)
        .environment(\.moinPopoverToken, popoverToken)
        .environment(\.colorScheme, colorScheme)
    }
    
    // MARK: - Logic
    
    private func handleHover(_ hovering: Bool) {
        guard trigger == .hover, !disabled, !isControlled else { return }
        if hovering {
            if !isHovering {
                isHovering = true
                scheduleShow()
            }
        } else {
            isHovering = false
            scheduleHide()
        }
    }
    
    private func handleAnchorClick() {
        guard trigger == .click else { return }
    }
    
    private func handleForceClose() {
        DispatchQueue.main.async {
            self.internalIsOpen = false
            self.isHovering = false
        }
    }
    
    private func toggleWithAnimation() {
        withAnimation(.easeInOut(duration: token.motionDurationMid)) {
            internalIsOpen.toggle()
        }
    }
    
    private let mouseEnterDelay: Double = 0.1
    private let mouseLeaveDelay: Double = 0.1
    
    private func scheduleShow() {
        hoverTask?.cancel()
        hoverTask = Task {
            try? await Task.sleep(nanoseconds: UInt64(mouseEnterDelay * 1_000_000_000))
            guard !Task.isCancelled, isHovering else { return }
            await MainActor.run {
                withAnimation(.easeInOut(duration: token.motionDurationMid)) {
                    internalIsOpen = true
                }
            }
        }
    }
    
    private func scheduleHide() {
        hoverTask?.cancel()
        hoverTask = Task {
            try? await Task.sleep(nanoseconds: UInt64(mouseLeaveDelay * 1_000_000_000))
            guard !Task.isCancelled, !isHovering else { return }
            await MainActor.run {
                withAnimation(.easeInOut(duration: token.motionDurationMid)) {
                    internalIsOpen = false
                }
            }
        }
    }
}

// MARK: - PopoverBubble

private struct PopoverBubble<Content: View>: View {
    let placement: _TooltipPlacement
    let arrowConfig: _TooltipArrowConfig
    let bgColor: Color
    let arrowSize: CGFloat
    let borderRadius: CGFloat
    let arrowOffset: CGFloat
    @ObservedObject var layoutState: TooltipLayoutState
    
    @ViewBuilder let content: () -> Content
    
    var effectiveAlignment: _TooltipPlacement.ArrowAlignment {
        layoutState.arrowAlignmentOverride ?? placement.arrowAlignment
    }
    
    var effectiveArrowOffset: CGFloat {
        layoutState.arrowOffsetOverride ?? arrowOffset
    }
    
    var body: some View {
        switch placement.primaryDirection {
        case .top:
            VStack(spacing: 0) {
                contentBox
                if arrowConfig.show {
                    arrowRowHorizontal(pointingDown: true)
                }
            }
        case .bottom:
            VStack(spacing: 0) {
                if arrowConfig.show {
                    arrowRowHorizontal(pointingDown: false)
                }
                contentBox
            }
        case .leading:
            HStack(spacing: 0) {
                contentBox
                if arrowConfig.show {
                    arrowColumnVertical(pointingRight: true)
                }
            }
        case .trailing:
            HStack(spacing: 0) {
                if arrowConfig.show {
                    arrowColumnVertical(pointingRight: false)
                }
                contentBox
            }
        }
    }
    
    private var contentBox: some View {
        content()
            .background(bgColor)
            .clipShape(RoundedRectangle(cornerRadius: borderRadius))
    }
    
    @ViewBuilder
    private func arrowRowHorizontal(pointingDown: Bool) -> some View {
        HStack(spacing: 0) {
            switch effectiveAlignment {
            case .center:
                Spacer(minLength: 0)
                horizontalArrow(pointingDown: pointingDown)
                Spacer(minLength: 0)
            case .leading:
                Spacer().frame(width: effectiveArrowOffset)
                horizontalArrow(pointingDown: pointingDown)
                Spacer(minLength: 0)
            case .trailing:
                Spacer(minLength: 0)
                horizontalArrow(pointingDown: pointingDown)
                Spacer().frame(width: effectiveArrowOffset)
            default:
                Spacer(minLength: 0)
                horizontalArrow(pointingDown: pointingDown)
                Spacer(minLength: 0)
            }
        }
    }
    
    @ViewBuilder
    private func arrowColumnVertical(pointingRight: Bool) -> some View {
        VStack(spacing: 0) {
            switch effectiveAlignment {
            case .center:
                Spacer(minLength: 0)
                verticalArrow(pointingRight: pointingRight)
                Spacer(minLength: 0)
            case .top:
                Spacer().frame(height: effectiveArrowOffset)
                verticalArrow(pointingRight: pointingRight)
                Spacer(minLength: 0)
            case .bottom:
                Spacer(minLength: 0)
                verticalArrow(pointingRight: pointingRight)
                Spacer().frame(height: effectiveArrowOffset)
            default:
                Spacer(minLength: 0)
                verticalArrow(pointingRight: pointingRight)
                Spacer(minLength: 0)
            }
        }
    }
    
    private func horizontalArrow(pointingDown: Bool) -> some View {
        PopoverArrowShape(direction: pointingDown ? .down : .up, cornerRadius: 2)
            .fill(bgColor)
            .frame(width: arrowSize * 2, height: arrowSize)
    }
    
    private func verticalArrow(pointingRight: Bool) -> some View {
        PopoverArrowShape(direction: pointingRight ? .right : .left, cornerRadius: 2)
            .fill(bgColor)
            .frame(width: arrowSize, height: arrowSize * 2)
    }
}

// MARK: - Arrow Direction

private enum PopoverArrowDirection {
    case up, down, left, right
}

// MARK: - Arrow Shape

private struct PopoverArrowShape: Shape {
    let direction: PopoverArrowDirection
    let cornerRadius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let r = cornerRadius
        
        switch direction {
        case .down:
            let midX = rect.midX
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: midX - r, y: rect.height - r))
            path.addQuadCurve(
                to: CGPoint(x: midX + r, y: rect.height - r),
                control: CGPoint(x: midX, y: rect.height)
            )
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            
        case .up:
            let midX = rect.midX
            path.move(to: CGPoint(x: 0, y: rect.height))
            path.addLine(to: CGPoint(x: midX - r, y: r))
            path.addQuadCurve(
                to: CGPoint(x: midX + r, y: r),
                control: CGPoint(x: midX, y: 0)
            )
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            
        case .right:
            let midY = rect.midY
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: rect.width - r, y: midY - r))
            path.addQuadCurve(
                to: CGPoint(x: rect.width - r, y: midY + r),
                control: CGPoint(x: rect.width, y: midY)
            )
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            
        case .left:
            let midY = rect.midY
            path.move(to: CGPoint(x: rect.width, y: 0))
            path.addLine(to: CGPoint(x: r, y: midY - r))
            path.addQuadCurve(
                to: CGPoint(x: r, y: midY + r),
                control: CGPoint(x: 0, y: midY)
            )
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        }
        
        path.closeSubpath()
        return path
    }
}

// MARK: - Convenience Init without Title

public extension _Popover where TitleContent == EmptyView {
    init(
        @ViewBuilder content: () -> Content,
        @ViewBuilder popoverContent: () -> PopoverContent,
        placement: _TooltipPlacement = .top,
        arrow: _TooltipArrowConfig = .true,
        trigger: _TooltipTrigger = .hover,
        open: Binding<Bool>? = nil,
        disabled: Bool = false
    ) {
        self.content = content()
        self.titleContent = nil
        self.popoverContent = popoverContent()
        self.placement = placement
        self.arrowConfig = arrow
        self.trigger = trigger
        self._open = open ?? .constant(false)
        self.disabled = disabled
        self.isControlled = open != nil
    }
}

// MARK: - String Title Convenience

public extension _Popover where TitleContent == Text {
    init(
        _ title: String,
        @ViewBuilder content: () -> Content,
        @ViewBuilder popoverContent: () -> PopoverContent,
        placement: _TooltipPlacement = .top,
        arrow: _TooltipArrowConfig = .true,
        trigger: _TooltipTrigger = .hover,
        open: Binding<Bool>? = nil,
        disabled: Bool = false
    ) {
        self.content = content()
        self.titleContent = Text(title)
        self.popoverContent = popoverContent()
        self.placement = placement
        self.arrowConfig = arrow
        self.trigger = trigger
        self._open = open ?? .constant(false)
        self.disabled = disabled
        self.isControlled = open != nil
    }
}

// MARK: - Factory

public struct _MoinPopoverFactory {
    public init() {}
    
    /// Popover with title and content views
    public func callAsFunction<Content: View, TitleContent: View, PopoverContent: View>(
        @ViewBuilder content: () -> Content,
        @ViewBuilder title: () -> TitleContent,
        @ViewBuilder popoverContent: () -> PopoverContent,
        placement: _TooltipPlacement = .top,
        arrow: _TooltipArrowConfig = .true,
        trigger: _TooltipTrigger = .hover,
        open: Binding<Bool>? = nil,
        disabled: Bool = false
    ) -> _Popover<Content, TitleContent, PopoverContent> {
        _Popover(
            content: content,
            title: title,
            popoverContent: popoverContent,
            placement: placement,
            arrow: arrow,
            trigger: trigger,
            open: open,
            disabled: disabled
        )
    }
    
    /// Popover with string title
    public func callAsFunction<Content: View, PopoverContent: View>(
        _ title: String,
        @ViewBuilder content: () -> Content,
        @ViewBuilder popoverContent: () -> PopoverContent,
        placement: _TooltipPlacement = .top,
        arrow: _TooltipArrowConfig = .true,
        trigger: _TooltipTrigger = .hover,
        open: Binding<Bool>? = nil,
        disabled: Bool = false
    ) -> _Popover<Content, Text, PopoverContent> {
        _Popover(
            title,
            content: content,
            popoverContent: popoverContent,
            placement: placement,
            arrow: arrow,
            trigger: trigger,
            open: open,
            disabled: disabled
        )
    }
    
    /// Popover without title
    public func callAsFunction<Content: View, PopoverContent: View>(
        @ViewBuilder content: () -> Content,
        @ViewBuilder popoverContent: () -> PopoverContent,
        placement: _TooltipPlacement = .top,
        arrow: _TooltipArrowConfig = .true,
        trigger: _TooltipTrigger = .hover,
        open: Binding<Bool>? = nil,
        disabled: Bool = false
    ) -> _Popover<Content, EmptyView, PopoverContent> {
        _Popover(
            content: content,
            popoverContent: popoverContent,
            placement: placement,
            arrow: arrow,
            trigger: trigger,
            open: open,
            disabled: disabled
        )
    }
}
