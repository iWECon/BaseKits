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
    
    override func initialized() {
        super.initialized()
        
    }
    
    func transform(input: Input) -> Output {
        
        let loginTriggered = input.loginControlEvent
        loginTriggered.onNext { (_) in
            
            //self?.request(.login(account: "13203007472", password: "111111"))
            
        }.disposed(by: rx.disposeBag)
        
        input.switchDriver.onNext({ (_) in
            IWService.shared.switchMode()
            
        }).disposed(by: rx.disposeBag)
        
        let checkPass = Observable<String>.combineLatest([input.accountDriver, input.passwordDriver]).asObservable().map { (tuple) -> Bool in
            let condition1 = tuple.first.check({ $0.count > 0 })
            let condition2 = tuple.last.check({ $0.count >= 6 })
            return condition1 && condition2
        }.asDriver(onErrorJustReturn: false)
        
        return Output.init(loginTriggered: loginTriggered, checkPass: checkPass)
    }
    
}
