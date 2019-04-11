//
//  JCollectionViewController.swift
//  IWBaseKits
//
//  Created by suTang on 2019/4/10.
//  Copyright © 2019 iWECon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class JCollectionViewController: IWViewController {


    var vm:JCollectionViewModel {
        return viewModel as! JCollectionViewModel
    }
    
    var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func prepareUI() {
        super.prepareUI()
        
        self.navigationItem.setRightBarButton(UIBarButtonItem.init(title: "设置", style: .plain, target: self, action: #selector(setting)), animated: true)
        
        let flowLayout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset =  UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        let cellW = (ScreenWidth-15*4)/3
        flowLayout.itemSize = CGSize(width: cellW, height: cellW+25)

        collectionView = UICollectionView(frame: self.view.frame,
                                          collectionViewLayout: flowLayout)
        // 设置delegate和dateSource 是swift的写法，需要实现对应函数
        //collectionView.delegate = self
        //collectionView.dataSource = self
        collectionView.backgroundColor = .white
//        collectionView.register(JCollectionViewItemCell.self, forCellWithReuseIdentifier: "collectCell")
        collectionView.register(UINib.init(nibName: "JCollectionViewItemCell", bundle: nil), forCellWithReuseIdentifier: "collectCell")

        self.view.addSubview(collectionView)
        
        //这里DataSource进行绑定是RxSwift的用法 设置单元格 相当于cellForItemAt 的封装
        //！！！！！注意：这个方法不能和delegate的函数同时实现！！！！！！
        // 给item绑定数据
        vm.lists.asObservable().bind(to: collectionView.rx.items) { (collectionView, row, element) in

            let indexPath = IndexPath(row: row, section: 0)

            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectCell", for: indexPath) as! JCollectionViewItemCell
            
            cell.backgroundColor = .clear
            return cell
            }.disposed(by: rx.disposeBag)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectCell", for: indexPath) as! JCollectionViewItemCell
        cell.backgroundColor = .red
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return vm.lists.value.count
    }
    
  
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Console.log("选中了\(vm.lists.value[indexPath.row].1)")
    }
        
    
    @objc func setting() {
        Console.log("_________setting_________")
        
        let alert = MyAlertControlle.init(title: "设置", message: "请选择设置", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction.init(title: "Night", style: .default, handler: { (action) in
            
            UIView.animate(withDuration: 1.0, animations: {
                self.collectionView.backgroundColor = .black
            })
        }))
        alert.addAction(UIAlertAction.init(title: "Day", style: .default, handler: { (action) in
            UIView.animate(withDuration: 1.0, animations: {
                self.collectionView.backgroundColor = .white
            })
        }))
        alert.addAction(UIAlertAction.init(title: "取消", style: .cancel, handler: { (action) in
            
        }))
        
        self.present(alert, animated: true) {
            Console.log("_________进行设置_________")
        }
    }
}
