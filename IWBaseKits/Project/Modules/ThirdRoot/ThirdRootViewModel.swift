//
//  ThirdRootViewModel.swift
//  IWBaseKits
//
//  Created by 未来 on 2019/3/29.
//  Copyright © 2019 iWECon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

//struct LanguageModel {
//    var name: String?
//    var mark: String?
//    var isSelected: Bool {
//        return Languages.currentLanguage().value == self.mark
//    }
//}

class ThirdRootViewModel: IWViewModel {
    
    override var instanceController: IWViewControllerable {
        return ThirdRootController.init(viewModel: self)
    }
    
//    var datas = BehaviorRelay<[SectionModel<String?, LanguageModel>]>.init(value: [])
    
    override func initialized() {
        super.initialized()
        
        navigationBarTitle.accept("语言")
        
        
//        let zhCNModel = LanguageModel.init(name: R.string.localizable.languagesChineseHans.key.localized(), mark: "zh-Hans")
//        let enModel = LanguageModel.init(name: R.string.localizable.languagesEnglish.key.localized(), mark: "en")
//        let itModel = LanguageModel.init(name: R.string.localizable.languagesItalian.key.localized(), mark: "it")
//        let followSystemModel = LanguageModel.init(name: R.string.localizable.languagesFollowSystem.key.localized(), mark: "system")
//        
//        datas.accept([SectionModel<String?, LanguageModel>.init(model: "语言选择", items: [zhCNModel, enModel, itModel, followSystemModel])])
    }

}
