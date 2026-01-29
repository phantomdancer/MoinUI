import SwiftUI

enum ResultExamplesTab: String, CaseIterable {
    case examples
    case api
    case token
}

struct ResultExamplesWrapper: View {
    @Binding var selectedTab: ResultExamplesTab

    var body: some View {
        switch selectedTab {
        case .examples:
            ResultExamples()
        case .api:
            ResultAPIView()
        case .token:
            ResultTokenView()
        }
    }
}
