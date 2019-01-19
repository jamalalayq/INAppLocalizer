//
//  ViewController.swift
//  INAppLocalizer
//
//  Created by gemgemo on 09/02/2017.
//  Copyright (c) 2017 gemgemo. All rights reserved.
//

import UIKit
import INAppLocalizer

class ViewController: UIViewController, Localizer {

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(onLanguageDidChanged), name: .languageDidChanged, object: nil)
        print(INAppLocalizer.current)
        print(INAppLocalizer.getSelectedLanguages())
        INAppLocalizer.set(language: "ar")
    }

    @objc func onLanguageDidChanged() {
        let language = localize(for: LocalizationsKeys.language)
        print(#function, language)
    }

}

enum LocalizationsKeys: String, LocalizedKey {
    case language = "langauge.lan"
}
