import SwiftUI

public extension Moin {
    /// 标签组件
    struct Tag: View {
        @Environment(\.moinToken) private var token
        @Environment(\.colorScheme) private var colorScheme
        @State private var isHovered = false

        private let text: String
        private let color: TagColor
        private let variant: TagVariant
        private let icon: String?
        private let closable: Bool
        private let onClose: (() -> Void)?

        /// 创建标签
        /// - Parameters:
        ///   - text: 标签文本
        ///   - color: 颜色
        ///   - variant: 变体
        ///   - icon: SF Symbol 图标名
        ///   - closable: 是否可关闭
        ///   - onClose: 关闭回调
        public init(
            _ text: String,
            color: TagColor = .default,
            variant: TagVariant = .filled,
            icon: String? = nil,
            closable: Bool = false,
            onClose: (() -> Void)? = nil
        ) {
            self.text = text
            self.color = color
            self.variant = variant
            self.icon = icon
            self.closable = closable
            self.onClose = onClose
        }

        public var body: some View {
            HStack(spacing: token.paddingXXS) {
                if let icon = icon {
                    Image(systemName: icon)
                        .font(.system(size: 10))
                }

                Text(text)
                    .font(.system(size: token.fontSize - 2))
                    .lineLimit(1)

                if closable {
                    Button(action: { onClose?() }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 8, weight: .medium))
                            .foregroundStyle(foregroundColor.opacity(0.6))
                    }
                    .buttonStyle(.plain)
                    .contentShape(Rectangle())
                }
            }
            .padding(.horizontal, Moin.Constants.Spacing.xs)
            .padding(.vertical, token.paddingXXS)
            .foregroundStyle(foregroundColor)
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: token.borderRadiusSM))
            .overlay(
                RoundedRectangle(cornerRadius: token.borderRadiusSM)
                    .strokeBorder(borderColor, lineWidth: hasBorder ? 1 : 0)
            )
            .onHover { isHovered = $0 }
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
        private var baseColor: Color {
            switch color {
            case .default: return token.colorTextSecondary
            case .success: return token.colorSuccess
            case .processing: return token.colorPrimary
            case .warning: return token.colorWarning
            case .error: return token.colorDanger
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
        private var foregroundColor: Color {
            switch variant {
            case .filled, .borderless:
                if color.isDefault {
                    return token.colorText
                }
                return colorAt(level: 6)
            case .outlined:
                if color.isDefault {
                    return token.colorText
                }
                return colorAt(level: 6)
            case .solid:
                return .white
            }
        }

        /// 背景色
        private var backgroundColor: Color {
            switch variant {
            case .filled, .borderless:
                if color.isDefault {
                    return token.colorFillSecondary
                }
                return colorAt(level: 1)
            case .outlined:
                return .clear
            case .solid:
                if color.isDefault {
                    return token.colorTextSecondary
                }
                return colorAt(level: 6)
            }
        }

        /// 边框色
        private var borderColor: Color {
            switch variant {
            case .filled:
                if color.isDefault {
                    return token.colorBorder
                }
                return colorAt(level: 3)
            case .outlined:
                if color.isDefault {
                    return token.colorBorder
                }
                return colorAt(level: 3)
            case .solid, .borderless:
                return .clear
            }
        }

        /// 获取指定级别的颜色
        private func colorAt(level: Int) -> Color {
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
        private func tokenColorLevel(base: Color, level: Int) -> Color {
            let palette = Moin.ColorPalette.generate(from: base, theme: isDark ? .dark : .light)
            return palette[level]
        }
    }
}
