//
//  ViewModel.swift
//  IWBaseKits
//
//  Created by 未来 on 2019/3/29.
//  Copyright © 2019 iWECon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewModel: IWViewModel {
    
    var httpDisposeBag = DisposeBag.init()
    
    override var instanceController: IWViewControllerable {
        let a = ViewController.from()
        a.attach(viewModel: self)
        return a
    }
    
    var account = BehaviorRelay<String>.init(value: "")
    var password = BehaviorRelay<String>.init(value: "")
    
    struct Input {
        var loginControlEvent: Driver<Void>
        var accountDriver: Observable<String>
        var passwordDriver: Observable<String>
        var switchDriver: Driver<Void>
    }
    
    struct Output {
        var loginTriggered: Driver<Void>
        var checkPass: Driver<Bool>
    }
    
    func transform(input: Input) -> Output {
        
        let loginTriggered = input.loginControlEvent
        loginTriggered.onNext { [weak self] (_) in
            
            guard let self = self else { return }
            
            self.provider.login(account: "admin", password: "123123").subscribe(onSuccess: { (userModel) in
                Console.log("\(userModel)")
                Console.log("\(userModel.message ?? "Not message.")")
            }, onError: { (error) in
                Console.log("\(error.localizedDescription)")
            }).disposed(by: self.rx.disposeBag)
            
        }.disposed(by: rx.disposeBag)
        
        input.switchDriver.onNext({
            IWService.shared.switchMode()
        }).disposed(by: rx.disposeBag)
        
        let checkPass = Observable<String>.combineLatest([input.accountDriver, input.passwordDriver]).asObservable().map { (tuple) -> Bool in
            let condition1 = tuple.first.check({ $0.count > 0 })
            let condition2 = tuple.last.check({ $0.count >= 6 })
            return condition1 && condition2
        }.asDriver(onErrorJustReturn: false)
        
        return Output.init(loginTriggered: loginTriggered, checkPass: checkPass)
    }
    
    func login() -> Void {
//        self.provider.login(account: "admin", password: "123123").debug().observeOn(MainScheduler.instance).subscribe(onSuccess: { (userModel) in
//            Console.log("\(userModel)")
//        }) { (error) in
//            Console.error(error.localizedDescription)
//        }.disposed(by: rx.disposeBag)
        
        //self.provider.login(account: <#T##String#>, password: <#T##String#>)
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
            Console.log("点击了效验按钮-可以对ViewModel做些什么事")
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
