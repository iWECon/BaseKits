//
//  FourthRootViewModel.swift
//  IWBaseKits
//
//  Created by 未来 on 2019/3/29.
//  Copyright © 2019 iWECon. All rights reserved.
//

import UIKit

class FourthRootViewModel: IWViewModel {
    
    override var instanceController: IWViewControllerable {
        return FourthRootController.init(viewModel: self)
    }
    
    override func initialized() {
        super.initialized()
        
        
        navigationBarTitle.accept("控制器4")
        presentBackTitle = "返回"

    }
    
    
    

}
