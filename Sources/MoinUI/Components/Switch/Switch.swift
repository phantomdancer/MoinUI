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
        
        // MARK: - Body
        
        public var body: some View {
            let actualTrackHeight = size == .small ? token.trackHeight - 4 : token.trackHeight
            let actualHandleSize = size == .small ? token.handleSize - 4 : token.handleSize
            let styleBg = isOn ? token.colorPrimary : token.colorTextQuaternary
            let styleBgHover = isOn ? token.colorPrimaryHover : token.colorTextTertiary
            
            // Disabled colors
            let finalBg = (isEnabled && !loading) ? (isHovering ? styleBgHover : styleBg) : token.colorBgDisabled
            
            // Animation offset
            // We need to calculate width dynamically or fix it.
            // AntDesign logic: minWidth.
            // If contents are wider, track expands.
            
            HStack {
                ZStack(alignment: .leading) {
                    // Track
                    Capsule()
                        .fill(finalBg)
                        .frame(height: actualTrackHeight)
                        .frame(minWidth: token.trackMinWidth)
                        .animation(.easeInOut(duration: 0.2), value: finalBg)
                    
                    // Children Content (Text/Icon)
                    // If ON, show checkedChildren on Left.
                    // If OFF, show uncheckedContent on Right.
                    HStack {
                        if isOn {
                            checkedChildren
                                .font(.system(size: 12))
                                .foregroundColor(.white)
                                .lineLimit(1)
                                .padding(.leading, actualHandleSize + token.innerMargin * 2)
                                .padding(.trailing, token.innerMargin + 4)
                                .opacity(isOn ? 1 : 0)
                                .transition(.opacity)
                        } else {
                            Spacer()
                            uncheckedContent
                                .font(.system(size: 12))
                                .foregroundColor(.white)
                                .lineLimit(1)
                                .padding(.leading, token.innerMargin + 4)
                                .padding(.trailing, actualHandleSize + token.innerMargin * 2)
                                .opacity(isOn ? 0 : 1)
                                .transition(.opacity)
                        }
                    }
                    .frame(height: actualTrackHeight)
                    .frame(minWidth: token.trackMinWidth)
                    
                    // Handle
                    Circle()
                        .fill(token.handleBg)
                        .shadow(color: token.handleShadow, radius: 1, x: 0, y: 1)
                        .padding(token.innerMargin)
                        .frame(width: actualTrackHeight, height: actualTrackHeight) // Wrapper frame matches track height
                        .overlay(
                            // Loading Spinner
                            Group {
                                if loading {
                                    // Use Moin.Spin or simulated spinner
                                    Circle()
                                        .trim(from: 0, to: 0.8)
                                        .stroke(style: StrokeStyle(lineWidth: 1.5, lineCap: .round))
                                        .fill(isOn ? token.colorPrimary : token.colorTextQuaternary) // Spinner color
                                        .rotationEffect(Angle(degrees: 360)) // Need persistent animation
                                        .frame(width: actualHandleSize * 0.7, height: actualHandleSize * 0.7)
                                        // Implementing simple spin animation later or use Moin.Spin if available as simple view
                                        // For now static or simple rotating view modifier
                                        .modifier(SpinningModifier())
                                }
                            }
                        )
                        .frame(maxWidth: .infinity, alignment: isOn ? .trailing : .leading)
                }
                .fixedSize()
                .onTapGesture {
                    guard isEnabled && !loading else { return }
                    withAnimation(.easeInOut(duration: 0.2)) {
                        isOn.toggle()
                    }
                    onChange?(isOn)
                }
                .onHover { hover in
                    guard isEnabled && !loading else { return }
                    withAnimation(.easeInOut(duration: 0.1)) {
                        isHovering = hover
                    }
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
