import SwiftUI


// MARK: - _Avatar (internal name, use Moin.Avatar.View)

/// 头像组件 - 用于展示用户头像、图标或字符
public struct _Avatar: View {
    @Environment(\.moinToken) private var token
    @Environment(\.moinAvatarToken) private var avatarToken

    private let content: AnyView?
    private let size: _AvatarSize
    private let shape: _AvatarShape
    private let icon: String?
    private let text: String?
    private let backgroundColor: SwiftUI.Color?
    private let gap: CGFloat

    /// 内部通用初始化方法
    private init(
        content: AnyView?,
        size: _AvatarSize,
        shape: _AvatarShape,
        icon: String?,
        text: String?,
        backgroundColor: SwiftUI.Color?,
        gap: CGFloat
    ) {
        self.content = content
        self.size = size
        self.shape = shape
        self.icon = icon
        self.text = text
        self.backgroundColor = backgroundColor
        self.gap = gap
    }

    /// 创建自定义内容的头像
    public init<Content: View>(
        size: _AvatarSize = .default,
        shape: _AvatarShape = .circle,
        backgroundColor: _AvatarColor? = nil,
        gap: CGFloat = 4,
        @ViewBuilder content: () -> Content
    ) {
        self.init(
            content: AnyView(content()),
            size: size,
            shape: shape,
            icon: nil,
            text: nil,
            backgroundColor: backgroundColor?.color,
            gap: gap
        )
    }

    /// 创建图标头像
    public init(
        icon: String,
        size: _AvatarSize = .default,
        shape: _AvatarShape = .circle,
        backgroundColor: _AvatarColor? = nil,
        gap: CGFloat = 4
    ) {
        self.init(
            content: nil,
            size: size,
            shape: shape,
            icon: icon,
            text: nil,
            backgroundColor: backgroundColor?.color,
            gap: gap
        )
    }

    /// 创建文本头像
    public init(
        _ text: String,
        size: _AvatarSize = .default,
        shape: _AvatarShape = .circle,
        backgroundColor: _AvatarColor? = nil,
        gap: CGFloat = 4
    ) {
        self.init(
            content: nil,
            size: size,
            shape: shape,
            icon: nil,
            text: text,
            backgroundColor: backgroundColor?.color,
            gap: gap
        )
    }

    /// 创建图片头像
    public init(
        image: Image,
        size: _AvatarSize = .default,
        shape: _AvatarShape = .circle
    ) {
        self.init(
            content: AnyView(image.resizable()),
            size: size,
            shape: shape,
            icon: nil,
            text: nil,
            backgroundColor: nil,
            gap: 4
        )
    }

    /// 创建网络图片头像
    public init(
        src: URL?,
        fallbackIcon: String = "person.fill",
        size: _AvatarSize = .default,
        shape: _AvatarShape = .circle
    ) {
        self.init(
            content: AnyView(_AvatarAsyncImage(url: src, fallbackIcon: fallbackIcon)),
            size: size,
            shape: shape,
            icon: nil,
            text: nil,
            backgroundColor: nil,
            gap: 4
        )
    }

    /// 创建网络图片头像 (String URL)
    public init(
        src: String,
        fallbackIcon: String = "person.fill",
        size: _AvatarSize = .default,
        shape: _AvatarShape = .circle
    ) {
        self.init(
            content: AnyView(_AvatarAsyncImage(url: URL(string: src), fallbackIcon: fallbackIcon)),
            size: size,
            shape: shape,
            icon: nil,
            text: nil,
            backgroundColor: nil,
            gap: 4
        )
    }

    public var body: some View {
        ZStack {
            resolvedBackgroundColor
            contentView
        }
        .frame(width: sizeValue, height: sizeValue)
        .clipShape(clipShape)
    }

    @ViewBuilder
    private var contentView: some View {
        if let icon = icon {
            SwiftUI.Image(systemName: icon)
                .font(.system(size: fontSize))
                .foregroundStyle(contentColor)
        } else if let text = text {
            _AvatarTextView(
                text: text,
                fontSize: fontSize,
                color: contentColor,
                containerSize: sizeValue,
                gap: gap
            )
        } else if let content = content {
            content
                .foregroundStyle(contentColor)
        }
    }

    // MARK: - Properties

    private var sizeValue: CGFloat {
        switch size {
        case .large: return avatarToken.sizeLG
        case .default: return avatarToken.size
        case .small: return avatarToken.sizeSM
        case ._custom(let val): return val
        }
    }

    private var fontSize: CGFloat {
        switch size {
        case .large: return avatarToken.fontSizeLG
        case .default: return avatarToken.fontSize
        case .small: return avatarToken.fontSizeSM
        case ._custom(let val): return val * 0.5
        }
    }

    private var clipShape: SwiftUI.AnyShape {
        switch shape {
        case .circle:
            return SwiftUI.AnyShape(Circle())
        case .square:
            let radius: CGFloat
            switch size {
            case .large: radius = token.borderRadiusLG
            case .default: radius = token.borderRadius
            case .small: radius = token.borderRadiusSM
            case ._custom(let val): radius = val * 0.15
            }
            return SwiftUI.AnyShape(RoundedRectangle(cornerRadius: radius))
        }
    }

    private var resolvedBackgroundColor: SwiftUI.Color {
        if let backgroundColor = backgroundColor {
            return backgroundColor
        }
        return token.colorTextPlaceholder
    }

    private var contentColor: SwiftUI.Color {
        return token.colorTextLightSolid
    }
}

// MARK: - _AvatarTextView (内部)

/// 头像文字视图 - 精确计算缩放比例
private struct _AvatarTextView: View {
    let text: String
    let fontSize: CGFloat
    let color: Color
    let containerSize: CGFloat
    let gap: CGFloat

    @State private var textSize: CGSize = .zero
    @State private var scale: CGFloat = 1.0

    var body: some View {
        Text(text)
            .font(.system(size: fontSize))
            .foregroundStyle(color)
            .lineLimit(1)
            .fixedSize()
            .scaleEffect(scale)
            .background(
                GeometryReader { geo in
                    Color.clear
                        .onAppear {
                            calculateScale(textWidth: geo.size.width)
                        }
                        .onChange(of: geo.size.width) { newWidth in
                            calculateScale(textWidth: newWidth)
                        }
                }
            )
    }

    private func calculateScale(textWidth: CGFloat) {
        let availableWidth = containerSize - gap * 2
        if textWidth > 0 && textWidth > availableWidth {
            scale = availableWidth / textWidth
        } else {
            scale = 1.0
        }
    }
}



// MARK: - Moin.Avatar Extensions

