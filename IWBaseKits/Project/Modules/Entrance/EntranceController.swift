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
        
        set(tabBarItemTitles: ["首页", "第二页", "语言"])
        set(normalColor: UIColor.gray)
        set(selectedColor: UIColor.black)
        
        let firstNavController = IWNavigationController.init(rootViewController: vm.first.instanceController as! UIViewController)
        let secondNavController = IWNavigationController.init(rootViewController: vm.second.instanceController as! UIViewController)
        let thirdNavController = IWNavigationController.init(rootViewController: vm.third.instanceController as! UIViewController)
//        let fourthNavController = IWNavigationController.init(rootViewController: vm.fourth.instanceController)
        
        set(navigationControllers: [firstNavController, secondNavController, thirdNavController])
        
        installNavigationControllers()
    }
}
