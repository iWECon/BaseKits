//
//  SecondRootController.swift
//  IWBaseKits
//
//  Created by 未来 on 2019/3/29.
//  Copyright © 2019 iWECon. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources

class SecondRootController: IWViewController/*,UITableViewDelegate,UITableViewDataSource */{
    
    var tableView: UITableView!
//    var datas: [(String,Int,String)]!   //元组
    var datas : Observable<[(String,Int,String)]>?
    

//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        view.backgroundColor = .red
//        self.prepareUI()
//
//        // Do any additional setup after loading the view.
//    }
    
    
    override func prepareUI() {
        super.prepareUI()

        //赋值类型要和定义时保持一致
//        datas =[("1",8,"大"),("2",9,"中"),("3",3,"小")]
        
        struct BoxItem {
            let boxNum:String!
            let boxModel:Int!
            let boxType:String!
        }
        
        var lists : Observable<[BoxItem]>
        lists = Observable.just([
//            BoxItem("1",8,"大")
            ])

        datas = Observable.just([
            ("1",8,"大"),
            ("2",9,"中"),
            ("3",3,"小")
        ])

        tableView = UITableView(frame: view.bounds, style: .grouped)
        tableView.backgroundColor = UIColor.white
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "mycell")
        
        datas?.bind(to:tableView.rx.items) {(tableView,row,item) in
//            let cell = tableView.dequeueReusableCell(withIdentifier: "mycell") as! UITableViewCell
            let cell = tableView.dequeueReusableCell(withIdentifier: "mycell")
            cell!.textLabel?.text = "第\(item.0)个" + item.2 + "盒子，编号:" + String(item.1)
            return cell!
            
        }.disposed(by: rx.disposeBag)

        tableView.rx.modelSelected((String,Int,String).self).subscribe(onNext: { (item) in
            Console.log("第\(item.0)个" + item.2 + "盒子，编号:" + String(item.1))
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: rx.disposeBag)
        
        tableView.rx.modelDeselected((String,Int,String).self).onNext { (item) in
            Console.log("拜拜")
        }.disposed(by: rx.disposeBag)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
