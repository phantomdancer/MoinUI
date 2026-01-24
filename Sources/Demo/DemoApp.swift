import SwiftUI
import AppKit
import MoinUI
import os

// MARK: - Notification Names
extension Notification.Name {
    static let buttonDocReset = Notification.Name("buttonDocReset")
    static let badgeDocReset = Notification.Name("badgeDocReset")
    static let emptyDocReset = Notification.Name("emptyDocReset")
    static let dividerDocReset = Notification.Name("dividerDocReset")
    static let spaceDocReset = Notification.Name("spaceDocReset")
    static let statisticDocReset = Notification.Name("statisticDocReset")
    static let alertDocReset = Notification.Name("alertDocReset")
}

@main
struct DemoApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject private var configProvider = Moin.ConfigProvider.shared

    init() {
        // Register Demo translations
        DemoTranslations.register()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .moinThemeRoot()
                .focusable(false)

        }
        .defaultSize(width: 800, height: 600)
        .commands {
            CommandGroup(replacing: .appInfo) {
                Button(configProvider.tr("demo.about")) {
                    NSApplication.shared.orderFrontStandardAboutPanel(nil)
                }
            }
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    private var windowObserver: NSObjectProtocol?

    func applicationDidFinishLaunching(_ notification: Notification) {
        NSApp.setActivationPolicy(.regular)
        setupAppIcon()
        NSApp.activate(ignoringOtherApps: true)

        // 监听窗口创建完成后再设置位置
        windowObserver = NotificationCenter.default.addObserver(
            forName: NSWindow.didBecomeMainNotification,
            object: nil,
            queue: .main
        ) { [weak self] notification in
            guard let window = notification.object as? NSWindow,
                  let screen = window.screen ?? NSScreen.main else { return }

            // 只执行一次
            if let observer = self?.windowObserver {
                NotificationCenter.default.removeObserver(observer)
                self?.windowObserver = nil
            }

            // 窗口大小为屏幕一半（但不小于minSize），居中显示
            let screenFrame = screen.visibleFrame
            let width = max(screenFrame.width / 2, window.minSize.width)
            let height = max(screenFrame.height / 2, window.minSize.height)
            window.setContentSize(NSSize(width: width, height: height))
            window.center()
        }
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }

    private func setupAppIcon() {
        let size: CGFloat = 512
        let image = NSImage(size: NSSize(width: size, height: size))

        image.lockFocus()

        let padding: CGFloat = size * 0.1
        let iconSize = size - padding * 2
        let rect = NSRect(x: padding, y: padding, width: iconSize, height: iconSize)
        let cornerRadius: CGFloat = iconSize * 0.225
        let path = NSBezierPath(roundedRect: rect, xRadius: cornerRadius, yRadius: cornerRadius)

        let gradient = NSGradient(
            starting: NSColor(red: 0.2, green: 0.6, blue: 1.0, alpha: 1.0),
            ending: NSColor(red: 0.4, green: 0.3, blue: 0.9, alpha: 1.0)
        )
        gradient?.draw(in: path, angle: -45)

        if let symbol = NSImage(systemSymbolName: appIconName, accessibilityDescription: nil) {
            let config = NSImage.SymbolConfiguration(pointSize: iconSize * 0.45, weight: .medium)
                .applying(.init(paletteColors: [.white]))

            if let coloredSymbol = symbol.withSymbolConfiguration(config) {
                let symbolRect = NSRect(
                    x: (size - coloredSymbol.size.width) / 2,
                    y: (size - coloredSymbol.size.height) / 2,
                    width: coloredSymbol.size.width,
                    height: coloredSymbol.size.height
                )
                coloredSymbol.draw(in: symbolRect)
            }
        }

        image.unlockFocus()
        NSApp.applicationIconImage = image
    }
}

// MARK: - Navigation Manager

class NavigationManager: ObservableObject {
    static let shared = NavigationManager()

    private let selectedItemKey = "Demo.selectedNavItem"

    @Published var selectedItem: NavItem? {
        didSet {
            // 保存选中状态
            if let item = selectedItem {
                UserDefaults.standard.set(item.rawValue, forKey: selectedItemKey)
            }
        }
    }

