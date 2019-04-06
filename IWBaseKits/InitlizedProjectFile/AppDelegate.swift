//
//  AppDelegate.swift
//  IWBaseKits
//
//  Created by 未来 on 2019/3/26.
//  Copyright © 2019 iWECon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Moya

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    /// 请求
    var provider: IWProvider<CommonAPI> = IWProvider<CommonAPI>.init() //IWMagicApi.init(provider: IWNetworking.networking())
    /// 路由器
    let router: IWRouter = IWRouter.init()
    /// router stack for navigation
    var routerStack: IWRouterNavigationControllerStack!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        Console.initialize()
        initRequires()
        
        self.routerStack = IWRouterNavigationControllerStack.init(with: router)
        
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window!.backgroundColor = .white
        router.reset(root: EntranceViewModel.init())
        window!.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}



// MARK: - 初始化
extension AppDelegate {
    
    private func initRequires() -> Void {
        initForProvider()
    }
    
    private func initForProvider() -> Void {
        let release = IWServiceModel.init(scheme: .https, host: "api.baige.in", path: "/user")
        IWService.shared.bind(release: release, debug: nil)
    }
    
}

extension AppDelegate {
    
    static var shared: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
}
