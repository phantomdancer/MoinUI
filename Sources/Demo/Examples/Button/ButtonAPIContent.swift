import SwiftUI
import MoinUI

struct ButtonAPIContent: View {
    @Localized var tr

    /// 锚点列表
    private let anchors: [AnchorItem] = [
        AnchorItem(id: "api", titleKey: "API"),
        AnchorItem(id: "component_token", titleKey: "api.component_token"),
        AnchorItem(id: "global_token", titleKey: "api.global_token_title"),
    ]

    var body: some View {
        ExamplePageWithAnchor(pageName: "Button API", anchors: anchors) { _ in
            ButtonAPISection().id("api")
        }
    }
}
