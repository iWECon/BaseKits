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
    
    var datas = BehaviorRelay<[(String,Int,String)]>.init(value: [])
    
    func initDataForUI () {
        datas.accept([
            ("JLearn_Test",1,"JLearnTestController"),
            ("JLearn_More",2,"JLearnTestMoreController"),
            ("JLearn_Other",3,"JLearnTestOtherController")
            ])
//        datas.value
//        datas = Observable.just([
//                ("JLearn_Test",1,"JLearnTestController"),
//                ("JLearn_More",2,"JLearnTestMoreController"),
//                ("JLearn_Other",3,"JLearnTestOtherController")
//            ])
    }

}
