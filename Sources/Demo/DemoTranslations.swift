import Foundation
import os
import MoinUI

private let translationsLogger = Logger(subsystem: "MoinUIDemo", category: "Translations")

/// Demo app translations loader
enum DemoTranslations {
    static func register() {
        for locale in MoinUILocale.allCases {
            // Try with subdirectory first, then without
            let url = Bundle.module.url(forResource: locale.rawValue, withExtension: "json", subdirectory: "Locales")
                ?? Bundle.module.url(forResource: locale.rawValue, withExtension: "json")

            if let url = url {
                translationsLogger.info("Found locale file: \(url.path)")
                if let data = try? Data(contentsOf: url) {
                    do {
                        try MoinUILocalization.shared.registerFromJSON(data, locale: locale)
                        translationsLogger.info("Registered locale: \(locale.rawValue)")
                    } catch {
                        translationsLogger.error("Failed to register locale \(locale.rawValue): \(error)")
                    }
                }
            } else {
                translationsLogger.warning("Locale file not found: \(locale.rawValue)")
            }
        }
    }
}
