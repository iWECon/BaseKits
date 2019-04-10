//
//  IWTableViewModel.swift
//  IWBaseKits
//
//  Created by 未来 on 2019/4/8.
//  Copyright © 2019 iWECon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class IWTableViewModel: IWViewModel {
    
    override var instanceController: IWViewControllerable {
        return IWTableViewController.init(viewModel: self)
    }
    
//    var datas = BehaviorRelay<[SectionModel<String?, String>]>.init(value: [])
    
//    public var tableViewStyle: UITableView.Style! = .plain
    public var tableViewBackgroundColor = BehaviorRelay<UIColor>.init(value: .white)
    public var mutilSection: Bool = false
    
    override func initialized() {
        super.initialized()
        
//        datas.accept([SectionModel<String?, String>.init(model: "a", items: ["1", "2", "3"])])
    }

}
