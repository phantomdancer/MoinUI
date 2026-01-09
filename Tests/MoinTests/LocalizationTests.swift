import XCTest
@testable import MoinUI

final class LocalizationTests: XCTestCase {

    // MARK: - Basic Tests

    func testSharedInstance() {
        let instance1 = Moin.Localization.shared
        let instance2 = Moin.Localization.shared

        XCTAssertTrue(instance1 === instance2, "Should be same instance")
    }

    // MARK: - Translation Tests

    func testTranslationZhCN() {
        let localization = Moin.Localization.shared

        // 先注册一个自定义翻译，然后测试
        localization.register("test.key", translations: [.zhCN: "中文测试"])
        let test = localization.tr("test.key", locale: .zhCN)
        XCTAssertEqual(test, "中文测试", "Should return translated string for zh-CN")
        XCTAssertFalse(test.isEmpty, "Translated string should not be empty")
    }

    func testTranslationEnUS() {
        let localization = Moin.Localization.shared

        // 先注册一个自定义翻译，然后测试
        localization.register("test.key", translations: [.enUS: "English Test"])
        let test = localization.tr("test.key", locale: .enUS)
        XCTAssertEqual(test, "English Test", "Should return translated string for en-US")
        XCTAssertFalse(test.isEmpty, "Translated string should not be empty")
    }

    func testTranslationFallback() {
        let localization = Moin.Localization.shared

        // Test non-existent key
        let nonExistent = localization.tr("this.key.does.not.exist", locale: .zhCN)
        XCTAssertEqual(nonExistent, "this.key.does.not.exist", "Should return key as fallback")
    }

    func testTranslationForSpecificLocale() {
        let localization = Moin.Localization.shared

        // 先注册自定义翻译，然后测试
        localization.register("test.key", translations: [
            .zhCN: "中文",
            .enUS: "English"
        ])

        // Test translation for specific locale
        let overviewEn = localization.tr("test.key", locale: .enUS)
        let overviewZh = localization.tr("test.key", locale: .zhCN)

        XCTAssertNotEqual(overviewEn, overviewZh, "Translations for different locales should differ")
        XCTAssertEqual(overviewEn, "English", "Should return English translation for en-US locale")
        XCTAssertEqual(overviewZh, "中文", "Should return Chinese translation for zh-CN locale")
    }

    // MARK: - Custom Translation Tests

    func testRegisterCustomTranslation() {
        let localization = Moin.Localization.shared

        // Register custom translation
        localization.register("custom.key", translations: [
            .zhCN: "自定义翻译",
            .enUS: "Custom Translation"
        ])

        // Test custom translation
        let customZh = localization.tr("custom.key", locale: .zhCN)
        XCTAssertEqual(customZh, "自定义翻译", "Should return custom translation for zh-CN")

        let customEn = localization.tr("custom.key", locale: .enUS)
        XCTAssertEqual(customEn, "Custom Translation", "Should return custom translation for en-US")
    }

    func testRegisterAllTranslations() {
        let localization = Moin.Localization.shared

        // Register multiple custom translations
        localization.registerAll([
            ("custom.key1", [.zhCN: "自定义翻译1", .enUS: "Custom Translation 1"]),
            ("custom.key2", [.zhCN: "自定义翻译2", .enUS: "Custom Translation 2"])
        ])

        // Test both translations
        XCTAssertEqual(localization.tr("custom.key1", locale: .zhCN), "自定义翻译1")
        XCTAssertEqual(localization.tr("custom.key2", locale: .zhCN), "自定义翻译2")

        XCTAssertEqual(localization.tr("custom.key1", locale: .enUS), "Custom Translation 1")
        XCTAssertEqual(localization.tr("custom.key2", locale: .enUS), "Custom Translation 2")
    }

    // MARK: - JSON Registration Tests

    func testRegisterFromJSONString() throws {
        let localization = Moin.Localization.shared

        // Test valid JSON string
        let jsonString = "{\"test\": {\"key\": \"Test Value\"}}"
        try localization.registerFromJSONString(jsonString, locale: .enUS)

        let value = localization.tr("test.key", locale: .enUS)
        XCTAssertEqual(value, "Test Value", "Should register translation from JSON string")
    }

    func testRegisterFromJSONStringInvalid() {
        let localization = Moin.Localization.shared

        // Test invalid JSON string
        let invalidJSON = "invalid json"
        XCTAssertThrowsError(try localization.registerFromJSONString(invalidJSON, locale: .enUS),
                             "Should throw error for invalid JSON")
    }

    // MARK: - Dictionary Registration Tests

