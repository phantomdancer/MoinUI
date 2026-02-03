import Foundation
import os
import MoinUI

private let translationsLogger = Logger(subsystem: "Demo", category: "Translations")

/// Demo app translations loader
enum DemoTranslations {
    /// 组件翻译子目录列表
    private static let componentDirs = [
        "Locales/Avatar",
        "Locales/Button",
        "Locales/Typography",
        "Locales/Tag",
        "Locales/Badge",
        "Locales/Space",
        "Locales/Divider",
        "Locales/Colors",
        "Locales/QuickStart",
        "Locales/Theme",
        "Locales/Token",
        "Locales/ConfigProvider",
        "Locales/Localization",
        "Locales/Empty",
        "Locales/Spin",
        "Locales/Statistic",
        "Locales/Alert",
        "Locales/Progress",
        "Locales/Switch",
        "Locales/Checkbox",
        "Locales/Radio",
        "Locales/Skeleton",
        "Locales/Rate",
        "Locales/Slider",
        "Locales/Result",
        "Locales/Tooltip",
        "Locales/Popover",
    ]

    static func register() {
        for locale in Moin.Locale.allCases {
            // 1. 先加载主 Locales 目录的共享翻译
            loadTranslations(locale: locale, subdirectory: "Locales/Common")

            // 2. 加载各组件子目录的翻译
            for dir in componentDirs {
                loadTranslations(locale: locale, subdirectory: dir)
            }
        }
    }

    private static func loadTranslations(locale: Moin.Locale, subdirectory: String) {
        let url = Bundle.module.url(forResource: locale.rawValue, withExtension: "json", subdirectory: subdirectory)

        if let url = url {
            translationsLogger.info("Found locale file: \(url.path)")
            if let data = try? Data(contentsOf: url) {
                do {
                    try Moin.Localization.shared.registerFromJSON(data, locale: locale)
                    translationsLogger.info("Registered locale from \(subdirectory): \(locale.rawValue)")
                } catch {
                    translationsLogger.error("Failed to register locale \(locale.rawValue) from \(subdirectory): \(error)")
                }
            }
        } else {
            translationsLogger.debug("Locale file not found in \(subdirectory): \(locale.rawValue)")
        }
    }
}
