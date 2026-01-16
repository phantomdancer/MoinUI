import SwiftUI

// MARK: - SpinExamples

public struct SpinExamples: View {
    @State private var isLoading = true
    @State private var showFullscreen = false

    public init() {}

    public var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 32) {
                // 基础用法
                ExampleSection(title: "基础用法", description: "简单的 loading 状态") {
                    HStack(spacing: 40) {
                        VStack {
                            Spin(size: .small)
                            Text("Small").font(.caption)
                        }
                        VStack {
                            Spin()
                            Text("Default").font(.caption)
                        }
                        VStack {
                            Spin(size: .large)
                            Text("Large").font(.caption)
                        }
                    }
                }

                // 带提示
                ExampleSection(title: "加载提示", description: "自定义加载文案") {
                    HStack(spacing: 40) {
                        Spin(tip: "Loading...")
                        Spin(size: .large, tip: "加载中...")
                    }
                }

                // 嵌套模式
                ExampleSection(title: "嵌套模式", description: "包裹内容并在加载时显示遮罩") {
                    VStack(spacing: 16) {
                        Toggle("Loading", isOn: $isLoading)
                            .frame(width: 120)

                        Spin(spinning: isLoading, tip: "加载中...") {
                            VStack(spacing: 12) {
                                Text("Content Area")
                                    .font(.headline)
                                Text("This is the content that will be blurred")
                                    .foregroundStyle(.secondary)
                                HStack {
                                    ForEach(0..<3) { _ in
                                        RoundedRectangle(cornerRadius: 4)
                                            .fill(Color.blue.opacity(0.2))
                                            .frame(width: 60, height: 40)
                                    }
                                }
                            }
                            .padding(24)
                            .background(Color.gray.opacity(0.05))
                            .cornerRadius(8)
                        }
                    }
                }

                // 延迟加载
                ExampleSection(title: "延迟加载", description: "延迟显示 loading 效果，防止闪烁") {
                    Text("500ms 延迟后显示")
                        .foregroundStyle(.secondary)
                    Spin(tip: "Delayed...", delay: 500)
                }

                // 全屏模式
                ExampleSection(title: "全屏模式", description: "全屏遮罩加载") {
                    Button("显示全屏加载") {
                        showFullscreen = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            showFullscreen = false
                        }
                    }
                    .buttonStyle(.borderedProminent)
                }

                // 自定义指示器
                ExampleSection(title: "自定义指示器", description: "使用自定义加载动画") {
                    HStack(spacing: 40) {
                        Spin {
                            Image(systemName: "arrow.triangle.2.circlepath")
                                .font(.system(size: 24))
                                .foregroundStyle(.blue)
                        }

                        Spin {
                            ProgressView()
                                .progressViewStyle(.circular)
                        }

                        Spin(tip: "系统样式") {
                            ProgressView()
                                .progressViewStyle(.circular)
                                .scaleEffect(1.5)
                        }
                    }
                }
            }
            .padding(24)
        }
        .overlay {
            if showFullscreen {
                Spin(spinning: true, tip: "全屏加载中...", fullscreen: true)
            }
        }
    }
}

// MARK: - ExampleSection

private struct ExampleSection<Content: View>: View {
    let title: String
    let description: String
    let content: Content

    init(title: String, description: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.description = description
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                Text(description)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            content
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(16)
                .background(Color.gray.opacity(0.03))
                .cornerRadius(8)
        }
    }
}

// MARK: - Preview

#Preview("Spin Examples") {
    SpinExamples()
        .frame(width: 600, height: 800)
        .moinThemeRoot()
}