    func testRegisterFromDictionary() {
        let localization = Moin.Localization.shared

        // Test nested dictionary registration
        let nestedDict: [String: Any] = [
            "nested": [
                "key": "Nested Value",
                "another": [
                    "deep": "Deep Value"
                ]
            ]
        ]

        localization.registerFromDictionary(nestedDict, locale: .enUS)

        // Verify flattened keys work
        let value1 = localization.tr("nested.key", locale: .enUS)
        XCTAssertEqual(value1, "Nested Value", "Should register nested keys")

        let value2 = localization.tr("nested.another.deep", locale: .enUS)
        XCTAssertEqual(value2, "Deep Value", "Should register deeply nested keys")
    }

    func testRegisterFromJSON() throws {
        let localization = Moin.Localization.shared

        // Test valid JSON data
        let jsonData = "{\"json\": {\"key\": \"JSON Value\"}}".data(using: .utf8)!
        try localization.registerFromJSON(jsonData, locale: .enUS)

        let value = localization.tr("json.key", locale: .enUS)
        XCTAssertEqual(value, "JSON Value", "Should register translation from JSON data")
    }

    func testRegisterFromJSONInvalidData() {
        let localization = Moin.Localization.shared

        // Test invalid JSON data
        let invalidData = Data([0x00, 0x01, 0x02]) // Invalid JSON bytes
        XCTAssertThrowsError(try localization.registerFromJSON(invalidData, locale: .enUS),
                             "Should throw error for invalid JSON data")
    }

    func testRegisterFromInvalidJSONFormat() {
        let localization = Moin.Localization.shared

        // Test valid JSON but not a dictionary
        let arrayJSON = "[\"value1\", \"value2\"]"
        XCTAssertThrowsError(try localization.registerFromJSONString(arrayJSON, locale: .enUS),
                             "Should throw error for non-dictionary JSON")
    }

    // MARK: - Translation Priority Tests

    func testTranslationPriority() {
        let localization = Moin.Localization.shared

        // Register custom translation
        localization.register("priority.test", translations: [.zhCN: "Custom Value"])

        // Custom translation should take priority
        let value = localization.tr("priority.test", locale: .zhCN)
        XCTAssertEqual(value, "Custom Value", "Custom translation should have higher priority")
    }

    // MARK: - Builtin Locale Loading Tests

    func testBuiltinLocalesLoading() {
        let localization = Moin.Localization.shared

        // Test that all locales are loaded (even if no translations are found)
        for locale in Moin.Locale.allCases {
            // Just verify we can call the method without errors
            let value = localization.tr("test.key", locale: locale)
            XCTAssertNotNil(value, "Should return non-nil value for any locale")
        }
    }

    // MARK: - Edge Case Tests

    func testRegisterFromEmptyDictionary() {
        let localization = Moin.Localization.shared

        // Test registering empty dictionary
        let emptyDict: [String: Any] = [:]
        localization.registerFromDictionary(emptyDict, locale: .enUS)

        // Should not crash and should return key for non-existent translations
        let value = localization.tr("nonexistent.key", locale: .enUS)
        XCTAssertEqual(value, "nonexistent.key")
    }

    func testRegisterFromDeepNestedDictionary() {
        let localization = Moin.Localization.shared

        // Test very deep nested dictionary
        let deepDict: [String: Any] = [
            "a": [
                "b": [
                    "c": [
                        "d": [
                            "e": [
                                "f": "Deep Value"
                            ]
                        ]
                    ]
                ]
            ]
        ]

        localization.registerFromDictionary(deepDict, locale: .enUS)

        // Verify the flattened key works
        let value = localization.tr("a.b.c.d.e.f", locale: .enUS)
        XCTAssertEqual(value, "Deep Value")
    }

    func testRegisterFromJSONStringWithInvalidData() {
        let localization = Moin.Localization.shared

        // Test with invalid JSON string that can't be converted to Data
        let invalidString = "\u{19}" // Invalid UTF-8 character
        XCTAssertThrowsError(try localization.registerFromJSONString(invalidString, locale: .enUS))
    }

    // MARK: - Locale Fallback Tests

    func testLocaleFallback() {
        let localization = Moin.Localization.shared

        // Register translation only for en-US (builtin translations)
        localization.registerFromDictionary(["fallback": ["key": "English Only"]], locale: .enUS)

        // Test fallback to en-US when zh-CN not found (only works for builtin/dictionary registrations)
        let fallbackValue = localization.tr("fallback.key", locale: .zhCN)
        XCTAssertEqual(fallbackValue, "English Only", "Should fallback to en-US translation")
    }
}