    private init() {
        // 恢复上次选中状态
        if let savedRawValue = UserDefaults.standard.string(forKey: selectedItemKey),
           let savedItem = NavItem(rawValue: savedRawValue) {
            selectedItem = savedItem
        } else {
            selectedItem = .introduction
        }
    }

    func navigate(to item: NavItem) {
        selectedItem = item
    }
}

struct ContentView: View {
    @StateObject private var navManager = NavigationManager.shared
    @EnvironmentObject var configProvider: Moin.ConfigProvider
    @Localized var tr
    @State private var typographyTab: TypographyExamplesTab = .examples
    @State private var tagTab: TagExamplesTab = .examples
    @State private var spaceTab: SpaceExamplesTab = .examples
    @State private var dividerTab: DividerExamplesTab = .examples
    @State private var tokenTab: TokenExamplesTab = .examples
    @State private var badgeTab: BadgeExamplesTab = .examples
    @State private var avatarTab: AvatarExamplesTab = .examples
    @State private var emptyTab: EmptyExamplesTab = .examples
    @State private var spinTab: SpinExamplesTab = .examples
    @State private var statisticTab: StatisticExamplesTab = .examples
    @State private var alertTab: AlertExamplesTab = .examples
    @State private var progressTab: ProgressExamplesTab = .examples
    @State private var buttonTab: ButtonExamplesTab = .examples
    @State private var switchTab: SwitchExamplesTab = .examples
    @State private var checkboxTab: CheckboxExamplesTab = .examples

