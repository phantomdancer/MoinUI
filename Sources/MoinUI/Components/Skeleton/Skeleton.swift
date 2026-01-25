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
/// // 条件渲染
/// Skeleton(loading: isLoading) {
///     Text("Content loaded")
/// }
/// ```
public struct Skeleton<Content: View>: View {
    // MARK: - Properties

    /// 是否显示动画
    let active: Bool
    /// 是否显示头像
    let avatar: SkeletonAvatarConfig?
    /// 是否显示标题
    let title: SkeletonTitleConfig?
    /// 是否显示段落
    let paragraph: SkeletonParagraphConfig?
    /// 是否圆角
    let round: Bool
    /// 是否加载中（控制是否显示骨架屏）
    let loading: Bool
    /// 实际内容
    let content: Content?

    @Environment(\.moinToken) private var globalToken
    @ObservedObject private var config = Moin.ConfigProvider.shared

    // MARK: - Init (基础)

    public init(
        active: Bool = false,
        avatar: Bool = false,
        title: Bool = true,
        paragraph: Bool = true,
        round: Bool = false
    ) where Content == EmptyView {
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
        avatar: SkeletonAvatarConfig?,
        title: SkeletonTitleConfig?,
        paragraph: SkeletonParagraphConfig?,
        round: Bool = false
    ) where Content == EmptyView {
        self.active = active
        self.avatar = avatar
        self.title = title
        self.paragraph = paragraph
        self.round = round
        self.loading = true
        self.content = nil
    }

    // MARK: - Init (条件渲染)

    public init(
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
        self.content = content()
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
                SkeletonElement.avatar(
                    size: avatarConfig.size,
                    shape: avatarConfig.shape,
                    active: active
                )
            }

            // 标题和段落
            VStack(alignment: .leading, spacing: 0) {
                // 标题
                if let titleConfig = title {
                    SkeletonElement.block(
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
                        SkeletonElement.block(
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

    private func paragraphWidth(for index: Int, total: Int, config: SkeletonParagraphConfig) -> CGFloat? {
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

// MARK: - Avatar Config

public struct SkeletonAvatarConfig {
    public let size: SkeletonSize
    public let shape: SkeletonAvatarShape

    public init(size: SkeletonSize = .default, shape: SkeletonAvatarShape = .circle) {
        self.size = size
        self.shape = shape
    }

    public static let `default` = SkeletonAvatarConfig()
}

// MARK: - Title Config

public struct SkeletonTitleConfig {
    public let width: CGFloat?

    public init(width: CGFloat? = nil) {
        self.width = width
    }

    public static let `default` = SkeletonTitleConfig()
}

// MARK: - Paragraph Config

public struct SkeletonParagraphConfig {
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

    public static let `default` = SkeletonParagraphConfig()
}

// MARK: - Size

public enum SkeletonSize {
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

// MARK: - Avatar Shape

public enum SkeletonAvatarShape {
    case circle
    case square
}

// MARK: - Button Shape

public enum SkeletonButtonShape {
    case `default`
    case circle
    case round
    case square
}

// MARK: - Preview

#Preview("Skeleton") {
    VStack(spacing: 32) {
        Skeleton()
        Skeleton(active: true)
        Skeleton(active: true, avatar: true)
        Skeleton(active: true, round: true)
    }
    .padding()
    .frame(width: 400)
}
