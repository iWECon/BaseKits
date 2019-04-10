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
import Localize_Swift

class ViewController: IWViewController {
    
    var vm: ViewModel {
        return viewModel as! ViewModel
    }
    
    @IBOutlet weak var accountTexiField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var switchServiceModeButton: UIButton!
    
    //learn box 入口
    @IBOutlet weak var userButton: UIButton!
    
    var account: BehaviorRelay<String> = BehaviorRelay<String>.init(value: "")
    var password: BehaviorRelay<String> = BehaviorRelay<String>.init(value: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    override func prepareUI() {
        super.prepareUI()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "语言", style: .plain, target: nil, action: nil)
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        let input = ViewModel.Input.init(loginControlEvent: loginButton.rx.tap.asDriver(),
                accountDriver: accountTexiField.rx.text.orEmpty.asObservable(),
                passwordDriver: passwordTextField.rx.text.orEmpty.asObservable(),
                switchDriver: switchServiceModeButton.rx.tap.asDriver(),
                chooseLanguageTrigger: navigationItem.rightBarButtonItem!.rx.tap.asDriver())
        
        let output = vm.transform(input: input)
        
        output.checkPass.drive(loginButton.rx.isEnabled).disposed(by: rx.disposeBag)
        language?.onNext({ [weak self] (_) in
            
            self?.loginButton.setTitle(R.string.localizable.userProfileSettingsLogin.key.localized(), for: .normal)
            
        }).disposed(by: rx.disposeBag)
        
        
        /*-----------------------------------------------*/
        /*                     Learn_box                 */
        /*-----------------------------------------------*/
        userButton.rx.controlEvent(.touchDown).onNext { (_) in

            let vm = JLearnBoxViewModel.init()
            vm.present(true, completion: nil)
        }.disposed(by: rx.disposeBag)
        
    }
}
