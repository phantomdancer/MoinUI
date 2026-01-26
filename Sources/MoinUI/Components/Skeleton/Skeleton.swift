// MARK: - Moin.Skeleton

import SwiftUI

public extension Moin {
    typealias Skeleton = MoinUI.Skeleton
}

// MARK: - Skeleton

/// 骨架屏组件，用于数据加载时的占位显示
///
/// ## 功能特点
/// - 支持动画效果
/// - 支持头像、标题、段落组合
/// - 支持圆角模式
/// - 支持 loading 条件渲染
///
/// ## 使用示例
/// ```swift
/// // 基础骨架屏
/// Skeleton()
///
/// // 带动画
/// Skeleton(active: true)
///
/// // 带头像
/// Skeleton(avatar: true, active: true)
///
/// // 子组件
/// Skeleton.Avatar(active: true)
/// Skeleton.Button(shape: .round, active: true)
///
/// // 条件渲染
/// Skeleton(loading: isLoading) {
///     Text("Content loaded")
/// }
/// ```
public struct Skeleton: View {
    // MARK: - Properties

    /// 是否显示动画
    let active: Bool
    /// 是否显示头像
    let avatar: AvatarConfig?
    /// 是否显示标题
    let title: TitleConfig?
    /// 是否显示段落
    let paragraph: ParagraphConfig?
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
        title: TitleConfig?,
        paragraph: ParagraphConfig?,
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
                Skeleton.Avatar(
                    size: avatarConfig.size,
                    shape: avatarConfig.shape,
                    active: active
                )
            }

            // 标题和段落
            VStack(alignment: .leading, spacing: 0) {
                // 标题
                if let titleConfig = title {
                    Skeleton.Block(
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
                        Skeleton.Block(
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

    private func paragraphWidth(for index: Int, total: Int, config: ParagraphConfig) -> CGFloat? {
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

// MARK: - Skeleton.AvatarConfig

public extension Skeleton {
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

// MARK: - Skeleton.TitleConfig

public extension Skeleton {
    struct TitleConfig {
        public let width: CGFloat?

        public init(width: CGFloat? = nil) {
            self.width = width
        }

        public static let `default` = TitleConfig()
    }
}

// MARK: - Skeleton.ParagraphConfig

public extension Skeleton {
    struct ParagraphConfig {
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

        public static let `default` = ParagraphConfig()
    }
}

// MARK: - Skeleton.Size

public extension Skeleton {
    enum Size {
        case small
        case `default`
        case large
        case custom(CGFloat)

        func avatarSize(from token: Moin.SkeletonToken) -> CGFloat {
            switch self {
            case .small: return token.avatarSizeSM
            case .default: return token.avatarSize
            case .large: return token.avatarSizeLG
            case .custom(let size): return size
            }
        }

        func buttonHeight(from token: Moin.SkeletonToken) -> CGFloat {
            switch self {
            case .small: return token.buttonHeightSM
            case .default: return token.buttonHeight
            case .large: return token.buttonHeightLG
            case .custom(let size): return size
            }
        }

        func inputHeight(from token: Moin.SkeletonToken) -> CGFloat {
            switch self {
            case .small: return token.inputHeightSM
            case .default: return token.inputHeight
            case .large: return token.inputHeightLG
            case .custom(let size): return size
            }
        }
    }
}

// MARK: - Skeleton.AvatarShape

public extension Skeleton {
    enum AvatarShape {
        case circle
        case square
    }
}

// MARK: - Skeleton.ButtonShape

public extension Skeleton {
    enum ButtonShape {
        case `default`
        case circle
        case round
        case square
    }
}

// MARK: - Skeleton.Avatar

public extension Skeleton {
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
                skeletonBackground(token: token, active: active)
                    .frame(width: avatarSize, height: avatarSize)
                    .clipShape(Circle())
            } else {
                skeletonBackground(token: token, active: active)
                    .frame(width: avatarSize, height: avatarSize)
                    .clipShape(RoundedRectangle(cornerRadius: token.blockRadius))
            }
        }
    }
}

// MARK: - Skeleton.Button

public extension Skeleton {
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

            skeletonBackground(token: token, active: active)
                .frame(width: width, height: height)
                .frame(maxWidth: block ? .infinity : nil)
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        }
    }
}

// MARK: - Skeleton.Input

public extension Skeleton {
    /// 输入框骨架元素
    struct Input: View {
        let size: Size
        let active: Bool

        @Environment(\.moinToken) private var globalToken
        @ObservedObject private var config = Moin.ConfigProvider.shared

        public init(
            size: Size = .default,
            active: Bool = false
        ) {
            self.size = size
            self.active = active
        }

        public var body: some View {
            let token = config.components.skeleton
            let height = size.inputHeight(from: token)

            skeletonBackground(token: token, active: active)
                .frame(height: height)
                .frame(maxWidth: .infinity)
                .clipShape(RoundedRectangle(cornerRadius: token.blockRadius))
        }
    }
}

// MARK: - Skeleton.Image

public extension Skeleton {
    /// 图片骨架元素
    struct Image: View {
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

            skeletonBackground(token: token, active: active)
                .frame(width: width ?? 96, height: height ?? 96)
                .clipShape(RoundedRectangle(cornerRadius: token.blockRadius))
        }
    }
}

// MARK: - Skeleton.Block

public extension Skeleton {
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
                skeletonBackground(token: token, active: active)
                    .frame(width: width, height: height)
                    .clipShape(RoundedRectangle(cornerRadius: radius))
            } else {
                GeometryReader { geometry in
                    skeletonBackground(token: token, active: active)
                        .frame(width: geometry.size.width, height: height)
                        .clipShape(RoundedRectangle(cornerRadius: radius))
                }
                .frame(height: height)
            }
        }
    }
}

// MARK: - Skeleton Background Helper

@ViewBuilder
private func skeletonBackground(token: Moin.SkeletonToken, active: Bool) -> some View {
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
