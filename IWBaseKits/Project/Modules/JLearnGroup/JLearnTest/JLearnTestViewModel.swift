//
//  JLearnTestViewModel.swift
//  IWBaseKits
//
//  Created by suTang on 2019/4/4.
//  Copyright © 2019年 iWECon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class JLearnTestViewModel: IWViewModel {
    
    override var instanceController: IWViewControllerable{
        
        return JLearnTestController.init(viewModel:self)
    }
    
    override func initialized() {
        super.initialized()
        navigationBarTitle.accept("test")
        presentBackTitle = "返回"
    }
    
    //learn test
    struct UserInter {
        var checkTouchEvent: Driver<Void> //按钮点击
        var interTextDiver :Observable <String> //输入框
    }
    struct UserShow {
        var hasShow: Driver<Bool>  //label 显示
    }
    
    var interPer = BehaviorRelay<String>.init(value: "身份待确认")
    
    func userPermissions(inter: UserInter) ->UserShow {
        
        let userTouch = inter.checkTouchEvent
        userTouch.onNext { (_) in
//            Console.log("点击了效验按钮-可以对ViewModel做些什么事")
            let vm = JLearnTestOtherViewModel.init()
//            vm.present(true, completion: nil)
            vm.push(true)//push过去后，暂时无法pop返回
            }.disposed(by: rx.disposeBag)
        
        inter.interTextDiver.onNext { (testStr) in
            
            //设置管理员id为“123456”
            self.interPer.accept(testStr=="123456" ? "您是管理员":"您的id："+testStr)
            }.disposed(by: rx.disposeBag)
        
        let hasShow = Observable<String>.combineLatest([inter.interTextDiver,self.interPer.asObservable()]).asObservable().map { (result) -> Bool in
            let isResult = result.first.check({$0.count > 3 })
            let isResult2 =  result.last.check({$0=="您是管理员"})
            return isResult && isResult2
            
            }.asDriver(onErrorJustReturn: false)
        
        return UserShow.init(hasShow: hasShow)
        
    }
}
