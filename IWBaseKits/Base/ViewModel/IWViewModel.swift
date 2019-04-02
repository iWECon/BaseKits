//
//  IWViewModel.swift
//  IWBaseKits
//
//  Created by 未来 on 2019/3/26.
//  Copyright © 2019 iWECon. All rights reserved.
//

import UIKit
import Moya
import RxSwift
import RxCocoa

class IWViewModel: NSObject, IWViewModelable {
    
    deinit {
        Console.debug("\(self) is deinit.")
    }
    /// 这里只能这样设计, 若是改成 store 属性, 会造成内存无法释放...
    /// ⚠️ 注意: 这个只用来初始化, 不干其它事情, 也不要在 viewModel 里面用 self.instanceController !!!
    var instanceController: IWViewControllerable {
        let v = IWViewController.init(viewModel: self)
        return v
    }
    
    var router: IWRouter! {
        return AppDelegate.shared.router
    }
    
    /// 网络请求
    let provider: IWMagicApi = AppDelegate.shared.provider
    ///
    var params: [String: Any]?
    
    init(with params: [String: Any]? = nil) {
        super.init()
        
        self.params = params
        self.initialized()
    }
    
    /// Override
    func initialized() -> Void { }
    
    
    // MARK: - IWViewModelable
    var navigationBarTitle: BehaviorRelay<String> = BehaviorRelay<String>.init(value: "No Title")
    var navigationBackTitle: String? = ""
    
    var backgroundColor: BehaviorRelay<UIColor> = BehaviorRelay<UIColor>.init(value: .white)
    var touchViewHiddenKeyboard: BehaviorRelay<Bool> = BehaviorRelay<Bool>.init(value: false)
}

extension IWViewModel: IWRouterViewModelable {
    
    func push(_ animated: Bool = true) -> Void {
        router.push(viewModel: self, animated: animated)
    }
    
    func pop(_ animated: Bool = true) -> Void {
        router.popViewModel(animated)
    }
    
    func popToRoot(_ animated: Bool = true) -> Void {
        router.popToRootViewModel(animated)
    }
    
    func present(_ animated: Bool = true) -> Void {
        router.present(viewModel: self, animated: animated)
    }
    
    func dismiss(_ animated: Bool = true, completion: (() -> Void)? = nil) -> Void {
        router.dismiss(animated, completion: completion)
    }
    
    func back(_ animated: Bool) {
        Console.debug("Editing is about to be done here")
    }
    
    func reset() {
        router.reset(root: self)
    }
    
}
