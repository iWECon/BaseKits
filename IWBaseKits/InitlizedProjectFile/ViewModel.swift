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
        var accountObs: Observable<String>
        var passwordObs: Observable<String>
        var switchDriver: Driver<Void>
        var chooseLanguageTrigger: Driver<()>
    }
    
    struct Output {
        var loginTriggered: Driver<Void>
        var checkPass: Driver<Bool>
    }
    
    override func initialized() {
        super.initialized()
        
        navigationBarTitle.accept("首页")
    }
    
    func transform(input: Input) -> Output {
        
        input.accountObs.bind(to: account).disposed(by: rx.disposeBag)
        input.passwordObs.bind(to: password).disposed(by: rx.disposeBag)
        
        let loginTriggered = input.loginControlEvent
        loginTriggered.onNext { [weak self] (_) in
            guard let self = self else { return }
            
            self.request(.login(account: self.account.value, password: self.password.value)).take(UserModel.self).onNext({ (userModel) in
                
                Console.debug(userModel)
                
            }).disposed(by: self.rx.disposeBag)

        }.disposed(by: rx.disposeBag)
        
        input.switchDriver.onNext({ (_) in
            IWService.shared.switchMode()
            
        }).disposed(by: rx.disposeBag)
        
        let checkPass = Observable<String>.combineLatest([input.accountObs, input.passwordObs]).asObservable().map { (tuple) -> Bool in
            let condition1 = tuple.first.checkCount(more: 0)
            let condition2 = tuple.last.checkCount(greaterOrEqual: 6)
            return condition1 && condition2
        }.asDriver(onErrorJustReturn: false)
        
        input.chooseLanguageTrigger.onNext { (_) in

            let lvm = LanguageViewModel.init()
            lvm.present(true, completion: nil)

        }.disposed(by: rx.disposeBag)
        
        return Output.init(loginTriggered: loginTriggered, checkPass: checkPass)
    }
    
}
