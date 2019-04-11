//
//  JCollectionItemViewModel.swift
//  IWBaseKits
//
//  Created by suTang on 2019/4/10.
//  Copyright © 2019 iWECon. All rights reserved.
//

import UIKit

class JCollectionItemViewModel: IWViewModel {
    
    override func initialized() {
        super.initialized()
    }
    
    var showImageName:String!
    var showInfoString:String!
    
    var isNightMode:Bool!
    var isShowImageHight:Bool!
    var isHiddenText:Bool!
    var isHiddenImage:Bool!
    
    
    var infoTextColor:UIColor!
    var imageHightColor:UIColor!

    
    func bindItemViewModel(vModel:(String,String),isNight:Bool) -> JCollectionItemViewModel {
        
        let item:JCollectionItemViewModel! = JCollectionItemViewModel.init()
        
        item.showImageName = vModel.0.count==0 ? "TestshowImage" : vModel.0
        item.showInfoString = vModel.1
        item.isNightMode = isNight
        item.isShowImageHight = isNight
        
        if isNight==true {
            item.infoTextColor = .yellow
            item.imageHightColor = .yellow
        }else{
            item.infoTextColor = .gray
            item.imageHightColor = .white
        }
        item.isHiddenText = vModel.1.count==0 ? true : false
        item.isHiddenImage = vModel.1.count==0 ? true : false

        return item
    }

}
//ViewModel 作为View和Model的中介，用数据控制视图上的内容，与OC基本没差，因为使用了Rx ，要注意不在观察者范围内的需要手动刷新

