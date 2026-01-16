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
    /// 延迟显示(毫秒)
    let delay: Int?
    /// 自定义指示器
    let indicator: AnyView?
    /// 全屏模式
    let fullscreen: Bool
    /// 嵌套内容
    let content: Content?

    @Environment(\.moinConfig) private var config
    @State private var isVisible: Bool = true

    // MARK: - Init (基础)

    public init(
        spinning: Bool = true,
        size: SpinSize = .default,
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
        }
        .onChange(of: spinning) { newValue in
            if newValue {
                setupDelay()
            } else {
                isVisible = false
            }
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
            SpinIndicator(
                size: size.dotSize(from: token),
                color: token.dotColor,
                duration: token.motionDuration
            )
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

    private func setupDelay() {
        if let delay = delay, delay > 0 {
            isVisible = false
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(delay) / 1000) {
                if spinning {
                    withAnimation {
                        isVisible = true
                    }
                }
            }
        } else {
            isVisible = true
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
