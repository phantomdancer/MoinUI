import SwiftUI

// MARK: - Environment Keys for Group Context

private struct AvatarGroupSizeKey: EnvironmentKey {
    static let defaultValue: AvatarSize? = nil
}

private struct AvatarGroupShapeKey: EnvironmentKey {
    static let defaultValue: AvatarShape? = nil
}

private struct AvatarGroupGapKey: EnvironmentKey {
    static let defaultValue: CGFloat? = nil
}

extension EnvironmentValues {
    var avatarGroupSize: AvatarSize? {
        get { self[AvatarGroupSizeKey.self] }
        set { self[AvatarGroupSizeKey.self] = newValue }
    }

    var avatarGroupShape: AvatarShape? {
        get { self[AvatarGroupShapeKey.self] }
        set { self[AvatarGroupShapeKey.self] = newValue }
    }

    var avatarGroupGap: CGFloat? {
        get { self[AvatarGroupGapKey.self] }
        set { self[AvatarGroupGapKey.self] = newValue }
    }
}

// MARK: - AvatarGroup

public extension Moin {
    /// 头像组 - 用于展示一组头像
    struct AvatarGroup<Content: View>: View {
        @Environment(\EnvironmentValues.moinAvatarToken) private var avatarToken
        @Environment(\.moinToken) private var globalToken

        private let maxCount: Int?
        private let content: Content
        private let size: AvatarSize
        private let shape: AvatarShape
        private let gap: CGFloat

        /// 创建头像组
        /// - Parameters:
        ///   - maxCount: 最大显示数量，超出显示 +N
        ///   - size: 统一尺寸 (会覆盖子元素尺寸)
        ///   - shape: 统一形状 (会覆盖子元素形状)
        ///   - gap: 文字距边界间距
        ///   - content: 头像列表
        public init(
            maxCount: Int? = nil,
            size: AvatarSize = .default,
            shape: AvatarShape = .circle,
            gap: CGFloat = 4,
            @ViewBuilder content: () -> Content
        ) {
            self.maxCount = maxCount
            self.size = size
            self.shape = shape
            self.gap = gap
            self.content = content()
        }

        public var body: some View {
            _VariadicView.Tree(
                _AvatarGroupContainer(
                    maxCount: maxCount,
                    spacing: avatarToken.groupSpacing,
                    borderWidth: globalToken.lineWidth * 2,
                    borderColor: avatarToken.groupBorderColor,
                    size: size,
                    shape: shape,
                    gap: gap,
                    avatarToken: avatarToken
                )
            ) {
                content
                    .environment(\.avatarGroupSize, size)
                    .environment(\.avatarGroupShape, shape)
                    .environment(\.avatarGroupGap, gap)
            }
        }
    }
}

// MARK: - Internal Implementation

// MARK: - Internal Implementation

struct _AvatarGroupContainer: _VariadicView_MultiViewRoot {
    let maxCount: Int?
    let spacing: CGFloat
    let borderWidth: CGFloat
    let borderColor: Color
    let size: AvatarSize
    let shape: AvatarShape
    let gap: CGFloat
    let avatarToken: Moin.AvatarToken

    func body(children: _VariadicView.Children) -> some View {
        let count = children.count
        let visibleCount = maxCount != nil ? min(count, maxCount!) : count
        let hasOverflow = maxCount != nil && count > maxCount!
        let sizeValue = resolveSize(size)

        HStack(spacing: spacing) {
            // 显示前 N 个头像
            ForEach(children.prefix(visibleCount)) { child in
                child
                    .frame(width: sizeValue, height: sizeValue)
                    .clipShape(resolveShape(shape))
                    .overlay(
                        resolveShape(shape)
                            .stroke(borderColor, lineWidth: borderWidth)
                    )
            }

            // 如果有溢出，显示 +N
            if hasOverflow {
                let overflowCount = count - visibleCount
                Moin.Avatar("+\(overflowCount)", size: size, shape: shape, gap: gap)
                    .overlay(
                        resolveShape(shape)
                            .stroke(borderColor, lineWidth: borderWidth)
                    )
            }
        }
    }

    private func resolveShape(_ shape: AvatarShape) -> AnyShape {
        switch shape {
        case .circle:
            return AnyShape(Circle())
        case .square:
            return AnyShape(RoundedRectangle(cornerRadius: 4))
        }
    }

    private func resolveSize(_ size: AvatarSize) -> CGFloat {
        switch size {
        case .large: return avatarToken.sizeLG
        case .default: return avatarToken.size
        case .small: return avatarToken.sizeSM
        case ._custom(let val): return val
        }
    }
}
