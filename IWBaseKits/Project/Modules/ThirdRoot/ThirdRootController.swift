//
//  ThirdRootController.swift
//  IWBaseKits
//
//  Created by 未来 on 2019/3/29.
//  Copyright © 2019 iWECon. All rights reserved.
//

import UIKit

class ThirdRootController: IWViewController {
    
    var tableView: IWTableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepareUI() {
        super.prepareUI()
        
        tableView = IWTableView(frame: ScreenBounds, style: UITableView.Style.plain)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
    }
    
}

//extension ThirdRootController: UITableViewDelegate, UITableViewDataSource {
//    
//    
//}
