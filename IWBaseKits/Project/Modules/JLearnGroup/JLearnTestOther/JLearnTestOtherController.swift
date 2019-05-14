//
//  JLearnTestOtherController.swift
//  IWBaseKits
//
//  Created by suTang on 2019/4/4.
//  Copyright © 2019年 iWECon. All rights reserved.
//

import UIKit
import CollectionKit

var viewNo:Int! = 0

class JLearnTestOtherController: IWViewController {
    var vm : JLearnTestOtherViewModel{
        return viewModel as! JLearnTestOtherViewModel
    }
    
//    var viewNo:Int! = 0
    let collectView:CollectionView! = CollectionView.init(frame: CGRect(x: 10, y: NavBarHeight + 10, width: ScreenWidth-20, height: ScreenHeight-(NavBarHeight+10)-(TabBarHeight+44+50+80)))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepareUI() {
        super.prepareUI()
        
            
        if (self.navigationController?.viewControllers.count)!<3 {
            Console.log("Other部分-首页")
            
            view.addSubview(collectView)
            
            
            let animationButton:UIButton! = UIButton.init(type: .custom)
            animationButton.backgroundColor = .red
            animationButton.frame = CGRect(x: 20, y: collectionViewButton.y-60, width: (ScreenWidth-60)/2, height: 44)
            animationButton.setTitle("Animation", for: .normal)
            animationButton.addTarget(self, action: #selector(animationing), for: .touchDown)
            view.addSubview(animationButton)
            
            let reSetButton:UIButton! = UIButton.init(type: .custom)
            reSetButton.backgroundColor = .red
            reSetButton.frame = CGRect(x: 40+(ScreenWidth-60)/2, y: animationButton.y, width: (ScreenWidth-60)/2, height: 44)
            reSetButton.setTitle("Reset", for: .normal)
            reSetButton.addTarget(self, action: #selector(reSetting), for: .touchDown)
            view.addSubview(reSetButton)
            
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
    
    //CollectionKit learn
    func learnCollectionViewTest() {
        
        
        
        collectView.backgroundColor  = .lightGray
        let dataSource = ArrayDataSource(data: ["可乐", "雪碧", "哇哈哈", "橙汁","可乐", "雪碧", "哇哈哈", "橙汁","可乐", "雪碧", "哇哈哈", "橙汁"])
        let dataSource2 = ArrayDataSource(data: ["苹果", "香蕉", "芒果", "椰子", "橘子", "樱桃", "甘蔗","苹果", "香蕉", "芒果", "椰子", "橘子", "樱桃", "甘蔗","苹果", "香蕉", "芒果", "椰子", "橘子", "樱桃", "甘蔗"])

        let viewSource = ClosureViewSource(viewUpdater: { (view: CustomView, data: String, index: Int) in
            view.backgroundColor = .yellow
            view.infoLabel.text = data
            view.infoLabel.textAlignment = .center
            view.collectionAnimator = FadeAnimator()
        })
        let viewSource2 = ClosureViewSource(viewUpdater: { (view: CustomView, data: String, index: Int) in
            view.backgroundColor = .yellow
            view.infoLabel.text = data
            view.infoLabel.textAlignment = .center
            view.collectionAnimator = FadeAnimator()
        })
        let sizeSource = { (index: Int, data: String, collectionSize: CGSize) -> CGSize in
            return CGSize(width: 75, height: 40)
        }
        let sizeSource2 = { (index: Int, data: String, collectionSize: CGSize) -> CGSize in
            return CGSize(width: 100, height: 60)
        }
        let provider = BasicProvider(
            dataSource: dataSource,
            viewSource: viewSource,
            sizeSource: sizeSource,
            layout: FlowLayout(spacing: 15).inset(by: UIEdgeInsets(top: 5, left: 10, bottom: 15, right: 10)), //transposed()
            animator:  ScaleAnimator(),
            tapHandler:{[weak self] context in
                context.view.backgroundColor = .blue
                Console.log(context.data)
                Console.log(self?.navigationItem.title)
            }
        )
        
        let provider2 = BasicProvider(
            dataSource: dataSource2,
            viewSource: viewSource2,
            sizeSource: sizeSource2,
            layout: FlowLayout(spacing: 15).inset(by: UIEdgeInsets(top: 0, left: 10, bottom: 15, right: 10)),
            animator:  SimpleAnimator(),
            tapHandler:{[weak self] context in
                context.view.backgroundColor = .blue
                context.view.infoLabel.text = ""
                Console.log(context.data)
                Console.log(self?.navigationItem.title)
            }
        )
        let sPovider = ComposedProvider( sections:[provider,provider2]) //不同分区设置
    
        collectView.provider = sPovider
        collectView.animator = FadeAnimator()
    }
  
//    func getLabHeigh(labelStr:String,font:UIFont,width:CGFloat) -> CGFloat {
//
//        let statusLabelText: NSString! = labelStr as NSString
//
//        let size = CGSize(width: width, height: 900.0)
//
//        let dic = NSDictionary(object: font, forKey: NSAttributedString.Key.font as NSCopying)
//
//        let strSize = statusLabelText.boundingRectWithSize(size, options: .UsesLineFragmentOrigin, attributes: dic as? [String : AnyObject], context: nil).size
//
//        return strSize.height
//
//    }
//
//
//
//    func getLabWidth(labelStr:String,font:UIFont,height:CGFloat) -> CGFloat {
//
//        let statusLabelText: NSString = labelStr as NSString
//
//        let size = CGSize(width: 900.0, height: height)
//
//        let dic = NSDictionary(object: font, forKey: NSAttributedString.Key.font as NSCopying)
//
//        let strSize = statusLabelText.boundingRectWithSize(size, options: .UsesLineFragmentOrigin, attributes: dic as? [String : AnyObject], context: nil).size
//
//        return strSize.width
//
//    }
    
    @objc func animationing() {
        
        self.learnCollectionViewTest()
        
//        let alert = UIAlertController.init(title: <#T##String?#>, message: <#T##String?#>, preferredStyle: <#T##UIAlertController.Style#>)
        
        
    }
    
    @objc func reSetting() {
        
        let kGridCellSize = CGSize(width: 50, height: 50)
        let kGridSize = (width: 20, height: 20)
        let kGridCellPadding:CGFloat = 10
        
        let dataSource = ArrayDataSource(data: Array(1...kGridSize.width * kGridSize.height), identifierMapper: { (_, data) in
            return "\(data)"
        })
        let visibleFrameInsets = UIEdgeInsets(top: -150, left: -150, bottom: -150, right: -150)
        let layout = Closurelayout(frameProvider: { (i: Int, _) in
            CGRect(x: CGFloat(i % kGridSize.width) * (kGridCellSize.width + kGridCellPadding),
                   y: CGFloat(i / kGridSize.width) * (kGridCellSize.height + kGridCellPadding),
                   width: kGridCellSize.width,
                   height: kGridCellSize.height)
        }).insetVisibleFrame(by: visibleFrameInsets)
        
        collectView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        collectView.provider = BasicProvider(
            dataSource: dataSource,
            viewSource: { (view: CustomView, data: Int, index: Int) in
                view.backgroundColor = UIColor(hue: CGFloat(index) / CGFloat(kGridSize.width * kGridSize.height),
                                               saturation: 0.68, brightness: 0.98, alpha: 1)
                view.infoLabel.text = "\(data)"
        },
            layout: layout,
            animator: ZoomAnimator()
        )
        
        collectView.reloadData()

    }
}















