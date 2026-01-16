import SwiftUI

// MARK: - EmptyDefaultImage

struct EmptyDefaultImage: View {
    var body: some View {
        Image(systemName: "tray")
            .font(.system(size: 60, weight: .thin))
    }
}

// MARK: - EmptySimpleImage

struct EmptySimpleImage: View {
    var body: some View {
        Image(systemName: "tray")
            .font(.system(size: 32, weight: .thin))
    }
}
