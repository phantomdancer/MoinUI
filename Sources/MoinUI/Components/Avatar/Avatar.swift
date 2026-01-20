import SwiftUI

public extension Moin {
    /// 头像组件 - 用于展示用户头像、图标或字符
    struct Avatar<Content: View>: View {
        @Environment(\.moinToken) private var token
        @Environment(\.moinAvatarToken) private var avatarToken

        private let content: Content
        private let size: AvatarSize
        private let shape: AvatarShape
        private let icon: String?
        private let text: String?
        private let backgroundColor: Color? // 允许覆盖背景色
        private let gap: CGFloat // 文字距边界间距

        /// 创建自定义内容的头像
        public init(
            size: AvatarSize = .default,
            shape: AvatarShape = .circle,
            backgroundColor: Color? = nil,
            gap: CGFloat = 4,
            @ViewBuilder content: () -> Content
        ) {
            self.content = content()
            self.size = size
            self.shape = shape
            self.backgroundColor = backgroundColor
            self.gap = gap
            self.icon = nil
            self.text = nil
        }

        public var body: some View {
            ZStack {
                // Background
                resolvedBackgroundColor

                // Content
                contentView
            }
            .frame(width: sizeValue, height: sizeValue)
            .clipShape(clipShape)
        }

        @ViewBuilder
        private var contentView: some View {
            if let icon = icon {
                Image(systemName: icon)
                    .font(.system(size: fontSize))
                    .foregroundStyle(contentColor)
            } else if let text = text {
                AvatarTextView(
                    text: text,
                    fontSize: fontSize,
                    color: contentColor,
                    containerSize: sizeValue,
                    gap: gap
                )
            } else {
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
            case ._custom(let val): return val * 0.5 // 自定义尺寸时字体粗略减半
            }
        }
        
        private var clipShape: AnyShape {
            switch shape {
            case .circle:
                return AnyShape(Circle())
            case .square:
                // Square 也有微小圆角
                let radius: CGFloat
                switch size {
                case .large: radius = avatarToken.borderRadiusLG
                case .default: radius = avatarToken.borderRadius
                case .small: radius = avatarToken.borderRadiusSM
                case ._custom(let val): radius = val * 0.15 // 粗略估算
                }
                return AnyShape(RoundedRectangle(cornerRadius: radius))
            }
        }
        
        private var resolvedBackgroundColor: Color {
            if let backgroundColor = backgroundColor {
                return backgroundColor
            }
            // 如果是文本，默认使用灰色背景
            // 如果是图片 (Content)，通常图片自带全填充，背景色看不见；
            // 这里统一给一个默认背景
            return avatarToken.containerBg
        }
        
        private var contentColor: Color {
            // 如果只有文本且背景是默认的，使用 token 定义的文本色
            // 但如果用户自定义了背景色（例如彩色），通常文本应该是白色
            if backgroundColor != nil {
                return avatarToken.colorTextLight
            }
            return avatarToken.colorText
        }
    }
}

// MARK: - Convenience Inits

public extension Moin.Avatar where Content == EmptyView {
    /// 创建图标头像 (SF Symbol)
    init(
        icon: String,
        size: AvatarSize = .default,
        shape: AvatarShape = .circle,
        backgroundColor: Color? = nil,
        gap: CGFloat = 4
    ) {
        self.content = EmptyView()
        self.size = size
        self.shape = shape
        self.backgroundColor = backgroundColor
        self.gap = gap
        self.icon = icon
        self.text = nil
    }

    /// 创建文本头像
    init(
        _ text: String,
        size: AvatarSize = .default,
        shape: AvatarShape = .circle,
        backgroundColor: Color? = nil,
        gap: CGFloat = 4
    ) {
        self.content = EmptyView()
        self.size = size
        self.shape = shape
        self.backgroundColor = backgroundColor
        self.gap = gap
        self.icon = nil
        self.text = text
    }
}

// MARK: - Image Init
public extension Moin.Avatar where Content == Image {
    /// 创建图片头像
    init(
        image: Image,
        size: AvatarSize = .default,
        shape: AvatarShape = .circle
    ) {
        self.content = image.resizable()
        self.size = size
        self.shape = shape
        self.backgroundColor = nil
        self.gap = 4
        self.icon = nil
        self.text = nil
    }
}

// MARK: - Icon View Init
public extension Moin.Avatar {
    /// 创建自定义图标头像 (任意 View)
    init(
        size: AvatarSize = .default,
        shape: AvatarShape = .circle,
        backgroundColor: Color? = nil,
        gap: CGFloat = 4,
        @ViewBuilder icon iconContent: () -> Content
    ) {
        self.content = iconContent()
        self.size = size
        self.shape = shape
        self.backgroundColor = backgroundColor
        self.gap = gap
        self.icon = nil
        self.text = nil
    }
}

// Helper needed for AnyShape
struct AnyShape: Shape, @unchecked Sendable {
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

// MARK: - AvatarTextView (精确缩放)

/// 头像文字视图 - 精确计算缩放比例
struct AvatarTextView: View {
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

// MARK: - URL Image Init

public extension Moin.Avatar where Content == AvatarAsyncImage {
    /// 创建网络图片头像
    /// - Parameters:
    ///   - src: 图片 URL
    ///   - fallbackIcon: 加载失败时显示的图标 (SF Symbol)
    ///   - size: 尺寸
    ///   - shape: 形状
    init(
        src: URL?,
        fallbackIcon: String = "person.fill",
        size: AvatarSize = .default,
        shape: AvatarShape = .circle
    ) {
        self.content = AvatarAsyncImage(url: src, fallbackIcon: fallbackIcon)
        self.size = size
        self.shape = shape
        self.backgroundColor = nil
        self.gap = 4
        self.icon = nil
        self.text = nil
    }

    /// 创建网络图片头像 (String URL)
    init(
        src: String,
        fallbackIcon: String = "person.fill",
        size: AvatarSize = .default,
        shape: AvatarShape = .circle
    ) {
        self.content = AvatarAsyncImage(url: URL(string: src), fallbackIcon: fallbackIcon)
        self.size = size
        self.shape = shape
        self.backgroundColor = nil
        self.gap = 4
        self.icon = nil
        self.text = nil
    }
}

/// 异步图片视图 - 支持加载失败兜底
public struct AvatarAsyncImage: View {
    let url: URL?
    let fallbackIcon: String

    public var body: some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .scaleEffect(0.5)
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            case .failure:
                Image(systemName: fallbackIcon)
                    .font(.system(size: 16))
            @unknown default:
                Image(systemName: fallbackIcon)
                    .font(.system(size: 16))
            }
        }
    }
}
