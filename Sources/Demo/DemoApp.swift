import SwiftUI
import AppKit
import MoinUI
import os

@main
struct DemoApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject private var configProvider = MoinUIConfigProvider.shared

    init() {
        // Register Demo translations
        DemoTranslations.register()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .moinUIThemeRoot()
                .focusable(false)
                .modifier(DisableFocusEffectModifier())
                .textSelection(.enabled)
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
    func applicationDidFinishLaunching(_ notification: Notification) {
        NSApp.setActivationPolicy(.regular)
        setupAppIcon()
        NSApp.activate(ignoringOtherApps: true)

        // 窗口大小为屏幕一半，居中显示
        DispatchQueue.main.async {
            if let window = NSApp.windows.first, let screen = window.screen ?? NSScreen.main {
                let screenFrame = screen.visibleFrame
                let width = screenFrame.width / 2
                let height = screenFrame.height / 2
                let x = screenFrame.origin.x + (screenFrame.width - width) / 2
                let y = screenFrame.origin.y + (screenFrame.height - height) / 2
                window.setFrame(NSRect(x: x, y: y, width: width, height: height), display: true)
            }
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
    @Published var selectedItem: NavItem? = .introduction

    func navigate(to item: NavItem) {
        selectedItem = item
    }
}

struct ContentView: View {
    @StateObject private var navManager = NavigationManager.shared
    @EnvironmentObject var configProvider: MoinUIConfigProvider
    @EnvironmentObject var localization: MoinUILocalization

    var body: some View {
        NavigationSplitView {
            Sidebar(selection: $navManager.selectedItem)
                .modifier(HideSidebarToggleModifier())
        } detail: {
            DetailView(item: navManager.selectedItem)
        }
        .navigationSplitViewStyle(.balanced)
        .frame(minWidth: 1100, minHeight: 700)
        .toolbar {
            ToolbarItemGroup(placement: .automatic) {
                Link(destination: URL(string: "https://github.com/phantomdancer/moin-ui")!) {
                    if let image = Bundle.module.image(forResource: "github-fill") {
                        Image(nsImage: image)
                            .resizable()
                            .aspectRatio(1, contentMode: .fit)
                            .frame(width: 16, height: 16)
                    }
                }
                .help("GitHub")

                Button {
                    configProvider.toggleTheme()
                } label: {
                    Image(systemName: configProvider.isDarkMode ? "sun.max.fill" : "moon.fill")
                        .font(.system(size: 14))
                }
                .help(localization.tr(configProvider.isDarkMode ? "toolbar.switch_light" : "toolbar.switch_dark"))

                Picker("", selection: $localization.locale) {
                    Text(localization.tr("toolbar.lang_zh")).tag(MoinUILocale.zhCN)
                    Text(localization.tr("toolbar.lang_en")).tag(MoinUILocale.enUS)
                }
                .pickerStyle(.segmented)
                .frame(width: 100)
            }
        }
    }
}

// MARK: - Navigation Items

enum NavItem: String, Identifiable {
    // Overview
    case introduction
    case quickStart

    // Components
    case button

    // Development
    case theme
    case configProvider
    case localization

    var id: String { rawValue }

    var icon: String {
        switch self {
        case .introduction: return "house"
        case .quickStart: return "play.circle"
        case .theme: return "paintbrush"
        case .button: return "rectangle.and.hand.point.up.left"
        case .configProvider: return "gearshape"
        case .localization: return "globe"
        }
    }

    var titleKey: String {
        switch self {
        case .introduction: return "nav.introduction"
        case .quickStart: return "nav.quick_start"
        case .theme: return "nav.theme"
        case .button: return "component.button"
        case .configProvider: return "component.configProvider"
        case .localization: return "component.localization"
        }
    }

    static var overview: [NavItem] { [.introduction, .quickStart] }
    static var components: [NavItem] { [.button] }
    static var development: [NavItem] { [.theme, .configProvider, .localization] }
}

// MARK: - Sidebar

struct Sidebar: View {
    @Binding var selection: NavItem?
    @EnvironmentObject var localization: MoinUILocalization

    var body: some View {
        List(selection: $selection) {
            Section(localization.tr("nav.overview")) {
                ForEach(NavItem.overview) { item in
                    NavigationLink(value: item) {
                        Label(localization.tr(item.titleKey), systemImage: item.icon)
                    }
                }
            }

            Section(localization.tr("nav.development")) {
                ForEach(NavItem.development) { item in
                    NavigationLink(value: item) {
                        Label(localization.tr(item.titleKey), systemImage: item.icon)
                    }
                }
            }

            Section(localization.tr("nav.components")) {
                ForEach(NavItem.components) { item in
                    NavigationLink(value: item) {
                        Label(localization.tr(item.titleKey), systemImage: item.icon)
                    }
                }
            }
        }
        .listStyle(.sidebar)
        .frame(minWidth: 220)
        .navigationTitle("MoinUI")
    }
}

// MARK: - Detail View

struct DetailView: View {
    let item: NavItem?
    @EnvironmentObject var localization: MoinUILocalization

    var body: some View {
        Group {
            switch item {
            case .introduction, .none:
                HomeView()
            case .quickStart:
                QuickStartView()
            case .theme:
                ThemeView()
            case .button:
                ButtonExamples()
            case .configProvider:
                ConfigProviderExamples()
            case .localization:
                LocalizationExamples()
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
