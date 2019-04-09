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

class Languages: NSObject {
    
    enum Language {
        case zh_cn
        case en
        case italy
    }
    
    static let shared = Languages.init()
    
    private var _language = BehaviorRelay<Language>.init(value: .zh_cn)
    public var language: Driver<Void>!
    
    convenience init(use lang: Language) {
        self.init()
        _language.accept(lang)
        language = _language.mapToVoid().asDriver(onErrorJustReturn: ())
    }
    
    func use(_ lang: Language) -> Void {
        _language.accept(lang)
    }
}
