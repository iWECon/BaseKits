//
//  JLearnTestController.swift
//  IWBaseKits
//
//  Created by suTang on 2019/4/4.
//  Copyright © 2019年 iWECon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
class JLearnTestController: IWViewController {
    
    var vm : JLearnTestViewModel{
        return viewModel as! JLearnTestViewModel
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func prepareUI() {
        super.prepareUI()
        
        view.addSubview(infoLabel)
        view.addSubview(checkButton)
        view.addSubview(interTextField)
        
        
        self.learnTest()
        
    }
    
    func learnTest() {
        //learn test
        // .rx.text.orEmpty 因为文本框的 text 默认值可能为 nil, 加上 orEmpty 之后会自动转换为空字符串 ""
        let userInter = JLearnTestViewModel.UserInter.init(checkTouchEvent: checkButton.rx.tap.asDriver(),
                                                 interTextDiver: interTextField.rx.text.orEmpty.asObservable())
        
        let userShow = vm.userPermissions(inter: userInter)
        // 这里的 driver 相当于 下面的 bind, 名字不同 用法一样,与onNext效果一样
        userShow.hasShow.drive(checkButton.rx.isEnabled).disposed(by: rx.disposeBag)
        userShow.hasShow.onNext { [weak self] (value) in
            guard let self = self else { return }
            
            self.checkButton.isEnabled = value
            self.isEnabledShow(isEnable: value)
            
            }.disposed(by: rx.disposeBag)
        
        
        //页面按钮控制
        self.normalShow()
        // 记得加上 [weak self] 和 guard let self = self else { return }
        //observeOn(MainScheduler.instance) 使操作在主线程内执行（加在.bind等之前）
        checkButton.rx.controlEvent(.touchDown).observeOn(MainScheduler.instance).bind { [weak self] (_) in
            guard let self = self else { return }
            self.touchDownShow()
            self.view.endEditing(true)
            }.disposed(by: rx.disposeBag)
        
        checkButton.rx.touchUpInside.onNext { [weak self] (_) in
            guard let self = self else { return }
            
            self.touchInsideShow()
            }.disposed(by: rx.disposeBag)
        
        checkButton.rx.touchUpOutside.onNext { [weak self] (_) in
            guard let self = self else { return }
            
            self.touchOutsideShow()
            }.disposed(by: rx.disposeBag)
        
        // 绑定操作
        vm.interPer.bind(to: infoLabel.rx.text).disposed(by: rx.disposeBag)
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
            checkButton.setTitleColor(.white, for: .normal)
        }else{
            checkButton.setTitleColor(.blue, for: .normal)
        }
        
        checkButton.setTitle(btnTitle,for: .normal)
        checkButton.backgroundColor = color
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true) //点击页面后取消键盘
    }
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 100, width: UIScreen.main.bounds.width, height: 44)
        label.textColor = .green
        label.textAlignment = .center
        label.text = ""
        return label
    }()
    
    private lazy var checkButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 0, y: 100, width: UIScreen.main.bounds.width, height: 44)
        return button
    }()
    
    private lazy var interTextField: UITextField = {
        let textField = UITextField()
        textField.frame = CGRect(x: 0, y: 100, width: UIScreen.main.bounds.width, height: 44)
        textField.textColor = .green
        textField.textAlignment = .center
        textField.text = ""
        return textField
    }()
    

}
