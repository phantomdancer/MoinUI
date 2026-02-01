import SwiftUI
// MARK: - Internal Wrapper for Text Tooltip
// 用于包装 Text 并应用 .fixedSize 以支持自动换行
public struct TooltipTextWrapper: View {
    let title: LocalizedStringKey?
    let text: String?
    
    init(_ text: String) {
        self.text = text
        self.title = nil
    }
    
    init(_ title: LocalizedStringKey) {
        self.title = title
        self.text = nil
    }
    
    public var body: some View {
        Group {
            if let title = title {
                Text(title)
            } else {
                Text(text ?? "")
            }
        }
        .fixedSize(horizontal: false, vertical: true)
    }
}
