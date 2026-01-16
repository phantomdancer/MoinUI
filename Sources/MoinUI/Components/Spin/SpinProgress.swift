import SwiftUI

// MARK: - SpinProgress

/// 进度圆环指示器
public struct SpinProgress: View {
    let size: CGFloat
    let percent: Double
    let color: Color
    let trackColor: Color

    private let viewSize: CGFloat = 100
    private var borderWidth: CGFloat { viewSize / 5 }
    private var radius: CGFloat { viewSize / 2 - borderWidth / 2 }
    private var circumference: CGFloat { radius * 2 * .pi }

    public init(size: CGFloat, percent: Double, color: Color, trackColor: Color) {
        self.size = size
        self.percent = max(0, min(100, percent))
        self.color = color
        self.trackColor = trackColor
    }

    public var body: some View {
        ZStack {
            // 背景轨道
            Circle()
                .stroke(trackColor, lineWidth: borderWidth * size / viewSize)

            // 进度圆弧
            Circle()
                .trim(from: 0, to: percent / 100)
                .stroke(
                    color,
                    style: StrokeStyle(
                        lineWidth: borderWidth * size / viewSize,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))  // 从顶部开始
                .animation(.easeInOut(duration: 0.3), value: percent)
        }
        .frame(width: size, height: size)
    }
}

// MARK: - SpinPercent

/// Spin percent 类型，支持数值或自动模式
public enum SpinPercent: Equatable {
    case value(Double)
    case auto

    public static func == (lhs: SpinPercent, rhs: SpinPercent) -> Bool {
        switch (lhs, rhs) {
        case (.auto, .auto):
            return true
        case (.value(let l), .value(let r)):
            return l == r
        default:
            return false
        }
    }
}

// MARK: - Preview

#Preview("SpinProgress") {
    HStack(spacing: 24) {
        SpinProgress(size: 20, percent: 25, color: .blue, trackColor: .gray.opacity(0.2))
        SpinProgress(size: 20, percent: 50, color: .blue, trackColor: .gray.opacity(0.2))
        SpinProgress(size: 20, percent: 75, color: .blue, trackColor: .gray.opacity(0.2))
        SpinProgress(size: 32, percent: 100, color: .green, trackColor: .gray.opacity(0.2))
    }
    .padding()
}
