import SwiftUI

// MARK: - Skeleton Background Helper

@ViewBuilder
func _skeletonBackground(token: Moin.SkeletonToken, active: Bool) -> some View {
    if active {
        TimelineView(.animation) { timeline in
            let phase = timeline.date.timeIntervalSinceReferenceDate.truncatingRemainder(dividingBy: token.motionDuration) / token.motionDuration

            Rectangle()
                .fill(token.color)
                .overlay(
                    GeometryReader { geometry in
                        let shimmerWidth = max(geometry.size.width * 0.5, 60)
                        let totalTravel = geometry.size.width + shimmerWidth

                        Rectangle()
                            .fill(
                                LinearGradient(
                                    colors: [
                                        .clear,
                                        token.colorGradientEnd.opacity(0.5),
                                        .clear
                                    ],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .frame(width: shimmerWidth)
                            .offset(x: -shimmerWidth + phase * totalTravel)
                    }
                    .clipped()
                )
        }
    } else {
        Rectangle()
            .fill(token.color)
    }
}

// MARK: - _Skeleton (internal name, use Moin.Skeleton.View)

/// 骨架屏组件，用于数据加载时的占位显示
public struct _Skeleton: View {
    // MARK: - Properties

    /// 是否显示动画
    let active: Bool
    /// 是否显示头像
    let avatar: AvatarConfig?
    /// 是否显示标题
    let title: TitleProps?
    /// 是否显示段落
    let paragraph: ParagraphProps?
    /// 是否圆角
    let round: Bool
    /// 是否加载中（控制是否显示骨架屏）
    let loading: Bool
    /// 实际内容
    let content: AnyView?

    @Environment(\.moinToken) private var globalToken
    @ObservedObject private var config = Moin.ConfigProvider.shared

    // MARK: - Init (基础)

    public init(
        active: Bool = false,
        avatar: Bool = false,
        title: Bool = true,
        paragraph: Bool = true,
        round: Bool = false
    ) {
        self.active = active
        self.avatar = avatar ? .default : nil
        self.title = title ? .default : nil
        self.paragraph = paragraph ? .default : nil
        self.round = round
        self.loading = true
        self.content = nil
    }

    // MARK: - Init (详细配置)

    public init(
        active: Bool = false,
        avatar: AvatarConfig?,
        title: TitleProps?,
        paragraph: ParagraphProps?,
        round: Bool = false
    ) {
        self.active = active
        self.avatar = avatar
        self.title = title
        self.paragraph = paragraph
        self.round = round
        self.loading = true
        self.content = nil
    }

    // MARK: - Init (条件渲染)

    public init<Content: View>(
        loading: Bool,
        active: Bool = false,
        avatar: Bool = false,
        title: Bool = true,
        paragraph: Bool = true,
        round: Bool = false,
        @ViewBuilder content: () -> Content
    ) {
        self.active = active
        self.avatar = avatar ? .default : nil
        self.title = title ? .default : nil
        self.paragraph = paragraph ? .default : nil
        self.round = round
        self.loading = loading
        self.content = AnyView(content())
    }

    // MARK: - Body

    public var body: some View {
        let skeletonToken = config.components.skeleton

        if loading {
            skeletonView(token: skeletonToken)
        } else if let content = content {
            content
        }
    }

    // MARK: - Views

    @ViewBuilder
    private func skeletonView(token: Moin.SkeletonToken) -> some View {
        HStack(alignment: .top, spacing: 16) {
            // 头像
            if let avatarConfig = avatar {
                _Skeleton.Avatar(
                    size: avatarConfig.size,
                    shape: avatarConfig.shape,
                    active: active
                )
            }

            // 标题和段落
            VStack(alignment: .leading, spacing: 0) {
                // 标题
                if let titleConfig = title {
                    _Skeleton.Block(
                        width: titleConfig.width ?? (avatar != nil ? 200 : 300),
                        height: token.titleHeight,
                        radius: round ? token.titleHeight / 2 : token.blockRadius,
                        active: active
                    )
                }

                // 段落
                if let paragraphConfig = paragraph {
                    let rows = paragraphConfig.rows ?? (title != nil ? 3 : 4)
                    ForEach(0..<rows, id: \.self) { index in
                        _Skeleton.Block(
                            width: paragraphWidth(for: index, total: rows, config: paragraphConfig),
                            height: token.paragraphLineHeight,
                            radius: round ? token.paragraphLineHeight / 2 : token.blockRadius,
                            active: active
                        )
                        .padding(.top, index == 0 && title != nil ? token.paragraphLineMarginTop : (index == 0 ? 0 : 16))
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }

    // MARK: - Private

    private func paragraphWidth(for index: Int, total: Int, config: ParagraphProps) -> CGFloat? {
        if let widths = config.widths, index < widths.count {
            return widths[index]
        }
        if let width = config.width, index == total - 1 {
            return width
        }
        // 最后一行默认 60%
        if index == total - 1 {
            return nil // 使用 maxWidth 的 60%
        }
        return nil // 使用 maxWidth
    }
}

// MARK: - _Skeleton.AvatarConfig

public extension _Skeleton {
    struct AvatarConfig {
        public let size: Size
        public let shape: AvatarShape

        public init(size: Size = .default, shape: AvatarShape = .circle) {
            self.size = size
            self.shape = shape
        }

        public static let `default` = AvatarConfig()
    }
}

// MARK: - _Skeleton.TitleConfig

public extension _Skeleton {
    struct TitleProps {
        public let width: CGFloat?

        public init(width: CGFloat? = nil) {
            self.width = width
        }

        public static let `default` = TitleProps()
    }
}

// MARK: - _Skeleton.ParagraphConfig

public extension _Skeleton {
    struct ParagraphProps {
        public let rows: Int?
        public let width: CGFloat?
        public let widths: [CGFloat]?

        public init(rows: Int? = nil, width: CGFloat? = nil) {
            self.rows = rows
            self.width = width
            self.widths = nil
        }

        public init(rows: Int? = nil, widths: [CGFloat]) {
            self.rows = rows
            self.width = nil
            self.widths = widths
        }

        public static let `default` = ParagraphProps()
    }
}

// MARK: - _Skeleton.Size

public extension _Skeleton {
    /// 骨架屏尺寸
    struct Size: ExpressibleByIntegerLiteral, ExpressibleByFloatLiteral {
        public let rawValue: CGFloat

        public init(_ value: CGFloat) {
            rawValue = value
        }

        public init(integerLiteral value: Int) {
            rawValue = CGFloat(value)
        }

        public init(floatLiteral value: Double) {
            rawValue = CGFloat(value)
        }

        /// 小尺寸
        public static let small = Size(24)
        /// 默认尺寸
        public static let `default` = Size(32)
        /// 大尺寸
        public static let large = Size(40)

        func avatarSize(from token: Moin.SkeletonToken) -> CGFloat {
            if rawValue == Self.small.rawValue { return token.avatarSizeSM }
            if rawValue == Self.`default`.rawValue { return token.avatarSize }
            if rawValue == Self.large.rawValue { return token.avatarSizeLG }
            return rawValue
        }

        func buttonHeight(from token: Moin.SkeletonToken) -> CGFloat {
            if rawValue == Self.small.rawValue { return token.buttonHeightSM }
            if rawValue == Self.`default`.rawValue { return token.buttonHeight }
            if rawValue == Self.large.rawValue { return token.buttonHeightLG }
            return rawValue
        }

        func inputHeight(from token: Moin.SkeletonToken) -> CGFloat {
            if rawValue == Self.small.rawValue { return token.inputHeightSM }
            if rawValue == Self.`default`.rawValue { return token.inputHeight }
            if rawValue == Self.large.rawValue { return token.inputHeightLG }
            return rawValue
        }
    }
}

// MARK: - _Skeleton.AvatarShape

public extension _Skeleton {
    enum AvatarShape {
        case circle
        case square
    }
}

// MARK: - _Skeleton.ButtonShape

public extension _Skeleton {
    enum ButtonShape {
        case `default`
        case circle
        case round
        case square
    }
}

// MARK: - _Skeleton.Avatar

public extension _Skeleton {
    /// 头像骨架元素
    struct Avatar: View {
        let size: Size
        let shape: AvatarShape
        let active: Bool

        @Environment(\.moinToken) private var globalToken
        @ObservedObject private var config = Moin.ConfigProvider.shared

        public init(
            size: Size = .default,
            shape: AvatarShape = .circle,
            active: Bool = false
        ) {
            self.size = size
            self.shape = shape
            self.active = active
        }

        public var body: some View {
            let token = config.components.skeleton
            let avatarSize = size.avatarSize(from: token)

            if shape == .circle {
                _skeletonBackground(token: token, active: active)
                    .frame(width: avatarSize, height: avatarSize)
                    .clipShape(Circle())
            } else {
                _skeletonBackground(token: token, active: active)
                    .frame(width: avatarSize, height: avatarSize)
                    .clipShape(RoundedRectangle(cornerRadius: token.blockRadius))
            }
        }
    }
}

// MARK: - _Skeleton.Button

public extension _Skeleton {
    /// 按钮骨架元素
    struct Button: View {
        let size: Size
        let shape: ButtonShape
        let block: Bool
        let active: Bool

        @Environment(\.moinToken) private var globalToken
        @ObservedObject private var config = Moin.ConfigProvider.shared

        public init(
            size: Size = .default,
            shape: ButtonShape = .default,
            block: Bool = false,
            active: Bool = false
        ) {
            self.size = size
            self.shape = shape
            self.block = block
            self.active = active
        }

        public var body: some View {
            let token = config.components.skeleton
            let height = size.buttonHeight(from: token)
            let width: CGFloat? = {
                switch shape {
                case .circle: return height
                case .default, .round, .square: return block ? nil : 66
                }
            }()
            let cornerRadius: CGFloat = {
                switch shape {
                case .circle: return height / 2
                case .round: return height / 2
                case .square: return 0
                case .default: return token.blockRadius
                }
            }()

            _skeletonBackground(token: token, active: active)
            .frame(width: width, height: height)
            .frame(maxWidth: block ? .infinity : nil)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        }
    }
}

// MARK: - _Skeleton.Input

public extension _Skeleton {
    /// 输入框骨架元素
    struct Input: View {
        let size: Size
        let block: Bool
        let active: Bool

        @Environment(\.moinToken) private var globalToken
        @ObservedObject private var config = Moin.ConfigProvider.shared

        public init(
            size: Size = .default,
            block: Bool = false,
            active: Bool = false
        ) {
            self.size = size
            self.block = block
            self.active = active
        }

        public var body: some View {
            let token = config.components.skeleton
            let height = size.inputHeight(from: token)
            let width: CGFloat? = block ? nil : 200

            _skeletonBackground(token: token, active: active)
            .frame(width: width, height: height)
            .frame(maxWidth: block ? .infinity : nil)
            .clipShape(RoundedRectangle(cornerRadius: token.blockRadius))
        }
    }
}

// MARK: - _Skeleton.Image

public extension _Skeleton {
    /// 图片骨架元素
    struct SkeletonImage: View {
        let width: CGFloat?
        let height: CGFloat?
        let active: Bool

        @Environment(\.moinToken) private var globalToken
        @ObservedObject private var config = Moin.ConfigProvider.shared

        public init(
            width: CGFloat? = nil,
            height: CGFloat? = nil,
            active: Bool = false
        ) {
            self.width = width
            self.height = height
            self.active = active
        }

        public var body: some View {
            let token = config.components.skeleton

            _skeletonBackground(token: token, active: active)
            .frame(width: width ?? 96, height: height ?? 96)
            .clipShape(RoundedRectangle(cornerRadius: token.blockRadius))
        }
    }
}

// MARK: - _Skeleton.Node

public extension _Skeleton {
    /// 自定义骨架节点，支持传入任意子视图
    struct Node: View {
        let active: Bool
        let content: AnyView?

        @Environment(\.moinToken) private var globalToken
        @ObservedObject private var config = Moin.ConfigProvider.shared

        public init(active: Bool = false) {
            self.active = active
            self.content = nil
        }

        public init<Content: View>(active: Bool = false, @ViewBuilder content: () -> Content) {
            self.active = active
            self.content = AnyView(content())
        }

        public var body: some View {
            let token = config.components.skeleton

            if let content = content {
                if active {
                    content.overlay(_skeletonBackground(token: token, active: true).opacity(0.5))
                } else {
                    content
                }
            } else {
                _skeletonBackground(token: token, active: active)
                .frame(width: 96, height: 96)
                .clipShape(RoundedRectangle(cornerRadius: token.blockRadius))
            }
        }
    }
}

// MARK: - _Skeleton.Block

public extension _Skeleton {
    /// 基础块骨架元素
    struct Block: View {
        let width: CGFloat?
        let height: CGFloat
        let radius: CGFloat
        let active: Bool

        @Environment(\.moinToken) private var globalToken
        @ObservedObject private var config = Moin.ConfigProvider.shared

        public init(
            width: CGFloat? = nil,
            height: CGFloat,
            radius: CGFloat = 4,
            active: Bool = false
        ) {
            self.width = width
            self.height = height
            self.radius = radius
            self.active = active
        }

        public var body: some View {
            let token = config.components.skeleton

            if let width = width {
                _skeletonBackground(token: token, active: active)
                .frame(width: width, height: height)
                .clipShape(RoundedRectangle(cornerRadius: radius))
            } else {
                GeometryReader { geometry in
                    _skeletonBackground(token: token, active: active)
                    .frame(width: geometry.size.width, height: height)
                    .clipShape(RoundedRectangle(cornerRadius: radius))
                }
                .frame(height: height)
            }
        }
    }
}
