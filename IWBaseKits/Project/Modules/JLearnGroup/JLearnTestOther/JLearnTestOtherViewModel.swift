//
//  JLearnTestOtherViewModel.swift
//  IWBaseKits
//
//  Created by suTang on 2019/4/4.
//  Copyright © 2019年 iWECon. All rights reserved.
//

import UIKit

class JLearnTestOtherViewModel: IWViewModel {
    
    override var instanceController: IWViewControllerable{
        
        return JLearnTestOtherController.init(viewModel:self)
    }
    
    override func initialized() {
        super.initialized()
        navigationBarTitle.accept("other")
        autoAddBackBarButton = true
    }

}
