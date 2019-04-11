//
//  IWNavigationController.swift
//  IWBaseKits
//
//  Created by 未来 on 2019/3/29.
//  Copyright © 2019 iWECon. All rights reserved.
//

import UIKit

class IWNavigationController: UINavigationController {
    
    /// 使用`返回`标题标签, 默认为 false 不使用, 为 true 时优先级比 `useCustomerBackTitle` 高
    var useBackItemTitle = false
    /// 使用自定义`返回`标题, 默认为 true 使用
    var useCustomerBackTitle = true
    
    deinit {
        Console.debug("The <\(type(of: self))> is deinit.")
    }
    
    convenience init(viewControllable: IWViewControllerable) {
        self.init(rootViewController: viewControllable as! UIViewController)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    /// 拦截所有 push viewcontroller 操作
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        // 如果当前 push 的操作不是最底层的控制器
        if self.viewControllers.count > 0 {
            // 隐藏 tabBar
            viewController.hidesBottomBarWhenPushed = true
            
            var navTitle = self.topViewController?.navigationItem.title ?? "返回"
            if useBackItemTitle {
                navTitle = "返回"
            }
            
            // 从控制器 viewModel 中提取返回按钮标题
            if !useBackItemTitle && useCustomerBackTitle {
                // 判断要被 Push 的控制器是否为 IWViewController
                guard let baseViewController = (viewController as? IWViewController) else {
                    fatalError("ViewController should be `IWViewController` subclass.")
                }
                if baseViewController.viewModel != nil {
                    navTitle = baseViewController.viewModel.navigationBackTitle ?? ""
                }
            }
            
            // 设置返回按钮
            self.topViewController?.navigationItem.backBarButtonItem = _navigationController_createBackItem(with: navTitle)
        }
        // Push
        super.pushViewController(viewController, animated: animated)
    }
    
    private func _navigationController_createBackItem(with title: String?) -> UIBarButtonItem {
        let backItem = UIBarButtonItem()
        backItem.title = title
        // 当标题内容为空时, 缩小范围
        let titleFontSize:CGFloat = (title == nil ? 12 : 17)
        backItem.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: titleFontSize)], for: .normal)
        return backItem
    }
    
}
