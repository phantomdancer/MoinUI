import SwiftUI
import AppKit

public extension Moin {
    /// 标签组件
    struct Tag: View {
        @Environment(\.moinToken) private var token
        @Environment(\.moinTagToken) private var tagToken
        @Environment(\.colorScheme) private var colorScheme
        @State private var isHovered = false
        @State private var isCloseHovered = false

        private let text: String
        private let color: _TagColor
        private let variant: _TagVariant
        private let size: _TagSize
        private let round: Bool
        private let icon: String?
        private let closable: Bool
        private let onClose: (() -> Void)?

        /// 创建标签
        /// - Parameters:
        ///   - text: 标签文本
        ///   - color: 颜色
        ///   - variant: 变体
        ///   - size: 尺寸
        ///   - round: 是否圆角（药丸形）
        ///   - icon: SF Symbol 图标名
        ///   - closable: 是否可关闭
        ///   - onClose: 关闭回调
        public init(
            _ text: String,
            color: _TagColor = .default,
            variant: _TagVariant = .filled,
            size: _TagSize = .medium,
            round: Bool = false,
            icon: String? = nil,
            closable: Bool = false,
            onClose: (() -> Void)? = nil
        ) {
            self.text = text
            self.color = color
            self.variant = variant
            self.size = size
            self.round = round
            self.icon = icon
            self.closable = closable
            self.onClose = onClose
        }

        public var body: some View {
            HStack(spacing: iconSpacing) {
                if let icon = icon {
                    Image(systemName: icon)
                        .font(.system(size: iconSize))
                }

                Text(text)
                    .font(.system(size: fontSize))
                    .lineLimit(1)

                if closable {
                    Image(systemName: "xmark")
                        .font(.system(size: closeIconSize, weight: .semibold))
                        .foregroundStyle(isCloseHovered ? foregroundColor : foregroundColor.opacity(0.5))
                        .onHover { hovering in
                            isCloseHovered = hovering
                            if hovering {
                                NSCursor.pointingHand.push()
                            } else {
                                NSCursor.pop()
                            }
                        }
                        .onTapGesture {
                            onClose?()
                        }
                }
            }
            .padding(.horizontal, paddingH)
            .padding(.vertical, paddingV)
            .foregroundStyle(foregroundColor)
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .strokeBorder(borderColor, lineWidth: hasBorder ? token.lineWidth : 0) // 全局Token
            )
            .onHover { isHovered = $0 }
        }

        // MARK: - Size Properties (全局Token)

        private var fontSize: CGFloat {
            switch size {
            case .large: return token.fontSize        // 全局Token
            case .medium: return token.fontSizeSM     // 全局Token
            case .small: return token.fontSizeSM - 2  // 派生
            }
        }

        private var iconSize: CGFloat {
            switch size {
            case .large: return tagToken.iconSizeLG
            case .medium: return tagToken.iconSize
            case .small: return tagToken.iconSizeSM
            }
        }

        private var closeIconSize: CGFloat {
            switch size {
            case .large: return tagToken.closeIconSizeLG
            case .medium: return tagToken.closeIconSize
            case .small: return tagToken.closeIconSizeSM
            }
        }

        private var iconSpacing: CGFloat {
            switch size {
            case .large: return tagToken.iconGapLG
            case .medium: return tagToken.iconGap
            case .small: return tagToken.iconGapSM
            }
        }

        private var paddingH: CGFloat {
            switch size {
            case .large: return tagToken.paddingHLG
            case .medium: return tagToken.paddingH
            case .small: return tagToken.paddingHSM
            }
        }

        private var paddingV: CGFloat {
            switch size {
            case .large: return tagToken.paddingVLG
            case .medium: return tagToken.paddingV
            case .small: return tagToken.paddingVSM
            }
        }

        private var cornerRadius: CGFloat {
            if round {
                // 药丸形：使用足够大的圆角
                return 100
            }
            switch size {
            case .large: return token.borderRadiusSM + 2   // 全局Token
            case .medium: return token.borderRadiusSM      // 全局Token
            case .small: return max(token.borderRadiusSM - 1, 2)
            }
        }

        // MARK: - Computed Properties

        private var isDark: Bool { colorScheme == .dark }

        private var hasBorder: Bool {
            switch variant {
            case .filled, .outlined: return true
            case .solid, .borderless: return false
            }
        }

        /// 基础色（用于派生其他颜色）
        private var baseColor: SwiftUI.Color {
            switch color {
            case .default: return token.colorTextSecondary   // 全局Token
            case .success: return token.colorSuccess         // 全局Token
            case .processing: return token.colorPrimary      // 全局Token
            case .warning: return token.colorWarning         // 全局Token
            case .error: return token.colorDanger            // 全局Token
            case .custom(let c): return c
            }
        }

        /// 色阶（用于自定义颜色）
        private var palette: Moin.ColorPalette? {
            if case .custom(let c) = color {
                return Moin.ColorPalette.generate(from: c, theme: isDark ? .dark : .light)
            }
            return nil
        }

        /// 前景色
        private var foregroundColor: SwiftUI.Color {
            switch variant {
            case .filled, .borderless:
                if color.isDefault {
                    return tagToken.defaultColor
                }
                return colorAt(level: 6)
            case .outlined:
                if color.isDefault {
                    return tagToken.defaultColor
                }
                return colorAt(level: 6)
            case .solid:
                return tagToken.solidTextColor
            }
        }

        /// 背景色
        private var backgroundColor: SwiftUI.Color {
            switch variant {
            case .filled, .borderless:
                if color.isDefault {
                    return tagToken.defaultBg
                }
                return colorAt(level: 1)
            case .outlined:
                return SwiftUI.Color.clear
            case .solid:
                if color.isDefault {
                    return token.colorTextSecondary  // 全局Token
                }
                return colorAt(level: 6)
            }
        }

        /// 边框色
        private var borderColor: SwiftUI.Color {
            switch variant {
            case .filled:
                if color.isDefault {
                    return token.colorBorder  // 全局Token
                }
                return colorAt(level: 3)
            case .outlined:
                if color.isDefault {
                    return token.colorBorder  // 全局Token
                }
                return colorAt(level: 3)
            case .solid, .borderless:
                return SwiftUI.Color.clear
            }
        }

        /// 获取指定级别的颜色
        private func colorAt(level: Int) -> SwiftUI.Color {
            // 自定义颜色使用动态色板
            if let palette = palette {
                return palette[level]
            }

            // 语义色使用 token 色阶
            switch color {
            case .success:
                return tokenColorLevel(base: token.colorSuccess, level: level)
            case .processing:
                return tokenColorLevel(base: token.colorPrimary, level: level)
            case .warning:
                return tokenColorLevel(base: token.colorWarning, level: level)
            case .error:
                return tokenColorLevel(base: token.colorDanger, level: level)
            default:
                return baseColor
            }
        }

        /// Token 语义色色阶
        private func tokenColorLevel(base: SwiftUI.Color, level: Int) -> SwiftUI.Color {
            let palette = Moin.ColorPalette.generate(from: base, theme: isDark ? .dark : .light)
            return palette[level]
        }
    }
}
