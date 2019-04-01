//
//  IWRoter.swift
//  IWBaseKits
//
//  Created by 未来 on 2019/3/28.
//  Copyright © 2019 iWECon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol IWRouterNavigationProtocol: NSObjectProtocol {
    var pushSubject     : PublishSubject<(Any)> { get }
    var popSubject      : PublishSubject<(Any)> { get }
    var popRootSubject  : PublishSubject<(Any)> { get }
    var presentSubject  : PublishSubject<(Any)> { get }
    var dismissSubject  : PublishSubject<(Any)> { get }
    var resetSubject    : PublishSubject<(Any)> { get }
    
    func push(viewModel: IWViewModel, animated: Bool) -> Void
    func popViewModel(_ animated: Bool)               -> Void
    func popToRootViewModel(_ animated: Bool)         -> Void
    func present(viewModel: IWViewModel, animated: Bool) -> Void
    func dismiss(_ animated: Bool, completion: (() -> Void)?) -> Void
    func reset(root viewModel: IWViewModel)           -> Void
}

protocol IWRouterServices: IWRouterNavigationProtocol { }

protocol IWRouterViewModelable: NSObjectProtocol {
    
    func push(_ animated: Bool) -> Void
    func pop(_ animated: Bool) -> Void
    func popToRoot(_ animated: Bool) -> Void
    func present(_ animated: Bool) -> Void
    func dismiss(_ animated: Bool, completion: (() -> Void)?) -> Void
    func back(_ animated: Bool) -> Void
    func reset() -> Void
}
