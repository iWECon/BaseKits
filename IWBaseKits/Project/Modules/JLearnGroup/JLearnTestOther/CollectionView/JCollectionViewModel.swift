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
        
        lists.accept([("","春困"),("","夏打盹"),("","秋乏"),("","冬眠"),("","阳春"),("","白雪"),("",""),("","阳春"),("","白雪")])
    }
}
