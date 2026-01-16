import SwiftUI

// MARK: - Token Playground Panel Tab

/// Token Playground Tab 分组
enum TokenPlaygroundPanelGroup: String, CaseIterable {
    case basic
    case component

    var titleKey: String {
        switch self {
        case .basic: return "token.playground.group.basic"
        case .component: return "token.playground.group.component"
        }
    }

    var tabs: [TokenPlaygroundPanelTab] {
        switch self {
        case .basic:
            return [.seed, .global]
        case .component:
            return [.avatar, .badge, .button, .divider, .empty, .space, .spin, .tag]
        }
    }
}

/// Token Playground 右侧面板 Tab
enum TokenPlaygroundPanelTab: String, CaseIterable {
    case seed
    case global
    case avatar
    case badge
    case button
    case divider
    case empty
    case space
    case spin
    case tag

    var title: String {
        rawValue.capitalized
    }

    var icon: String {
        switch self {
        case .seed: return DemoIcons.seed
        case .global: return DemoIcons.global
        case .avatar: return DemoIcons.avatar
        case .badge: return DemoIcons.badge
        case .button: return DemoIcons.button
        case .divider: return DemoIcons.divider
        case .empty: return DemoIcons.empty
        case .space: return DemoIcons.space
        case .spin: return DemoIcons.spin
        case .tag: return DemoIcons.tag
        }
    }
}
