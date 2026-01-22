import SwiftUI
import MoinUI

enum AlertExamplesTab: String, CaseIterable {
    case examples
    case api
    case token
}

struct AlertExamplesWrapper: View {
    @Binding var selectedTab: AlertExamplesTab
    
    var body: some View {
        switch selectedTab {
        case .examples:
            AlertExamples()
        case .api:
            AlertAPIView()
        case .token:
            AlertTokenView()
        }
    }
}
