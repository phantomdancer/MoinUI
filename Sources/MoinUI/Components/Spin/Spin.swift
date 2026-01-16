import SwiftUI

public extension Moin {
    typealias Spin = MoinUI.Spin
}

// MARK: - Spin

/// 加载中组件
///
/// 用于页面和区块的加载中状态，支持嵌套模式和全屏模式。
///
/// ## 基础用法
/// ```swift
/// Spin()
/// Spin(size: .large)
/// Spin(tip: "加载中...")
/// ```
///
/// ## 进度模式
/// ```swift
/// Spin(percent: .value(50))
/// Spin(percent: .auto)  // 自动增长
/// ```
///
/// ## 嵌套模式
/// ```swift
/// Spin(spinning: isLoading) {
///     ContentView()
/// }
/// ```
///
/// ## 全屏模式
/// ```swift
/// Spin(spinning: isLoading, fullscreen: true)
/// ```
public struct Spin<Content: View>: View {
    // MARK: - Properties

    /// 是否旋转
    let spinning: Bool
    /// 尺寸
    let size: SpinSize
    /// 提示文案
    let tip: String?
    /// 延迟显示(毫秒)，使用 debounce 防抖
    let delay: Int?
    /// 进度百分比
    let percent: SpinPercent?
    /// 自定义指示器
    let indicator: AnyView?
    /// 全屏模式
    let fullscreen: Bool
    /// 嵌套内容
    let content: Content?

    @ObservedObject private var config = Moin.ConfigProvider.shared
    @State private var isVisible: Bool = true
    @State private var delayTask: DispatchWorkItem?
    @State private var autoPercent: Double = 0

    // MARK: - Init (基础)

    public init(
        spinning: Bool = true,
        size: SpinSize = .default,
        tip: String? = nil,
        delay: Int? = nil,
        percent: SpinPercent? = nil,
        fullscreen: Bool = false
    ) where Content == EmptyView {
        self.spinning = spinning
        self.size = size
        self.tip = tip
        self.delay = delay
        self.percent = percent
        self.indicator = nil
        self.fullscreen = fullscreen
        self.content = nil
    }

    // MARK: - Init (自定义指示器)

    public init<Indicator: View>(
        spinning: Bool = true,
        size: SpinSize = .default,
        tip: String? = nil,
        delay: Int? = nil,
        fullscreen: Bool = false,
        @ViewBuilder indicator: () -> Indicator
    ) where Content == EmptyView {
        self.spinning = spinning
        self.size = size
        self.tip = tip
        self.delay = delay
        self.percent = nil
        self.indicator = AnyView(indicator())
        self.fullscreen = fullscreen
        self.content = nil
    }

    // MARK: - Init (嵌套模式)

    public init(
        spinning: Bool = true,
        size: SpinSize = .default,
        tip: String? = nil,
        delay: Int? = nil,
        percent: SpinPercent? = nil,
        @ViewBuilder content: () -> Content
    ) {
        self.spinning = spinning
        self.size = size
        self.tip = tip
        self.delay = delay
        self.percent = percent
        self.indicator = nil
        self.fullscreen = false
        self.content = content()
    }

    // MARK: - Body

    public var body: some View {
        let token = config.components.spin

        Group {
            if fullscreen {
                fullscreenView(token: token)
            } else if content != nil {
                nestedView(token: token)
            } else {
                spinnerView(token: token)
            }
        }
        .onAppear {
            setupDelay()
            startAutoPercent()
        }
        .onChange(of: spinning) { newValue in
            if newValue {
                setupDelay()
                startAutoPercent()
            } else {
                cancelDelay()
                isVisible = false
                autoPercent = 0
            }
        }
        .onDisappear {
            cancelDelay()
        }
    }

    // MARK: - Computed

    /// 当前显示的进度值
    private var currentPercent: Double? {
        guard let percent = percent else { return nil }
        switch percent {
        case .value(let v):
            return v
        case .auto:
            return autoPercent
        }
    }

    // MARK: - Views

