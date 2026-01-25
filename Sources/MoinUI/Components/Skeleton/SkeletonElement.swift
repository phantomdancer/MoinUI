// MARK: - SkeletonElement

import SwiftUI

/// 骨架屏元素组件
///
/// 提供独立的骨架屏元素，如头像、按钮、输入框、图片等
public struct SkeletonElement: View {
    // MARK: - Properties

    let type: ElementType
    let active: Bool

    @Environment(\.moinToken) private var globalToken
    @ObservedObject private var config = Moin.ConfigProvider.shared
    @State private var animationPhase: CGFloat = 0

    // MARK: - Element Type

    enum ElementType {
        case avatar(size: SkeletonSize, shape: SkeletonAvatarShape)
        case button(size: SkeletonSize, shape: SkeletonButtonShape, block: Bool)
        case input(size: SkeletonSize)
        case image(width: CGFloat?, height: CGFloat?)
        case block(width: CGFloat?, height: CGFloat, radius: CGFloat)
    }

    // MARK: - Init

    private init(type: ElementType, active: Bool) {
        self.type = type
        self.active = active
    }

    // MARK: - Static Constructors

    /// 头像骨架
    public static func avatar(
        size: SkeletonSize = .default,
        shape: SkeletonAvatarShape = .circle,
        active: Bool = false
    ) -> SkeletonElement {
        SkeletonElement(type: .avatar(size: size, shape: shape), active: active)
    }

    /// 按钮骨架
    public static func button(
        size: SkeletonSize = .default,
        shape: SkeletonButtonShape = .default,
        block: Bool = false,
        active: Bool = false
    ) -> SkeletonElement {
        SkeletonElement(type: .button(size: size, shape: shape, block: block), active: active)
    }

    /// 输入框骨架
    public static func input(
        size: SkeletonSize = .default,
        active: Bool = false
    ) -> SkeletonElement {
        SkeletonElement(type: .input(size: size), active: active)
    }

    /// 图片骨架
    public static func image(
        width: CGFloat? = nil,
        height: CGFloat? = nil,
        active: Bool = false
    ) -> SkeletonElement {
        SkeletonElement(type: .image(width: width, height: height), active: active)
    }

    /// 基础块骨架
    public static func block(
        width: CGFloat? = nil,
        height: CGFloat,
        radius: CGFloat = 4,
        active: Bool = false
    ) -> SkeletonElement {
        SkeletonElement(type: .block(width: width, height: height, radius: radius), active: active)
    }

    // MARK: - Body

    public var body: some View {
        let token = config.components.skeleton

        elementView(token: token)
            .onAppear {
                if active {
                    withAnimation(.linear(duration: token.motionDuration).repeatForever(autoreverses: false)) {
                        animationPhase = 1
                    }
                }
            }
    }

    // MARK: - Views

    @ViewBuilder
    private func elementView(token: Moin.SkeletonToken) -> some View {
        switch type {
        case .avatar(let size, let shape):
            avatarView(size: size, shape: shape, token: token)

        case .button(let size, let shape, let block):
            buttonView(size: size, shape: shape, block: block, token: token)

        case .input(let size):
            inputView(size: size, token: token)

        case .image(let width, let height):
            imageView(width: width, height: height, token: token)

        case .block(let width, let height, let radius):
            blockView(width: width, height: height, radius: radius, token: token)
        }
    }

    @ViewBuilder
    private func avatarView(size: SkeletonSize, shape: SkeletonAvatarShape, token: Moin.SkeletonToken) -> some View {
        let avatarSize = size.avatarSize(from: token)

        if shape == .circle {
            skeletonBackground(token: token)
                .frame(width: avatarSize, height: avatarSize)
                .clipShape(Circle())
        } else {
            skeletonBackground(token: token)
                .frame(width: avatarSize, height: avatarSize)
                .clipShape(RoundedRectangle(cornerRadius: token.blockRadius))
        }
    }

    @ViewBuilder
    private func buttonView(size: SkeletonSize, shape: SkeletonButtonShape, block: Bool, token: Moin.SkeletonToken) -> some View {
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

        skeletonBackground(token: token)
            .frame(width: width, height: height)
            .frame(maxWidth: block ? .infinity : nil)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
    }

    @ViewBuilder
    private func inputView(size: SkeletonSize, token: Moin.SkeletonToken) -> some View {
        let height = size.inputHeight(from: token)

        skeletonBackground(token: token)
            .frame(height: height)
            .frame(maxWidth: .infinity)
            .clipShape(RoundedRectangle(cornerRadius: token.blockRadius))
    }

    @ViewBuilder
    private func imageView(width: CGFloat?, height: CGFloat?, token: Moin.SkeletonToken) -> some View {
        skeletonBackground(token: token)
            .frame(width: width ?? 96, height: height ?? 96)
            .clipShape(RoundedRectangle(cornerRadius: token.blockRadius))
    }

    @ViewBuilder
    private func blockView(width: CGFloat?, height: CGFloat, radius: CGFloat, token: Moin.SkeletonToken) -> some View {
        if let width = width {
            skeletonBackground(token: token)
                .frame(width: width, height: height)
                .clipShape(RoundedRectangle(cornerRadius: radius))
        } else {
            GeometryReader { geometry in
                skeletonBackground(token: token)
                    .frame(width: geometry.size.width, height: height)
                    .clipShape(RoundedRectangle(cornerRadius: radius))
            }
            .frame(height: height)
        }
    }

    @ViewBuilder
    private func skeletonBackground(token: Moin.SkeletonToken) -> some View {
        if active {
            Rectangle()
                .fill(
                    LinearGradient(
                        colors: [token.color, token.colorGradientEnd, token.color],
                        startPoint: UnitPoint(x: animationPhase - 1, y: 0.5),
                        endPoint: UnitPoint(x: animationPhase, y: 0.5)
                    )
                )
        } else {
            Rectangle()
                .fill(token.color)
        }
    }
}

// MARK: - Preview

#Preview("SkeletonElement") {
    VStack(spacing: 24) {
        HStack(spacing: 16) {
            SkeletonElement.avatar(active: true)
            SkeletonElement.avatar(shape: .square, active: true)
            SkeletonElement.avatar(size: .large, active: true)
        }

        HStack(spacing: 16) {
            SkeletonElement.button(active: true)
            SkeletonElement.button(shape: .circle, active: true)
            SkeletonElement.button(shape: .round, active: true)
        }

        SkeletonElement.input(active: true)
            .frame(width: 200)

        SkeletonElement.image(active: true)
    }
    .padding()
}
