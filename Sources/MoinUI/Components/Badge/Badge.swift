import SwiftUI

public extension Moin {
    /// 徽标组件 - 用于展示数字、状态或小红点
    struct Badge<Content: View>: View {
        @Environment(\.moinToken) private var token
        @Environment(\.colorScheme) private var colorScheme

        private let content: Content?
        private let count: Int?
        private let dot: Bool
        private let showZero: Bool
        private let overflowCount: Int
        private let status: BadgeStatus?
        private let text: String?
        private let size: BadgeSize
        private let color: BadgeColor
        private let offset: (x: CGFloat, y: CGFloat)?

        /// 创建带内容的徽标
        /// - Parameters:
        ///   - count: 显示的数字
        ///   - dot: 是否显示小红点（优先于 count）
        ///   - showZero: count 为 0 时是否显示
        ///   - overflowCount: 溢出阈值，超过显示 {overflowCount}+
        ///   - size: 尺寸
        ///   - color: 颜色
        ///   - offset: 偏移量 (x, y)
        ///   - content: 被包裹的内容
        public init(
            count: Int? = nil,
            dot: Bool = false,
            showZero: Bool = false,
            overflowCount: Int = 99,
            size: BadgeSize = .default,
            color: BadgeColor = .default,
            offset: (x: CGFloat, y: CGFloat)? = nil,
            @ViewBuilder content: () -> Content
        ) {
            self.content = content()
            self.count = count
            self.dot = dot
            self.showZero = showZero
            self.overflowCount = overflowCount
            self.status = nil
            self.text = nil
            self.size = size
            self.color = color
            self.offset = offset
        }

        public var body: some View {
            if let content = content {
                // 带内容模式
                content
                    .overlay(alignment: .topTrailing) {
                        badgeIndicator
                            .offset(x: offsetX, y: offsetY)
                    }
            } else {
                // 独立模式
                badgeIndicator
            }
        }

        @ViewBuilder
        private var badgeIndicator: some View {
            if dot {
                dotView
            } else if let count = count, (count > 0 || showZero) {
                countView(count)
            }
        }

        private var dotView: some View {
            Circle()
                .fill(badgeColor)
                .frame(width: dotSize, height: dotSize)
                .shadow(color: badgeColor.opacity(0.3), radius: 2, x: 0, y: 1)
        }

        private func countView(_ count: Int) -> some View {
            let displayText = count > overflowCount ? "\(overflowCount)+" : "\(count)"
            return Text(displayText)
                .font(.system(size: fontSize, weight: .medium))
                .foregroundStyle(.white)
                .padding(.horizontal, horizontalPadding)
                .frame(minWidth: minWidth, minHeight: height)
                .background(badgeColor)
                .clipShape(Capsule())
                .shadow(color: badgeColor.opacity(0.3), radius: 2, x: 0, y: 1)
        }

        // MARK: - Size Properties

        private var fontSize: CGFloat {
            switch size {
            case .default: return 11
            case .small: return 10
            }
        }

        private var height: CGFloat {
            switch size {
            case .default: return 18
            case .small: return 14
            }
        }

        private var minWidth: CGFloat {
            height
        }

        private var horizontalPadding: CGFloat {
            switch size {
            case .default: return 6
            case .small: return 4
            }
        }

        private var dotSize: CGFloat {
            switch size {
            case .default: return 8
            case .small: return 6
            }
        }

        private var offsetX: CGFloat {
            offset?.x ?? (height / 2)
        }

        private var offsetY: CGFloat {
            offset?.y ?? -(height / 2)
        }

        // MARK: - Color

        private var isDark: Bool { colorScheme == .dark }

        private var badgeColor: Color {
            switch color {
            case .default:
                return token.colorDanger
            case .success:
                return token.colorSuccess
            case .processing:
                return token.colorPrimary
            case .warning:
                return token.colorWarning
            case .error:
                return token.colorDanger
            case .custom(let c):
                return c
            }
        }
    }
}

// MARK: - 独立徽标（无内容）

public extension Moin.Badge where Content == EmptyView {
    /// 创建独立徽标（无子内容）
    init(
        count: Int? = nil,
        dot: Bool = false,
        showZero: Bool = false,
        overflowCount: Int = 99,
        size: BadgeSize = .default,
        color: BadgeColor = .default
    ) {
        self.content = nil
        self.count = count
        self.dot = dot
        self.showZero = showZero
        self.overflowCount = overflowCount
        self.status = nil
        self.text = nil
        self.size = size
        self.color = color
        self.offset = nil
    }
}

// MARK: - 状态徽标

public extension Moin {
    /// 状态徽标 - 带状态点和文本的独立组件
    struct StatusBadge: View {
        @Environment(\.moinToken) private var token

        private let status: BadgeStatus
        private let text: String?

        public init(status: BadgeStatus, text: String? = nil) {
            self.status = status
            self.text = text
        }

        public var body: some View {
            HStack(spacing: 6) {
                Circle()
                    .fill(statusColor)
                    .frame(width: 6, height: 6)

                if let text = text {
                    Text(text)
                        .font(.system(size: 13))
                        .foregroundStyle(token.colorText)
                }
            }
        }

        private var statusColor: Color {
            switch status {
            case .success: return token.colorSuccess
            case .processing: return token.colorPrimary
            case .default: return token.colorTextSecondary
            case .error: return token.colorDanger
            case .warning: return token.colorWarning
            }
        }
    }
}
