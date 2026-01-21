import SwiftUI
import MoinUI

struct ComponentTokenPropertyView<Content: View>: View {
    @Environment(\.moinToken) private var token
    let componentName: String
    @ViewBuilder let content: () -> Content
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            // Preview Area (Center)
            VStack {
                 // The preview is usually handled by the parent view passing environment objects 
                 // and the view reacting to them. 
                 // However, for pure token tweaking, usually we have a preview on the left and controls on the right.
                 // This view seems to be designed as the Right Side Panel content.
                 
                 ScrollView {
                     VStack(alignment: .leading, spacing: 24) {
                         Text("\(componentName) Tokens")
                             .font(.headline)
                             .padding(.horizontal)
                             
                         VStack(spacing: 0) {
                             content()
                         }
                         .padding(.horizontal)
                     }
                     .padding(.vertical)
                 }
            }
            .background(token.colorBgContainer)
        }
    }
}
