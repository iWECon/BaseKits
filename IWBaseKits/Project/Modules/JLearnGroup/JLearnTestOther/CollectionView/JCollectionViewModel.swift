//
//  JCollectionViewModel.swift
//  IWBaseKits
//
//  Created by suTang on 2019/4/10.
//  Copyright © 2019 iWECon. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift


class JCollectionViewModel: IWViewModel {
    
    
    var lists = BehaviorRelay<[(String,String)]>.init(value: []) //图片，文本
    
    override var instanceController: IWViewControllerable{
        return JCollectionViewController.init(viewModel: self)
    }
   
    
    override func initialized() {
        super.initialized()
        
        self.navigationBarTitle.accept("CollectionView")
        presentBackTitle = "返回"
        lists.accept([("TestshowImage","春困"),
                      ("TestshowImage","夏打盹"),
                      ("TestshowImage","秋乏"),
                      ("TestshowImage","冬眠"),
                      ("TestshowImage","阳春"),
                      ("TestshowImage","白雪"),
                      ("","国色天香"),
                      ("TestshowImage","芝兰"),
                      ("TestshowImage","香草"),
                      ("","")])
    }
}
