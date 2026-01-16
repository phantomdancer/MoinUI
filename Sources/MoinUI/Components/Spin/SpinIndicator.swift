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
                Circle()
                    .fill(color)
                    .frame(width: dotItemSize, height: dotItemSize)
                    .offset(x: dotOffset(for: index).x, y: dotOffset(for: index).y)
                    .opacity(dotOpacity(for: index))
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

    /// 单个点的尺寸 (约为整体的 40%)
    private var dotItemSize: CGFloat {
        (size - size * 0.1) / 2.5
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

    /// 每个点的基础透明度 (交替闪烁效果)
    private func dotOpacity(for index: Int) -> Double {
        // 0.3 → 0.5 → 0.7 → 1.0 依次递增
        let base = 0.3 + Double(index) * 0.233
        return min(base, 1.0)
    }
}

// MARK: - Preview

#Preview("SpinIndicator Sizes") {
    HStack(spacing: 40) {
        VStack {
            SpinIndicator(size: 14, color: .blue)
            Text("Small")
        }
        VStack {
            SpinIndicator(size: 20, color: .blue)
            Text("Default")
        }
        VStack {
            SpinIndicator(size: 32, color: .blue)
            Text("Large")
        }
    }
    .padding()
}
