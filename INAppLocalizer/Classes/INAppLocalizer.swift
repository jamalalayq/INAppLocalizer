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
    
    /// get localize string for key from localizable files
    public var localized: String {
        guard let languageStringsFilePath = Bundle.main.path(forResource: INAppLocalizer.current, ofType: "lproj") else { return Bundle.main.localizedString(forKey: self, value: nil, table: nil) }
        return Bundle(path: languageStringsFilePath)?.localizedString(forKey: self, value: nil, table: nil) ?? self
    }
}


/// Use enums to grouped localizations keys and inherit from LocalizedKey protocol.
public protocol LocalizedKey: RawRepresentable where Self.RawValue == String { }

/// Nice way to make localizations more readable.
public protocol Localizer { }
public extension Localizer {
    func localize<Key: LocalizedKey>(for key: Key) -> String {
        return key.rawValue.localized
    }
}
