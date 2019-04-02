//
//  SecondRootViewModel.swift
//  IWBaseKits
//
//  Created by 未来 on 2019/3/29.
//  Copyright © 2019 iWECon. All rights reserved.
//

import UIKit

class SecondRootViewModel: IWViewModel {
    
    override var instanceController: IWViewControllerable {
        return SecondRootController.init(viewModel: self)
    }
    
    override func initialized() {
        super.initialized()
        
        backgroundColor.accept(.green)
        navigationBarTitle.accept("控制器2")
    }

}
 
