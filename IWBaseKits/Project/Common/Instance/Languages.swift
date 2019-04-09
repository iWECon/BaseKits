//
//  Languages.swift
//  IWBaseKits
//
//  Created by 未来 on 2019/4/8.
//  Copyright © 2019 iWECon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Localize_Swift

fileprivate let languageKey = "languageKey"

class Languages: NSObject {
    
    enum Language {
        case zh_cn
        case en
        case italy
        case system
        
        var value: String {
            switch self {
            case .zh_cn:
                return "zh-Hans"
            case .en:
                return "en"
            case .italy:
                return "it"
            case .system:
                return "system"
            }
        }
        
        init(_ value: String) {
            if value == "zh-Hans" {
                self = .zh_cn
            } else if (value == "en") {
                self = .en
            } else if (value == "it") {
                self = .italy
            } else {
                self = .system
            }
        }
    }
    
    static let shared = Languages.init(use: Languages.currentLanguage())
    
    private var _language = BehaviorRelay<Language>.init(value: .zh_cn)
    public var language: Driver<Void>!
    
    convenience init(use lang: Language) {
        self.init()
        use(lang)
        language = _language.distinctUntilChanged().mapToVoid().share(replay: 1, scope: .forever).asDriver(onErrorJustReturn: ())
    }
    
    func use(_ lang: Language) -> Void {
        if lang == .system {
            removeCurrentLanguage()
            Localize.setCurrentLanguage(Localize.defaultLanguage())
        } else {
            Localize.setCurrentLanguage(lang.value)
        }
        _language.accept(lang)
        save()
    }
    
    private func save() {
        if _language.value == .system {
            return
        }
        if Localize.availableLanguages(true).contains(_language.value.value) {
            UserDefaults.standard.set(_language.value.value, forKey: languageKey)
            UserDefaults.standard.synchronize()
            return
        }
        Console.error("The language(\(_language.value.value)) save failed. Bcz is not contains in available languages!")
    }
    
    static func currentLanguage() -> Language {
        if let lang = UserDefaults.standard.string(forKey: languageKey) {
            return Language.init(lang)
        }
        return .system
    }
    
    private func removeCurrentLanguage() {
        UserDefaults.standard.removeObject(forKey: languageKey)
        UserDefaults.standard.synchronize()
    }
}


