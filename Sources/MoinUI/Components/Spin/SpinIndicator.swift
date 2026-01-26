import SwiftUI

// MARK: - SpinIndicator

/// Ant Design 风格四点旋转指示器
public struct SpinIndicator: View {
    let size: CGFloat
    let color: Color
    let duration: Double

    @State private var isAnimating = false

    public init(size: CGFloat, color: Color, duration: Double = 1.2) {
        self.size = size
        self.color = color
        self.duration = duration
    }

    public var body: some View {
        ZStack {
            ForEach(0..<4, id: \.self) { index in
                SpinDot(
                    size: dotItemSize,
                    color: color,
                    delay: Double(index) * 0.4,  // antd: 0s, 0.4s, 0.8s, 1.2s
                    isAnimating: isAnimating
                )
                .offset(x: dotOffset(for: index).x, y: dotOffset(for: index).y)
            }
        }
        .frame(width: size, height: size)
        .rotationEffect(.degrees(45 + (isAnimating ? 360 : 0)))  // antd: 45deg → 405deg
        .animation(
            .linear(duration: duration).repeatForever(autoreverses: false),
            value: isAnimating
        )
        .onAppear {
            isAnimating = true
        }
    }

    // MARK: - Private

    /// 单个点的尺寸 (antd: (dotSize - marginXXS/2) / 2)
    private var dotItemSize: CGFloat {
        (size - 2) / 2
    }

    /// 点距中心的偏移距离
    private var offsetDistance: CGFloat {
        (size - dotItemSize) / 2
    }

    /// 计算每个点的偏移位置
    /// 布局: 正方形四角 (左上、右上、右下、左下)
    /// 通过 45° 旋转变成菱形
    private func dotOffset(for index: Int) -> CGPoint {
        switch index {
        case 0: return CGPoint(x: -offsetDistance, y: -offsetDistance)  // 左上
        case 1: return CGPoint(x: offsetDistance, y: -offsetDistance)   // 右上
        case 2: return CGPoint(x: offsetDistance, y: offsetDistance)    // 右下
        case 3: return CGPoint(x: -offsetDistance, y: offsetDistance)   // 左下
        default: return .zero
        }
    }
}

// MARK: - SpinDot

/// 单个旋转点，带有 opacity 闪烁动画
private struct SpinDot: View {
    let size: CGFloat
    let color: Color
    let delay: Double
    let isAnimating: Bool

    @State private var isAtMaxOpacity = false

    var body: some View {
        Circle()
            .fill(color)
            .frame(width: size, height: size)
            .scaleEffect(0.75)  // antd: transform: scale(0.75)
            .opacity(isAtMaxOpacity ? 1.0 : 0.3)
            .animation(
                isAnimating ?
                    Animation.easeInOut(duration: 1.0)
                        .repeatForever(autoreverses: true)
                        .delay(delay)
                    : nil,
                value: isAtMaxOpacity
            )
            .onChange(of: isAnimating) { animating in
                if animating {
                    isAtMaxOpacity = true
                }
            }
            .onAppear {
                if isAnimating {
                    // 延迟一帧启动，确保动画正确绑定
                    DispatchQueue.main.async {
                        isAtMaxOpacity = true
                    }
                }
            }
    }
}