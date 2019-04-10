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
class JLearnTestMoreController: IWViewController ,UITableViewDataSource,UITableViewDelegate{
    
    
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
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "编辑", style: .plain, target: self, action: #selector(editTable))
        
        vm.netWork()
        
        self.learnBinderTest()
        self.learnObservableTest()
        
    }
    
    @objc func editTable() -> Void{
        
        if self.navigationItem.rightBarButtonItem?.title=="编辑" {
            Console.debug("开始编辑 tableView")
            self.navigationItem.rightBarButtonItem?.title = "完成"
            mainTable.setEditing(true, animated: true) //开始编辑
        }else{
            Console.debug("tableView 编辑完成")
            self.navigationItem.rightBarButtonItem?.title = "编辑"
            mainTable.setEditing(false, animated: true) //结束编辑
        }
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
            
            }.disposed(by: rx.disposeBag) //直接使用by:disposeBag() 不起作用啊啊--不是不起作用，而是disposed是注销，那么此时bind这系列操作直接注销无效了
        
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        //注意操作符号的间隔
        if mainTable != nil {
            mainTable.removeFromSuperview()
        }

        //或者
//        if (self.view.viewWithTag(199) != nil) {
//            mainTable.removeFromSuperview()
//        }
        
        self.showAlert() //点击页面空白处出现弹框 ，然后再以不同方式实现Table
    }
    
    /*Alert 使用：用于选择Table的实现方式*/
    func showAlert() -> Void {
        let alertCtrl:MyAlertControlle = MyAlertControlle.init(title: "温馨提示", message: "请选择学习模块", preferredStyle: .actionSheet)
        alertCtrl.addAction(UIAlertAction.init(title: "Swift", style: .default, handler: { action in
            Console.log("选择了-Swift")
            self.initTabelView()
            self.learnSwiftTableTest()
        }))
        alertCtrl.addAction(UIAlertAction.init(title: "RxSwift", style: .default, handler: { action in
            Console.log("选择了-RxSwift")
            self.initTabelView()
            self.learnRXSwiftTableTest()
        }))
        alertCtrl.addAction(UIAlertAction.init(title: "RxDataSource", style: .default, handler: { action in
            Console.log("选择了-RxDataSource")
            self.initTabelView()
            self.learnRxDataSourceTableTest()
        }))
        alertCtrl.addAction(UIAlertAction.init(title: "取消", style: .cancel, handler: { action in
            Console.log("取消")
        }))
        
        self.present(alertCtrl, animated: true, completion: nil)
    }
    
    /* table 的学习*/
    func initTabelView() -> Void {
        // 0-设置tableView
        mainTable = UITableView(frame: CGRect(x: 0,
                                              y: infoLabel.y + infoLabel.height + 20,
                                              width: ScreenWidth,
                                              height: ScreenHeight-200),
                                style: .grouped)
        mainTable.tag = 199
        mainTable.backgroundColor = UIColor.white
        view.addSubview(mainTable)
        //注册单元格
        mainTable.register(UITableViewCell.self, forCellReuseIdentifier: "teamCell")
        
        //添加tableView的页眉
        let headerView:UIView = UIView.init(frame: CGRect(x: 0,
                                                          y: 0,
                                                          width: ScreenWidth,
                                                          height: ScreenWidth*0.15))
        
        let headerLab:UILabel = UILabel.init(frame: CGRect(x: 10,
                                                           y: ScreenWidth*0.05/2,
                                                           width: ScreenWidth-20,
                                                           height: ScreenWidth*0.1))
        
        headerLab.text = "这是海贼的新时代"
        headerLab.textColor = .red
        headerView.addSubview(headerLab)
        headerView.backgroundColor = .black
        mainTable.tableHeaderView = headerView
        
        //添加TableView的页脚
        let footerView:UIView = UIView(frame: CGRect(x: 0,
                                                     y: 0,
                                                     width: ScreenWidth,
                                                     height: ScreenWidth*0.15))
        let footerLab:UILabel = UILabel(frame: CGRect(x: 10,
                                                      y: ScreenWidth*0.05/2,
                                                      width: ScreenWidth-20,
                                                      height: ScreenWidth*0.1))
        footerLab.text = "海上皇帝"
        footerLab.textColor = .blue
        footerLab.textAlignment = .right
        footerView.addSubview(footerLab)
        footerView.backgroundColor = .yellow
        mainTable.tableFooterView = footerView
    }
    func learnSwiftTableTest() {
        //dataSource - vm.tableDatas
        
        mainTable.delegate = self
        mainTable.dataSource = self

    }
    
    //table delegate
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.datas.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "teamCell", for: indexPath)
        cell.textLabel?.text = "only swift -"+vm.datas.value[indexPath.row]
        return cell
    }
    
    func learnRXSwiftTableTest() {
        //dataSource - vm.tableDatas
   
        vm.datas.asObservable().bind(to:mainTable.rx.items) {(table,row,item) in
            
            let cell = table.dequeueReusableCell(withIdentifier: "teamCell")
            
            cell?.textLabel!.text =  "RxSwift -"+item
            
            return cell!
        }.disposed(by: rx.disposeBag)
        
       
    }
    
    func learnRxDataSourceTableTest() {
        
        //dataSource - vm.tableDatas
        
        //1-ViewModel处的数据-给item进行设置
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String,JLearnTestMoreViewModel.UserInfo>> (configureCell: {(datas, mainTable, indexPath, userInfo) -> UITableViewCell in
            
            //var cell:UITableViewCell!
            let cell = mainTable.dequeueReusableCell(withIdentifier: "teamCell", for: indexPath)
            //if (cell == nil){
            //   cell = UITableViewCell(style: .subtitle, reuseIdentifier: "teamCell")
            //}
            cell.textLabel?.text = "\(userInfo.title)---\(userInfo.name)"
            cell.detailTextLabel?.text = "梦想：\(userInfo.dream)"
            return cell
        })
        
        //2-给分区设置title
        dataSource.titleForHeaderInSection = {(datas,section) in
            return datas.sectionModels[section].model
        }
        //3-允许tableView进行编辑 RxDataSource重写了函数，默认FALSE：即使设置了isEditing=true，也不能编辑，需要进行下面的设置
        dataSource.canEditRowAtIndexPath = { (ds,indexPath) in
            return true
        }
        //4-允许tableView进行移动 RxDataSource重写了函数，默认FALSE( 注意查看源码-CanMoveRowAtIndexPath = (TableViewSectionedDataSource<S>, IndexPath) -> Bool)
        dataSource.canMoveRowAtIndexPath = { (ds,indexPath) in
            if indexPath.row==0 {
                //Console.log("船长不能换队伍")  //不能根据当前船长的位置来确定船长，还是要根据userinfo来确定身份
                //return false
            }
            if ds[indexPath.section].items[indexPath.row].title=="船长" {
                Console.log("船长不能换队伍") //当前是设置了船长不能移动，未满足不能换队伍的需求
                return false
            }
            return true
        }
        
        //数据源必须全部设置后才能绑定（bind To，drive等）
        //因为vm.tableDatas是BehaviorRelay，进行bind时需要转成可观察者“.asObservable()”
        vm.tableDatas.asObservable().bind(to: mainTable.rx.items(dataSource: dataSource)).disposed(by: rx.disposeBag)
        
        //Table 选中的索引
        mainTable.rx.itemSelected.subscribe(onNext:{ indexPath in
            Console.log(self.vm.tableDatas.value[indexPath.section].items[indexPath.row].name)
        }).disposed(by: rx.disposeBag)
        
        //table 选中的内容  JLearnTestMoreViewModel.UserInfo-UserInfo是JLearnTestMoreViewModel.UserInfo中的struct，是当前item绑定的数据类型
        mainTable.rx.modelSelected(JLearnTestMoreViewModel.UserInfo.self).onNext { (userInfo) in
            Console.log("梦想：\(userInfo.dream)")
        }.disposed(by: rx.disposeBag)
        
        //选中的索引  和  内容
        Observable.zip(mainTable.rx.itemSelected,mainTable.rx.modelSelected(JLearnTestMoreViewModel.UserInfo.self))
            .bind{ indexPath,items in
                //Console.debug(indexPath)
                //Console.log(items.name)
            }.disposed(by: rx.disposeBag)
        
        //取消选中的索引
        mainTable.rx.modelDeselected(JLearnTestMoreViewModel.UserInfo.self).onNext { (userInfo) in
            
        }.disposed(by: rx.disposeBag)
        
        //取消选中的内容
        mainTable.rx.itemDeselected.subscribe(onNext: { indexPath in
            
        }).disposed(by: rx.disposeBag)
        
        //取消选中项的索引 和内容
        Observable.zip(mainTable.rx.itemDeselected,mainTable.rx.modelDeselected(JLearnTestMoreViewModel.UserInfo.self))
            .bind{ indexPath ,items in
                
                Console.log("取消选中:"+self.vm.tableDatas.value[indexPath.section].model+items.title)
        }.disposed(by: rx.disposeBag)
        
        //获取删除项的索引
        mainTable.rx.itemDeleted.subscribe({ indexPath in
            Console.log("删除项的索引\(indexPath)")
        }).disposed(by: rx.disposeBag)
        
        
        //mainTable.rx.modelSelected(String.self).onNext { (values) in
        //
        //}.disposed(by: rx.disposeBag)
        
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
