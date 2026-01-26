import SwiftUI

public extension Moin {
    typealias Spin = MoinUI.Spin
}

// MARK: - Spin

/// 加载中组件
///
/// 用于页面和区块的加载中状态，支持嵌套模式和全屏模式。
public struct Spin<Content: View>: View {
    // MARK: - Properties

    /// 是否旋转
    let spinning: Bool
    /// 尺寸
    let size: Size
    /// 提示文案
    let tip: String?
    /// 延迟显示(毫秒)，使用 debounce 防抖
    let delay: Int?
    /// 自定义指示器
    let indicator: AnyView?
    /// 全屏模式
    let fullscreen: Bool
    /// 嵌套内容
    let content: Content?

    @Environment(\.moinToken) private var globalToken
    @ObservedObject private var config = Moin.ConfigProvider.shared
    @State private var isVisible: Bool = true
    @State private var delayTask: DispatchWorkItem?

    // MARK: - Init (基础)

    public init(
        spinning: Bool = true,
        size: Size = .default,
        tip: String? = nil,
        delay: Int? = nil,
        fullscreen: Bool = false
    ) where Content == EmptyView {
        self.spinning = spinning
        self.size = size
        self.tip = tip
        self.delay = delay
        self.indicator = nil
        self.fullscreen = fullscreen
        self.content = nil
    }

    // MARK: - Init (自定义指示器)

    public init<IndicatorView: View>(
        spinning: Bool = true,
        size: Size = .default,
        tip: String? = nil,
        delay: Int? = nil,
        fullscreen: Bool = false,
        @ViewBuilder indicator: () -> IndicatorView
    ) where Content == EmptyView {
        self.spinning = spinning
        self.size = size
        self.tip = tip
        self.delay = delay
        self.indicator = AnyView(indicator())
        self.fullscreen = fullscreen
        self.content = nil
    }

    // MARK: - Init (嵌套模式)

    public init(
        spinning: Bool = true,
        size: Size = .default,
        tip: String? = nil,
        delay: Int? = nil,
        @ViewBuilder content: () -> Content
    ) {
        self.spinning = spinning
        self.size = size
        self.tip = tip
        self.delay = delay
        self.indicator = nil
        self.fullscreen = false
        self.content = content()
    }

    // MARK: - Body

    public var body: some View {
        let spinToken = config.components.spin

        Group {
            if fullscreen {
                fullscreenView(token: spinToken)
            } else if content != nil {
                nestedView(token: spinToken)
            } else {
                spinnerView(token: spinToken)
            }
        }
        .onAppear {
            setupDelay()
        }
        .onChange(of: spinning) { newValue in
            if newValue {
                setupDelay()
            } else {
                cancelDelay()
                isVisible = false
            }
        }
        .onDisappear {
            cancelDelay()
        }
    }

    // MARK: - Views

    @ViewBuilder
    private func spinnerView(token: Moin.SpinToken) -> some View {
        if isVisible && spinning {
            VStack(spacing: 8) {
                indicatorView(token: token)

                if let tip = tip {
                    Text(tip)
                        .font(.system(size: 14))
                        .foregroundStyle(globalToken.colorTextTertiary)
                }
            }
        }
    }

    @ViewBuilder
    private func indicatorView(token: Moin.SpinToken) -> some View {
        if let customIndicator = indicator {
            customIndicator
        } else {
            let dotSize = size.dotSize(from: token)
            Indicator(
                size: dotSize,
                color: globalToken.colorPrimary,
                duration: token.motionDuration
            )
        }
    }

    @ViewBuilder
    private func nestedView(token: Moin.SpinToken) -> some View {
        ZStack {
            content
                .blur(radius: (isVisible && spinning) ? 1 : 0)
                .opacity((isVisible && spinning) ? 0.5 : 1)
                .allowsHitTesting(!(isVisible && spinning))

            if isVisible && spinning {
                VStack(spacing: 8) {
                    indicatorView(token: token)

                    if let tip = tip {
                        Text(tip)
                            .font(.system(size: 14))
                            .foregroundStyle(globalToken.colorTextTertiary)
                    }
                }
            }
        }
        .animation(.easeInOut(duration: 0.3), value: spinning)
    }

    @ViewBuilder
    private func fullscreenView(token: Moin.SpinToken) -> some View {
        if isVisible && spinning {
            ZStack {
                globalToken.colorBgMask
                    .ignoresSafeArea()

                VStack(spacing: 12) {
                    if let customIndicator = indicator {
                        customIndicator
                    } else {
                        let dotSize = size.dotSize(from: token)
                        Indicator(
                            size: dotSize,
                            color: .white,
                            duration: token.motionDuration
                        )
                    }

                    if let tip = tip {
                        Text(tip)
                            .font(.system(size: 14))
                            .foregroundStyle(.white)
                    }
                }
            }
            .transition(.opacity)
        }
    }

    // MARK: - Private

    private func setupDelay() {
        cancelDelay()

        if let delay = delay, delay > 0 {
            isVisible = false
            let task = DispatchWorkItem {
                if spinning {
                    withAnimation {
                        isVisible = true
                    }
                }
            }
            delayTask = task
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(delay) / 1000, execute: task)
        } else {
            isVisible = true
        }
    }

    private func cancelDelay() {
        delayTask?.cancel()
        delayTask = nil
    }
}
