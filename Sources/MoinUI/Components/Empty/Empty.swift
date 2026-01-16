import SwiftUI

// MARK: - Moin.Empty

public extension Moin {
    struct Empty<Content: View>: View {
        @Environment(\.moinToken) private var token
        @Environment(\.moinEmptyToken) private var emptyToken

        public enum ImageType {
            case `default`
            case simple
            case custom(Image)
            case systemIcon(String)
            case url(String)
            case none
        }

        private let imageType: ImageType
        private let description: String?
        private let content: Content?

        public var body: some View {
            VStack(spacing: 0) {
                imageView
                    .padding(.bottom, emptyToken.imageMarginBottom)

                if let description = description {
                    Text(description)
                        .font(.system(size: emptyToken.descriptionFontSize))
                        .foregroundStyle(emptyToken.descriptionColor)
                        .padding(.bottom, emptyToken.contentMarginTop)
                }

                if let content = content {
                    content
                }
            }
        }

        @ViewBuilder
        private var imageView: some View {
            switch imageType {
            case .default:
                EmptyDefaultImage()
                    .frame(height: emptyToken.imageHeight)
                    .foregroundStyle(emptyToken.imageColor.opacity(emptyToken.imageOpacity))
            case .simple:
                EmptySimpleImage()
                    .frame(height: emptyToken.imageHeightSM)
                    .foregroundStyle(emptyToken.imageColor.opacity(emptyToken.imageOpacity))
            case .custom(let image):
                image
                    .resizable()
                    .scaledToFit()
                    .frame(height: emptyToken.imageHeight)
            case .systemIcon(let name):
                Image(systemName: name)
                    .font(.system(size: emptyToken.imageHeight * 0.6))
                    .foregroundStyle(emptyToken.imageColor.opacity(emptyToken.imageOpacity))
                    .frame(height: emptyToken.imageHeight)
            case .url(let urlString):
                AsyncImage(url: URL(string: urlString)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(height: emptyToken.imageHeight)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(height: emptyToken.imageHeight)
                    case .failure:
                        EmptyDefaultImage()
                            .frame(height: emptyToken.imageHeight)
                            .foregroundStyle(emptyToken.imageColor.opacity(emptyToken.imageOpacity))
                    @unknown default:
                        EmptyDefaultImage()
                            .frame(height: emptyToken.imageHeight)
                            .foregroundStyle(emptyToken.imageColor.opacity(emptyToken.imageOpacity))
                    }
                }
            case .none:
                EmptyView()
            }
        }
    }
}

// MARK: - Initializers

public extension Moin.Empty where Content == EmptyView {
    init(
        image: ImageType = .default,
        description: String? = nil
    ) {
        self.imageType = image
        self.description = description
        self.content = nil
    }
}

public extension Moin.Empty {
    init(
        image: ImageType = .default,
        description: String? = nil,
        @ViewBuilder content: () -> Content
    ) {
        self.imageType = image
        self.description = description
        self.content = content()
    }
}
