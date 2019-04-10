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

class JLearnBoxViewController: IWViewController {
    
    var tableView: UITableView!
    
    var vm : JLearnBoxViewModel{
        return viewModel as! JLearnBoxViewModel
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
        // vm, title, datasSources
        // vm,
        //
        // datas.count
        //
        // datas[section].datasSrouces.count
    }
    
    @objc func editTable() -> Void{
        
        tableView.beginUpdates()
        if self.navigationItem.rightBarButtonItem?.title=="编辑" {
            Console.debug(" 编辑 tableView")
            self.navigationItem.rightBarButtonItem?.title = "完成"
            tableView.setEditing(true, animated: true) //开始编辑
        }else{
            Console.debug(" tableView 编辑完成")
            self.navigationItem.rightBarButtonItem?.title = "编辑"
            tableView.setEditing(false, animated: true) //结束编辑
        }
        tableView.endUpdates()
        //        mainTable.reloadData()
    }
    
    override func prepareUI() {
        
        super.prepareUI()
        
        struct BoxItem {
            let boxNum:String!
            let boxModel:Int!
            let boxType:String!
        }
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "编辑", style: .plain, target: self, action: #selector(editTable))
        
        tableView = UITableView(frame: view.bounds, style: .grouped)
        tableView.backgroundColor = UIColor.white
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "mycell")
                
        vm.datas.asObservable().bind(to:tableView.rx.items) {(tableView,row,item) in
            //注意：! 与 ?
            let cell = tableView.dequeueReusableCell(withIdentifier: "mycell")!
            cell.textLabel?.text = String(item.1) + "-" + "\(item.0)"
            cell.accessoryType = .disclosureIndicator
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


