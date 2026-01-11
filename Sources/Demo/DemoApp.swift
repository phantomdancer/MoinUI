import SwiftUI
import AppKit
import MoinUI
import os

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
                .modifier(DisableFocusEffectModifier())
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
    @State private var buttonTab: ButtonExamplesTab = .examples
    @State private var typographyTab: TypographyExamplesTab = .examples
    @State private var spaceTab: SpaceExamplesTab = .examples
    @State private var dividerTab: DividerExamplesTab = .examples

    var body: some View {
        NavigationSplitView {
            Sidebar(selection: $navManager.selectedItem)
                .modifier(HideSidebarToggleModifier())
        } detail: {
            DetailView(item: navManager.selectedItem, buttonTab: $buttonTab, typographyTab: $typographyTab, spaceTab: $spaceTab, dividerTab: $dividerTab)
                .navigationTitle(navManager.selectedItem.map { tr($0.titleKey) } ?? "MoinUI")
                .toolbar {
                    ToolbarItemGroup(placement: .primaryAction) {
                        // 按钮页面显示 Tab 切换（分段控件样式）
                        if navManager.selectedItem == .button {
                            Picker("", selection: $buttonTab) {
                                Text(tr("tab.examples")).tag(ButtonExamplesTab.examples)
                                Text(tr("tab.playground")).tag(ButtonExamplesTab.playground)
                                Text(tr("tab.api")).tag(ButtonExamplesTab.api)
                                Text(tr("tab.token")).tag(ButtonExamplesTab.token)
                            }
                            .pickerStyle(.segmented)
                            .fixedSize()
                        }

                        // Typography 页面显示 Tab 切换
                        if navManager.selectedItem == .typography {
                            Picker("", selection: $typographyTab) {
                                Text(tr("tab.examples")).tag(TypographyExamplesTab.examples)
                                Text(tr("tab.playground")).tag(TypographyExamplesTab.playground)
                                Text(tr("tab.api")).tag(TypographyExamplesTab.api)
                                Text(tr("tab.token")).tag(TypographyExamplesTab.token)
                            }
                            .pickerStyle(.segmented)
                            .fixedSize()
                        }

                        // Space 页面显示 Tab 切换
                        if navManager.selectedItem == .space {
                            Picker("", selection: $spaceTab) {
                                Text(tr("tab.examples")).tag(SpaceExamplesTab.examples)
                                Text(tr("tab.playground")).tag(SpaceExamplesTab.playground)
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
                                Text(tr("tab.playground")).tag(DividerExamplesTab.playground)
                                Text(tr("tab.api")).tag(DividerExamplesTab.api)
                                Text(tr("tab.token")).tag(DividerExamplesTab.token)
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
        .navigationSplitViewStyle(.balanced)
        .frame(minWidth: 1200, minHeight: 700)
    }
}

// MARK: - Navigation Items

enum NavItem: String, Identifiable {
    // Overview
    case introduction
    case quickStart

    // Components
    case button
    case typography
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
        case .introduction: return "house"
        case .quickStart: return "play.circle"
        case .theme: return "paintbrush"
        case .token: return "square.stack.3d.up"
        case .button: return "rectangle.and.hand.point.up.left"
        case .typography: return "textformat.size"
        case .space: return "rectangle.split.3x1"
        case .divider: return "minus"
        case .configProvider: return "gearshape"
        case .localization: return "globe"
        case .colors: return "paintpalette"
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
        case .space: return "component.space"
        case .divider: return "component.divider"
        case .configProvider: return "component.configProvider"
        case .localization: return "component.localization"
        case .colors: return "component.colors"
        }
    }

    static var overview: [NavItem] { [.introduction, .quickStart] }
    static var general: [NavItem] { [.button, .typography] }
    static var layout: [NavItem] { [.space, .divider] }
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

            Section(tr("nav.layout")) {
                ForEach(NavItem.layout) { item in
                    NavigationLink(value: item) {
                        Label(tr(item.titleKey), systemImage: item.icon)
                    }
                }
            }
        }
        .listStyle(.sidebar)
        .frame(minWidth: 180)
        .navigationTitle("MoinUI")
    }
}

// MARK: - Detail View

struct DetailView: View {
    let item: NavItem?
    @Binding var buttonTab: ButtonExamplesTab
    @Binding var typographyTab: TypographyExamplesTab
    @Binding var spaceTab: SpaceExamplesTab
    @Binding var dividerTab: DividerExamplesTab

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
                TokenExamples()
            case .button:
                ButtonExamples(selectedTab: $buttonTab)
            case .typography:
                TypographyExamples(selectedTab: $typographyTab)
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

/// 隐藏侧边栏切换按钮
struct HideSidebarToggleModifier: ViewModifier {
    func body(content: Content) -> some View {
        if #available(macOS 14.0, *) {
            content.toolbar(removing: .sidebarToggle)
        } else {
            content
        }
    }
}

/// 禁用聚焦效果（兼容 macOS 13+）
struct DisableFocusEffectModifier: ViewModifier {
    func body(content: Content) -> some View {
        if #available(macOS 14.0, *) {
            content.focusEffectDisabled()
        } else {
            content
        }
    }
}
