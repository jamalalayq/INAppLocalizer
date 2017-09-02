//  INAppLocalizer.swift
//  AppLocalizations
//  Created by GeMoOo on 9/2/17.
//  Copyright © 2017 GeMoOo. All rights reserved.

import Foundation

// MARK:-  Constants
private let DefaultLanguageSign = "default.language.ia"

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
        return UserDefaults.standard.string(forKey: DefaultLanguageSign) ?? defaultSign
    }
    
    /**
        Save language and put it defualt
     - parameter language: may be language sign to save it
     - returns: void
     */
    public class func set(language: String) -> Void {
        let lang = getSelectedLanguages().contains(language) ? language : defaultSign
        guard (lang != current) else { return }
        UserDefaults.standard.set(lang, forKey: DefaultLanguageSign)
        UserDefaults.standard.synchronize()
        NotificationCenter.default.post(name: .LanguageDidChanged, object: nil)
    }
    
}


// MARK:-  Notifications.Name

public extension Notification.Name {
    public static var LanguageDidChanged: Notification.Name {
        return Notification.Name("language.did.changed.ia")
    }
}


// MARK:-  Strings

public extension String {
    
    /// get localize string for key from localizable files
    public var localize: String {
        guard let languageStringsFilePath = Bundle.main.path(forResource: INAppLocalizer.current, ofType: "lproj") else { return Bundle.main.localizedString(forKey: self, value: nil, table: nil) }
        return Bundle(path: languageStringsFilePath)?.localizedString(forKey: self, value: nil, table: nil) ?? self
    }
}




































