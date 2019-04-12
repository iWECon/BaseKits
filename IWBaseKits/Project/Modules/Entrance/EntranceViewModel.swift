//
//  EntranceViewModel.swift
//  IWBaseKits
//
//  Created by 未来 on 2019/3/29.
//  Copyright © 2019 iWECon. All rights reserved.
//

import UIKit

class EntranceViewModel: IWViewModel {
    
    override var instanceController: IWViewControllerable {
        return EntranceController.init(viewModel: self)
    }
    
    var first: ViewModel!
    var second: SecondRootViewModel!
    var third: ThirdRootViewModel!
    var fourth: FourthRootViewModel!
    
    override func initialized() {
        super.initialized()
        
        first = ViewModel.init()
        second = SecondRootViewModel.init()
        third = ThirdRootViewModel.init()
        fourth = FourthRootViewModel.init()
        
        /**
         入口配置文件, 这里只写这么多，其他的都在 EntranceController.swift 里面
         */
    }
}