    var body: some View {
        NavigationSplitView {
            Sidebar(selection: $navManager.selectedItem)
                .navigationSplitViewColumnWidth(min: 240, ideal: 300, max: 420)
        } detail: {
            DetailView(item: navManager.selectedItem, buttonTab: $buttonTab, switchTab: $switchTab, checkboxTab: $checkboxTab, typographyTab: $typographyTab, tagTab: $tagTab, spaceTab: $spaceTab, dividerTab: $dividerTab, badgeTab: $badgeTab, avatarTab: $avatarTab, emptyTab: $emptyTab, spinTab: $spinTab, statisticTab: $statisticTab, alertTab: $alertTab, progressTab: $progressTab, tokenTab: $tokenTab)
                .navigationTitle(navManager.selectedItem.map { tr($0.titleKey) } ?? "MoinUI")
                .toolbar {
                    ToolbarItemGroup(placement: .primaryAction) {
                        // Button 页面显示 Tab 切换
                        if navManager.selectedItem == .button {
                            Picker("", selection: $buttonTab) {
                                Text(tr("tab.examples")).tag(ButtonExamplesTab.examples)
                                Text("API").tag(ButtonExamplesTab.api)
                                Text("Token").tag(ButtonExamplesTab.token)
                            }
                            .pickerStyle(.segmented)
                            .fixedSize()
                        }

                        // Switch 页面显示 Tab 切换
                        if navManager.selectedItem == .switch {
                            Picker("", selection: $switchTab) {
                                Text(tr("tab.examples")).tag(SwitchExamplesTab.examples)
                                Text("API").tag(SwitchExamplesTab.api)
                                Text("Token").tag(SwitchExamplesTab.token)
                            }
                            .pickerStyle(.segmented)
                            .fixedSize()
                        }

                        // Checkbox 页面显示 Tab 切换
                        if navManager.selectedItem == .checkbox {
                            Picker("", selection: $checkboxTab) {
                                Text(tr("tab.examples")).tag(CheckboxExamplesTab.examples)
                                Text("API").tag(CheckboxExamplesTab.api)
                                Text("Token").tag(CheckboxExamplesTab.token)
                            }
                            .pickerStyle(.segmented)
                            .fixedSize()
                        }

                        // Typography 页面显示 Tab 切换
                        if navManager.selectedItem == .typography {
                            Picker("", selection: $typographyTab) {
                                Text(tr("tab.examples")).tag(TypographyExamplesTab.examples)
                                Text(tr("tab.api")).tag(TypographyExamplesTab.api)
                                Text(tr("tab.token")).tag(TypographyExamplesTab.token)
                            }
                            .pickerStyle(.segmented)
                            .fixedSize()
                        }

                        // Tag 页面显示 Tab 切换
                        if navManager.selectedItem == .tag {
                            Picker("", selection: $tagTab) {
                                Text(tr("tab.examples")).tag(TagExamplesTab.examples)
                                Text(tr("tab.api")).tag(TagExamplesTab.api)
                                Text(tr("tab.token")).tag(TagExamplesTab.token)
                            }
                            .pickerStyle(.segmented)
                            .fixedSize()
                        }

                        // Space 页面显示 Tab 切换
                        if navManager.selectedItem == .space {
                            Picker("", selection: $spaceTab) {
                                Text(tr("tab.examples")).tag(SpaceExamplesTab.examples)

                                Text(tr("tab.api")).tag(SpaceExamplesTab.api)
                                Text(tr("tab.token")).tag(SpaceExamplesTab.token)
                            }
                            .pickerStyle(.segmented)
                            .fixedSize()
                        }

                        // Divider 页面显示 Tab 切换
                        if navManager.selectedItem == .divider {
                            Picker("", selection: $dividerTab) {
                                Text(tr("tab.examples")).tag(DividerExamplesTab.examples)

                                Text(tr("tab.api")).tag(DividerExamplesTab.api)
                                Text(tr("tab.token")).tag(DividerExamplesTab.token)
                            }
                            .pickerStyle(.segmented)
                            .fixedSize()
                        }

                        // Badge 页面显示 Tab 切换
                        if navManager.selectedItem == .badge {
                            Picker("", selection: $badgeTab) {
                                Text(tr("tab.examples")).tag(BadgeExamplesTab.examples)

                                Text(tr("tab.api")).tag(BadgeExamplesTab.api)
                                Text(tr("tab.token")).tag(BadgeExamplesTab.token)
                            }
                            .pickerStyle(.segmented)
                            .fixedSize()
                        }

                        // Avatar 页面显示 Tab 切换
                        if navManager.selectedItem == .avatar {
                            Picker("", selection: $avatarTab) {
                                Text(tr("tab.examples")).tag(AvatarExamplesTab.examples)

                                Text(tr("tab.api")).tag(AvatarExamplesTab.api)
                                Text(tr("tab.token")).tag(AvatarExamplesTab.token)
                            }
                            .pickerStyle(.segmented)
                            .fixedSize()
                        }

                        // Empty 页面显示 Tab 切换
                        if navManager.selectedItem == .empty {
                            Picker("", selection: $emptyTab) {
                                Text(tr("tab.examples")).tag(EmptyExamplesTab.examples)

                                Text(tr("tab.api")).tag(EmptyExamplesTab.api)
                                Text(tr("tab.token")).tag(EmptyExamplesTab.token)
                            }
                            .pickerStyle(.segmented)
                            .fixedSize()
                        }

                        // Spin 页面显示 Tab 切换
                        if navManager.selectedItem == .spin {
                            Picker("", selection: $spinTab) {
                                Text(tr("tab.examples")).tag(SpinExamplesTab.examples)

                                Text(tr("tab.api")).tag(SpinExamplesTab.api)
                                Text(tr("tab.token")).tag(SpinExamplesTab.token)
                            }
                            .pickerStyle(.segmented)
                            .fixedSize()
                        }
                        
                         // Statistic 页面显示 Tab 切换
                        if navManager.selectedItem == .statistic {
                            Picker("", selection: $statisticTab) {
                                Text(tr("tab.examples")).tag(StatisticExamplesTab.examples)

                                Text(tr("tab.api")).tag(StatisticExamplesTab.api)
                                Text(tr("tab.token")).tag(StatisticExamplesTab.token)
                            }
                            .pickerStyle(.segmented)
                            .fixedSize()
                        }

                        // Alert 页面显示 Tab 切换
                        if navManager.selectedItem == .alert {
                             Picker("", selection: $alertTab) {
                                 Text(tr("tab.examples")).tag(AlertExamplesTab.examples)
                                 Text(tr("tab.api")).tag(AlertExamplesTab.api)
                                 Text(tr("tab.token")).tag(AlertExamplesTab.token)
                             }
                             .pickerStyle(.segmented)
                             .fixedSize()
                        }

                        // Progress 页面显示 Tab 切换
                        if navManager.selectedItem == .progress {
                             Picker("", selection: $progressTab) {
                                 Text(tr("tab.examples")).tag(ProgressExamplesTab.examples)
                                 Text(tr("tab.api")).tag(ProgressExamplesTab.api)
                                 Text(tr("tab.token")).tag(ProgressExamplesTab.token)
                             }
                             .pickerStyle(.segmented)
                             .fixedSize()
                        }

                        Spacer()

                        Button {
                            configProvider.toggleTheme()
                        } label: {
                            Image(systemName: configProvider.isDarkMode ? "sun.max.fill" : "moon.fill")
                                .font(.system(size: 14))
                        }
                        .help(tr(configProvider.isDarkMode ? "toolbar.switch_light" : "toolbar.switch_dark"))

                        Picker("", selection: $configProvider.locale) {
                            Text(tr("toolbar.lang_zh")).tag(Moin.Locale.zhCN)
                            Text(tr("toolbar.lang_en")).tag(Moin.Locale.enUS)
                        }
                        .pickerStyle(.segmented)
                        .frame(width: 100)
                    }
                }
        }
        .transaction { transaction in
            transaction.animation = nil
        }
        .navigationSplitViewStyle(.balanced)
        .frame(minWidth: 1200, minHeight: 700)
    }
}

