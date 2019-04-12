//
//  JLearnTestOtherController.swift
//  IWBaseKits
//
//  Created by suTang on 2019/4/4.
//  Copyright © 2019年 iWECon. All rights reserved.
//

import UIKit

var viewNo:Int! = 0

class JLearnTestOtherController: IWViewController {
    var vm : JLearnTestOtherViewModel{
        return viewModel as! JLearnTestOtherViewModel
    }
    
//    var viewNo:Int! = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepareUI() {
        super.prepareUI()
        
            
        if (self.navigationController?.viewControllers.count)!<3 {
            Console.log("Other部分-首页")
            
            view.addSubview(collectionViewButton)
            collectionViewButton.rx.controlEvent(.touchUpInside).subscribe(onNext: { (_) in
                let collectionVm = JCollectionViewModel.init()
                collectionVm.push(true)
            }).disposed(by: rx.disposeBag)
        }
        
        view.addSubview(aButton)
        
        aButton.rx.controlEvent(.touchDown).subscribe(onNext: {[weak self] (_) in
            guard let self = self else { return }
            self.vm.pop()
        }).disposed(by: rx.disposeBag)
    
        view.addSubview(bButton)
        bButton.rx.controlEvent(.touchDown).subscribe(onNext: {[weak self] (_) in
            guard let self = self else { return }
            self.vm.popToRoot() //无效-现在好了
        }).disposed(by: rx.disposeBag)
        
        view.addSubview(nextButton)
        nextButton.rx.controlEvent(.touchDown).subscribe(onNext: {[weak self] (_) in
            guard let self = self else { return }
            
            viewNo = viewNo+1
            
//            let nextVm =  JLearnTestOtherViewModel.init(with: "Other Next-" + String(viewNo))
//            nextVm.push(false)
            
            self.vm.params = String(viewNo)
            self.vm.push()
            
        }).disposed(by: rx.disposeBag)
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        let titleName = vm.params as Any as? String
        
        if titleName != nil {
            vm.navigationBarTitle.accept(vm.params as Any as! String)
        }
    }
    
    private lazy var aButton: UIButton = {
        
        let button = UIButton()
        button.frame = CGRect(x: 20, y: ScreenHeight-TabBarHeight-44, width: (ScreenWidth-80)/3, height: 44)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .gray
        button.setTitle("上一页",for: .normal)
        return button
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 20*2+(ScreenWidth-80)/3, y: ScreenHeight-TabBarHeight-44, width: (ScreenWidth-80)/3, height: 44)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .gray
        button.setTitle("下一页",for: .normal)
        return button
    }()
    
    private lazy var bButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 20*3+(ScreenWidth-80)/3*2, y: ScreenHeight-TabBarHeight-44, width: (ScreenWidth-80)/3, height: 44)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .gray
        button.setTitle("Box 首页",for: .normal)
        return button
    }()
    
    
    private lazy var collectionViewButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 20, y: ScreenHeight-TabBarHeight-44-50, width: ScreenWidth-40, height: 44)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.setTitle("collectionView",for: .normal)
        return button
    }()
    /*关于lazy 懒加载
     
        swift中懒加载只会在第一次调用时执行创建对象，后面如果对象被释放了，则不会再次创建。而oc中会再次创建
        Swift和OC中懒加载的区别：
        OC中的懒加载，如果最开始调用懒加载创建对象，中间再次将对象设置为nil，之后会再次调用懒加载方法。
        Swift中的懒加载：如果想设置对象为nil，对象必须设置为可选。并且对象一旦设置为nil，懒加载不会再次执行。
        换句话说懒加载只会在第一调用的时候执行闭包，然后将闭包的结果保存在对象的属性中。
     
     so:Swift中一定要注意不要主动清理视图或空间，因为懒加载不会再次创建
     */


}















