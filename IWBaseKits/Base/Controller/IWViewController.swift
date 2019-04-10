//
//  IWViewController.swift
//  IWBaseKits
//
//  Created by 未来 on 2019/3/27.
//  Copyright © 2019 iWECon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class IWViewController: UIViewController, IWViewControllerable {
    
    deinit {
        Console.debug("The <\(type(of: self))> is deinit.")
        Console.logResourcesCount()
    }
    
    var snapshot: UIView?
    
    let language = AppDelegate.shared.language
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    public convenience init(viewModel: IWViewModelable) {
        self.init(nibName: nil, bundle: nil)
        
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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        Console.logResourcesCount()
    }
    
    func prepareUI() -> Void { }
    func updateUI() -> Void { }
    func bindViewModel() -> Void {
        
        if viewModel.isSome {
            viewModel.navigationBarTitle.bind(to: navigationItem.rx.title).disposed(by: rx.disposeBag)
            viewModel.backgroundColor.bind(to: view.rx.backgroundColor).disposed(by: rx.disposeBag)
            
            _autoCheck()
        }
    }
    
    var viewModel: IWViewModelable!
    func attach(viewModel: Any) {
        self.viewModel = (viewModel as! IWViewModelable)
    }
    
    private func _autoCheck() -> Void {
        if viewModel.presentBackTitle.isSome && self.iwe.isPresentered {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: viewModel.presentBackTitle.value, style: .plain, target: self, action: #selector(_autoBack))
        }
    }
    @objc private func _autoBack() -> Void {
        self.viewModel.destroy(true)
    }
}
