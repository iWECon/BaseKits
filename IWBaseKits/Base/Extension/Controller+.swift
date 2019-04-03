//
//  Controller+.swift
//  IWBaseKits
//
//  Created by 未来 on 2019/3/30.
//  Copyright © 2019 iWECon. All rights reserved.
//
#if os(iOS)
import UIKit

extension IWViewControllerable where Self: UIViewController {
    
    static func from(storyboard name: String = "Main") -> Self {
        let sb = UIStoryboard.init(name: name, bundle: Bundle.main)
        return sb.instantiateViewController(withIdentifier: "\(Self.self)") as! Self
    }
    
}

class IWViewControllerBridge<Base> {
    let base: Base
    init(base: Base) {
        self.base = base
    }
}
protocol _IWViewControllerable {
    associatedtype Base
    var iwe: Base { get }
}
extension _IWViewControllerable {
    var iwe: IWViewControllerBridge<Self> {
        return IWViewControllerBridge(base: self)
    }
}

extension UIViewController: _IWViewControllerable { }

extension UIViewController {
    
    enum BackType {
        case pop
        case dismiss
    }
    
    enum EnterType {
        case presented
        /// 从上个界面返回
        case backward
        /// 从前一个界面进来
        case push
    }
    
}
 extension IWViewControllerBridge where Base: UIViewController {
    
    /// 可以用来判断是 presenter 进入还是 push 进入
    var backType: UIViewController.BackType {
        if let controllers = base.navigationController?.viewControllers, controllers.count > 1 {
            if controllers[safe: controllers.count - 1] == base {
                // push
                return .pop
            }
        }
        return .dismiss
    }
    
    /// 是否为 present 出来的 controller
    var isPresentered: Bool {
        var tmpViewController: UIViewController = base
        if let navC = tmpViewController.navigationController {
            if navC.viewControllers.first! != tmpViewController {
                return false
            }
            tmpViewController = navC
        }
        return tmpViewController.presentingViewController?.presentedViewController == tmpViewController
    }
    
    /// 返回
    func destroy() -> Void {
        if backType == .dismiss {
            base.dismiss(animated: true, completion: nil)
        } else {
            base.navigationController?.popViewController(animated: true)
        }
    }
    
}

public protocol _IWGetCurrentViewControllerProtocol: class { }

extension UIViewController: _IWGetCurrentViewControllerProtocol { }

extension _IWGetCurrentViewControllerProtocol where Self: UIViewController {
    
    public static var current: Self? {
        let rootVc = UIApplication.shared.keyWindow?.rootViewController
        let vc = self.find(in: rootVc)
        return vc as? Self
    }
    
    private static func find(in displayController: UIViewController?) -> UIViewController? {
        if displayController != nil {
            if (displayController?.presentedViewController != nil) {
                
                return self.find(in: displayController?.presentedViewController!)
            } else if (displayController?.isKind(of: UISplitViewController.self))! {
                
                let splitVc = displayController as! UISplitViewController
                if splitVc.viewControllers.count > 0 {
                    return self.find(in: splitVc.viewControllers.last)
                }
            } else if (displayController?.isKind(of: UINavigationController.self))! {
                
                let navigationC = displayController as! UINavigationController
                if navigationC.viewControllers.count > 0 {
                    return self.find(in: navigationC.topViewController)
                }
            } else if (displayController?.isKind(of: UITabBarController.self))! {
                
                let tabbarC = displayController as! UITabBarController
                if tabbarC.viewControllers!.count > 0 {
                    return self.find(in: tabbarC.selectedViewController)
                }
            }
            return displayController
        }
        return nil
    }
    
}

/// (当前屏幕显示的控制器).
public var GetCurrentViewController: UIViewController? {
    return UIViewController.current
}
#endif
