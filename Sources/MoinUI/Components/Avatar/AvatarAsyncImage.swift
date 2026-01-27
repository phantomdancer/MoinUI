import SwiftUI

// MARK: - _AvatarAsyncImage (internal name, use Moin.Avatar.AsyncImage)

/// 异步图片视图 - 支持加载失败兜底
public struct _AvatarAsyncImage: View {
    let url: URL?
    let fallbackIcon: String

    public init(url: URL?, fallbackIcon: String = "person.fill") {
        self.url = url
        self.fallbackIcon = fallbackIcon
    }

    public var body: some View {
        SwiftUI.AsyncImage(url: url) { phase in
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
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundStyle(.secondary)
                    .padding(4)
            @unknown default:
                Image(systemName: fallbackIcon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundStyle(.secondary)
                    .padding(4)
            }
        }
    }
}


