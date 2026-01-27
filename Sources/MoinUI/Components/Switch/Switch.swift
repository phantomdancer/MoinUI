import SwiftUI
import AppKit


// MARK: - _Switch (internal name, use Moin.Switch.View)

/// 开关组件
public struct _Switch<CheckedContent: View, UncheckedContent: View>: View {
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
    var unCheckedChildren: UncheckedContent

    /// 变更回调
    var onChange: ((Bool) -> Void)?

    /// 是否禁用 (手动控制，以支持 Disabled Cursor)
    var disabled: Bool

    public init(
        isOn: Binding<Bool>,
        loading: Bool = false,
        disabled: Bool = false,
        size: ControlSize = .regular,
        @ViewBuilder checkedChildren: () -> CheckedContent,
        @ViewBuilder unCheckedChildren: () -> UncheckedContent,
        onChange: ((Bool) -> Void)? = nil
    ) {
        self._isOn = isOn
        self.loading = loading
        self.disabled = disabled
        self.size = size
        self.checkedChildren = checkedChildren()
        self.unCheckedChildren = unCheckedChildren()
        self.onChange = onChange
    }

    @State private var isHovering: Bool = false
    @State private var isPressed: Bool = false

    // MARK: - Body

    public var body: some View {
        let actualTrackHeight = size == .small ? token.trackHeightSM : token.trackHeight
        let actualHandleSize = size == .small ? token.handleSizeSM : token.handleSize

        let styleBg = isOn ? token.colorPrimary : token.colorTextQuaternary
        let styleBgHover = isOn ? token.colorPrimaryHover : token.colorTextTertiary

        let isEffectiveDisabled = !isEnabled || disabled

        let finalBg: Color
        if isEffectiveDisabled || loading {
            finalBg = (isOn ? token.colorPrimary : token.colorTextQuaternary).opacity(token.opacityLoading)
        } else {
             finalBg = isHovering ? styleBgHover : styleBg
        }

        let handleWidth = isPressed ? actualHandleSize * 1.3 : actualHandleSize

        let innerMin = size == .small ? token.innerMinMarginSM : token.innerMinMargin
        let innerMax = size == .small ? token.innerMaxMarginSM : token.innerMaxMargin
        let actualMinWidth = size == .small ? token.trackMinWidthSM : token.trackMinWidth

        return ZStack {
            checkedChildren
                .font(.system(size: 12))
                .lineLimit(1)
                .padding(.leading, innerMin)
                .padding(.trailing, innerMax)
                .opacity(0)

            unCheckedChildren
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
            ZStack {
                checkedChildren
                    .font(.system(size: 12))
                    .foregroundColor(.white)
                    .lineLimit(1)
                    .padding(.leading, innerMin)
                    .padding(.trailing, innerMax)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .opacity(isOn ? 1 : 0)

                unCheckedChildren
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
                                    .trim(from: 0, to: 0.25)
                                    .stroke((isOn ? token.colorPrimary : token.colorTextQuaternary).opacity(0.5), style: StrokeStyle(lineWidth: 1.5, lineCap: .round))
                                    .rotationEffect(Angle(degrees: 360))
                                    .frame(width: actualHandleSize * 0.7, height: actualHandleSize * 0.7)
                                    .modifier(_SwitchSpinningModifier())
                            }
                        }
                    )

                if !isOn { Spacer() }
            },
            alignment: .center
        )
        .animation(.spring(response: token.motionDuration + 0.1, dampingFraction: 0.7, blendDuration: 0), value: isOn)
        .animation(.spring(response: token.motionDuration + 0.1, dampingFraction: 0.6, blendDuration: 0), value: isPressed)
        .animation(.easeInOut(duration: token.motionDuration), value: finalBg)
        .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in
                    if isEnabled && !disabled && !loading && !isPressed {
                        isPressed = true
                    }
                }
                .onEnded { _ in
                    guard isEnabled && !disabled && !loading else { return }
                    isPressed = false
                    isOn.toggle()
                    onChange?(isOn)
                }
        )
        .contentShape(Capsule())
        .onContinuousHover { phase in
            switch phase {
            case .active:
                let isInteractable = isEnabled && !disabled && !loading
                let cursor: NSCursor = isInteractable ? .pointingHand : .operationNotAllowed
                cursor.set()

                if isInteractable && !isHovering {
                    withAnimation(.easeInOut(duration: 0.1)) {
                        isHovering = true
                    }
                }
            case .ended:
                NSCursor.arrow.set()
                guard isHovering else { return }
                withAnimation(.easeInOut(duration: 0.1)) {
                    isHovering = false
                    isPressed = false
                }
            }
        }
    }
}

// MARK: - Convenience Inits

public extension _Switch where CheckedContent == EmptyView, UncheckedContent == EmptyView {
    init(
        isOn: Binding<Bool>,
        loading: Bool = false,
        disabled: Bool = false,
        size: ControlSize = .regular,
        onChange: ((Bool) -> Void)? = nil
    ) {
        self.init(
            isOn: isOn,
            loading: loading,
            disabled: disabled,
            size: size,
            checkedChildren: { EmptyView() },
            unCheckedChildren: { EmptyView() },
            onChange: onChange
        )
    }
}

public extension _Switch where CheckedContent == Text, UncheckedContent == Text {
    init(
        isOn: Binding<Bool>,
        loading: Bool = false,
        disabled: Bool = false,
        size: ControlSize = .regular,
        checkedText: String,
        uncheckedText: String,
        onChange: ((Bool) -> Void)? = nil
    ) {
        self.init(
            isOn: isOn,
            loading: loading,
            disabled: disabled,
            size: size,
            checkedChildren: { Text(checkedText) },
            unCheckedChildren: { Text(uncheckedText) },
            onChange: onChange
        )
    }
}

// MARK: - Private Helpers

private struct _SwitchSpinningModifier: ViewModifier {
    @State private var isSpinning = false

    func body(content: Content) -> some View {
        content
            .rotationEffect(Angle(degrees: isSpinning ? 360 : 0))
            .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false), value: isSpinning)
            .onAppear { isSpinning = true }
    }
}


