//
//  IWRouterNavigationControllerStack.swift
//  IWBaseKits
//
//  Created by 未来 on 2019/3/29.
//  Copyright © 2019 iWECon. All rights reserved.
//

#if os(iOS)
import UIKit
import RxSwift
import RxCocoa

class IWRouterNavigationControllerStack: NSObject {
    
    private let stackDisposeBag = DisposeBag()
    
    var router: IWRouter!
    var navigationControllers: [UINavigationController]!
    
    convenience init(with router: IWRouter) {
        self.init()
        
        self.router = router
        self.navigationControllers = []
        self.registerNavigationHooks()
    }
    
    func push(navigationController: UINavigationController) -> Void {
        guard self.navigationControllers.contains(navigationController) else {
            self.navigationControllers.append(navigationController)
            return
        }
    }
    
    @discardableResult
    func popNavigationController() -> UINavigationController? {
        let navigationController = self.navigationControllers.last
        self.navigationControllers.removeLast()
        return navigationController
    }
    
    @discardableResult
    func topNavigationController() -> UINavigationController? {
        return self.navigationControllers.last
    }

}

extension IWRouterNavigationControllerStack {
    
    private func registerNavigationHooks() {
        
        router.pushSubject.bind { [weak self] (tuple) in
            guard let self = self else { return }
            
            let (viewModel, animated) = tuple as! (IWViewModel, Bool)
            let topViewController = self.navigationControllers.last?.topViewController as! IWViewController
            if topViewController.tabBarController != nil {
                topViewController.snapshot = topViewController.tabBarController?.view.snapshotView(afterScreenUpdates: false)
            } else {
                topViewController.snapshot = self.navigationControllers.last?.view.snapshotView(afterScreenUpdates: false)
            }
            let viewController = viewModel.instanceController
            Console.debug("You entered <\(type(of: viewController))> from <\(type(of: self.navigationControllers.last!.viewControllers.last.value))> by push.")
            self.navigationControllers.last?.pushViewController(viewController as! UIViewController, animated: animated)
            
        }.disposed(by: stackDisposeBag)
        
        router.popSubject.bind { [weak self] (tuple) in
            guard let self = self else { return }
            
            let (animated) = tuple as! (Bool)
            Console.debug("You exited <\(type(of: self.navigationControllers.last!.viewControllers.last.value))> by pop.")
            self.navigationControllers.last?.popViewController(animated: animated)
        }.disposed(by: stackDisposeBag)
        
        router.popRootSubject.bind { [weak self] (tuple) in
            guard let self = self else { return }
            
            let (animated) = tuple as! (Bool)
            Console.debug("You exited <\(type(of: self.navigationControllers.last!.viewControllers.last.value))> by popRoot.")
            self.navigationControllers.last?.popToRootViewController(animated: animated)
        }.disposed(by: stackDisposeBag)
        
        router.presentSubject.bind { [weak self] (tuple) in
            guard let self = self else { return }
            
            let (viewModel, animated, completion) = tuple as! (IWViewModel, Bool, (() -> Void)?)
            
            var viewController = viewModel.instanceController as! UIViewController
            let presentingViewController = self.navigationControllers.last
            if !(viewController is UINavigationController) {
                viewController = IWNavigationController.init(rootViewController: viewController)
            }
            Console.debug("You entered <\(type(of: (viewController.navControl).viewControllers.first!))> from <\(type(of: self.navigationControllers.last.value.viewControllers.last.value))> by present.")
            
            self.push(navigationController: viewController.navControl)
            presentingViewController?.present(viewController, animated: animated, completion: completion)
            
        }.disposed(by: stackDisposeBag)
        
        router.dismissSubject.bind { [weak self] (tuple) in
            guard let self = self else { return }
            
            let (animated, completion) = tuple as! (Bool, (() -> Void)?)
            Console.debug("You exited <\(type(of: self.navigationControllers.last.value.viewControllers.last.value))> from <\(type(of: self.navigationControllers.last.value))> by dimiss.")
            
            self.popNavigationController()
            self.navigationControllers.last?.dismiss(animated: animated, completion: completion)
            
        }.disposed(by: stackDisposeBag)
        
        /// ResetRootViewController
        router.resetSubject.bind { [weak self] (tuple) in
            guard let self = self else { return }
            
            self.navigationControllers.removeAll()
            
            let viewModel = tuple as! IWViewModel
            var viewController = viewModel.instanceController as! UIViewController
            
            let isNavigationController = (viewController.isKind(of: UINavigationController.self))
            let isTabBarController = (viewController is IWTabBarController)
            if !isNavigationController && !isTabBarController {
                let navController = IWNavigationController.init(rootViewController: viewController)
                self.push(navigationController: navController)
                viewController = navController
            }
            Console.debug("You reset with <\(type(of: viewModel))>.")
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = viewController
            
        }.disposed(by: stackDisposeBag)
        
    }
    
}
#endif
