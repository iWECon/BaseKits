//
//  ViewController.swift
//  IWBaseKits
//
//  Created by 未来 on 2019/3/26.
//  Copyright © 2019 iWECon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: IWViewController {
    
    var vm: ViewModel {
        return viewModel as! ViewModel
    }
    
    @IBOutlet weak var accountTexiField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var switchServiceModeButton: UIButton!
    
    //learn test
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var userButton: UIButton!
    @IBOutlet weak var userTextField: UITextField!
    
    var account: BehaviorRelay<String> = BehaviorRelay<String>.init(value: "")
    var password: BehaviorRelay<String> = BehaviorRelay<String>.init(value: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        let input = ViewModel.Input.init(loginControlEvent: loginButton.rx.tap.asDriver(),
                accountDriver: accountTexiField.rx.text.orEmpty.asObservable(),
                passwordDriver: passwordTextField.rx.text.orEmpty.asObservable(),
                switchDriver: switchServiceModeButton.rx.tap.asDriver())
        
        let output = vm.transform(input: input)
        
        output.checkPass.drive(loginButton.rx.isEnabled).disposed(by: rx.disposeBag)
        
        vm.login()
        
        
        
        //learn test
        // .rx.text.orEmpty 因为文本框的 text 默认值可能为 nil, 加上 orEmpty 之后会自动转换为空字符串 ""
        let userInter = ViewModel.UserInter.init(checkTouchEvent: userButton.rx.tap.asDriver(),
                                                 interTextDiver: userTextField.rx.text.orEmpty.asObservable())
        
        let userShow = vm.userPermissions(inter: userInter)
        // 这里的 driver 相当于 下面的 bind, 名字不同 用法一样,与onNext效果一样
        userShow.hasShow.drive(userButton.rx.isEnabled).disposed(by: rx.disposeBag)
        userShow.hasShow.onNext { [weak self] (value) in
            guard let self = self else { return }
            
            self.userButton.isEnabled = value
            self.isEnabledShow(isEnable: value)
            Console.debug("\(Thread.current.isMainThread)") //当前是否是在主线程
            
        }.disposed(by: rx.disposeBag)
        
        
        //页面按钮控制
        self.normalShow()
        // 记得加上 [weak self] 和 guard let self = self else { return }
        //observeOn(MainScheduler.instance) 使操作在主线程内执行（加在.bind等之前）
        userButton.rx.controlEvent(.touchDown).observeOn(MainScheduler.instance).bind { [weak self] (_) in
            guard let self = self else { return }
            self.touchDownShow()
            self.view.endEditing(true)
        }.disposed(by: rx.disposeBag)
        
        userButton.rx.controlEvent(.touchUpInside).bind { [weak self] (_) in
            guard let self = self else { return }
            self.touchInsideShow()
        }.disposed(by: rx.disposeBag)
        
        userButton.rx.controlEvent(.touchUpOutside).bind { [weak self] (_) in
            guard let self = self else { return }
            self.touchOutsideShow()
        }.disposed(by: rx.disposeBag)
        
        // 绑定操作
        vm.interPer.bind(to: userLabel.rx.text).disposed(by: rx.disposeBag)
        
//        vm.interPer.subscribe(onNext: { (result) in
//            self.userLabel.text = result
//        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: rx.disposeBag)
    }
    
    func normalShow() {
        self.buttonCustomShow(color: .white, btnTitle: "User validation requires Id entry")
    }
    func isEnabledShow(isEnable:Bool) -> Void {
        if isEnable {
            self.buttonCustomShow(color: .green, btnTitle: "Authenticate")

        }else{
            self.buttonCustomShow(color: .red, btnTitle: "Currently unable to authenticate")
        }
    }
    
    func touchInsideShow() {
        self.buttonCustomShow(color: .red, btnTitle: "You cannot use APP")
    }
    
    func touchDownShow() {
        self.buttonCustomShow(color: .orange, btnTitle: "To check the reason：touchUp Outside")
    }
    
    func touchOutsideShow() {
        self.buttonCustomShow(color: .yellow, btnTitle: "Have no legal power.")
    }
    
    //inout 需要在函数中修改当前传入参数时使用，加在参数类型前
    //？当前d参数可为空时使用，加在参数类型后
    func buttonCustomShow(color:UIColor,btnTitle: String) -> Void {
        
        if color==UIColor.red {
            self.userButton.setTitleColor(.white, for: .normal)
        }else{
            self.userButton.setTitleColor(.blue, for: .normal)
        }

        self.userButton.setTitle(btnTitle,for: .normal)
        self.userButton.backgroundColor = color
    }
}
