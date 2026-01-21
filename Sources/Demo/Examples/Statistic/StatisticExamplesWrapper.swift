import SwiftUI
import MoinUI

enum StatisticExamplesTab: String, CaseIterable {
    case examples
    case api
    case token
}

struct StatisticExamplesWrapper: View {
    @Binding var selectedTab: StatisticExamplesTab
    
    var body: some View {
        switch selectedTab {
        case .examples:
            StatisticExamples()
        case .api:
            StatisticAPIView()
        case .token:
            StatisticTokenView()
        }
    }
}
