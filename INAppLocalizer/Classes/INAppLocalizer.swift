//  INAppLocalizer.swift
//  AppLocalizations
//  Created by Jamal on 9/2/17.
//  Copyright © 2017 Jamal. All rights reserved.

import Foundation

// MARK:-  Constants
fileprivate let defaultLanguageSign = "default.language.ia"

public final class INAppLocalizer: NSObject {
    
    private static let defaultSign = Bundle.main.preferredLocalizations[0]
    
    /**
     Get available languages from main bundle
     - returns: array of languages signs
     */
    public class func getSelectedLanguages() -> Array<String> {
        var languages = Bundle.main.localizations
        if let base = languages.index(of: "Base") {
            languages.remove(at: base)
        }
        return languages
    }
    
    /**
     Get default language or saved language
     - returns: language sign string
     */
    public static var current: String {
        return UserDefaults.standard.string(forKey: defaultLanguageSign) ?? defaultSign
    }
    
    /**
        Save language and put it defualt
     - parameter language: may be language sign to save it
     - returns: void
     */
    public class func set(language: String) -> Void {
        let lang = getSelectedLanguages().contains(language) ? language : defaultSign
        guard lang != current else { return }
        UserDefaults.standard.set(lang, forKey: defaultLanguageSign)
        UserDefaults.standard.synchronize()
        NotificationCenter.default.post(name: .languageDidChanged, object: lang)
    }
    
}


// MARK:-  Notifications.Name

public extension Notification.Name {
    public static var languageDidChanged: Notification.Name {
        return Notification.Name("language.did.changed.ia")
    }
}


// MARK:-  Strings

public extension String {
    
    @available(*, deprecated, renamed: "localize()" ,message: "This will be removed in v1.0; please migrate to localize function.")
    public var localized: String {
        let path = getStringsFilePath()
        return Bundle(path: path)?.localizedString(forKey: self, value: nil, table: nil) ?? self
    }
    
    
    /// Localize keys from custom tables
    ///
    /// - Parameter table: Strings files you want to localize from it.
    /// - Returns: localized key value
    public func localize(from table: String = "Localizable") -> String {
        let path = getStringsFilePath()
        return Bundle(path: path)?.localizedString(forKey: self, value: nil, table: table) ?? self
    }
    
    private func getStringsFilePath() -> String {
        guard let languageStringsFilePath = Bundle.main.path(forResource: INAppLocalizer.current, ofType: "lproj") else {
            return Bundle.main.localizedString(forKey: self, value: nil, table: nil)
        }
        return languageStringsFilePath
    }
}


/// Use enums to grouped localizations keys and inherit from LocalizedKey protocol.
public protocol LocalizedKey: RawRepresentable where Self.RawValue == String { }

/// Nice way to make localizations more readable.
public protocol Localizer { }

public extension Localizer {
    
    /// In order to localize keys from custom enums which inherit from **LocalizedKey**
    ///
    /// - Parameters:
    ///   - key: localized key
    ///   - table: The table which contain keys with localized values.
    /// - Returns: The localized value by key which passed in function.
    func localize<Key: LocalizedKey>(for key: Key, from table: String = "Localizable") -> String {
        return key.rawValue.localize(from: table)
    }
    
}
