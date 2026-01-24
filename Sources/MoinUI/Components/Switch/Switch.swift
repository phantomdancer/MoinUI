import SwiftUI

public extension Moin {
    struct Switch<CheckedContent: View, UncheckedContent: View>: View {
        @Environment(\.moinSwitchToken) private var token
        @Environment(\.isEnabled) private var isEnabled
        
        @Binding var isOn: Bool
        
        /// 是否加载中
        var loading: Bool
        
        /// 尺寸
        var size: ControlSize
        
        /// 选中时的内容 (Text/Icon)
        var checkedChildren: CheckedContent
        
        /// 未选中时的内容 (Text/Icon)
        var uncheckedContent: UncheckedContent
        
        /// 变更回调
        var onChange: ((Bool) -> Void)?
        
        public init(
            isOn: Binding<Bool>,
            loading: Bool = false,
            size: ControlSize = .regular,
            @ViewBuilder checkedChildren: () -> CheckedContent,
            @ViewBuilder uncheckedContent: () -> UncheckedContent,
            onChange: ((Bool) -> Void)? = nil
        ) {
            self._isOn = isOn
            self.loading = loading
            self.size = size
            self.checkedChildren = checkedChildren()
            self.uncheckedContent = uncheckedContent()
            self.onChange = onChange
        }
        
        @State private var isHovering: Bool = false
        @State private var isPressed: Bool = false
        
        // MARK: - Body

        public var body: some View {
            // ... (keep variable definitions)
            let actualTrackHeight = size == .small ? token.trackHeightSM : token.trackHeight
            let actualHandleSize = size == .small ? token.handleSizeSM : token.handleSize
            
            let styleBg = isOn ? token.colorPrimary : token.colorTextQuaternary
            let styleBgHover = isOn ? token.colorPrimaryHover : token.colorTextTertiary
            
            // Disabled colors logic:
            // If disabled, use base color but with opacity (0.4 usually in AntD)
            // If disabled & isOn -> primary color with opacity
            // If disabled & !isOn -> quaternary color with opacity
            
            let finalBg: Color
            if !isEnabled || loading {
                finalBg = (isOn ? token.colorPrimary : token.colorTextQuaternary).opacity(0.4)
            } else {
                 finalBg = isHovering ? styleBgHover : styleBg
            }
            
            // Handle Width Calculation
            // Ant Design spec: extends by 30% when pressed
            let handleWidth = isPressed ? actualHandleSize * 1.3 : actualHandleSize
            
            // Layout inversion: Content drives size
            // This ensures text is never truncated if it exceeds minWidth.
            let innerMin = size == .small ? token.innerMinMarginSM : token.innerMinMargin
            let innerMax = size == .small ? token.innerMaxMarginSM : token.innerMaxMargin
            let actualMinWidth = size == .small ? token.trackMinWidthSM : token.trackMinWidth
            
            // Layout inversion: Content drives size
            // To ensure no width jitter and correct alignment, we use a "Ghost" ZStack 
            // to measure the maximum width required by either state, then overlay the real content.
            
            return ZStack {
                // Ghost Content for Sizing
                // Both are present but invisible, ensuring the container adds up to the max width needed.
                checkedChildren
                    .font(.system(size: 12))
                    .lineLimit(1)
                    .padding(.leading, innerMin)
                    .padding(.trailing, innerMax)
                    .opacity(0)
                
                uncheckedContent
                    .font(.system(size: 12))
                    .lineLimit(1)
                    .padding(.leading, innerMax)
                    .padding(.trailing, innerMin)
                    .opacity(0)
            }
            .frame(minWidth: actualMinWidth)
            .frame(height: actualTrackHeight)
            .background(
                Capsule()
                    .fill(finalBg)
            )
            .overlay(
                // Visible Content Layer
                // Now we can use maxWidth: .infinity because the parent frame is fixed by the ghost content.
                ZStack {
                    checkedChildren
                        .font(.system(size: 12))
                        .foregroundColor(.white)
                        .lineLimit(1)
                        .padding(.leading, innerMin)
                        .padding(.trailing, innerMax)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .opacity(isOn ? 1 : 0)
                    
                    uncheckedContent
                        .font(.system(size: 12))
                        .foregroundColor(.white)
                        .lineLimit(1)
                        .padding(.leading, innerMax)
                        .padding(.trailing, innerMin)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .opacity(isOn ? 0 : 1)
                }
            )
            .overlay(
                // Handle
                HStack(spacing: 0) {
                    if isOn { Spacer() }
                    
                    Capsule()
                        .fill(token.handleBg)
                        .shadow(color: token.handleShadow, radius: 1, x: 0, y: 1)
                        .frame(width: handleWidth, height: actualHandleSize)
                        .padding(token.trackPadding)
                        .overlay(
                            Group {
                                if loading {
                                    Circle()
                                        .trim(from: 0, to: 0.8)
                                        .stroke(style: StrokeStyle(lineWidth: 1.5, lineCap: .round))
                                        .fill(isOn ? token.colorPrimary : token.colorTextQuaternary)
                                        .rotationEffect(Angle(degrees: 360))
                                        .frame(width: actualHandleSize * 0.7, height: actualHandleSize * 0.7)
                                        .modifier(SpinningModifier())
                                }
                            }
                        )
                    
                    if !isOn { Spacer() }
                },
                alignment: .center
            )
            // Animations
            .animation(.spring(response: 0.3, dampingFraction: 0.7, blendDuration: 0), value: isOn) // Slide
            .animation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0), value: isPressed) // Press effect
            .animation(.easeInOut(duration: 0.2), value: finalBg) // Color
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { _ in
                        if isEnabled && !loading && !isPressed {
                            isPressed = true
                        }
                    }
                    .onEnded { _ in
                        guard isEnabled && !loading else { return }
                        isPressed = false
                        isOn.toggle()
                        onChange?(isOn)
                    }
            )
            .onHover { hover in
                guard isEnabled && !loading else { return }
                withAnimation(.easeInOut(duration: 0.1)) {
                    isHovering = hover
                }
            }
        }
    }
}

// MARK: - Convenience Inits

public extension Moin.Switch where CheckedContent == EmptyView, UncheckedContent == EmptyView {
    init(
        isOn: Binding<Bool>,
        loading: Bool = false,
        size: ControlSize = .regular,
        onChange: ((Bool) -> Void)? = nil
    ) {
        self.init(
            isOn: isOn,
            loading: loading,
            size: size,
            checkedChildren: { EmptyView() },
            uncheckedContent: { EmptyView() },
            onChange: onChange
        )
    }
}

public extension Moin.Switch where CheckedContent == Text, UncheckedContent == Text {
    init(
        isOn: Binding<Bool>,
        loading: Bool = false,
        size: ControlSize = .regular,
        checkedText: String,
        uncheckedText: String,
        onChange: ((Bool) -> Void)? = nil
    ) {
        self.init(
            isOn: isOn,
            loading: loading,
            size: size,
            checkedChildren: { Text(checkedText) },
            uncheckedContent: { Text(uncheckedText) },
            onChange: onChange
        )
    }
}

// MARK: - Private Helpers

private struct SpinningModifier: ViewModifier {
    @State private var isSpinning = false
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(Angle(degrees: isSpinning ? 360 : 0))
            .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false), value: isSpinning)
            .onAppear { isSpinning = true }
    }
}

