//
//  JLearnTestOtherController.swift
//  IWBaseKits
//
//  Created by suTang on 2019/4/4.
//  Copyright © 2019年 iWECon. All rights reserved.
//

import UIKit

class JLearnTestOtherController: IWViewController {
    var vm : JLearnTestOtherViewModel{
        return viewModel as! JLearnTestOtherViewModel
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepareUI() {
        super.prepareUI()
        
        view.addSubview(nextButton)
        nextButton.rx.controlEvent(.touchDown).subscribe(onNext: {[weak self] (_) in
            
            guard let self = self else { return }
//            let nextVm =  JLearnTestOtherViewModel.init()
//            nextVm.push()
            self.vm.push()

        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: rx.disposeBag)
        
        view.addSubview(aButton)
        
        aButton.rx.controlEvent(.touchDown).subscribe(onNext: {[weak self] (_) in
            
            guard let self = self else { return }
            
            self.vm.pop()
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: rx.disposeBag)
    
        
        view.addSubview(bButton)
        bButton.rx.controlEvent(.touchDown).subscribe(onNext: {[weak self] (_) in
            
            guard let self = self else { return }
            
            self.vm.popToRoot() //无效
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: rx.disposeBag)
        
        
        view.addSubview(collectionViewButton)
        collectionViewButton.rx.controlEvent(.touchUpInside).subscribe(onNext: { (_) in
            let collectionVm = JCollectionViewModel.init()
            collectionVm.push(true)
            
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: rx.disposeBag)
    
    }
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 20, y: 80, width: UIScreen.main.bounds.width-40, height: 44)
//        button.backgroundColor = .magenta
        button.setTitleColor(.black, for: .normal)
        button.setTitle("🌺 进入下一页 🌺",for: .normal)
        return button
    }()
    
    private lazy var aButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 20, y: 80+70, width: UIScreen.main.bounds.width-40, height: 44)
//        button.backgroundColor = .orange
        button.setTitleColor(.black, for: .normal)
        button.setTitle("🌺   返回上一页",for: .normal)
        return button
    }()
    
    private lazy var bButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 20, y: 80+120, width: UIScreen.main.bounds.width-40, height: 44)
//        button.backgroundColor = .cyan
        button.setTitleColor(.black, for: .normal)
        button.setTitle("🌺    返回root页",for: .normal)
        return button
    }()
    
    
    private lazy var collectionViewButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 20, y: 80+200, width: UIScreen.main.bounds.width-40, height: 44)
//        button.backgroundColor = .cyan
        button.setTitleColor(.black, for: .normal)
        button.setTitle("🌺    collectionView",for: .normal)
        return button
    }()
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}















