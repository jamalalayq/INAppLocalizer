//
//  ViewController.swift
//  INAppLocalizer
//
//  Created by gemgemo on 09/02/2017.
//  Copyright (c) 2017 gemgemo. All rights reserved.
//

import UIKit
import INAppLocalizer

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(onLanguageDidChanged), name: .LanguageDidChanged, object: nil)
        print(INAppLocalizer.current)
        print(INAppLocalizer.getSelectedLanguages())
        INAppLocalizer.set(language: "en")
    }

    func onLanguageDidChanged() {
        debugPrint(#function)
    }

}

