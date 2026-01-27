import SwiftUI

// MARK: - Environment Keys for Group Context

private struct AvatarGroupSizeKey: EnvironmentKey {
    static let defaultValue: _AvatarSize? = nil
}

private struct AvatarGroupShapeKey: EnvironmentKey {
    static let defaultValue: _AvatarShape? = nil
}

private struct AvatarGroupGapKey: EnvironmentKey {
    static let defaultValue: CGFloat? = nil
}

extension EnvironmentValues {
    var avatarGroupSize: _AvatarSize? {
        get { self[AvatarGroupSizeKey.self] }
        set { self[AvatarGroupSizeKey.self] = newValue }
    }

    var avatarGroupShape: _AvatarShape? {
        get { self[AvatarGroupShapeKey.self] }
        set { self[AvatarGroupShapeKey.self] = newValue }
    }

    var avatarGroupGap: CGFloat? {
        get { self[AvatarGroupGapKey.self] }
        set { self[AvatarGroupGapKey.self] = newValue }
    }
}

// MARK: - _AvatarGroup (internal name, use Moin.Avatar.Group)

/// 头像组 - 用于展示一组头像
public struct _AvatarGroup<Content: View>: View {
    @Environment(\EnvironmentValues.moinAvatarToken) private var avatarToken
    @Environment(\.moinToken) private var globalToken

    private let maxCount: Int?
    private let content: Content
    private let size: _AvatarSize
    private let shape: _AvatarShape
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
        size: _AvatarSize = .default,
        shape: _AvatarShape = .circle,
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

// MARK: - Internal Implementation

struct _AvatarGroupContainer: _VariadicView_MultiViewRoot {
    let maxCount: Int?
    let spacing: CGFloat
    let borderWidth: CGFloat
    let borderColor: Color
    let size: _AvatarSize
    let shape: _AvatarShape
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
                _Avatar("+\(overflowCount)", size: size, shape: shape, gap: gap)
                    .overlay(
                        resolveShape(shape)
                            .stroke(borderColor, lineWidth: borderWidth)
                    )
            }
        }
    }

    private func resolveShape(_ shape: _AvatarShape) -> _AnyShape {
        switch shape {
        case .circle:
            return _AnyShape(Circle())
        case .square:
            return _AnyShape(RoundedRectangle(cornerRadius: 4))
        }
    }

    private func resolveSize(_ size: _AvatarSize) -> CGFloat {
        switch size {
        case .large: return avatarToken.sizeLG
        case .default: return avatarToken.size
        case .small: return avatarToken.sizeSM
        case ._custom(let val): return val
        }
    }
}

// Helper for AnyShape
struct _AnyShape: Shape, @unchecked Sendable {
    private let _path: @Sendable (CGRect) -> Path

    init<S: Shape>(_ wrapped: S) {
        _path = { rect in
            let path = wrapped.path(in: rect)
            return path
        }
    }

    func path(in rect: CGRect) -> Path {
        _path(rect)
    }
}



// MARK: - 兼容旧 API

@available(*, deprecated, renamed: "Moin.Avatar.Group")
public typealias MoinAvatarGroup<Content: View> = _AvatarGroup<Content>
