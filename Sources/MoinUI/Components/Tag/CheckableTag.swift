import SwiftUI
import AppKit

public extension Moin {
    /// 可选中标签
    struct CheckableTag: View {
        @Environment(\.moinToken) private var token
        @Environment(\.colorScheme) private var colorScheme
        @Binding var isChecked: Bool
        @State private var isHovered = false
        @State private var isPressed = false

        private let text: String
        private let onChange: ((Bool) -> Void)?

        /// 创建可选中标签
        /// - Parameters:
        ///   - text: 标签文本
        ///   - isChecked: 选中状态绑定
        ///   - onChange: 状态变化回调
        public init(
            _ text: String,
            isChecked: Binding<Bool>,
            onChange: ((Bool) -> Void)? = nil
        ) {
            self.text = text
            self._isChecked = isChecked
            self.onChange = onChange
        }

        public var body: some View {
            Text(text)
                .font(.system(size: token.fontSize - 2))
                .lineLimit(1)
                .padding(.horizontal, Moin.Constants.Spacing.xs)
                .padding(.vertical, token.paddingXXS)
                .foregroundStyle(foregroundColor)
                .background(backgroundColor)
                .clipShape(RoundedRectangle(cornerRadius: token.borderRadiusSM))
                .onHover { hovering in
                    isHovered = hovering
                    if hovering {
                        NSCursor.pointingHand.push()
                    } else {
                        NSCursor.pop()
                    }
                }
                .simultaneousGesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { _ in isPressed = true }
                        .onEnded { _ in
                            isPressed = false
                            isChecked.toggle()
                            onChange?(isChecked)
                        }
                )
                .animation(.easeInOut(duration: token.motionDurationFast), value: isChecked)
                .animation(.easeInOut(duration: token.motionDurationFast), value: isHovered)
                .animation(.easeInOut(duration: token.motionDurationFast), value: isPressed)
        }

        // MARK: - Computed Properties

        private var isDark: Bool { colorScheme == .dark }

        private var foregroundColor: Color {
            // 按下或选中时：白色文字
            if isPressed || isChecked {
                return .white
            }
            // hover 时：主色文字
            if isHovered {
                return token.colorPrimary
            }
            // 默认：普通文本色
            return token.colorText
        }

        private var backgroundColor: Color {
            // 选中状态
            if isChecked {
                // 选中 + hover：主色 hover 态
                if isHovered {
                    return token.colorPrimaryHover
                }
                // 选中：主色背景
                return token.colorPrimary
            }
            // 按下状态：主色激活态
            if isPressed {
                return token.colorPrimaryActive
            }
            // hover 状态：浅色背景
            if isHovered {
                return token.colorFillSecondary
            }
            // 默认：透明
            return .clear
        }
    }
}
