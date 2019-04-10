//
//  LanguageViewModel.swift
//  IWBaseKits
//
//  Created by 未来 on 2019/4/9.
//  Copyright © 2019 iWECon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Localize_Swift

class LanguageViewModel: IWTableViewModel {
    
    deinit {
        Console.debug("\(type(of: self)) deinit.")
    }
    
    override var instanceController: IWViewControllerable {
        return LanguageController.init(viewModel: self)
    }
    
    struct Input {
        var selectModelTrigger: Driver<LanguageSectionItem>
        var itemSelectedTrigger: Driver<IndexPath>
        var doneTrigger: Driver<()>
    }
    
    struct Output {
        var items: Driver<[LanguageSection]>
        var isDone: Driver<Bool>
    }
    
    private var selectedLanguage: Languages.Language? = .system
    
    override func initialized() {
        super.initialized()
        
        presentBackTitle = "取消"
    }
    
    func transform(_ input: Input) -> Output {
        let items = BehaviorRelay<[LanguageSection]>.init(value: [])

        Observable.just(()).map { (_) -> [LanguageSection] in
            let languages = Localize.availableLanguages(true)

            var itemModels = languages.map({ (language) -> LanguageSectionItem in
                let cellViewModel = LanguageCellViewModel.init(language)
                return LanguageSectionItem.languageItem(viewModel: cellViewModel)
            })

            let systemCellViewModel = LanguageCellViewModel.init("system")
            let systemModel = LanguageSectionItem.languageItem(viewModel: systemCellViewModel)
            itemModels.append(systemModel)

            return [LanguageSection.languages(title: R.string.localizable.languagesSectionTitle.key.localized() + "\(Languages.displayName(forLanguage: Languages.currentLanguage()))", items: itemModels)]

        }.bind(to: items).disposed(by: rx.disposeBag)


        let done = BehaviorRelay<Bool>.init(value: false)
        input.itemSelectedTrigger.onNext { [weak self] (idx) in

            switch items.value[idx.section].items[idx.row] {
            case .languageItem(let cvm):
                if Languages.currentLanguage().rawValue != cvm.mark {
                    done.accept(true)
                } else {
                    done.accept(false)
                }
                self?.selectedLanguage = Languages.Language.init(rawValue: cvm.mark)
            }

        }.disposed(by: rx.disposeBag)

        input.doneTrigger.onNext { [weak self] (_) in

            Languages.shared.use(self?.selectedLanguage ?? .system)
            self?.back(true)

        }.disposed(by: rx.disposeBag)

        return Output.init(items: items.asDriver(), isDone: done.asDriver())
    }
}
