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
    var autoAddBackBarButton: Bool = false
    func destroy(_ animated: Bool = true) {
        self.back(animated)
    }
}

extension IWViewModel: IWRouterViewModelable {
    
    func back(_ animated: Bool) {
        guard let viewController = UIViewController.current else { return }
        if viewController.iwe.isPresentered {
            self.dismiss(animated, completion: nil)
        } else {
            self.pop(animated)
        }
    }
    
    func push(_ animated: Bool = true) -> Void {
        router.push(viewModel: self, animated: animated)
    }
    
    func pop(_ animated: Bool = true) -> Void {
        router.popViewModel(animated)
    }
    
    func popToRoot(_ animated: Bool = true) -> Void {
        router.popToRootViewModel(animated)
    }
    
    func present(_ animated: Bool, completion: (() -> Void)?) {
        router.present(viewModel: self, animated: animated, completion: completion)
    }
    
    func dismiss(_ animated: Bool = true, completion: (() -> Void)? = nil) -> Void {
        router.dismiss(animated, completion: completion)
    }
    
    func reset() {
        router.reset(root: self)
    }
    
}
