//
//  ThirdRootController.swift
//  IWBaseKits
//
//  Created by 未来 on 2019/3/29.
//  Copyright © 2019 iWECon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import Localize_Swift

class ThirdRootController: IWViewController {
    
    var tableView: IWTableView!
    
    var vm: ThirdRootViewModel {
        return viewModel as! ThirdRootViewModel
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepareUI() {
        super.prepareUI()
        
        tableView = IWTableView(frame: ScreenBounds, style: UITableView.Style.grouped)
        view.addSubview(tableView)
        
        let dataSources = RxTableViewSectionedReloadDataSource<SectionModel<String?, LanguageModel>>.init(configureCell: ({ (ds, tv, idx, dt) -> UITableViewCell in
            
            var cell = tv.dequeueReusableCell(withIdentifier: "cell")
            if nil == cell {
                cell = UITableViewCell.init(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "cell")
            }
            cell!.textLabel?.text = dt.name
            if dt.isSelected {
                cell?.accessoryType = .checkmark
            } else {
                cell?.accessoryType = .none
            }
            return cell!
        }), titleForHeaderInSection: { (ds, section) -> String? in
            
            ds.sectionModels[safe: 0]?.model
        })
        
        tableView.rx.modelSelected(LanguageModel.self).onNext { (md) in
            
            Languages.shared.use(Languages.Language.init(md.mark.or("system")))
            
        }.disposed(by: rx.disposeBag)
        
        vm.datas.bind(to: tableView.rx.items(dataSource: dataSources)).disposed(by: rx.disposeBag)
        
    }
    
}
