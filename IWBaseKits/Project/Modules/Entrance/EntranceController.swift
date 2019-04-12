//
//  EntranceController.swift
//  IWBaseKits
//
//  Created by 未来 on 2019/3/29.
//  Copyright © 2019 iWECon. All rights reserved.
//

import UIKit

class EntranceController: IWEntranceTabBarController {
    
    var vm: EntranceViewModel {
        return viewModel as! EntranceViewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepareUI() {
        super.prepareUI()
        
        /// TabBar 上显示的标题
        set(tabBarItemTitles: ["首页", "次页", "次次页", "次次次页"])
        /// 正常情况下显示的颜色
        set(normalColor: UIColor.gray)
        /// 选中后显示的颜色
        set(selectedColor: UIColor.black)
        
        /// 以下为控制器
        let firstNavController = IWNavigationController.init(rootViewController: vm.first.instanceController as! UIViewController)
        let secondNavController = IWNavigationController.init(rootViewController: vm.second.instanceController as! UIViewController)
        let thirdNavController = IWNavigationController.init(rootViewController: vm.third.instanceController as! UIViewController)
        let fourthNavController = IWNavigationController.init(rootViewController: vm.fourth.instanceController as! UIViewController)
        
        set(navigationControllers: [firstNavController, secondNavController, thirdNavController, fourthNavController])
        
        /// 安装控制器(推入栈中)
        installNavigationControllers()
    }
}
