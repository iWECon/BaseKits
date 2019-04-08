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
    
    var mainTable : UITableView!
    
    var vm: JLearnTestMoreViewModel{
        return viewModel as!JLearnTestMoreViewModel
    }//viewModel为基类，在此使用时强转为当前类的viewModel-vm
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Console.log(vm.params as Any as? String)
    }
    
    override func prepareUI() {
        super.prepareUI()
        
        self.learnBinderTest()
        self.learnObservableTest()
        self.learnTableTest()
    }
    
    /* Binder  的学习*/
    func learnBinderTest() {
        //as Any -强转为any   as? String-可以转为string，但是不确定是否会转成功
        infoLabel.text = vm.params as Any as? String
        view.addSubview(infoLabel)
        
        //let disposeBag = DisposeBag()  //下方会失效
        
        let observable = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        observable.map {"当前需要盒子的个数：\($0)" }.bind{[weak self](text) in
            
            guard let self = self else { return }
            
            self.infoLabel.text = text
            
            }.disposed(by: rx.disposeBag) //直接使用by:disposeBag() 不起作用啊啊--不是不起作用，而是disposed是注销，那么此时bind这系列操作直接无效了
        
        observable.map{ CGFloat($0) }.bind(to: infoLabel.fontSize).disposed(by: rx.disposeBag)
        
        observable.map { (fontSize) -> CGFloat in
            if (fontSize>18){
                return CGFloat(18.0)
            }
            return CGFloat(fontSize)
            
            }.subscribe(onNext: { (fontSize) in
                
                self.infoLabel.font = UIFont.systemFont(ofSize: fontSize)
            }, onError: { (error) in
                
            }, onCompleted: {
                
            }) {
                
            }.disposed(by: rx.disposeBag)
        
        //let bableVar = Observable.of(1,2,3)
        
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
    }()   //????-上面的VM都不是这样写的，若按照vm的写法，去掉“=”和句尾的“()”，xcode则会提示去掉“lazy”
    
    /* observable 的学习 */
    func learnObservableTest() {

        let observable = Observable.of("索隆","路飞","罗宾","乔巴","娜美")
        
        /* map-对序列数据进行转化操作 */
        observable.map { (value) -> String in
            return "人物：" + value
            }.subscribe(onNext: { (userInfo) in
                Console.log("海贼王-"+userInfo)
            }, onError: { (error) in
                Console.error(error.localizedDescription)
            }, onCompleted: {
                Console.log("........")
            }, onDisposed: {
                
            }).disposed(by: rx.disposeBag)
        
        /* do -观察生命周期 （在里面对序列做其他的修改，是不会在subscribe被发现的---有点鸡肋） */
        observable.do(onNext: { (userName) in
            Console.log("草帽海贼团：" + userName)
        }, onError: { error in
            Console.log("Do" + error.localizedDescription)
        }, onCompleted: {
            Console.log("Do Completed")
        }, onSubscribed: {
            Console.log("Do Subscribed")
        }, onDispose:{
            Console.log("Do Dispose")
        }).subscribe(onNext: { userName in
            Console.log("人物名字：" + userName)
        }, onError: { error in
            Console.error("subscribe" + error.localizedDescription)
        }, onCompleted: {
            Console.log("subscribe completed")
        }, onDisposed: {
            Console.log("subscribe Disposed")
        }).disposed(by: rx.disposeBag)
        
    }
    
    /* table 的学习*/
    func learnTableTest() {
        mainTable = UITableView(frame: CGRect(x: 0, y: infoLabel.y + infoLabel.height + 20, width: self.view.width, height: self.view.height-200), style: .grouped)
        mainTable.backgroundColor = UIColor.white
        view.addSubview(mainTable)
        
        mainTable.register(UITableViewCell.self, forCellReuseIdentifier: "teamCell")
        
//        mainTable.rx.modelSelected(String.self).onNext { (values) in
//
//        }.disposed(by: rx.disposeBag)
        
        //ViewModel处的数据
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String,JLearnTestMoreViewModel.UserInfo>> (configureCell: {(datas, mainTable, indexPath, userInfo) -> UITableViewCell in
            
            var cell:UITableViewCell!
            cell = mainTable.dequeueReusableCell(withIdentifier: "teamCell", for: indexPath)
            if (cell == nil){
                cell = UITableViewCell(style: .subtitle, reuseIdentifier: "teamCell")
            }
            cell.textLabel?.text = "\(userInfo.title)---\(userInfo.name)"
            cell.detailTextLabel?.text = "梦想：\(userInfo.dream)"
            return cell
        })
        
        dataSource.titleForHeaderInSection = {(datas,section) in
            return datas.sectionModels[section].model
        }
        
        //因为vm.tableDatas是BehaviorRelay，进行bind时需要转成可观察者“.asObservable()”
        vm.tableDatas.asObservable().bind(to: mainTable.rx.items(dataSource: dataSource)).disposed(by: rx.disposeBag)
        
        
        //Table 选中的索引
        mainTable.rx.itemSelected.subscribe(onNext: { indexPath in
            print("选中项的indexPath为：\(indexPath)")
        }).disposed(by: rx.disposeBag)
        mainTable.rx.itemSelected.sub
        
        //table 选中事件  JLearnTestMoreViewModel.UserInfo-UserInfo是JLearnTestMoreViewModel.UserInfo中的struct
        
//        mainTable.rx.modelSelected(SectionModel.self).subscribe(onNext: { (teamInfo) in
//
//                Console.log("梦想：\(teamInfo.1.dream)")
//
//        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: rx.disposeBag)
        
        /*测试数据-固定的数据
        let items = Observable.just([SectionModel(model: "*", items: ["2","7"]),
                                      SectionModel(model: "#", items: ["1","5","9"]),
                                      SectionModel(model: "_", items: ["3","4","6","8"])])
        
    
        RxTableViewSectionedReloadDataSource<SectionModel...固定写法，可看做是     var datas = BehaviorRelay<[[String]]>.init(value: [])//BehaviorRelay<[(String,[UserInfo])]>.init(value: [])  //相当于一个可变数组-添加观察时用“.asObservable()”
         参照：    public typealias ConfigureCell = (CollectionViewSectionedDataSource<S>, UICollectionView, IndexPath, I) -> UICollectionViewCell

        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String,String>> (configureCell: { (dataSource, mainTable, indexPath, element) -> UITableViewCell in

            let cell = mainTable.dequeueReusableCell(withIdentifier: "teamCell", for: indexPath)
            let str = dataSource[indexPath.section].model + element

            Console.log(dataSource[indexPath.section].model)
            cell.textLabel?.text = "该行的值:\(str)"
            return cell
        })

        //   参照： public typealias TitleForHeaderInSection = (TableViewSectionedDataSource<S>, Int) -> String?
        dataSource.titleForHeaderInSection = {(ds,section) in
            return ds.sectionModels[section].model  //ds-自己的数据源，section-区
        }
        //为Table的item绑定数据源
        items.bind(to: mainTable.rx.items(dataSource: dataSource)).disposed(by: rx.disposeBag)
    */
        
        
       
        
//        vm.datas.asObservable().bind(to:mainTable.rx.items(dataSource: RxTableViewDataSourceType & UITableViewDataSource)){ (mainTable,row,item) in
//            ()
//        }
//        vm.datas.asObservable().bind(to:tableView.rx.items) {(tableView,row,item) in
//            //注意：! 与 ?
//            let cell = tableView.dequeueReusableCell(withIdentifier: "mycell")!
//            //            let cell = tableView.dequeueReusableCell(withIdentifier: "mycell")
//            cell.textLabel?.text = String(item.1) + "-" + "\(item.0)"
//            return cell
//
//            }.disposed(by: rx.disposeBag)
        
    }
}

extension UILabel{
    public var fontSize: Binder<CGFloat>{
        return Binder(self) {label,fontSize in
            label.font = UIFont.systemFont(ofSize: fontSize)
        }
    }
}