// MARK: - Navigation Items

enum NavItem: String, Identifiable {
    // Overview
    case introduction
    case quickStart

    // Components - General
    case button
    case typography
    case tag

    // Components - Data Display
    case badge
    case avatar
    case empty
    case statistic
    case `switch`
    case checkbox

    // Components - Feedback
    case alert
    case spin
    case progress

    // Components - Layout
    case space
    case divider

    // Development
    case theme
    case token
    case configProvider
    case localization
    case colors

    var id: String { rawValue }

    var icon: String {
        switch self {
        case .introduction: return DemoIcons.introduction
        case .quickStart: return DemoIcons.quickStart
        case .theme: return DemoIcons.theme
        case .token: return DemoIcons.token
        case .button: return DemoIcons.button
        case .typography: return DemoIcons.typography
        case .tag: return DemoIcons.tag
        case .badge: return DemoIcons.badge
        case .avatar: return DemoIcons.avatar
        case .empty: return DemoIcons.empty
        case .statistic: return DemoIcons.statistic
        case .switch: return DemoIcons.switchIcon
        case .checkbox: return DemoIcons.checkbox
        case .alert: return DemoIcons.alert
        case .spin: return DemoIcons.spin
        case .progress: return DemoIcons.progress
        case .space: return DemoIcons.space
        case .divider: return DemoIcons.divider
        case .configProvider: return DemoIcons.configProvider
        case .localization: return DemoIcons.localization
        case .colors: return DemoIcons.colors
        }
    }

    var titleKey: String {
        switch self {
        case .introduction: return "nav.introduction"
        case .quickStart: return "nav.quick_start"
        case .theme: return "nav.theme"
        case .token: return "nav.token"
        case .button: return "component.button"
        case .typography: return "component.typography"
        case .tag: return "component.tag"
        case .badge: return "component.badge"
        case .avatar: return "component.avatar"
        case .empty: return "component.empty"
        case .statistic: return "component.statistic"
        case .switch: return "component.switch"
        case .checkbox: return "component.checkbox"
        case .alert: return "component.alert"
        case .spin: return "component.spin"
        case .progress: return "component.progress"
        case .space: return "component.space"
        case .divider: return "component.divider"
        case .configProvider: return "component.configProvider"
        case .localization: return "component.localization"
        case .colors: return "component.colors"
        }
    }

    static var overview: [NavItem] { [.introduction, .quickStart] }
    static var general: [NavItem] { [.button, .tag, .typography] }
    static var dataEntry: [NavItem] { [.switch, .checkbox] }
    static var dataDisplay: [NavItem] { [.avatar, .badge, .empty, .statistic] }
    static var feedback: [NavItem] { [.alert, .spin, .progress] }
    static var layout: [NavItem] { [.divider, .space] }
    static var development: [NavItem] { [.theme, .token, .configProvider, .localization, .colors] }
}

// MARK: - Sidebar

struct Sidebar: View {
    @Binding var selection: NavItem?
    @Localized var tr

