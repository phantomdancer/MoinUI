import SwiftUI
import AppKit

/// 颜色工具扩展
public extension Color {
    /// 加深颜色
    /// - Parameter amount: 加深程度 (0.0 - 1.0)
    func darkened(by amount: CGFloat = 0.1) -> Color {
        guard let components = nsColor.cgColor.components, components.count >= 3 else {
            return self
        }
        let r = max(0, components[0] - amount)
        let g = max(0, components[1] - amount)
        let b = max(0, components[2] - amount)
        let a = components.count >= 4 ? components[3] : 1.0
        return Color(red: r, green: g, blue: b, opacity: a)
    }

    /// 变浅颜色
    /// - Parameter amount: 变浅程度 (0.0 - 1.0)
    func lightened(by amount: CGFloat = 0.1) -> Color {
        guard let components = nsColor.cgColor.components, components.count >= 3 else {
            return self
        }
        let r = min(1, components[0] + amount)
        let g = min(1, components[1] + amount)
        let b = min(1, components[2] + amount)
        let a = components.count >= 4 ? components[3] : 1.0
        return Color(red: r, green: g, blue: b, opacity: a)
    }

    /// 获取 NSColor
    private var nsColor: NSColor {
        NSColor(self)
    }
}