    /// 基础旋转视图
    @ViewBuilder
    private func spinnerView(token: Moin.SpinToken) -> some View {
        if isVisible && spinning {
            VStack(spacing: 8) {
                indicatorView(token: token)

                if let tip = tip {
                    Text(tip)
                        .font(.system(size: 14))
                        .foregroundStyle(token.tipColor)
                }
            }
        }
    }

    /// 指示器视图
    @ViewBuilder
    private func indicatorView(token: Moin.SpinToken) -> some View {
        if let customIndicator = indicator {
            customIndicator
        } else {
            let dotSize = size.dotSize(from: token)

            ZStack {
                // 旋转点指示器
                SpinIndicator(
                    size: dotSize,
                    color: token.dotColor,
                    duration: token.motionDuration
                )

                // 进度圆环（如果有 percent）
                if let pct = currentPercent, pct > 0 {
                    SpinProgress(
                        size: dotSize,
                        percent: pct,
                        color: token.dotColor,
                        trackColor: token.progressTrackColor
                    )
                }
            }
        }
    }

    /// 嵌套模式视图
    @ViewBuilder
    private func nestedView(token: Moin.SpinToken) -> some View {
        ZStack {
            content
                .blur(radius: (isVisible && spinning) ? 1 : 0)
                .opacity((isVisible && spinning) ? 0.5 : 1)

            if isVisible && spinning {
                VStack(spacing: 8) {
                    indicatorView(token: token)

                    if let tip = tip {
                        Text(tip)
                            .font(.system(size: 14))
                            .foregroundStyle(token.tipColor)
                    }
                }
            }
        }
        .animation(.easeInOut(duration: 0.3), value: spinning)
    }

    /// 全屏模式视图
    @ViewBuilder
    private func fullscreenView(token: Moin.SpinToken) -> some View {
        if isVisible && spinning {
            ZStack {
                token.maskBackground
                    .ignoresSafeArea()

                VStack(spacing: 12) {
                    indicatorView(token: token)
                        .colorMultiply(.white)

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

    /// 设置延迟显示（debounce 防抖）
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

    /// 取消延迟任务
    private func cancelDelay() {
        delayTask?.cancel()
        delayTask = nil
    }

    /// 启动自动进度
    private func startAutoPercent() {
        guard case .auto = percent, spinning else { return }
        autoPercent = 0

        // antd 的自动进度算法
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { timer in
            guard spinning, case .auto = percent else {
                timer.invalidate()
                return
            }

            let rest = 100 - autoPercent
            let step: Double
            if autoPercent <= 30 {
                step = rest * 0.05
            } else if autoPercent <= 70 {
                step = rest * 0.03
            } else if autoPercent <= 96 {
                step = rest * 0.01
            } else {
                step = 0
            }

            if step > 0 {
                autoPercent += step
            }
        }
    }
}

// MARK: - Preview

#Preview("Spin Basic") {
    VStack(spacing: 40) {
        HStack(spacing: 40) {
            Spin(size: .small)
            Spin()
            Spin(size: .large)
        }

        Spin(tip: "Loading...")
    }
    .padding()
}

#Preview("Spin Percent") {
    HStack(spacing: 40) {
        Spin(percent: .value(30))
        Spin(percent: .value(70))
        Spin(size: .large, percent: .auto)
    }
    .padding()
}

#Preview("Spin Nested") {
    Spin(spinning: true, tip: "加载中...") {
        VStack {
            Text("Content Area")
                .font(.title)
            Text("This content will be blurred when loading")
        }
        .frame(width: 300, height: 200)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(8)
    }
    .padding()
}

#Preview("Spin Fullscreen") {
    ZStack {
        Color.white.ignoresSafeArea()
        Text("Background Content")

        Spin(spinning: true, tip: "Loading...", fullscreen: true)
    }
}

#Preview("Spin Custom Indicator") {
    Spin {
        Image(systemName: "arrow.triangle.2.circlepath")
            .font(.system(size: 24))
            .foregroundStyle(.blue)
            .rotationEffect(.degrees(360))
            .animation(.linear(duration: 1).repeatForever(autoreverses: false), value: UUID())
    }
}
