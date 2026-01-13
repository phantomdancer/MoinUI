import SwiftUI
import AppKit

public extension Moin {
    /// 可选中标签
    struct CheckableTag: View {
        @Environment(\.moinToken) private var token
        @Environment(\.colorScheme) private var colorScheme
        @Binding var isChecked: Bool
        @State private var isHovered = false

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
                .overlay(
                    RoundedRectangle(cornerRadius: token.borderRadiusSM)
                        .strokeBorder(borderColor, lineWidth: 1)
                )
                .onHover { hovering in
                    isHovered = hovering
                    if hovering {
                        NSCursor.pointingHand.push()
                    } else {
                        NSCursor.pop()
                    }
                }
                .onTapGesture {
                    isChecked.toggle()
                    onChange?(isChecked)
                }
                .animation(.easeInOut(duration: token.motionDurationFast), value: isChecked)
        }

        // MARK: - Computed Properties

        private var isDark: Bool { colorScheme == .dark }

        private var palette: Moin.ColorPalette {
            Moin.ColorPalette.generate(from: token.colorPrimary, theme: isDark ? .dark : .light)
        }

        private var foregroundColor: Color {
            if isChecked {
                return token.colorPrimary
            }
            return isHovered ? token.colorPrimary : token.colorText
        }

        private var backgroundColor: Color {
            if isChecked {
                return palette[1]
            }
            return isHovered ? palette[1] : .clear
        }

        private var borderColor: Color {
            if isChecked {
                return token.colorPrimary
            }
            return isHovered ? token.colorPrimary : token.colorBorder
        }
    }
}
