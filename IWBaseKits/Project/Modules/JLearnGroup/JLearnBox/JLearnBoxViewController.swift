//
//  JLearnBoxViewController.swift
//  IWBaseKits
//
//  Created by suTang on 2019/4/4.
//  Copyright © 2019年 iWECon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class JLearnBoxViewController: IWViewController {
    
    var tableView: UITableView!
    
    var vm : JLearnBoxViewModel{
        return viewModel as! JLearnBoxViewModel
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func prepareUI() {
        
        super.prepareUI()
        
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
            //注意：! 与 ?
            let cell = tableView.dequeueReusableCell(withIdentifier: "mycell")!
            //            let cell = tableView.dequeueReusableCell(withIdentifier: "mycell")
            cell.textLabel?.text = String(item.1) + "-" + "\(item.0)"
            return cell
            
            }.disposed(by: rx.disposeBag)
        
        tableView.rx.modelSelected((String,Int,String).self).subscribe(onNext: { (item) in
            
            if (item.1 == 1){
                let vm = JLearnTestViewModel.init(with: {item.1})
                vm.present(true, completion: nil)
            }else if (item.1 == 2){
                let vm = JLearnTestMoreViewModel.init(with: {item.1})
                vm.present(true, completion: nil)
            }else if (item.1 == 3){
                let vm = JLearnTestOtherViewModel.init(with: {item.1})
                vm.push()
//                vm.present(true, completion: nil)
            }else{
                
            }

            
            
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: rx.disposeBag)
        
        tableView.rx.modelDeselected((String,Int,String).self).onNext { (item) in
            Console.log("拜拜")
            }.disposed(by: rx.disposeBag)
    }
}


