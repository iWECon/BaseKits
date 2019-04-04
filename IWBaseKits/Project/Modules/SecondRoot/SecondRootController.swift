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

class SecondRootController: IWViewController{
    
    var vm: SecondRootViewModel{
        return viewModel as! SecondRootViewModel
    }
    
    override func prepareUI() {
        super.prepareUI()
<<<<<<< HEAD
=======

        struct BoxItem {
            let boxNum:String!
            let boxModel:Int!
            let boxType:String!
        }
        
        tableView = UITableView(frame: view.bounds, style: .grouped)
        tableView.backgroundColor = UIColor.white
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "mycell")
        
        vm.datas?.bind(to:tableView.rx.items) {(tableView,row,item) in
//            let cell = tableView.dequeueReusableCell(withIdentifier: "mycell") as! UITableViewCell
            let cell = tableView.dequeueReusableCell(withIdentifier: "mycell")
            cell!.textLabel?.text = "第\(item.0)个" + item.2 + "盒子，编号:" + String(item.1)
            return cell!
            
        }.disposed(by: rx.disposeBag)

        tableView.rx.modelSelected((String,Int,String).self).subscribe(onNext: { (item) in
            Console.log("第\(item.0)个" + item.2 + "盒子，编号:" + String(item.1))
            
            let vm = FourthRootViewModel.init(with: "123")
            vm.present(true, completion: nil)
            
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: rx.disposeBag)
>>>>>>> f8f7d1c55a19e14c2d58acaf982e4a1e64edfcb4
        
    }

}
