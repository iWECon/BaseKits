//
//  JLearnTestMoreViewModel.swift
//  IWBaseKits
//
//  Created by suTang on 2019/4/4.
//  Copyright © 2019年 iWECon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class JLearnTestMoreViewModel: IWViewModel {
    
    override var instanceController: IWViewControllerable{
        return JLearnTestMoreController.init(viewModel:self)
    }
    
    override func initialized() {
        super.initialized()
        navigationBarTitle.accept("learn-更多")
        autoAddBackBarButton = true
    }

}
