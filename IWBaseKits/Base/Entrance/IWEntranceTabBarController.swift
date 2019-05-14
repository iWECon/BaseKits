//
//  IWEntranceTabBarController.swift
//  IWBaseKits
//
//  Created by 未来 on 2019/3/29.
//  Copyright © 2019 iWECon. All rights reserved.
//

#if os(iOS)
import UIKit

class IWEntranceTabBarController: IWTabBarController {
    
    private var tabBarItemTitles: [String]?
    private var tabBarImages: [String]?
    private var tabBarSelectedImages: [String]?
    private var navigationControllers: [UINavigationController]!
    private var normalColor: UIColor = UIColor.gray
    private var selectedColor: UIColor = UIColor.darkText
    
    func set(tabBarItemTitles arr: [String]) -> Void {
        self.tabBarItemTitles = arr
    }
    func set(tabBarImages arr: [String]) -> Void {
        self.tabBarImages = arr
    }
    func set(tabBarSelectedImages arr: [String]) -> Void {
        self.tabBarSelectedImages = arr
    }
    func set(navigationControllers arr: [UINavigationController]) -> Void {
        self.navigationControllers = arr
    }
    func set(normalColor color: UIColor) -> Void {
        self.normalColor = color
    }
    func set(selectedColor color: UIColor) -> Void {
        self.selectedColor = color
    }
    
    func installNavigationControllers() -> Void {
        setupAllChildViewController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.tabBarController.delegate = self
    }
    
    private func setupAllChildViewController() -> Void {
        
        self.tabBarController.viewControllers = navigationControllers
        _config(viewControllers: navigationControllers)
        
        AppDelegate.shared.routerStack.push(navigationController: navigationControllers.first!)
    }
    
    private func _config(viewControllers: [UIViewController]?) -> Void {
        guard let vcs = viewControllers else { return }
        var index = 0
        for vc in vcs {
            let titles = tabBarItemTitles?[index] ?? ""
            let imageName = tabBarImages?[index] ?? ""
            let selectedImageName = tabBarSelectedImages?[index] ?? ""
            _config(viewController: vc,
                    imageName: imageName,
                    selectedImageName: selectedImageName,
                    title: titles)
            index += 1
        }
    }
    
    private func _config(viewController: UIViewController, imageName: String, selectedImageName: String, title: String) -> Void {
        
        var image = (imageName == "" ? UIImage() : UIImage(named: imageName))
        image = image?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        viewController.tabBarItem.image = image
        viewController.tabBarItem.tag = 0
        
        var selectImage = (selectedImageName == "" ? UIImage() : UIImage(named: selectedImageName))
        selectImage = selectImage?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        viewController.tabBarItem.selectedImage = selectImage
        viewController.tabBarItem.title = title
        
        let normalAttr = [NSAttributedString.Key.foregroundColor: normalColor,
                          NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10)]
        let selectedAttr = [NSAttributedString.Key.foregroundColor: selectedColor,
                            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10)]
        viewController.tabBarItem.setTitleTextAttributes(normalAttr, for: UIControl.State.normal)
        viewController.tabBarItem.setTitleTextAttributes(selectedAttr, for: UIControl.State.selected)
        
        viewController.tabBarItem.titlePositionAdjustment = UIOffset.init(horizontal: 0, vertical: 0)
        viewController.tabBarItem.imageInsets = UIEdgeInsets.zero
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let appDelegate = AppDelegate.shared
        appDelegate.routerStack.popNavigationController()
        appDelegate.routerStack.push(navigationController: viewController as! UINavigationController)
    }
    

}
#endif
