//
//  JLearnBoxViewModel.swift
//  IWBaseKits
//
//  Created by suTang on 2019/4/4.
//  Copyright © 2019年 iWECon. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class JLearnBoxViewModel: IWViewModel {
    
    override var instanceController: IWViewControllerable{

        return JLearnBoxViewController.init(viewModel:self)
    }

    
    override func initialized() {
        super.initialized()
        
        navigationBarTitle.accept("Learn_Box")
        autoAddBackBarButton = true
        
        self.initDataForUI();

    }
    
    var datas : Observable<[(String,Int,String)]>?
    
    func initDataForUI () {
        datas = Observable.just([
            ("1",8,"大"),
            ("2",9,"中"),
            ("3",3,"小")
            ])
    }

}
