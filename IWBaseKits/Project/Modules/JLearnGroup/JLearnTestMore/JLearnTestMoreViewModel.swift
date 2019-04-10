//
//  JLearnTestMoreViewModel.swift
//  IWBaseKits
//
//  Created by suTang on 2019/4/4.
//  Copyright © 2019年 iWECon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class JLearnTestMoreViewModel: IWViewModel {
    
    struct UserInfo {
        var name:String
        var title:String
        var dream:String
    }
//    var datas : Observable<[(String,[UserInfo])]>? //简单地，固定的数据时可以用这个 ，不能变
    var datas = BehaviorRelay<[[String]]>.init(value: [])//BehaviorRelay<[(String,[UserInfo])]>.init(value: [])  //相当于一个可变数组-添加观察时用“.asObservable()”
    
    var tableDatas = BehaviorRelay<[SectionModel]>.init(value: [SectionModel(model: "", items: [UserInfo(name: "", title: "", dream: "")])])
    
    
    
    override var instanceController: IWViewControllerable{
        return JLearnTestMoreController.init(viewModel:self)
    }
    
    override func initialized() {
        super.initialized()
        navigationBarTitle.accept("learn-更多")
        presentBackTitle = "返回"
        
//        datas = Observable.just([UserInfo(name: "路飞", title: "船长", dream: "集结一群优秀的伙伴，成为海贼王！"),
//                                 UserInfo(name: "索隆", title: "副船长", dream: "成为天下第一的剑客"),
//                                 UserInfo(name: "乔巴", title: "船医", dream: "每天吃棉花糖？？？"),
//                                 UserInfo(name: "娜美", title: "航海士", dream: "要画出全世界航海图"),
//                                 UserInfo(name: "甚平", title: "舵手", dream: "让路飞当海贼王？？？"),
//                                 UserInfo(name: "乌索普", title: "射击手", dream: "成为勇敢的海上战士"),
//                                 UserInfo(name: "山治", title: "厨师", dream: "找到All Blue"),
//                                 UserInfo(name: "罗宾", title: "历史学家", dream: "找到所有的历史正文并解读，解开空白的一百年"),
//                                 UserInfo(name: "布鲁克", title: "音乐家", dream: "和伙伴们一起航行"),
//                                 UserInfo(name: "弗兰奇", title: "船工", dream: "保护万里阳光号"),
//                                 UserInfo(name: "万里阳光号", title: "海贼船", dream: "带大伙航行"),
//                                 UserInfo(name: "黄金梅里号", title: "海贼船", dream: "带大伙航行")])
        
//        datas.accept([("草帽海贼团",
//                       [UserInfo(name: "路飞", title: "船长", dream: "集结一群优秀的伙伴，成为海贼王！"),
//                       UserInfo(name: "索隆", title: "副船长", dream: "成为天下第一的剑客"),
//                       UserInfo(name: "乔巴", title: "船医", dream: "每天吃棉花糖？？？"),
//                       UserInfo(name: "娜美", title: "航海士", dream: "要画出全世界航海图"),
//                       UserInfo(name: "甚平", title: "舵手", dream: "让路飞当海贼王？？？"),
//                       UserInfo(name: "乌索普", title: "射击手", dream: "成为勇敢的海上战士"),
//                       UserInfo(name: "山治", title: "厨师", dream: "找到All Blue"),
//                       UserInfo(name: "罗宾", title: "历史学家", dream: "找到所有的历史正文并解读，解开空白的一百年"),
//                       UserInfo(name: "布鲁克", title: "音乐家", dream: "和伙伴们一起航行"),
//                       UserInfo(name: "弗兰奇", title: "船工", dream: "保护万里阳光号"),
//                       UserInfo(name: "万里阳光号", title: "海贼船", dream: "带大伙航行"),
//                       UserInfo(name: "黄金梅里号", title: "海贼船", dream: "带大伙航行")]),
//                      ("big mom海贼团",
//                       [UserInfo(name: "big mom", title: "船长", dream: "建立世界上所有人都能一起相处的国家")]),
//                      ("白胡子海贼团",
//                       [UserInfo(name: "白胡子", title: "船长", dream: ""),
//                        UserInfo(name: "艾斯", title: "第二队队长", dream: "")])
//            ])
//
        
        //datas.accept(<#T##event: [(String, [JLearnTestMoreViewModel.UserInfo])]##[(String, [JLearnTestMoreViewModel.UserInfo])]#>)
//        let sources = BehaviorRelay<[[String]]>.init(value: [])
        
        datas.accept([["1", "2"], ["5", "6", "7", "8"]])
        
//        datas.asObservable().onNext { (userInfo) in
//
//        }.disposed(by: rx.disposeBag)
        
        tableDatas.accept([SectionModel(model: "草帽海贼团",
                                        items: [UserInfo(name: "路飞", title: "船长", dream: "集结一群优秀的伙伴，成为海贼王！"),
                                                UserInfo(name: "索隆", title: "副船长", dream: "成为天下第一的剑客"),
                                                UserInfo(name: "乔巴", title: "船医", dream: "每天吃棉花糖？？？"),
                                                UserInfo(name: "娜美", title: "航海士", dream: "要画出全世界航海图"),
                                                UserInfo(name: "甚平", title: "舵手", dream: "让路飞当海贼王？？？"),
                                                UserInfo(name: "乌索普", title: "射击手", dream: "成为勇敢的海上战士"),
                                                UserInfo(name: "山治", title: "厨师", dream: "找到All Blue"),
                                                UserInfo(name: "罗宾", title: "历史学家", dream: "找到所有的历史正文并解读，解开空白的一百年"),
                                                UserInfo(name: "布鲁克", title: "音乐家", dream: "和伙伴们一起航行"),
                                                UserInfo(name: "弗兰奇", title: "船工", dream: "保护万里阳光号"),
                                                UserInfo(name: "万里阳光号", title: "海贼船", dream: "带大伙航行"),
                                                UserInfo(name: "黄金梅里号", title: "海贼船", dream: "带大伙航行")]),
                           SectionModel(model: "big mom海贼团",
                                        items: [UserInfo(name: "big mom", title: "船长", dream: "建立世界上所有人都能一起相处的国家")]),
                           SectionModel(model: "白胡子海贼团",
                                        items: [UserInfo(name: "白胡子", title: "船长", dream: ""),
                                                UserInfo(name: "艾斯", title: "第二队队长", dream: "")])
                           ])
        
    }
    
    //模拟数据请求
    func netWork() {
        Console.log("netWork")
    }

}
