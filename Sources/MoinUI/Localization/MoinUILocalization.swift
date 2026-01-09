import SwiftUI

// MARK: - Moin.Locale

public extension Moin {
    /// Supported locales
    enum Locale: String, CaseIterable, Sendable {
        case zhCN = "zh-CN"
        case enUS = "en-US"

        public static var `default`: Locale { .zhCN }

        /// Locale file name
        var fileName: String { rawValue }
    }
}

/// 旧名别名（已弃用）
@available(*, deprecated, renamed: "Moin.Locale")
public typealias MoinUILocale = Moin.Locale

// MARK: - Moin.Localization

public extension Moin {
    /// Localization manager
    final class Localization: ObservableObject {
        public static let shared = Localization()

        @Published public var locale: Moin.Locale = .default

        /// Flat translation dictionary for each locale
        private var translations: [Moin.Locale: [String: String]] = [:]

        /// Custom translations registered at runtime
        private var customTranslations: [Moin.Locale: [String: String]] = [:]

        private init() {
            loadBuiltinLocales()
        }

        // MARK: - Public API

        /// Set current locale
        public func setLocale(_ locale: Moin.Locale) {
            self.locale = locale
        }

        /// Get translated string for current locale
        public func tr(_ key: String) -> String {
            // Priority: custom > builtin > fallback to English > return key
            if let value = customTranslations[locale]?[key] {
                return value
            }
            if let value = translations[locale]?[key] {
                return value
            }
            if locale != .enUS, let value = translations[.enUS]?[key] {
                return value
            }
            return key
        }

        /// Get translated string for specific locale
        public func tr(_ key: String, locale: Moin.Locale) -> String {
            if let value = customTranslations[locale]?[key] {
                return value
            }
            if let value = translations[locale]?[key] {
                return value
            }
            if locale != .enUS, let value = translations[.enUS]?[key] {
                return value
            }
            return key
        }

        // MARK: - Registration API

        /// Register a single translation
        public func register(_ key: String, translations: [Moin.Locale: String]) {
            for (locale, value) in translations {
                customTranslations[locale, default: [:]][key] = value
            }
        }

        /// Register multiple translations at once
        public func registerAll(_ items: [(String, [Moin.Locale: String])]) {
            for (key, trans) in items {
                register(key, translations: trans)
            }
        }

        /// Register translations from a dictionary (nested JSON structure)
        public func registerFromDictionary(_ dict: [String: Any], locale: Moin.Locale, prefix: String = "") {
            let flattened = flattenDictionary(dict, prefix: prefix)
            for (key, value) in flattened {
                customTranslations[locale, default: [:]][key] = value
            }
        }

        /// Register translations from JSON data
        public func registerFromJSON(_ data: Data, locale: Moin.Locale) throws {
            guard let dict = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                throw LocalizationError.invalidJSON
            }
            registerFromDictionary(dict, locale: locale)
        }

        /// Register translations from JSON string
        public func registerFromJSONString(_ json: String, locale: Moin.Locale) throws {
            guard let data = json.data(using: .utf8) else {
                throw LocalizationError.invalidJSON
            }
            try registerFromJSON(data, locale: locale)
        }

        // MARK: - Private Methods

        /// Load built-in locale files from bundle
        private func loadBuiltinLocales() {
            for locale in Moin.Locale.allCases {
                if let url = Bundle.module.url(forResource: locale.fileName, withExtension: "json", subdirectory: "Locales"),
                   let data = try? Data(contentsOf: url),
                   let dict = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
                    translations[locale] = flattenDictionary(dict, prefix: "")
                }
            }
        }

        /// Flatten nested dictionary to dot-notation keys
        private func flattenDictionary(_ dict: [String: Any], prefix: String) -> [String: String] {
            var result: [String: String] = [:]

            for (key, value) in dict {
                let fullKey = prefix.isEmpty ? key : "\(prefix).\(key)"

                if let stringValue = value as? String {
                    result[fullKey] = stringValue
                } else if let nestedDict = value as? [String: Any] {
                    let nested = flattenDictionary(nestedDict, prefix: fullKey)
                    result.merge(nested) { _, new in new }
                }
            }

            return result
        }
    }
}

/// 旧名别名（已弃用）
@available(*, deprecated, renamed: "Moin.Localization")
public typealias MoinUILocalization = Moin.Localization

// MARK: - Errors

public enum LocalizationError: Error {
    case invalidJSON
    case fileNotFound
}

// MARK: - Global shorthand function

/// Translate string using current locale
/// Usage: tr("key")
public func tr(_ key: String) -> String {
    Moin.Localization.shared.tr(key)
}

// MARK: - Environment

private struct MoinLocalizationKey: EnvironmentKey {
    static let defaultValue = Moin.Localization.shared
}

public extension EnvironmentValues {
    var moinLocalization: Moin.Localization {
        get { self[MoinLocalizationKey.self] }
        set { self[MoinLocalizationKey.self] = newValue }
    }
}
