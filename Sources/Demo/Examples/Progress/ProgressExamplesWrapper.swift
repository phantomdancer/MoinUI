import SwiftUI

enum ProgressExamplesTab: String, CaseIterable {
    case examples
    case api
    case token
}

struct ProgressExamplesWrapper: View {
    @Binding var selectedTab: ProgressExamplesTab
    
    var body: some View {
        switch selectedTab {
        case .examples:
            ProgressExamples()
        case .api:
            ProgressAPIView()
        case .token:
            ProgressTokenView()
        }
    }
}