    var body: some View {
        List(selection: $selection) {
            Section(tr("nav.overview")) {
                ForEach(NavItem.overview) { item in
                    NavigationLink(value: item) {
                        Label(tr(item.titleKey), systemImage: item.icon)
                    }
                }
            }

            Section(tr("nav.development")) {
                ForEach(NavItem.development) { item in
                    NavigationLink(value: item) {
                        Label(tr(item.titleKey), systemImage: item.icon)
                    }
                }
            }

            Section(tr("nav.general")) {
                ForEach(NavItem.general) { item in
                    NavigationLink(value: item) {
                        Label {
                            Text(tr(item.titleKey))
                        } icon: {
                            Image(systemName: item.icon)
                                .environment(\.locale, Locale(identifier: "en"))
                        }
                    }
                }
            }

            Section(tr("nav.data_entry")) {
                ForEach(NavItem.dataEntry) { item in
                    NavigationLink(value: item) {
                        Label(tr(item.titleKey), systemImage: item.icon)
                    }
                }
            }

            Section(tr("nav.data_display")) {
                ForEach(NavItem.dataDisplay) { item in
                    NavigationLink(value: item) {
                        Label(tr(item.titleKey), systemImage: item.icon)
                    }
                }
            }

            Section(tr("nav.feedback")) {
                ForEach(NavItem.feedback) { item in
                    NavigationLink(value: item) {
                        Label(tr(item.titleKey), systemImage: item.icon)
                    }
                }
            }

            Section(tr("nav.layout")) {
                ForEach(NavItem.layout) { item in
                    NavigationLink(value: item) {
                        Label(tr(item.titleKey), systemImage: item.icon)
                    }
                }
            }
        }
        .listStyle(.sidebar)
        .frame(minWidth: 240, maxWidth: 240)
        .navigationTitle("MoinUI")
    }
}

// MARK: - Detail View

struct DetailView: View {
    let item: NavItem?
    @Binding var buttonTab: ButtonExamplesTab
    @Binding var switchTab: SwitchExamplesTab
    @Binding var checkboxTab: CheckboxExamplesTab
    @Binding var typographyTab: TypographyExamplesTab
    @Binding var tagTab: TagExamplesTab
    @Binding var spaceTab: SpaceExamplesTab
    @Binding var dividerTab: DividerExamplesTab
    @Binding var badgeTab: BadgeExamplesTab
    @Binding var avatarTab: AvatarExamplesTab
    @Binding var emptyTab: EmptyExamplesTab
    @Binding var spinTab: SpinExamplesTab
    @Binding var statisticTab: StatisticExamplesTab
    @Binding var alertTab: AlertExamplesTab
    @Binding var progressTab: ProgressExamplesTab
    @Binding var tokenTab: TokenExamplesTab

    var body: some View {
        Group {
            switch item {
            case .introduction, .none:
                HomeView()
            case .quickStart:
                QuickStartView()
            case .theme:
                ThemeView()
            case .token:
                TokenExamples(selectedTab: $tokenTab)
            case .button:
                ButtonExamples(selectedTab: $buttonTab)
            case .switch:
                SwitchExamples(selectedTab: $switchTab)
            case .checkbox:
                CheckboxExamples(selectedTab: $checkboxTab)
            case .typography:
                TypographyExamples(selectedTab: $typographyTab)
            case .tag:
                TagExamples(selectedTab: $tagTab)
            case .badge:
                BadgeExamples(selectedTab: $badgeTab)
            case .avatar:
                AvatarExamples(selectedTab: $avatarTab)
            case .empty:
                EmptyExamples(selectedTab: $emptyTab)
            case .spin:
                SpinExamples(selectedTab: $spinTab)
            case .statistic:
                StatisticExamplesWrapper(selectedTab: $statisticTab)
            case .alert:
                AlertExamplesWrapper(selectedTab: $alertTab)
            case .progress:
                ProgressExamplesWrapper(selectedTab: $progressTab)
            case .space:
                SpaceExamples(selectedTab: $spaceTab)
            case .divider:
                DividerExamples(selectedTab: $dividerTab)
            case .configProvider:
                ConfigProviderExamples()
            case .localization:
                LocalizationExamples()
            case .colors:
                ColorsExamples()
            }
        }
    }
}

/// Global logger
public let logger = Logger(subsystem: "com.moinui", category: "MoinUI")


