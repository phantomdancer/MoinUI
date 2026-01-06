import SwiftUI

/// 按钮组组件
public struct MoinUIButtonGroup<Content: View>: View {
    private let size: MoinUIButtonSize
    private let content: Content

    public init(
        size: MoinUIButtonSize = .medium,
        @ViewBuilder content: () -> Content
    ) {
        self.size = size
        self.content = content()
    }

    public var body: some View {
        HStack(spacing: -1) {
            content
        }
        .environment(\.moinUIButtonGroupSize, size)
        .environment(\.moinUIButtonGroupPosition, .middle)
    }
}

// MARK: - 按钮组位置

enum MoinUIButtonGroupPosition {
    case leading
    case middle
    case trailing
    case single
}

// MARK: - 环境变量

private struct MoinUIButtonGroupSizeKey: EnvironmentKey {
    static let defaultValue: MoinUIButtonSize? = nil
}

private struct MoinUIButtonGroupPositionKey: EnvironmentKey {
    static let defaultValue: MoinUIButtonGroupPosition? = nil
}

extension EnvironmentValues {
    var moinUIButtonGroupSize: MoinUIButtonSize? {
        get { self[MoinUIButtonGroupSizeKey.self] }
        set { self[MoinUIButtonGroupSizeKey.self] = newValue }
    }

    var moinUIButtonGroupPosition: MoinUIButtonGroupPosition? {
        get { self[MoinUIButtonGroupPositionKey.self] }
        set { self[MoinUIButtonGroupPositionKey.self] = newValue }
    }
}
