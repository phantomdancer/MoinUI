import SwiftUI

// MARK: - Moin.Avatar.AsyncImage

public extension Moin.Avatar {
    /// 异步图片视图 - 支持加载失败兜底
    struct AsyncImage: View {
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
                    SwiftUI.Image(systemName: fallbackIcon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundStyle(.secondary)
                        .padding(4)
                @unknown default:
                    SwiftUI.Image(systemName: fallbackIcon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundStyle(.secondary)
                        .padding(4)
                }
            }
        }
    }
}
