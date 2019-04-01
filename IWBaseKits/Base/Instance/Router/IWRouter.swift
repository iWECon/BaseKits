//
//  IWRouter.swift
//  IWBaseKits
//
//  Created by 未来 on 2019/3/29.
//  Copyright © 2019 iWECon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class IWRouter: NSObject {
    
    private lazy var _pushSubject: PublishSubject<(Any)> = {
        return PublishSubject<(Any)>.init()
    }()
    
    private lazy var _popSubject: PublishSubject<(Any)> = {
        return PublishSubject<(Any)>.init()
    }()
    
    private lazy var _popRootSubject: PublishSubject<(Any)> = {
        return PublishSubject<(Any)>.init()
    }()
    
    private lazy var _presentSubject: PublishSubject<(Any)> = {
        return PublishSubject<(Any)>.init()
    }()
    
    private lazy var _dismissSubject: PublishSubject<(Any)> = {
        return PublishSubject<(Any)>.init()
    }()
    
    private lazy var _resetRootSubject: PublishSubject<(Any)> = {
        return PublishSubject<(Any)>.init()
    }()
    
    override init() {
        super.init()
    }
}


extension IWRouter: IWRouterServices {
    
    var pushSubject: PublishSubject<(Any)> {
        return _pushSubject
    }
    
    var popSubject: PublishSubject<(Any)> {
        return _popSubject
    }
    
    var popRootSubject: PublishSubject<(Any)> {
        return _popRootSubject
    }
    
    var presentSubject: PublishSubject<(Any)> {
        return _presentSubject
    }
    
    var dismissSubject: PublishSubject<(Any)> {
        return _dismissSubject
    }
    
    var resetSubject: PublishSubject<(Any)> {
        return _resetRootSubject
    }
    
    func push(viewModel: IWViewModel, animated: Bool) {
        _pushSubject.onNext((viewModel, animated))
    }
    
    func popViewModel(_ animated: Bool) {
        _popSubject.onNext(animated)
    }
    
    func popToRootViewModel(_ animated: Bool) {
        _popRootSubject.onNext(animated)
    }
    
    func present(viewModel: IWViewModel, animated: Bool) {
        _presentSubject.onNext((viewModel, animated))
    }
    
    func dismiss(_ animated: Bool, completion: (() -> Void)?) {
        _dismissSubject.onNext((animated, completion))
    }
    
    func reset(root viewModel: IWViewModel) {
        _resetRootSubject.onNext(viewModel)
    }
    
}
