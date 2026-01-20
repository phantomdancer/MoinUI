import SwiftUI

public extension Moin {
    /// 徽标组件 - 用于展示数字、状态或小红点
    struct Badge<Content: View, CountView: View>: View {
        @Environment(\.moinToken) private var token
        @Environment(\.moinBadgeToken) private var badgeToken
        @Environment(\.colorScheme) private var colorScheme

        private let content: Content?
        private let countNumber: Int?
        private let countView: CountView?
        private let dot: Bool
        private let showZero: Bool
        private let overflowCount: Int
        private let size: BadgeSize
        private let color: Moin.BadgeColor
        private let offset: (x: CGFloat, y: CGFloat)?
        private let status: BadgeStatus?
        private let text: String?

        /// 创建带数字的徽标
        public init(
            count: Int? = nil,
            dot: Bool = false,
            showZero: Bool = false,
            overflowCount: Int = 99,
            size: BadgeSize = .default,
            color: Moin.BadgeColor = .default,
            offset: (x: CGFloat, y: CGFloat)? = nil,
            @ViewBuilder content: () -> Content
        ) where CountView == EmptyView {
            self.content = content()
            self.countNumber = count
            self.countView = nil
            self.dot = dot
            self.showZero = showZero
            self.overflowCount = overflowCount
            self.size = size
            self.color = color
            self.offset = offset
            self.status = nil
            self.text = nil
        }

        /// 创建带自定义指示器的徽标（类似 Ant Design count={<Icon/>}）
        public init(
            count: @escaping () -> CountView,
            size: BadgeSize = .default,
            offset: (x: CGFloat, y: CGFloat)? = nil,
            @ViewBuilder content: () -> Content
        ) {
            self.content = content()
            self.countNumber = nil
            self.countView = count()
            self.dot = false
            self.showZero = false
            self.overflowCount = 99
            self.size = size
            self.color = .default
            self.offset = offset
            self.status = nil
            self.text = nil
        }

        public var body: some View {
            if let content = content {
                // 带内容模式
                content
                    .overlay(alignment: .topTrailing) {
                        badgeIndicator
                            .offset(x: offsetX, y: offsetY)
                    }
            } else if let status = status {
                // 状态模式（独立使用）
                statusView(status)
            } else {
                // 独立徽标模式
                badgeIndicator
            }
        }

        @ViewBuilder
        private var badgeIndicator: some View {
            if let countView = countView {
                // 自定义指示器
                countView
            } else if dot {
                dotView
            } else if let count = countNumber, (count > 0 || showZero) {
                numberView(count)
            }
        }

        private var dotView: some View {
            Circle()
                .fill(resolvedBadgeColor)
                .frame(width: dotSize, height: dotSize)
                .shadow(color: resolvedBadgeColor.opacity(badgeToken.shadowOpacity), radius: badgeToken.shadowRadius, x: 0, y: 1)
        }

        private func numberView(_ count: Int) -> some View {
            let displayText = count > overflowCount ? "\(overflowCount)+" : "\(count)"
            return Text(displayText)
                .font(.system(size: fontSize, weight: badgeToken.textFontWeight))
                .foregroundStyle(badgeToken.textColor)
                .lineLimit(1)
                .fixedSize()
                .padding(.horizontal, horizontalPadding)
                .frame(minWidth: minWidth, minHeight: height)
                .background(resolvedBadgeColor)
                .clipShape(Capsule())
                .shadow(color: resolvedBadgeColor.opacity(badgeToken.shadowOpacity), radius: badgeToken.shadowRadius, x: 0, y: 1)
        }

        private func statusView(_ status: BadgeStatus) -> some View {
            HStack(spacing: 6) {
                Circle()
                    .fill(statusColor(status))
                    .frame(width: badgeToken.statusSize, height: badgeToken.statusSize)

                if let text = text {
                    Text(text)
                        .font(.system(size: 13))
                        .foregroundStyle(token.colorText)
                }
            }
        }

        private func statusColor(_ status: BadgeStatus) -> Color {
            switch status {
            case .success: return token.colorSuccess
            case .processing: return token.colorPrimary
            case .default: return token.colorTextSecondary
            case .error: return token.colorDanger
            case .warning: return token.colorWarning
            }
        }

        // MARK: - Size Properties (from Token)

        private var fontSize: CGFloat {
            switch size {
            case .default: return badgeToken.textFontSize
            case .small: return badgeToken.textFontSizeSM
            }
        }

        private var height: CGFloat {
            switch size {
            case .default: return badgeToken.indicatorHeight
            case .small: return badgeToken.indicatorHeightSM
            }
        }

        private var minWidth: CGFloat {
            height
        }

        private var horizontalPadding: CGFloat {
            switch size {
            case .default: return badgeToken.paddingH
            case .small: return badgeToken.paddingHSM
            }
        }

        private var dotSize: CGFloat {
            switch size {
            case .default: return badgeToken.dotSize
            case .small: return badgeToken.dotSizeSM
            }
        }

        private var offsetX: CGFloat {
            if let x = offset?.x { return x }
            // dot 模式使用自身尺寸的一半，数字模式使用高度的一半
            return dot ? (dotSize / 2) : (height / 2)
        }

        private var offsetY: CGFloat {
            if let y = offset?.y { return y }
            // dot 模式使用自身尺寸的一半，数字模式使用高度的一半
            return dot ? -(dotSize / 2) : -(height / 2)
        }

        // MARK: - Color

        private var isDark: Bool { colorScheme == .dark }

        private var resolvedBadgeColor: Color {
            switch color {
            case .default:
                return badgeToken.badgeColor
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

public extension Moin.Badge where Content == EmptyView, CountView == EmptyView {
    /// 创建独立徽标（无子内容）
    init(
        count: Int? = nil,
        dot: Bool = false,
        showZero: Bool = false,
        overflowCount: Int = 99,
        size: BadgeSize = .default,
        color: Moin.BadgeColor = .default
    ) {
        self.content = nil
        self.countNumber = count
        self.countView = nil
        self.dot = dot
        self.showZero = showZero
        self.overflowCount = overflowCount
        self.size = size
        self.color = color
        self.offset = nil
        self.status = nil
        self.text = nil
    }

    /// 创建状态徽标（独立使用，类似 Ant Design）
    init(status: BadgeStatus, text: String? = nil) {
        self.content = nil
        self.countNumber = nil
        self.countView = nil
        self.dot = false
        self.showZero = false
        self.overflowCount = 99
        self.size = .default
        self.color = .default
        self.offset = nil
        self.status = status
        self.text = text
    }
}

// MARK: - StatusBadge (别名，保持兼容)

public extension Moin {
    /// 状态徽标 - Badge(status:text:) 的别名
    @available(*, deprecated, message: "Use Moin.Badge(status:text:) instead")
    struct StatusBadge: View {
        private let status: BadgeStatus
        private let text: String?

        public init(status: BadgeStatus, text: String? = nil) {
            self.status = status
            self.text = text
        }

        public var body: some View {
            Moin.Badge(status: status, text: text)
        }
    }
}
