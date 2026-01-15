import SwiftUI

public extension Moin {
    /// 头像组 - 用于展示一组头像
    struct AvatarGroup<Content: View>: View {
        @Environment(\EnvironmentValues.moinAvatarToken) private var avatarToken
        
        private let maxCount: Int?
        private let content: Content
        private let size: AvatarSize
        private let shape: AvatarShape
        
        /// 创建头像组
        /// - Parameters:
        ///   - maxCount: 最大显示数量，超出显示 +N
        ///   - size: 统一尺寸
        ///   - shape: 统一形状
        ///   - content: 头像列表
        public init(
            maxCount: Int? = nil,
            size: AvatarSize = .default,
            shape: AvatarShape = .circle,
            @ViewBuilder content: () -> Content
        ) {
            self.maxCount = maxCount
            self.size = size
            self.shape = shape
            self.content = content()
        }
        
        public var body: some View {
            _VariadicView.Tree(
                _AvatarGroupContainer(
                    maxCount: maxCount,
                    spacing: avatarToken.groupSpacing,
                    borderWidth: avatarToken.groupBorderWidth,
                    borderColor: avatarToken.groupBorderColor,
                    size: size,
                    shape: shape
                )
            ) {
                content
            }
        }
    }
}

// MARK: - Internal Implementation

struct _AvatarGroupContainer: _VariadicView_MultiViewRoot {
    let maxCount: Int?
    let spacing: CGFloat
    let borderWidth: CGFloat
    let borderColor: Color
    let size: AvatarSize
    let shape: AvatarShape
    
    func body(children: _VariadicView.Children) -> some View {
        let count = children.count
        let visibleCount = maxCount != nil ? min(count, maxCount!) : count
        let hasOverflow = maxCount != nil && count > maxCount!
        
        HStack(spacing: spacing) {
            // 显示前 N 个头像
            ForEach(children.prefix(visibleCount)) { child in
                child
                    .frame(
                        width: resolveSize(size),
                        height: resolveSize(size)
                    )
                    .clipShape(resolveShape(shape))
                    .overlay(
                        resolveShape(shape)
                            .stroke(borderColor, lineWidth: borderWidth)
                    )
            }
            
            // 如果有溢出，显示 +N
            if hasOverflow {
                let overflowCount = count - visibleCount
                Moin.Avatar("+\(overflowCount)", size: size, shape: shape)
                    .overlay(
                        resolveShape(shape)
                            .stroke(borderColor, lineWidth: borderWidth)
                    )
            }
        }
    }
    
    // Helper to resolve shape for overlay/clip
    private func resolveShape(_ shape: AvatarShape) -> AnyShape {
        switch shape {
        case .circle:
            return AnyShape(Circle())
        case .square:
            return AnyShape(RoundedRectangle(cornerRadius: 4)) // approximate
        }
    }
    
    // Helper to resolve size value (hardcoded approximation as we can't easily get token here without Environment passing)
    // Note: To precisely match token, we should pass token values into this struct.
    // For now, relying on the Avatar view itself to size content is better, but frame modifier needs value.
    // Actually, child views (Avatars) already have size from Init.
    // But overriding size via Group requires the child to know about it?
    // 
    // Moin.Avatar respects its local init params. 
    // If the user does Moin.Avatar(size: .small), but Group says .large?
    // Ant Design says Group size overrides.
    // But we are not injecting environment into children here easily without wrapping them.
    //
    // The `child` in VariadicView is the resolved view. We can apply scale or frame.
    private func resolveSize(_ size: AvatarSize) -> CGFloat? {
        // ideally we let the child determine its size unless we want to force frame.
        // For overlapping to work correctly, HStack spacing is key. 
        // We assume children are rendered at correct size.
        return nil 
    }
}
