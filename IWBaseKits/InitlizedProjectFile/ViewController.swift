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
    }
    
}
