import SwiftUI

// MARK: - _SpinIndicator (internal name, use Spin.Indicator)

/// Ant Design 风格四点旋转指示器
public struct _SpinIndicator: View {
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
                _SpinDot(
                    size: dotItemSize,
                    color: color,
                    delay: Double(index) * 0.4,
                    isAnimating: isAnimating
                )
                .offset(x: dotOffset(for: index).x, y: dotOffset(for: index).y)
            }
        }
        .frame(width: size, height: size)
        .rotationEffect(.degrees(45 + (isAnimating ? 360 : 0)))
        .animation(
            .linear(duration: duration).repeatForever(autoreverses: false),
            value: isAnimating
        )
        .onAppear {
            isAnimating = true
        }
    }

    private var dotItemSize: CGFloat {
        (size - 2) / 2
    }

    private var offsetDistance: CGFloat {
        (size - dotItemSize) / 2
    }

    private func dotOffset(for index: Int) -> CGPoint {
        switch index {
        case 0: return CGPoint(x: -offsetDistance, y: -offsetDistance)
        case 1: return CGPoint(x: offsetDistance, y: -offsetDistance)
        case 2: return CGPoint(x: offsetDistance, y: offsetDistance)
        case 3: return CGPoint(x: -offsetDistance, y: offsetDistance)
        default: return .zero
        }
    }
}

// MARK: - _SpinDot (Internal)

/// 单个旋转点，带有 opacity 闪烁动画
private struct _SpinDot: View {
    let size: CGFloat
    let color: Color
    let delay: Double
    let isAnimating: Bool

    @State private var isAtMaxOpacity = false

    var body: some View {
        Circle()
            .fill(color)
            .frame(width: size, height: size)
            .scaleEffect(0.75)
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
                    DispatchQueue.main.async {
                        isAtMaxOpacity = true
                    }
                }
            }
    }
}


