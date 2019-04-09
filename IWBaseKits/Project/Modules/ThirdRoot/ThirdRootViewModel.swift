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

class ThirdRootViewModel: IWViewModel {
    
    override var instanceController: IWViewControllerable {
        return ThirdRootController.init(viewModel: self)
    }
    
    var datas = BehaviorRelay<[SectionModel<String?, String>]>.init(value: [])
    
    override func initialized() {
        super.initialized()
        
        navigationBarTitle.accept("控制器3")
        
        datas.accept([SectionModel<String?, String>.init(model: "语言选择", items: ["zh-cn", "en", "it", "follow system"])])
    }

}
