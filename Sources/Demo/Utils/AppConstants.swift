import SwiftUI

/// 应用图标名称
let appIconName = "bird"

/// GitHub 仓库链接
let githubRepoURL = URL(string: "https://github.com/phantomdancer/MoinUI.git")!

/// 应用图标组件
struct AppIcon: View {
    var fontSize: CGFloat = 60
    var weight: Font.Weight = .medium
    var foregroundColor: Color = .white

    var body: some View {
        Image(systemName: appIconName)
            .font(.system(size: fontSize, weight: weight))
            .foregroundStyle(foregroundColor)
    }
}
