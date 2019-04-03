//
//  IWViewController.swift
//  IWBaseKits
//
//  Created by 未来 on 2019/3/27.
//  Copyright © 2019 iWECon. All rights reserved.
//

import UIKit

class IWViewController: UIViewController, IWViewControllerable {
    
    deinit {
        Console.debug("\(self) is deinit.")
    }
    
    var snapshot: UIView?
    
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    init(viewModel: IWViewModelable) {
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel = viewModel
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareUI()
        updateUI()
        bindViewModel()
        Console.log("Current ViewController :\(self)")
    }
    
    func prepareUI() -> Void { }
    func updateUI() -> Void { }
    func bindViewModel() -> Void {
        if viewModel != nil {
            viewModel.navigationBarTitle.asObservable().bind(to: navigationItem.rx.title).disposed(by: rx.disposeBag)
            
            viewModel.backgroundColor.asObservable().bind(to: view.rx.backgroundColor).disposed(by: rx.disposeBag)
//            viewModel.touchViewHiddenKeyboard.asDriver().onNext { [weak self] (value) in
//                guard let self = self else { return }
//
//                self.view.rx.tap.onNext({ (_) in
//
//                    if value {
//                        self.view.endEditing(true)
//                    }
//
//                }).disposed(by: self.rx.disposeBag)
//
//            }.disposed(by: rx.disposeBag)
        }
    }
    
    var viewModel: IWViewModelable!
    func attach(viewModel: Any) {
        self.viewModel = (viewModel as! IWViewModelable)
    }
    
}
