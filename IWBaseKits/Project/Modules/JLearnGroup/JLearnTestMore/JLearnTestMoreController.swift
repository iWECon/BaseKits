//
//  JLearnTestMoreController.swift
//  IWBaseKits
//
//  Created by suTang on 2019/4/4.
//  Copyright © 2019年 iWECon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
class JLearnTestMoreController: IWViewController {
    
    var vm: JLearnTestMoreViewModel{
        return viewModel as!JLearnTestMoreViewModel
    }//viewModel为基类，在此使用时强转为当前类的viewModel-vm
    

    override func viewDidLoad() {
        super.viewDidLoad()

        Console.log(vm.params as Any as? String)

    }
    
    
    override func prepareUI() {
        super.prepareUI()
        
        //as Any -强转为any   as? String-可以转为string，但是不确定是否会转成功
        infoLabel.text = vm.params as Any as? String
        view.addSubview(infoLabel)
        
        //let disposeBag = DisposeBag()  //下方会失效
        
        let observable = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        observable.map {"当前需要盒子的个数：\($0)" }.bind{[weak self](text) in
            
            guard let self = self else { return }
            self.infoLabel.text = text
            
            }.disposed(by: rx.disposeBag) //直接使用by:disposeBag 不起作用啊啊
        
        observable.map{ CGFloat($0) }.bind(to: infoLabel.fontSize).disposed(by: rx.disposeBag)
        
        
        //        let bableVar = Observable.of(1,2,3)
        
        
        Observable.just("what").subscribe(onNext: { (item) in
            
            Console.log(item)
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: rx.disposeBag)
    }
    
    
    /*  页面显示一个label展示选择的盒子 点击后出现弹框（使用-原来的数量改变、不使用-返回） */
    
    //'lazy' must not be used on a computed property-不能用于计算属性
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 100, width: UIScreen.main.bounds.width, height: 44)
        label.textColor = .green
        label.textAlignment = .center
        label.text = ""
        return label
    }()   //????-上面的VM都不是这样写的，按照vm的写法，去掉“=”和句尾的“()”，xcode会去掉“lazy”
}

extension UILabel{
    public var fontSize: Binder<CGFloat>{
        return Binder(self) {label,fontSize in
            label.font = UIFont.systemFont(ofSize: fontSize)
        }
    }
}
