import SwiftUI

// MARK: - Moin.ButtonGroup

public extension Moin {
    /// 按钮组组件
    struct ButtonGroup<Content: View>: View {
        private let size: Moin.ButtonSize
        private let content: Content

        public init(
            size: Moin.ButtonSize = .medium,
            @ViewBuilder content: () -> Content
        ) {
            self.size = size
            self.content = content()
        }

        public var body: some View {
            HStack(spacing: -1) {
                content
            }
            .environment(\.moinButtonGroupSize, size)
            .environment(\.moinButtonGroupPosition, .middle)
        }
    }
}


// MARK: - 按钮组位置

enum MoinButtonGroupPosition {
    case middle
}

// MARK: - 环境变量

private struct MoinButtonGroupSizeKey: EnvironmentKey {
    static let defaultValue: Moin.ButtonSize? = nil
}

private struct MoinButtonGroupPositionKey: EnvironmentKey {
    static let defaultValue: MoinButtonGroupPosition? = nil
}

extension EnvironmentValues {
    var moinButtonGroupSize: Moin.ButtonSize? {
        get { self[MoinButtonGroupSizeKey.self] }
        set { self[MoinButtonGroupSizeKey.self] = newValue }
    }

    var moinButtonGroupPosition: MoinButtonGroupPosition? {
        get { self[MoinButtonGroupPositionKey.self] }
        set { self[MoinButtonGroupPositionKey.self] = newValue }
    }
}
