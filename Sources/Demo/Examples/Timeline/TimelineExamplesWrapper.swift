import SwiftUI

enum TimelineExamplesTab: String, CaseIterable {
    case examples
    case api
    case token
}

struct TimelineExamplesWrapper: View {
    @Binding var selectedTab: TimelineExamplesTab

    var body: some View {
        switch selectedTab {
        case .examples:
            TimelineExamples()
        case .api:
            TimelineAPIView()
        case .token:
            TimelineTokenView()
        }
    }
}
