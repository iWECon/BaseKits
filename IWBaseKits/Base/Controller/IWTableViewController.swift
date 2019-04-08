//
//  IWTableViewController.swift
//  IWBaseKits
//
//  Created by 未来 on 2019/4/8.
//  Copyright © 2019 iWECon. All rights reserved.
//

import UIKit
import RxDataSources

class IWTableViewController: IWViewController {
    
    var tViewModel: IWTableViewModel {
        return viewModel as! IWTableViewModel
    }
    
    public var tableView: IWTableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepareUI() {
        super.prepareUI()
        
        tableView = IWTableView.init(frame: ScreenBounds, style: tViewModel.tableViewStyle)
        tViewModel.tableViewBackgroundColor.bind(to: tableView.rx.backgroundColor).disposed(by: rx.disposeBag)
        tableView.rx.setDelegate(self).disposed(by: rx.disposeBag)
        
        
        
        let dts = RxTableViewSectionedReloadDataSource<SectionModel<String?, String>>(configureCell: { (sectionModel, tableView, indexPath, userModel) -> UITableViewCell in
            
            var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
            if cell.isNone {
                cell = UITableViewCell.init(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "cell")
            }
            cell!.textLabel?.text = userModel
            cell!.detailTextLabel?.text = "\(indexPath.row)"
            return cell!
        })
        
        tViewModel.datas.bind(to: tableView.rx.items(dataSource: dts)).disposed(by: rx.disposeBag)
    }

}


extension IWTableViewController: UITableViewDelegate {
    
}
