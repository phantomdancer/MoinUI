import SwiftUI

// MARK: - Token Playground Panel Tab

/// Token Playground 右侧面板 Tab
enum TokenPlaygroundPanelTab: String, CaseIterable {
    case seed
    case global
    case button
    case tag
    case badge
    case space
    case divider
    
    var title: String {
        rawValue.capitalized
    }

    var icon: String {
        switch self {
        case .seed: return DemoIcons.seed
        case .global: return DemoIcons.global
        case .button: return DemoIcons.button
        case .tag: return DemoIcons.tag
        case .badge: return DemoIcons.badge
        case .space: return DemoIcons.space
        case .divider: return DemoIcons.divider
        }
    }
}
