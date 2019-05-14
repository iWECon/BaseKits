//
//  Languages.swift
//  IWBaseKits
//
//  Created by 未来 on 2019/4/8.
//  Copyright © 2019 iWECon. All rights reserved.
//

#if os(iOS)
import UIKit
import RxSwift
import RxCocoa
import Localize_Swift

fileprivate let languageKey = "languageKey"

class Languages: NSObject {
    
    enum Language: String {
        case zh_cn      = "zh-Hans"
        case en         = "en"
        case italy      = "it"
        case system     = "system"
    }
    
    static let shared = Languages.init(use: Languages.currentLanguage())
    
    private var _language = BehaviorRelay<Language>.init(value: Languages.currentLanguage())
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
            Localize.setCurrentLanguage(lang.rawValue)
        }
        _language.accept(lang)
        save()
    }
    
    private func save() {
        if _language.value == .system {
            return
        }
        if Localize.availableLanguages(true).contains(_language.value.rawValue) {
            UserDefaults.standard.set(_language.value.rawValue, forKey: languageKey)
            UserDefaults.standard.synchronize()
            return
        }
        Console.error("The language(\(_language.value.rawValue)) save failed. Bcz is not contains in available languages!")
    }
    
    static func currentLanguage() -> Language {
        if let lang = UserDefaults.standard.string(forKey: languageKey) {
            return Language.init(rawValue: lang).despair("The rawValue(\(lang)) can't convert to Language.")
        }
        return .system
    }
    
    private func removeCurrentLanguage() {
        UserDefaults.standard.removeObject(forKey: languageKey)
        UserDefaults.standard.synchronize()
    }
    
    static func displayName(forLanguage language: Language) -> String {
        if language == .system {
            return R.string.localizable.languagesFollowSystem.key.localized()
        }
        let local = Locale(identifier: language.rawValue)
        if let displayName = local.localizedString(forIdentifier: language.rawValue) {
            return displayName.capitalized(with: local)
        }
        return String()
    }
}
#endif
