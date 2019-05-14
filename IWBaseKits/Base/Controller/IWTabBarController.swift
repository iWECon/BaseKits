//
//  IWTabBarController.swift
//  IWBaseKits
//
//  Created by 未来 on 2019/3/29.
//  Copyright © 2019 iWECon. All rights reserved.
//

#if os(iOS)
import UIKit

class IWTabBarController: IWViewController {
    
    private var _tabBarController: UITabBarController!
    override var tabBarController: UITabBarController! {
        return _tabBarController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepareUI() {
        super.prepareUI()
        
        _tabBarController = UITabBarController.init()
        
        self.view.addSubview(self.tabBarController.view)
        self.addChild(self.tabBarController)
        self.tabBarController.didMove(toParent: self)
        
        /// kvc(key value coding) 替换 tabBar
        let tbr = IWTabBar.init()
        self.tabBarController.setValue(tbr, forKey: "tabBar")
    }
    
}

extension IWTabBarController: UITabBarControllerDelegate {
    
    override var shouldAutorotate: Bool {
        return tabBarController?.selectedViewController?.shouldAutorotate ?? false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return tabBarController?.selectedViewController?.supportedInterfaceOrientations ?? .portrait
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return tabBarController?.selectedViewController?.preferredStatusBarStyle ?? .default
    }
    
    override var prefersStatusBarHidden: Bool {
        return tabBarController?.selectedViewController?.prefersStatusBarHidden ?? false
    }
    
}
#endif
